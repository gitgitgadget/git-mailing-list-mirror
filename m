From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Allow creation of arbitrary git-shell commands
Date: Tue, 20 Jul 2010 10:01:20 -0700
Message-ID: <7vr5iym6jj.fsf@alter.siamese.dyndns.org>
References: <1279602972-1264-1-git-send-email-gdb@mit.edu>
 <1279602972-1264-2-git-send-email-gdb@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: j.sixt@viscovery.net, git@vger.kernel.org, avarab@gmail.com,
	jrnieder@gmail.com
To: Greg Brockman <gdb@MIT.EDU>
X-From: git-owner@vger.kernel.org Tue Jul 20 19:01:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObGCN-0003nu-Mk
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 19:01:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761405Ab0GTRBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 13:01:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46730 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758478Ab0GTRBg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 13:01:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EB5F6C668D;
	Tue, 20 Jul 2010 13:01:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G5hjQ09FIBg74GnNTonKxFitXDI=; b=VxyrWb
	/weXybRt1U18fpsuQbABBy2YPVckoTTXKqRs+S+J+4nJaF7b85xXtk14O/hD7VnI
	uxgR2dvmwzf4fVuD4Axkyeitq8ziaLIeGTXVlRNp1QU3IhRolzZ2G2zONqhS9qSg
	hqI4yZRVdihNIrMcGhWi4UGLzJuHMCwWcE6OU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vam3vuES1yTl6i8PW2QIFp4a+1PsYeyq
	k/0OTipZNR2EJZ9T2syWcg08qd5EXTkNBcPkyqUymm7dxsP09Xn5dgPKh65ISLP3
	0QuncMPbo6+08QgMUwAU8cNMKrADeErWz08A5aGHhpirHedM+V0+cs8sV4OeSbi9
	oLBk3ac51rY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 42615C6685;
	Tue, 20 Jul 2010 13:01:28 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 063FAC6681; Tue, 20 Jul
 2010 13:01:21 -0400 (EDT)
In-Reply-To: <1279602972-1264-2-git-send-email-gdb@mit.edu> (Greg Brockman's
 message of "Tue\, 20 Jul 2010 01\:16\:09 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6FF0F5C8-9420-11DF-BFBC-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151330>

Greg Brockman <gdb@MIT.EDU> writes:

> This provides a mechanism for the server to expose custom
> functionality to clients.  My particular use case is that I would like
> a way of discovering all repositories available for cloning.  A
> client that clones via
>
>   git clone user@example.com
>
> can invoke a command by
>
>   ssh user@example.com $command
>
> Signed-off-by: Greg Brockman <gdb@mit.edu>
> ---

Just a few minor nits...

> +static char *make_cmd(const char *prog)
> +{
> +	char *prefix = xmalloc((strlen(prog) + strlen(COMMAND_DIR) + 2) * sizeof(char));

Since sizeof(char) by defintion is 1, I'd rather not to see the above
obfuscation.

> @@ -48,6 +64,8 @@ static struct commands {
>  int main(int argc, char **argv)
>  {
>  	char *prog;
> +	char *prog_cpy;
> +	const char **user_argv;
>  	struct commands *cmd;
>  	int devnull_fd;
>  
> @@ -77,6 +95,7 @@ int main(int argc, char **argv)
>  		die("What do you think I am? A shell?");
>  
>  	prog = argv[2];
> +	prog_cpy = xstrdup(prog);

Wouldn't changing "prog = argv[2]" to "prog = xstrdup(argv[2])" easier to
read?  Or name this new variable "prog_orig", have one comment here to say
"keep the original for reporting purposes, as prog will be munged", and
drop the two 4-line comment blocks below.

>  	if (!strncmp(prog, "git", 3) && isspace(prog[3]))
>  		/* Accept "git foo" as if the caller said "git-foo". */
>  		prog[3] = '-';
> @@ -99,5 +118,25 @@ int main(int argc, char **argv)
>  		}
>  		exit(cmd->exec(cmd->name, arg));
>  	}
> -	die("unrecognized command '%s'", prog);
> +
> +	if (split_cmdline(prog, &user_argv) != -1) {
> +		if (is_valid_cmd_name(user_argv[0])) {
> +			prog  = make_cmd(user_argv[0]);

Extra SP before "="?

> +			user_argv[0] = prog;
> +			execv(user_argv[0], (char *const *) user_argv);
> +			free(prog);
> +		}
> +		free(user_argv);
> +		/*
> +		 * split_cmdline modifies its argument in-place, so 'prog' now
> +		 * holds the actual command name
> +		 */
> +		die("unrecognized command '%s'", prog_cpy);
> +	} else {
> +		/*
> +		 * split_cmdline has clobbered prog and printed an
> +		 * error message, so print the original
> +		 */
> +		die("invalid command format '%s'", prog_cpy);

Hmm, we might want to fix split_cmdline to report the breakage better
then (perhaps not as part of this patch series).  Instead of seeing

    error: cmdline ends with \.
    fatal: invalid command format 'foo bar \'.

wouldn't it be nicer to see a single error message:

    fatal: invalid command 'foo bar\': cmdline ends with \.
