From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] add: Use struct argv_array in run_add_interactive()
Date: Sun, 16 Mar 2014 12:42:21 +0100
Message-ID: <87a9cqxtcy.fsf@thomasrast.ch>
References: <53243620.8080401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 16 12:42:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WP9Ss-0007zD-Aa
	for gcvg-git-2@plane.gmane.org; Sun, 16 Mar 2014 12:42:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbaCPLme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2014 07:42:34 -0400
Received: from ip1.thgersdorf.net ([148.251.9.194]:56857 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175AbaCPLme (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2014 07:42:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 981BC4D6510;
	Sun, 16 Mar 2014 12:42:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ZBZFotrR-Uph; Sun, 16 Mar 2014 12:42:22 +0100 (CET)
Received: from hexa.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 7AAE84D64BD;
	Sun, 16 Mar 2014 12:42:22 +0100 (CET)
In-Reply-To: <53243620.8080401@gmail.com> (Fabian Ruch's message of "Sat, 15
	Mar 2014 12:14:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244188>

Fabian Ruch <bafain@gmail.com> writes:

> run_add_interactive() in builtin/add.c manually computes array bounds
> and allocates a static args array to build the add--interactive command
> line, which is error-prone. Use the argv-array helper functions instead.
>
> Signed-off-by: Fabian Ruch <bafain@gmail.com>

Thanks, this is a nicely done cleanup.

> ---
>  builtin/add.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index 4b045ba..459208a 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -15,6 +15,7 @@
>  #include "diffcore.h"
>  #include "revision.h"
>  #include "bulk-checkin.h"
> +#include "argv-array.h"
>  
>  static const char * const builtin_add_usage[] = {
>  	N_("git add [options] [--] <pathspec>..."),
> @@ -141,23 +142,21 @@ static void refresh(int verbose, const struct pathspec *pathspec)
>  int run_add_interactive(const char *revision, const char *patch_mode,
>  			const struct pathspec *pathspec)
>  {
> +	int status, i;
> +	struct argv_array argv = ARGV_ARRAY_INIT;
>  
> -	args = xcalloc(sizeof(const char *), (pathspec->nr + 6));
> -	ac = 0;
> -	args[ac++] = "add--interactive";
> +	argv_array_push(&argv, "add--interactive");
>  	if (patch_mode)
> -		args[ac++] = patch_mode;
> +		argv_array_push(&argv, patch_mode);
>  	if (revision)
> -		args[ac++] = revision;
> -	args[ac++] = "--";
> +		argv_array_push(&argv, revision);
> +	argv_array_push(&argv, "--");
>  	for (i = 0; i < pathspec->nr; i++)
>  		/* pass original pathspec, to be re-parsed */
> -		args[ac++] = pathspec->items[i].original;
> +		argv_array_push(&argv, pathspec->items[i].original);
>  
> -	status = run_command_v_opt(args, RUN_GIT_CMD);
> -	free(args);
> +	status = run_command_v_opt(argv.argv, RUN_GIT_CMD);
> +	argv_array_clear(&argv);
>  	return status;
>  }

-- 
Thomas Rast
tr@thomasrast.ch
