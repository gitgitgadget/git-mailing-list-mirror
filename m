From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH] git.c: prevent change of environment variables
Date: Sun, 11 Jan 2015 00:07:46 +0600
Message-ID: <CANCZXo56nqzDw6CFUNXfRg+bjq2Z9TdzhZ6uZcEeu9zZLExnQQ@mail.gmail.com>
References: <1420894416-22615-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 19:07:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YA0Rz-0008DJ-W6
	for gcvg-git-2@plane.gmane.org; Sat, 10 Jan 2015 19:07:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754053AbbAJSHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2015 13:07:48 -0500
Received: from mail-oi0-f52.google.com ([209.85.218.52]:41759 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160AbbAJSHr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2015 13:07:47 -0500
Received: by mail-oi0-f52.google.com with SMTP id a3so15917797oib.11
        for <git@vger.kernel.org>; Sat, 10 Jan 2015 10:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vaGa9oymDWQiDcjkWYKXrI+sImdD2f/nwXh/19P7/pA=;
        b=KXGdlmt2M+rXZFRzY2ZUfBri14dhB/CLCCQrTsQynj75cj9dCi1GcQpnB0jexin+Vn
         FwPpFbnugimVuzVZ8PJFyx4bd8G6cfGVkunDiNnzKbcHXJCVLrnCZOnKqZ/lfJ68UK2C
         jCQLSdkropYJdBYd9gDGWzU6KgLxLMxXnBWZt+JLRCUnZNKTiZmVl5oT2nqe4+/E3yU3
         n63hZCrAMB8pkplvp6qIh0hsjfFf31Ls95e+Nb/IzTp4spchAZ8mjWyNGKDniODZJK5T
         ykVkSCcqr3A786T2VXuV8Q0DSdCnjQ3sW5Rt1G/moFyuu84n/owenizRss0hC51VIGCF
         RsTQ==
X-Received: by 10.182.125.72 with SMTP id mo8mr13082759obb.61.1420913266877;
 Sat, 10 Jan 2015 10:07:46 -0800 (PST)
Received: by 10.182.26.42 with HTTP; Sat, 10 Jan 2015 10:07:46 -0800 (PST)
In-Reply-To: <1420894416-22615-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262266>

There is aliasing of git -c .... in t1300-repo-config.sh, but I see:

die("alias '%s' changes environment variables\n"
      "You can use '!git' in the alias to do this.",
      alias_command);

at git.c, how to be here?

Thank you.

2015-01-10 18:53 GMT+06:00 Alexander Kuleshov <kuleshovmail@gmail.com>:
> We can't change environment variables in aliases which doesn't start with '!'
>
> * 'git --exec-path=path' changes $GIT_EXEC_PATH variable in
> git_set_argv_exec_path
>
> * 'git -p/--paginate' sets 'use_pager' to 1 and commit_pager_choice
> will change $GIT_PAGER_IN_USE variable in setup_pager(void) from pager.c
>
> * 'git -c' calls git_config_push_parameter which will change
> $GIT_CONFIG_PARAMETERS variable
>
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
>  git.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/git.c b/git.c
> index c9bec99..3e87f05 100644
> --- a/git.c
> +++ b/git.c
> @@ -89,8 +89,11 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>                  * Check remaining flags.
>                  */
>                 if (skip_prefix(cmd, "--exec-path", &cmd)) {
> -                       if (*cmd == '=')
> +                       if (*cmd == '=') {
>                                 git_set_argv_exec_path(cmd + 1);
> +                               if (envchanged)
> +                                       *envchanged = 1;
> +                       }
>                         else {
>                                 puts(git_exec_path());
>                                 exit(0);
> @@ -106,6 +109,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>                         exit(0);
>                 } else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
>                         use_pager = 1;
> +                       if (envchanged)
> +                               *envchanged = 1;
>                 } else if (!strcmp(cmd, "--no-pager")) {
>                         use_pager = 0;
>                         if (envchanged)
> @@ -171,6 +176,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>                                 usage(git_usage_string);
>                         }
>                         git_config_push_parameter((*argv)[1]);
> +                       if (envchanged)
> +                               *envchanged = 1;
>                         (*argv)++;
>                         (*argc)--;
>                 } else if (!strcmp(cmd, "--literal-pathspecs")) {
> --
> 2.2.1.531.g5addc96.dirty
>



-- 
_________________________
0xAX
