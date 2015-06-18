From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP v3 03/31] am: implement skeletal builtin am
Date: Thu, 18 Jun 2015 13:26:08 -0700
Message-ID: <xmqqbngcepb3.fsf@gitster.dls.corp.google.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
	<1434626743-8552-4-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 22:26:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5gO9-0002H7-5u
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 22:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753637AbbFRU0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 16:26:13 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:35807 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbbFRU0L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 16:26:11 -0400
Received: by iefd2 with SMTP id d2so5993239ief.2
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 13:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=UjCFyewpMqOTR7edkeE63DnkvB/GImNcX9uTrZNXfeM=;
        b=AynoBYr7nPskam4pIwf55azQAMVe+exhAgqIxUaupx3HZc6m6pDuiPkXpVO11LecsV
         Ti5mRy79DTdwO6go7w81ND2sKQNlx5z52dlc8Xuh4ZLl4c1yU/QMrH8NvnK8eDsgNwv7
         RG2nGWS2t8Bk9JMkHDzqFLbDqNDlqDC9BWtDK/N78+e2kO2y9RAjjXy4VnaTRWaJEYmf
         MbftGZOjL/yqN8f5vEoIVSxi4WPjdiKbtKdje5nFLU8p/m6gzd7J6MmOZs1yfYGkLBqT
         9Bg/EifLo5Lm3ztpqRGsQOMOeNrVvUQbqqlCR7VY3g6haqivwCfBNvUwK5vqWIYFoiWo
         +EqQ==
X-Received: by 10.50.164.233 with SMTP id yt9mr19672073igb.41.1434659171036;
        Thu, 18 Jun 2015 13:26:11 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e04a:861:67b3:9e25])
        by mx.google.com with ESMTPSA id g1sm5616383iog.4.2015.06.18.13.26.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jun 2015 13:26:10 -0700 (PDT)
In-Reply-To: <1434626743-8552-4-git-send-email-pyokagan@gmail.com> (Paul Tan's
	message of "Thu, 18 Jun 2015 19:25:15 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272068>

Paul Tan <pyokagan@gmail.com> writes:

> For the purpose of rewriting git-am.sh into a C builtin, implement a
> skeletal builtin/am.c that redirects to $GIT_EXEC_PATH/git-am if the
> environment variable _GIT_USE_BUILTIN_AM is not defined. Since in the
> Makefile git-am.sh takes precedence over builtin/am.c,
> $GIT_EXEC_PATH/git-am will contain the shell script git-am.sh, and thus
> this allows us to fall back on the functional git-am.sh when running the
> test suite for tests that depend on a working git-am implementation.
>
> Since git-am.sh cannot handle any environment modifications by
> setup_git_directory(), "am" has to be declared as NO_SETUP in git.c. On
> the other hand, to re-implement git-am.sh in builtin/am.c, we do need to
> run all the git dir and work tree setup logic that git.c does for us. As
> such, we work around this temporarily by copying the logic in git.c's
> run_builtin(), which amounts to:
>
> 	prefix = setup_git_directory();
> 	trace_repo_setup(prefix);
> 	setup_work_tree();
>
> This redirection should be removed when all the features of git-am.sh
> have been re-implemented in builtin/am.c.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>
> Notes:
>     v3
>     
>     * Style fixes
>     
>     * git-am.sh cannot handle the chdir() and GIT_DIR envionment variable
>       that setup_git_directory() sets, so we work around it by copying the
>       logic of git.c's run_builtin(), and running it only when we are using
>       the builtin am.
>
>  Makefile     |  1 +
>  builtin.h    |  1 +
>  builtin/am.c | 28 ++++++++++++++++++++++++++++
>  git.c        |  1 +
>  4 files changed, 31 insertions(+)
>  create mode 100644 builtin/am.c
>
> diff --git a/Makefile b/Makefile
> index 93e4fa2..ff9bdc0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -811,6 +811,7 @@ LIB_OBJS += xdiff-interface.o
>  LIB_OBJS += zlib.o
>  
>  BUILTIN_OBJS += builtin/add.o
> +BUILTIN_OBJS += builtin/am.o
>  BUILTIN_OBJS += builtin/annotate.o
>  BUILTIN_OBJS += builtin/apply.o
>  BUILTIN_OBJS += builtin/archive.o
> diff --git a/builtin.h b/builtin.h
> index ea3c834..f30cf00 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -30,6 +30,7 @@ extern int textconv_object(const char *path, unsigned mode, const unsigned char
>  extern int is_builtin(const char *s);
>  
>  extern int cmd_add(int argc, const char **argv, const char *prefix);
> +extern int cmd_am(int argc, const char **argv, const char *prefix);
>  extern int cmd_annotate(int argc, const char **argv, const char *prefix);
>  extern int cmd_apply(int argc, const char **argv, const char *prefix);
>  extern int cmd_archive(int argc, const char **argv, const char *prefix);
> diff --git a/builtin/am.c b/builtin/am.c
> new file mode 100644
> index 0000000..dbc8836
> --- /dev/null
> +++ b/builtin/am.c
> @@ -0,0 +1,28 @@
> +/*
> + * Builtin "git am"
> + *
> + * Based on git-am.sh by Junio C Hamano.
> + */
> +#include "cache.h"
> +#include "builtin.h"
> +#include "exec_cmd.h"
> +
> +int cmd_am(int argc, const char **argv, const char *prefix)
> +{
> +	/*
> +	 * FIXME: Once all the features of git-am.sh have been re-implemented
> +	 * in builtin/am.c, this preamble can be removed.
> +	 */

It's not broken, so "FIXME" is not quite appropriate (and that is
why I sent you "NEEDSWORK").  Also mention that the entry in the
commands[] array needs "RUN_SETUP | NEED_WORK_TREE" added, I think.

> +	if (!getenv("_GIT_USE_BUILTIN_AM")) {
> +		const char *path = mkpath("%s/git-am", git_exec_path());
> +
> +		if (sane_execvp(path, (char **)argv) < 0)
> +			die_errno("could not exec %s", path);
> +	} else {
> +		prefix = setup_git_directory();
> +		trace_repo_setup(prefix);
> +		setup_work_tree();
> +	}
> +
> +	return 0;
> +}
> diff --git a/git.c b/git.c
> index e7a7713..a671535 100644
> --- a/git.c
> +++ b/git.c
> @@ -370,6 +370,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>  
>  static struct cmd_struct commands[] = {
>  	{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
> +	{ "am", cmd_am, NO_SETUP },

NO_SETUP is for things like init and clone that start without a
repository and then work in the one that they create.  I think
imitating "archive" or "diff" is more appropriate.

>  	{ "annotate", cmd_annotate, RUN_SETUP },
>  	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
>  	{ "archive", cmd_archive },
