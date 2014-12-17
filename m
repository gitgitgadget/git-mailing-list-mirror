From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 4/6] receive-pack.c: use a single ref_transaction for atomic pushes
Date: Wed, 17 Dec 2014 15:26:14 -0800
Message-ID: <xmqqa92l97u1.fsf@gitster.dls.corp.google.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
	<1418841177-12152-1-git-send-email-sbeller@google.com>
	<1418841177-12152-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	sunshine@sunshineco.com, git@vger.kernel.org,
	Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 00:26:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1Nz6-0005N6-Os
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 00:26:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbaLQX0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 18:26:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58250 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751711AbaLQX0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 18:26:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E7EE628929;
	Wed, 17 Dec 2014 18:26:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NbE+GG5cFIVv2wYH9m9vpJNx3qM=; b=ckLo7Z
	EQ2O53uNhdwrZbi+UtCrRwlY7VpnLjMD69YTpZbWOdw+8wi78mdAs8BVQ9fL18ny
	+PqBcP3Ul3ZavXK5EV5UhOxcwI2VEFwfq6jCY33/oW7cgyNL2VWyNFlx7Ftyxd04
	o64d7fMSK5Fkc6OF9aF+FP3o0nJmD+B4Zq9Hc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YmrXmV32LcHjre6Kf2CO6Qz9umWShFAZ
	kuLWF6HCgfoiUF0Dh4tvW/c8yxIHjYlCx0n1x2WCGto71gGQ2hORnGaH0Gcatn50
	MxJyr1ERowY0N82+zIts/UnzrkcQAbfZ+qooslVpwLhte6TbLzbBJ4rIPLN68TKY
	clgLa7v9rWM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DBCAC28927;
	Wed, 17 Dec 2014 18:26:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 53E0928925;
	Wed, 17 Dec 2014 18:26:17 -0500 (EST)
In-Reply-To: <1418841177-12152-5-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 17 Dec 2014 10:32:55 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 19A73252-8644-11E4-9D0B-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261506>

Stefan Beller <sbeller@google.com> writes:

> @@ -1086,8 +1100,25 @@ static void execute_commands(struct command *commands,
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
> +				return;
> +			}
> +		}
>  		cmd->error_string = update(cmd, si);
> +		if (!use_atomic)
> +			if (ref_transaction_commit(transaction, &err)) {
> +				ref_transaction_free(transaction);
> +				rp_error("%s", err.buf);
> +				strbuf_release(&err);
> +				cmd->error_string = "failed to update ref";
> +				return;
> +			}

Hmm, should the code even attempt to commit if update() returned a
non NULL, signaling a failure?

Or would we want to do this instead?

	if (cmd->error_string)
        	goto transaction_abort;
	else if (!use_atomic) {
		if (ref_transaction_commit(...)) {
			...
                        cmd->error_string = "...";
                        return;
        	}
	}

and then ...

>  		if (shallow_update && !cmd->error_string &&
>  		    si->shallow_ref[cmd->index]) {
>  			error("BUG: connectivity check has not been run on ref %s",
> @@ -1096,10 +1127,32 @@ static void execute_commands(struct command *commands,
>  		}
>  	}
>  
> +	if (use_atomic) {
> +		/*
> +		 * update(...) may abort early (i.e. because the hook refused to
> +		 * update that ref) which then doesn't even record a transaction
> +		 * regarding that ref. Make sure all commands are without error
> +		 * and then commit atomically.
> +		 */
> +		for (cmd = commands; cmd; cmd = cmd->next)
> +			if (cmd->error_string)
> +				break;
> +		if (cmd) {
> +			for (cmd = commands; cmd; cmd = cmd->next)
> +				if (!cmd->error_string)
> +					cmd->error_string = "atomic push failure";
> +		} else if (ref_transaction_commit(transaction, &err)) {
> +			rp_error("%s", err.buf);
> +			for (cmd = commands; cmd; cmd = cmd->next)
> +				cmd->error_string = err.buf;
> +		}

... have the label to jump to here:

	transaction_abort:

> +		ref_transaction_free(transaction);

I was confused by the fact that you did not have any call to
transaction-abort, until I realized that there is no such API
function and ref_transaction_free() serves that "don't commit,
roll it back" purpose.

> +	}
>  	if (shallow_update && !checked_connectivity)
>  		error("BUG: run 'git fsck' for safety.\n"
>  		      "If there are errors, try to remove "
>  		      "the reported refs above");
> +	strbuf_release(&err);
>  }
>  
>  static struct command **queue_command(struct command **tail,
