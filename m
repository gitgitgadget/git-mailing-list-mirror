From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] run-command: Add interpreter permissions check
Date: Tue, 06 Dec 2011 14:47:24 -0800
Message-ID: <7vk469e2rn.fsf@alter.siamese.dyndns.org>
References: <op.v5e8mgbc0aolir@keputer>
 <1323207503-26581-1-git-send-email-fransklaver@gmail.com>
 <1323207503-26581-3-git-send-email-fransklaver@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 23:47:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY3nX-0006Ln-Sw
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 23:47:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755502Ab1LFWrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 17:47:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58179 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755488Ab1LFWr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 17:47:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 207046559;
	Tue,  6 Dec 2011 17:47:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X3eAk3XQqFIZ3RgARDfRzD+Q93w=; b=dBuqfH
	my9ELiLBzLXCEL4Uqh2hQPFZo/1W0xhRWbGBoG+2RKiYgZwmX89oXC8tQdZl558K
	wDKMYxvH1CBsPYMplLzZnwf/V0Y7hdxy3wkj6OIXvkhydZHkdcL2aI2/XGnhGbEa
	+VqXAVsVw0OLAno4V/Z9TReBGPeJCpP2AEUjM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M3Z9kIxQRMMJ/WQuRjFCKXHS4aWhR9aW
	LOPcKSNPwXPikk1JvUK+jK2Y+HkrWFwPrWWGNFHYP1lFrP5JlYrrXM4ZxzZF29jP
	7l2kzK329qwEzJgIGv7jQ0HHjVd4Uk7KyQerzpAuRHFsl8fHzFcsV1oODLVFAXZj
	Cmw3eFID/0w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 164556558;
	Tue,  6 Dec 2011 17:47:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 344016553; Tue,  6 Dec 2011
 17:47:26 -0500 (EST)
