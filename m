From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] [GSoC][MICRO] Forbid "log --graph --no-walk"
Date: Fri, 6 Mar 2015 04:56:53 -0500
Message-ID: <CAPig+cQDAurk2WeTNZPVTnQ8GJSQOpWyDxHNCK_ww25ZdLtFwQ@mail.gmail.com>
References: <1425632110-31863-1-git-send-email-dongcan.jiang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Dongcan Jiang <dongcan.jiang@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 10:57:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTp0A-0004MA-0N
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 10:57:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbbCFJ45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 04:56:57 -0500
Received: from mail-yh0-f44.google.com ([209.85.213.44]:41197 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbbCFJ4y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 04:56:54 -0500
Received: by yhai57 with SMTP id i57so608101yha.8
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 01:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zdlYqj6Pmb74pP/BYgxYi584SZr/+uk6HM5jnA7MI9k=;
        b=FcCK8U4TGq1+Q2LUn9gwjRtpZswuCgJAzUa6fzIqq7NOURYS33CYiGh+1DJ2+61ZtZ
         cJamK/Xd0VwJaFhNCNN1nZQk0zJDbo1+RfBg+daIPGkUr9ZDLoAaOk2dlEdcvwADgFvs
         iyf+eaFvBWCl5l6LzA/0vNfyG5pOWyyZL4ipVf2WzXL7UImEr2AUz0pYtl9SrHKz4VyV
         lWiYDRyGVq7SltrXw0EknBCS92tA9Y47njYkneMSeReMnH9QEIN+zyxvYbLGvQQlwkEQ
         t9YwVn9smCHxTsN4nJKDuYa1sLpjhv1Iyroymx4f93bZHf9o7muNXx42IlLGih12sL79
         NItw==
X-Received: by 10.170.188.10 with SMTP id f10mr13398725yke.22.1425635813583;
 Fri, 06 Mar 2015 01:56:53 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Fri, 6 Mar 2015 01:56:53 -0800 (PST)
In-Reply-To: <1425632110-31863-1-git-send-email-dongcan.jiang@gmail.com>
X-Google-Sender-Auth: _aPW7aVbQHtDVU4bb-plF6l0wK0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264906>

On Fri, Mar 6, 2015 at 3:55 AM, Dongcan Jiang <dongcan.jiang@gmail.com> wrote:
> Forbid "log --graph --no-walk

Style: drop capitalization in the Subject: line. Also prefix with the
command or module being modified, followed by a colon. So:

    log: forbid combining --graph and --no-walk

or:

    revision: forbid combining --graph and --no-walk

> Because --graph is about connected history while --no-walk is about discrete points.

Okay. You might also want to cite the wider discussion[1].

[1]: http://article.gmane.org/gmane.comp.version-control.git/216083

> revision.c: Judge whether --graph and --no-walk come together when running git-log.
> buildin/log.c: Set git-log cmd flag.
> Documentation/rev-list-options.txt: Add specification on the forbidden usage.

No need to repeat in prose what the patch itself states more clearly
and concisely.

Also, such a change should be accompanied by new test(s).

> Signed-off-by: Dongcan Jiang <dongcan.jiang@gmail.com>
> ---
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 4ed8587..eea2c0a 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -679,6 +679,7 @@ endif::git-rev-list[]
>         given on the command line. Otherwise (if `sorted` or no argument
>         was given), the commits are shown in reverse chronological order
>         by commit time.
> +       Cannot be combined with `--graph` when running git-log.
>
>  --do-walk::
>         Overrides a previous `--no-walk`.
> @@ -781,6 +782,7 @@ you would get an output like this:
>         on the left hand side of the output.  This may cause extra lines
>         to be printed in between commits, in order for the graph history
>         to be drawn properly.
> +       Cannot be combined with `--no-walk` when running git-log.

Nice to see documentation updates. More below.

>  This enables parent rewriting, see 'History Simplification' below.
>  +
> diff --git a/builtin/log.c b/builtin/log.c
> index dd8f3fc..7bf5adb 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -627,6 +627,7 @@ int cmd_log(int argc, const char **argv, const char *prefix)
>         git_config(git_log_config, NULL);
>
>         init_revisions(&rev, prefix);
> +       rev.cmd_is_log = 1;
>         rev.always_show_header = 1;
>         memset(&opt, 0, sizeof(opt));
>         opt.def = "HEAD";
> diff --git a/revision.c b/revision.c
> index 66520c6..5f62c89 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1399,6 +1399,8 @@ void init_revisions(struct rev_info *revs, const char *prefix)
>
>         revs->commit_format = CMIT_FMT_DEFAULT;
>
> +       revs->cmd_is_log = 0;
> +
>         init_grep_defaults();
>         grep_init(&revs->grep_filter, prefix);
>         revs->grep_filter.status_only = 1;
> @@ -2339,6 +2341,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>
>         if (revs->reflog_info && revs->graph)
>                 die("cannot combine --walk-reflogs with --graph");
> +       if (revs->no_walk && revs->graph && revs->cmd_is_log)

Placing 'revs->cmd_is_log' first would make it clear at a glance that
this restriction impacts 'log' only (but see question below):

    if (revs->cmd_is_log && revs->no_walk && revs->graph)

> +               die("cannot combine --no-walk with --graph when running git-log");
>         if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
>                 die("cannot use --grep-reflog without --walk-reflogs");
>
> diff --git a/revision.h b/revision.h
> index 0ea8b4e..255982a 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -146,6 +146,9 @@ struct rev_info {
>                         track_first_time:1,
>                         linear:1;
>
> +       /* cmd type */
> +       unsigned int  cmd_is_log:1;

Genuine question: Despite the GSoC micro-project mentioning only
'log', is it ever meaningful for these two options to be specified
together? I suspect not, but it would be nice to hear from someone
more familiar with the issue. If not specific to 'log', then the patch
can be simplified a good deal.

>         enum date_mode date_mode;
>
>         unsigned int    abbrev;
> --
