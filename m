From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/5] Move reset_index_file() to a new reset.c
Date: Sat, 24 May 2008 00:21:42 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0805240016230.19665@iabervon.org>
References: <cover.1211586801.git.vmiklos@frugalware.org> <40d6845554a032ef66a20289aea6c7b2f157fed3.1211586801.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat May 24 06:23:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzlHj-0001oh-5L
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 06:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbYEXEVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 00:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbYEXEVy
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 00:21:54 -0400
Received: from iabervon.org ([66.92.72.58]:41290 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750835AbYEXEVx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 00:21:53 -0400
Received: (qmail 30207 invoked by uid 1000); 24 May 2008 04:21:42 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 May 2008 04:21:42 -0000
In-Reply-To: <40d6845554a032ef66a20289aea6c7b2f157fed3.1211586801.git.vmiklos@frugalware.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82793>

On Sat, 24 May 2008, Miklos Vajna wrote:

> This is needed as we want to use it later in builtin-merge.
> 
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>  Makefile        |    2 ++
>  builtin-reset.c |   17 +----------------
>  reset.c         |   28 ++++++++++++++++++++++++++++
>  reset.h         |    6 ++++++
>  4 files changed, 37 insertions(+), 16 deletions(-)
>  create mode 100644 reset.c
>  create mode 100644 reset.h
> 
> diff --git a/Makefile b/Makefile
> index a2de075..91d938a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -364,6 +364,7 @@ LIB_H += quote.h
>  LIB_H += reflog-walk.h
>  LIB_H += refs.h
>  LIB_H += remote.h
> +LIB_H += reset.h
>  LIB_H += revision.h
>  LIB_H += run-command.h
>  LIB_H += sha1-lookup.h
> @@ -443,6 +444,7 @@ LIB_OBJS += read-cache.o
>  LIB_OBJS += reflog-walk.o
>  LIB_OBJS += refs.o
>  LIB_OBJS += remote.o
> +LIB_OBJS += reset.o
>  LIB_OBJS += revision.o
>  LIB_OBJS += run-command.o
>  LIB_OBJS += server-info.o
> diff --git a/builtin-reset.c b/builtin-reset.c
> index 79424bb..6e6e168 100644
> --- a/builtin-reset.c
> +++ b/builtin-reset.c
> @@ -18,6 +18,7 @@
>  #include "tree.h"
>  #include "branch.h"
>  #include "parse-options.h"
> +#include "reset.h"
>  
>  static const char * const git_reset_usage[] = {
>  	"git-reset [--mixed | --soft | --hard] [-q] [<commit>]",
> @@ -49,22 +50,6 @@ static inline int is_merge(void)
>  	return !access(git_path("MERGE_HEAD"), F_OK);
>  }
>  
> -static int reset_index_file(const unsigned char *sha1, int is_hard_reset)
> -{
> -	int i = 0;
> -	const char *args[6];
> -
> -	args[i++] = "read-tree";
> -	args[i++] = "-v";
> -	args[i++] = "--reset";
> -	if (is_hard_reset)
> -		args[i++] = "-u";
> -	args[i++] = sha1_to_hex(sha1);
> -	args[i] = NULL;
> -
> -	return run_command_v_opt(args, RUN_GIT_CMD);
> -}
> -
>  static void print_new_head_line(struct commit *commit)
>  {
>  	const char *hex, *body;
> diff --git a/reset.c b/reset.c
> new file mode 100644
> index 0000000..a75fec6
> --- /dev/null
> +++ b/reset.c
> @@ -0,0 +1,28 @@
> +/*
> + * generic fucntion(s) from the "git reset" builtin command
> + *
> + * Copyright (c) 2007 Carlos Rica
> + *
> + * Based on git-reset.sh, which is
> + *
> + * Copyright (c) 2005, 2006 Linus Torvalds and Junio C Hamano
> + */
> +
> +#include "cache.h"
> +#include "run-command.h"
> +
> +int reset_index_file(const unsigned char *sha1, int is_hard_reset)
> +{
> +	int i = 0;
> +	const char *args[6];
> +
> +	args[i++] = "read-tree";
> +	args[i++] = "-v";
> +	args[i++] = "--reset";
> +	if (is_hard_reset)
> +		args[i++] = "-u";
> +	args[i++] = sha1_to_hex(sha1);
> +	args[i] = NULL;
> +
> +	return run_command_v_opt(args, RUN_GIT_CMD);
> +}

You might as well use unpack_trees() directly here, instead of running a 
separate command. In fact, you might skip making a function here, and just 
call unpack_trees() where you'd use it. (And maybe have a function to 
initialize a struct unpack_tree_options to some common defaults to make it 
easy to see what's being done.)

	-Daniel
*This .sig left intentionally blank*