In-Reply-To: <1323207503-26581-3-git-send-email-fransklaver@gmail.com> (Frans
 Klaver's message of "Tue, 6 Dec 2011 22:38:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 44DD2522-205C-11E1-B437-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186399>

Frans Klaver <fransklaver@gmail.com> writes:

> If a script is started and the interpreter of that script given in the
> shebang cannot be started due to permissions, we can get a rather
> obscure situation. All permission checks pass for the script itself,
> but we still get EACCES from execvp.
>
> Try to find out if the above is the case and warn the user about it.
>
> Signed-off-by: Frans Klaver <fransklaver@gmail.com>
> ---
>  run-command.c          |   66 +++++++++++++++++++++++++++++++++++++++++++----
>  t/t0061-run-command.sh |   22 ++++++++++++++++
>  2 files changed, 82 insertions(+), 6 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index 5e38c5a..b8cf8d4 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -194,6 +194,63 @@ static int have_read_execute_permissions(const char *path)
>  	return 0;
>  }
>  
> +static void check_interpreter(const char *cmd)
> +{
> +	FILE *f;
> +	struct strbuf sb = STRBUF_INIT;
> +	/* bash reads an 80 character line when determining the interpreter.
> +	 * BSD apparently only allows 32 characters, as it is the size of
> +	 * your average binary executable header.
> +	 */
> +	char firstline[80];
> +	char *interpreter = NULL;
> +	size_t s, i;
> +
> +	f = fopen(cmd, "r");
> +	if (!f) {
> +		error("cannot open file '%s': %s\n", cmd, strerror(errno));
> +		return;
> +	}
> +
> +	s = fread(firstline, 1, sizeof(firstline), f);
> +	if (s < 2) {
> +		trace_printf("cannot determine file type");
> +		fclose(f);
> +		return;
> +	}
> +
> +	if (firstline[0] != '#' || firstline[1] != '!') {
> +		trace_printf("file '%s' is not a script or"
> +				" is a script without '#!'", cmd);
> +		fclose(f);
> +		return;
> +	}

Nice touches to silently pass scripts that do not begin with she-bang.

> +
> +	/* see if the given path has the executable bit set */
> +	for (i = 2; i < s; i++) {
> +		if (!interpreter && firstline[i] != ' ' && firstline[i] != '\t')
> +			interpreter = firstline + i;
> +
> +		if (interpreter && (firstline[i] == ' ' ||
> +				firstline[i] == '\n')) {

Curious.

"#!<TAB>/bin/bash<TAB><LF>" would cause you to check "/bin/bash<TAB>"?

> +			strbuf_add(&sb, interpreter,
> +					(firstline + i) - interpreter);
> +			break;
> +		}

Wouldn't strcspn() work better instead of this loop?

> +	}
> +	if (!sb.len) {
> +		error("could not determine interpreter");
> +		strbuf_release(&sb);
> +		return;
> +	}
> +
> +	if (!have_read_execute_permissions(sb.buf))
> +		error("bad interpreter: no read/execute permissions on '%s'\n",
> +				sb.buf);
> +
> +	strbuf_release(&sb);
> +}
> +
>  static void diagnose_execvp_eacces(const char *cmd, const char **argv)
>  {
>  	/* man 2 execve states that EACCES is returned for:
> @@ -209,8 +266,8 @@ static void diagnose_execvp_eacces(const char *cmd, const char **argv)
>  	char *next;
>  
>  	if (strchr(cmd, '/')) {
> -		if (!have_read_execute_permissions(cmd))
> -			error("no read/execute permissions on '%s'\n", cmd);
> +		if (have_read_execute_permissions(cmd))
> +			check_interpreter(cmd);

I would have expected the overall logic to be more like this:

	if we cannot read and execute it then
        	that in itself is an error (i.e. the error message from [1/2])
	else if we can read it then
		let's see if there is an error in the interpreter.

It is unnatural to see "if we can read and execute, then see if there is
anything wrong with the interpreter" and _nothing else_ here. If you made
the "have_read_execute_permissions()" to issue the error message you used
to give in your [1/2] patch here, that is OK from the point of view of the
overall code structure, but then the function is no longer "do we have
permissions" boolean check and needs to be renamed. And if you didn't,
then I have to wonder why we do not need the error message you added in
your [1/2].

> @@ -233,10 +290,7 @@ static void diagnose_execvp_eacces(const char *cmd, const char **argv)
>  				error("no read/execute permissions on '%s'\n",
>  						sb.buf);
>  			else
> -				warn("file '%s' exists and permissions "
> -				"seem OK.\nIf this is a script, see if you "
> -				"have sufficient privileges to run the "
> -				"interpreter", sb.buf);
> +				check_interpreter(sb.buf);
>  		}
>  
>  		strbuf_release(&sb);
> diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
> index b39bd16..39bfaef 100755
> --- a/t/t0061-run-command.sh
> +++ b/t/t0061-run-command.sh
> @@ -13,6 +13,18 @@ cat >hello-script <<-EOF
>  EOF
>  >empty
>  
> +cat >someinterpreter <<-EOF
> +	#!$SHELL_PATH
> +	cat hello-script
> +EOF
> +>empty
> +
> +cat >incorrect-interpreter-script <<-EOF
> +	#!someinterpreter
> +	cat hello-script
> +EOF
> +>empty
> +
>  test_expect_success 'start_command reports ENOENT' '
>  	test-run-command start-command-ENOENT ./does-not-exist
>  '
> @@ -48,4 +60,14 @@ test_expect_success POSIXPERM 'run_command reports EACCES, search path permision
>  	grep "no read/execute permissions on" err
>  '
>  
> +test_expect_success POSIXPERM 'run_command reports EACCES, interpreter fails' '
> +	cat incorrect-interpreter-script >hello.sh &&
> +	chmod +x hello.sh &&
> +	chmod -x someinterpreter &&
> +	test_must_fail test-run-command run-command ./hello.sh 2>err &&
> +
> +	grep "fatal: cannot exec.*hello.sh" err &&
> +	grep "bad interpreter" err
> +'
> +
>  test_done
