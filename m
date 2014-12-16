From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 4/6] receive-pack.c: use a single ref_transaction for atomic pushes
Date: Tue, 16 Dec 2014 11:35:53 -0800
Message-ID: <xmqqwq5r9yli.fsf@gitster.dls.corp.google.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
	<1418755747-22506-1-git-send-email-sbeller@google.com>
	<1418755747-22506-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, jrnieder@gmail.com,
	ronniesahlberg@gmail.com, Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 20:36:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0xua-0008ON-0K
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 20:36:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbaLPTf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 14:35:56 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54588 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750862AbaLPTfz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2014 14:35:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2378B28AD6;
	Tue, 16 Dec 2014 14:35:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jffBwIwke2Hjr6OxuasAy9ZORN4=; b=HCHngs
	Konm0AghBabTbYUHk6AG9IORgmxBg+I0W2OHHMpmrBXRwb9nbN+xOQHGQl+qlevI
	gSdesjqiWmBh3GqAj/X6wya6YnwodXPHhcwoGVcQLM1oQg/nCjCPB0yLOfA2WfUV
	7NEMq54ueJreMfoORoEiius/aEUpgdS+ot+CE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CZPnmgTH3v8kDNHX56mdKFeugW8ROEe2
	Lz5Ve6mNNO73hNvnXX33Wsd4R3BZaP95/CAso5MY9xe1mc0cFUY1Qk1StP6Kb96u
	AEHsLpwTzOKTnzUE4JgrruNgv9i7SG6dMPBw/40THVkhI39VRmWnCVPIcf7LUxk1
	KE4nSPmHKWc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1969228AD5;
	Tue, 16 Dec 2014 14:35:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5C95728AD2;
	Tue, 16 Dec 2014 14:35:56 -0500 (EST)
In-Reply-To: <1418755747-22506-4-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 16 Dec 2014 10:49:05 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C1533FFE-855A-11E4-9069-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261459>

Stefan Beller <sbeller@google.com> writes:

>     	* update(...) assumes to be always in a transaction
>     	* Caring about when to begin/commit transactions is put
>     	  into execute_commands

I am obviously biased, but I find that the new code structure and
separation of responsibility between update() and execute()
functions a lot clearer than the previous one.

Thanks.

>  builtin/receive-pack.c | 64 ++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 49 insertions(+), 15 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index e76e5d5..0803fd2 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -67,6 +67,8 @@ static const char *NONCE_SLOP = "SLOP";
>  static const char *nonce_status;
>  static long nonce_stamp_slop;
>  static unsigned long nonce_stamp_slop_limit;
> +struct strbuf err = STRBUF_INIT;
> +struct ref_transaction *transaction;
>  
>  static enum deny_action parse_deny_action(const char *var, const char *value)
>  {
> @@ -832,34 +834,32 @@ static const char *update(struct command *cmd, struct shallow_info *si)
>  				cmd->did_not_exist = 1;
>  			}
>  		}
> -		if (delete_ref(namespaced_name, old_sha1, 0)) {
> -			rp_error("failed to delete %s", name);
> +		if (ref_transaction_delete(transaction,
> +					   namespaced_name,
> +					   old_sha1,
> +					   0, old_sha1 != NULL,
> +					   "push", &err)) {
> +			rp_error("%s", err.buf);
> +			strbuf_release(&err);
>  			return "failed to delete";
>  		}
>  		return NULL; /* good */
>  	}
>  	else {
> -		struct strbuf err = STRBUF_INIT;
> -		struct ref_transaction *transaction;
> -
>  		if (shallow_update && si->shallow_ref[cmd->index] &&
>  		    update_shallow_ref(cmd, si))
>  			return "shallow error";
>  
> -		transaction = ref_transaction_begin(&err);
> -		if (!transaction ||
> -		    ref_transaction_update(transaction, namespaced_name,
> -					   new_sha1, old_sha1, 0, 1, "push",
> -					   &err) ||
> -		    ref_transaction_commit(transaction, &err)) {
> -			ref_transaction_free(transaction);
> -
> +		if (ref_transaction_update(transaction,
> +					   namespaced_name,
> +					   new_sha1, old_sha1,
> +					   0, 1, "push",
> +					   &err)) {
>  			rp_error("%s", err.buf);
>  			strbuf_release(&err);
>  			return "failed to update ref";
>  		}
>  
> -		ref_transaction_free(transaction);
>  		strbuf_release(&err);
>  		return NULL; /* good */
>  	}
> @@ -1059,6 +1059,16 @@ static void execute_commands(struct command *commands,
>  		return;
>  	}
>  
> +	if (use_atomic) {
> +		transaction = ref_transaction_begin(&err);
> +		if (!transaction) {
> +			error("%s", err.buf);
> +			strbuf_release(&err);
> +			for (cmd = commands; cmd; cmd = cmd->next)
> +				cmd->error_string = "transaction error";
> +			return;
> +		}
> +	}
>  	data.cmds = commands;
>  	data.si = si;
>  	if (check_everything_connected(iterate_receive_command_list, 0, &data))
> @@ -1086,8 +1096,23 @@ static void execute_commands(struct command *commands,
>  
>  		if (cmd->skip_update)
>  			continue;
> -
> +		if (!use_atomic) {
> +			transaction = ref_transaction_begin(&err);
> +			if (!transaction) {
> +				rp_error("%s", err.buf);
> +				strbuf_release(&err);
> +				cmd->error_string = "failed to start transaction";
> +			}
> +		}
>  		cmd->error_string = update(cmd, si);
> +		if (!use_atomic)
> +			if (ref_transaction_commit(transaction, &err)) {
> +				ref_transaction_free(transaction);
> +				rp_error("%s", err.buf);
> +				strbuf_release(&err);
> +				cmd->error_string = "failed to update ref";
> +			}
> +
>  		if (shallow_update && !cmd->error_string &&
>  		    si->shallow_ref[cmd->index]) {
>  			error("BUG: connectivity check has not been run on ref %s",
> @@ -1096,6 +1121,14 @@ static void execute_commands(struct command *commands,
>  		}
>  	}
>  
> +	if (use_atomic) {
> +		if (ref_transaction_commit(transaction, &err)) {
> +			rp_error("%s", err.buf);
> +			for (cmd = commands; cmd; cmd = cmd->next)
> +				cmd->error_string = err.buf;
> +		}
> +		ref_transaction_free(transaction);
> +	}
>  	if (shallow_update && !checked_connectivity)
>  		error("BUG: run 'git fsck' for safety.\n"
>  		      "If there are errors, try to remove "
> @@ -1543,5 +1576,6 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>  	sha1_array_clear(&shallow);
>  	sha1_array_clear(&ref);
>  	free((void *)push_cert_nonce);
> +	strbuf_release(&err);
>  	return 0;
>  }
