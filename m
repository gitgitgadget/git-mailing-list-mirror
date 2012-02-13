From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] git push: verify refs early
Date: Mon, 13 Feb 2012 14:16:13 -0800
Message-ID: <7v4nuucrbm.fsf@alter.siamese.dyndns.org>
References: <7vhazobto3.fsf@alter.siamese.dyndns.org>
 <1329164235-29955-1-git-send-email-drizzd@aon.at>
 <1329164235-29955-4-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Feb 13 23:16:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx4C5-0003EM-Vi
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 23:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756040Ab2BMWQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 17:16:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56839 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754727Ab2BMWQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 17:16:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A814E66C6;
	Mon, 13 Feb 2012 17:16:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xFfq5hqYv1vU5gptp7tqfW2FRAo=; b=eftgzW
	rRTJEfxTaxy+m7pZvQ+s+Mz/9WlmhNpO0Wvnvr9Sm/ti42J4waXCZ2LOLzK5gMCR
	sNIoB5dS4WPLoadh1AWMqJU8AuoZZ4DlDheGm1P9MHvx38xZcn9g09IMZEVwewmQ
	QgkPDqwpnESaA7uIyxDvsbZ92rRa2V+ZyBk4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fgTttN1PWL++9LylAr6tApqByy1icKl6
	T1RLR3zdZtbwzb75XwSMjG9/bnpLhqkA6Ngx12Y/13/mlNHJRGs4eKwRc2pdS0z2
	WSxRVuhony4soA8deqYtC6Ujau97vRp6dNIRackKaWFWRJOGQUXcV6djPiQPQDQX
	34MKvbxru6g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E4F866C5;
	Mon, 13 Feb 2012 17:16:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8005566C4; Mon, 13 Feb 2012
 17:16:14 -0500 (EST)
