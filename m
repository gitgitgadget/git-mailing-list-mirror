From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/4] Allow creation of arbitrary git-shell commands
Date: Wed, 14 Jul 2010 08:27:58 -0700
Message-ID: <7vbpaaytfl.fsf@alter.siamese.dyndns.org>
References: <1279076475-27730-1-git-send-email-gdb@mit.edu>
 <1279076475-27730-2-git-send-email-gdb@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Greg Brockman <gdb@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Jul 14 17:28:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ3sd-0004J1-Ai
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 17:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757288Ab0GNP2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 11:28:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45950 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757227Ab0GNP2I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 11:28:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 291F4C4889;
	Wed, 14 Jul 2010 11:28:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gTZVwHYcVUv9hYlvX8LhJ82AzlY=; b=xNIw8J
	MSBGF1Cv6j5ITTryh81y+UwgbOCwFEJs4u5vUb83rX+UEyBHGthA7NTuNcF3/Tng
	HjCHTQyThHTMwJrCr+OEEMJ5WkJdX+BccVO4STX50aiIpPI/IEu5uhAH9Pdq21q/
	0iKOBL7P0MJ6vfG9RYl+xj+E/BiABZVsRnwxc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gQq4shAS6qXM0WFM3vHxtaa5O9AKBOXW
	3KXLbLSxz/lOoqwpzDRm/EEl4EK0dkEMhgj+GmwaZXl78I0hZOhCZoS4qDicMu0y
	WclwTkj00GYAGR7hgc6Vi4t3glyFzsjhmnCTXTdk+DDRlZ5ZjOyRVwaKsOVT7PJW
	e0OckOh6+qo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 009E0C4873;
	Wed, 14 Jul 2010 11:28:02 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 05D6DC486F; Wed, 14 Jul
 2010 11:27:59 -0400 (EDT)
In-Reply-To: <1279076475-27730-2-git-send-email-gdb@mit.edu> (Greg Brockman's
 message of "Tue\, 13 Jul 2010 23\:01\:12 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 64718F28-8F5C-11DF-B993-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150995>

Greg Brockman <gdb@MIT.EDU> writes:

> This provides a mechanism for the server to expose custom
> functionality to clients.  My particular use case is that I would like
> a way of discovering all repositories available for cloning.  A
> client that clones via
>   git clone user@example.com
> can invoke a command by
>   ssh user@example.com $command

Please have a blank line above and below sample command display like these
for readability.

> Signed-off-by: Greg Brockman <gdb@mit.edu>
> ---
>  shell.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
>
> diff --git a/shell.c b/shell.c
> index e4864e0..3fee0ed 100644
> --- a/shell.c
> +++ b/shell.c
> @@ -3,6 +3,8 @@
>  #include "exec_cmd.h"
>  #include "strbuf.h"
>  
> +#define COMMAND_DIR "git-shell-commands"
> +
>  static int do_generic_cmd(const char *me, char *arg)
>  {
>  	const char *my_argv[4];
> @@ -33,6 +35,12 @@ static int do_cvs_cmd(const char *me, char *arg)
>  	return execv_git_cmd(cvsserver_argv);
>  }
>  
> +static int is_valid_cmd_name(const char *cmd)
> +{
> +	/* Test command contains no . or / characters */
> +	return cmd[strcspn(cmd, "./")] == '\0';
> +}
> +
>  
>  static struct commands {
>  	const char *name;
> @@ -99,5 +107,13 @@ int main(int argc, char **argv)
>  		}
>  		exit(cmd->exec(cmd->name, arg));
>  	}
> +
> +	/* Shell should be spawned with cwd in the git user's home directory */
> +	if (chdir(COMMAND_DIR))
> +		die("unrecognized command '%s'", prog);

Hmm, could you justify "should be" above please?

An example would be "All of the custom commands I wrote to give added
features to users at my installation wanted to be in that directory, not
at the user's home directory, as they mostly operated on files in that
directory", but please do not make me (or other reviewers) guess why.

What I am getting at is that it may be more natural and useful to run
these custom commands in the user's $HOME directory---you would need to
make sure that execl() finds the command you get from the request, perhaps
by prefixing COMMAND_DIR / to the command name, though.

> +	if (is_valid_cmd_name(prog))
> +		execl(prog, prog, (char *) NULL);
> +
>  	die("unrecognized command '%s'", prog);
>  }
