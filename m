From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH/RFC 4/4] Add interactive mode to git-shell for user-friendliness
Date: Wed, 14 Jul 2010 12:27:23 +0200
Message-ID: <4C3D910B.7080401@viscovery.net>
References: <1279076475-27730-1-git-send-email-gdb@mit.edu> <1279076475-27730-5-git-send-email-gdb@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Greg Brockman <gdb@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Jul 14 12:27:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYzBf-0002Sr-OL
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 12:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942Ab0GNK1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 06:27:30 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:48175 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641Ab0GNK13 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 06:27:29 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OYzBU-0005XA-GT; Wed, 14 Jul 2010 12:27:24 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 3C4911660F;
	Wed, 14 Jul 2010 12:27:24 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <1279076475-27730-5-git-send-email-gdb@mit.edu>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150977>

I don't have an immediate need for features implemented by this series,
but I think they can be useful occasionally.

Am 7/14/2010 5:01, schrieb Greg Brockman:
> --- a/shell.c
> +++ b/shell.c
> @@ -1,8 +1,11 @@
> +#include <stdio.h>

Is it really needed? Doesn't cache.h pull it in already?

> +
>  #include "cache.h"
...
> +static int run(const char *prog)
> +{
> +	pid_t pid, res;
> +	int w;
> +	pid = fork();
> +	if (pid == -1) {
> +		perror("fork");
> +		exit(-1);
> +	} else if ( pid == 0 ) {
> +		execl(prog, prog, (char *) NULL);
> +		if (prog[0] != '\0')
> +			fprintf(stderr, "unrecognized command '%s'\n", prog);
> +		exit(127);
> +	} else {
> +		do {
> +			res = waitpid (pid, &w, 0);
> +		} while (res == -1 && errno == EINTR);
> +	}
> +}

Is there a reason that you duplicate functionality offered by run_command()?

> @@ -81,8 +105,30 @@ int main(int argc, char **argv)
>  	 * We do not accept anything but "-c" followed by "cmd arg",
>  	 * where "cmd" is a very limited subset of git commands.
>  	 */
> -	else if (argc != 3 || strcmp(argv[1], "-c"))
> -		die("What do you think I am? A shell?");
> +	else if (argc != 3 || strcmp(argv[1], "-c")) {
> +		if (chdir(COMMAND_DIR))
> +			die("Sorry, the interactive git-shell is not enabled");
> +		for (;;) {
> +			printf("git> ");
> +			if (fgets(line, MAX_LINE_LEN, stdin) == NULL) {
> +				printf("\n");
> +				exit(0);
> +			}
> +
> +			if (line[strlen(line) - 1] == '\n')
> +				line[strlen(line) - 1] = '\0';
> +
> +			if (!strcmp(line, "quit") || !strcmp(line, "logout") ||
> +				   !strcmp(line, "exit")) {
> +				exit(0);
> +			} else if (!strcmp(line, "")) {
> +			} else if (is_valid_cmd_name(line)) {
> +				run(line);
> +			} else {
> +				fprintf(stderr, "invalid command format '%s'\n", line);
> +			}
> +		};
> +	}

I can imagine that this loop grows in the future, so I suggest to move it
to a separate function right from the beginning.

I think it would make sense to print a help message before the first prompt.

-- Hannes