In-Reply-To: <1329164235-29955-4-git-send-email-drizzd@aon.at> (Clemens
 Buchacher's message of "Mon, 13 Feb 2012 21:17:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 57C0C4EA-5690-11E1-8E11-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190678>

Clemens Buchacher <drizzd@aon.at> writes:

> I suppose with some effort, this could be done for smart HTTP as well.
> But I am not sure if we actually want the overhead of the additional
> ping-pong for HTTP.

Hrm, I am confused.

The updated protocol exchange, if I am reading your patch correctly, would
go like this (S stands for the sender, R for the receiver):

        R: Here are the tips of my refs
        ----
        S: I'd like to update your refs this way
        ----
      + R: No you cannot because all updates will fail, go away
        or
      + R: You may proceed, as some updates may succeed
        ----
        S: Here is the packfile
        ----
        R: Here is how I processed your request

Given that this makes the sender stall for both smart HTTP and native
protocol, don't your worries about the additional ping-pong apply equally
to both transports?

If it is not worth doing for smart HTTP, I wonder if it is worth doing for
native transport.  After all, "all updates will fail" is hopefully the
less likely case, and with this protocol extension, we end up penalizing
the common case with an extra stall for everybody, regardless of the
transport.

I dunno.

All other patches in this "series" looked nice fixes and improvements, but
I am not sure about this change.  At least I am not yet convinced.

>  builtin/receive-pack.c |   83 ++++++++++++++++++++++++++++++++++++++----------
>  builtin/send-pack.c    |   43 +++++++++++++++++--------
>  send-pack.h            |    3 +-
>  3 files changed, 97 insertions(+), 32 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 0afb8b2..0129d9c 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -34,6 +34,8 @@ static int unpack_limit = 100;
>  static int report_status;
>  static int use_sideband;
>  static int quiet;
> +static int verify_refs;
> +static int stateless_rpc;
>  static int prefer_ofs_delta = 1;
>  static int auto_update_server_info;
>  static int auto_gc = 1;
> @@ -123,7 +125,7 @@ static void show_ref(const char *path, const unsigned char *sha1)
>  	else
>  		packet_write(1, "%s %s%c%s%s\n",
>  			     sha1_to_hex(sha1), path, 0,
> -			     " report-status delete-refs side-band-64k quiet",
> +			     " report-status delete-refs side-band-64k quiet verify-refs",
>  			     prefer_ofs_delta ? " ofs-delta" : "");
>  	sent_capabilities = 1;
>  }
> @@ -410,14 +412,13 @@ static void refuse_unconfigured_deny_delete_current(void)
>  		rp_error("%s", refuse_unconfigured_deny_delete_current_msg[i]);
>  }
>  
> -static const char *update(struct command *cmd)
> +static const char *verify_ref(struct command *cmd)
>  {
>  	const char *name = cmd->ref_name;
>  	struct strbuf namespaced_name_buf = STRBUF_INIT;
>  	const char *namespaced_name;
>  	unsigned char *old_sha1 = cmd->old_sha1;
>  	unsigned char *new_sha1 = cmd->new_sha1;
> -	struct ref_lock *lock;
>  
>  	/* only refs/... are allowed */
>  	if (prefixcmp(name, "refs/") || check_refname_format(name + 5, 0)) {
> @@ -444,12 +445,6 @@ static const char *update(struct command *cmd)
>  		}
>  	}
>  
> -	if (!is_null_sha1(new_sha1) && !has_sha1_file(new_sha1)) {
> -		error("unpack should have generated %s, "
> -		      "but I can't find it!", sha1_to_hex(new_sha1));
> -		return "bad pack";
> -	}
> -
>  	if (!is_null_sha1(old_sha1) && is_null_sha1(new_sha1)) {
>  		if (deny_deletes && !prefixcmp(name, "refs/heads/")) {
>  			rp_error("denying ref deletion for %s", name);
> @@ -473,6 +468,27 @@ static const char *update(struct command *cmd)
>  		}
>  	}
>  
> +	return NULL;
> +}
> +
> +static const char *update(struct command *cmd)
> +{
> +	const char *name = cmd->ref_name;
> +	struct strbuf namespaced_name_buf = STRBUF_INIT;
> +	const char *namespaced_name;
> +	unsigned char *old_sha1 = cmd->old_sha1;
> +	unsigned char *new_sha1 = cmd->new_sha1;
> +	struct ref_lock *lock;
> +
> +	strbuf_addf(&namespaced_name_buf, "%s%s", get_git_namespace(), name);
> +	namespaced_name = strbuf_detach(&namespaced_name_buf, NULL);
> +
> +	if (!is_null_sha1(new_sha1) && !has_sha1_file(new_sha1)) {
> +		error("unpack should have generated %s, "
> +		      "but I can't find it!", sha1_to_hex(new_sha1));
> +		return "bad pack";
> +	}
> +
>  	if (deny_non_fast_forwards && !is_null_sha1(new_sha1) &&
>  	    !is_null_sha1(old_sha1) &&
>  	    !prefixcmp(name, "refs/heads/")) {
> @@ -692,10 +708,41 @@ static int iterate_receive_command_list(void *cb_data, unsigned char sha1[20])
>  	return -1; /* end of list */
>  }
>  
> +static int verify_ref_commands(struct command *commands)
> +{
> +	unsigned char sha1[20];
> +	int commands_ok;
> +	struct command *cmd;
> +
> +	free(head_name_to_free);
> +	head_name = head_name_to_free = resolve_refdup("HEAD", sha1, 0, NULL);
> +
> +	commands_ok = 0;
> +	for (cmd = commands; cmd; cmd = cmd->next) {
> +		cmd->error_string = verify_ref(cmd);
> +		if (!cmd->error_string)
> +			commands_ok++;
> +	}
> +
> +	if (verify_refs && !stateless_rpc) {
> +		struct strbuf buf = STRBUF_INIT;
> +
> +		packet_buf_write(&buf, "verify-refs %s\n",
> +			 commands_ok > 0 ? "ok" : "no valid refs");
> +
> +		if (use_sideband)
> +			send_sideband(1, 1, buf.buf, buf.len, use_sideband);
> +		else
> +			safe_write(1, buf.buf, buf.len);
> +		strbuf_release(&buf);
> +	}
> +
> +	return commands_ok;
> +}
> +
>  static void execute_commands(struct command *commands, const char *unpacker_error)
>  {
>  	struct command *cmd;
> -	unsigned char sha1[20];
>  
>  	if (unpacker_error) {
>  		for (cmd = commands; cmd; cmd = cmd->next)
> @@ -718,9 +765,6 @@ static void execute_commands(struct command *commands, const char *unpacker_erro
>  
>  	check_aliased_updates(commands);
>  
> -	free(head_name_to_free);
> -	head_name = head_name_to_free = resolve_refdup("HEAD", sha1, 0, NULL);
> -
>  	for (cmd = commands; cmd; cmd = cmd->next) {
>  		if (cmd->error_string)
>  			continue;
> @@ -766,6 +810,8 @@ static struct command *read_head_info(void)
>  				use_sideband = LARGE_PACKET_MAX;
>  			if (parse_feature_request(feature_list, "quiet"))
>  				quiet = 1;
> +			if (parse_feature_request(feature_list, "verify-refs"))
> +				verify_refs = 1;
>  		}
>  		cmd = xcalloc(1, sizeof(struct command) + len - 80);
>  		hashcpy(cmd->old_sha1, old_sha1);
> @@ -905,7 +951,6 @@ static int delete_only(struct command *commands)
>  int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>  {
>  	int advertise_refs = 0;
> -	int stateless_rpc = 0;
>  	int i;
>  	char *dir = NULL;
>  	struct command *commands;
> @@ -962,11 +1007,15 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>  		return 0;
>  
>  	if ((commands = read_head_info()) != NULL) {
> +		int commands_ok;
>  		const char *unpack_status = NULL;
>  
> -		if (!delete_only(commands))
> -			unpack_status = unpack();
> -		execute_commands(commands, unpack_status);
> +		commands_ok = verify_ref_commands(commands);
> +		if (!verify_refs || commands_ok > 0) {
> +			if (!delete_only(commands))
> +				unpack_status = unpack();
> +			execute_commands(commands, unpack_status);
> +		}
>  		if (pack_lockfile)
>  			unlink_or_warn(pack_lockfile);
>  		if (report_status)
> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index 71f258e..7d514ca 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -265,6 +265,8 @@ int send_pack(struct send_pack_args *args,
>  		use_sideband = 1;
>  	if (!server_supports("quiet"))
>  		args->quiet = 0;
> +	if (server_supports("verify-refs"))
> +		args->verify_refs = 1;
>  
>  	if (!remote_refs) {
>  		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
> @@ -303,12 +305,13 @@ int send_pack(struct send_pack_args *args,
>  			char *old_hex = sha1_to_hex(ref->old_sha1);
>  			char *new_hex = sha1_to_hex(ref->new_sha1);
>  
> -			if (!cmds_sent && (status_report || use_sideband || args->quiet)) {
> -				packet_buf_write(&req_buf, "%s %s %s%c%s%s%s",
> +			if (!cmds_sent && (status_report || use_sideband || args->quiet || args->verify_refs)) {
> +				packet_buf_write(&req_buf, "%s %s %s%c%s%s%s%s",
>  					old_hex, new_hex, ref->name, 0,
>  					status_report ? " report-status" : "",
>  					use_sideband ? " side-band-64k" : "",
> -					args->quiet ? " quiet" : "");
> +					args->quiet ? " quiet" : "",
> +					args->verify_refs ? " verify-refs" : "");
>  			}
>  			else
>  				packet_buf_write(&req_buf, "%s %s %s",
> @@ -341,17 +344,29 @@ int send_pack(struct send_pack_args *args,
>  		in = demux.out;
>  	}
>  
> -	if (new_refs && cmds_sent) {
> -		if (pack_objects(out, remote_refs, extra_have, args) < 0) {
> -			for (ref = remote_refs; ref; ref = ref->next)
> -				ref->status = REF_STATUS_NONE;
> -			if (args->stateless_rpc)
> -				close(out);
> -			if (git_connection_is_socket(conn))
> -				shutdown(fd[0], SHUT_WR);
> -			if (use_sideband)
> -				finish_async(&demux);
> -			return -1;
> +	if (cmds_sent) {
> +		int verify_refs_status = 0;
> +
> +		if (args->verify_refs && !args->stateless_rpc) {
> +			char line[1000];
> +			int len = packet_read_line(in, line, sizeof(line));
> +			if (len < 15 || memcmp(line, "verify-refs ", 12))
> +				return error("did not receive remote status");
> +			verify_refs_status = memcmp(line, "verify-refs ok\n", 15);
> +		}
> +
> +		if (!verify_refs_status && new_refs) {
> +			if (pack_objects(out, remote_refs, extra_have, args) < 0) {
> +				for (ref = remote_refs; ref; ref = ref->next)
> +					ref->status = REF_STATUS_NONE;
> +				if (args->stateless_rpc)
> +					close(out);
> +				if (git_connection_is_socket(conn))
> +					shutdown(fd[0], SHUT_WR);
> +				if (use_sideband)
> +					finish_async(&demux);
> +				return -1;
> +			}
>  		}
>  	}
>  	if (args->stateless_rpc && cmds_sent)
> diff --git a/send-pack.h b/send-pack.h
> index 05d7ab1..87edaa5 100644
> --- a/send-pack.h
> +++ b/send-pack.h
> @@ -11,7 +11,8 @@ struct send_pack_args {
>  		use_thin_pack:1,
>  		use_ofs_delta:1,
>  		dry_run:1,
> -		stateless_rpc:1;
> +		stateless_rpc:1,
> +		verify_refs:1;
>  };
>  
>  int send_pack(struct send_pack_args *args,
