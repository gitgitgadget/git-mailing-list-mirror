From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH RFC 1/3] add: add new --exclude option to git add
Date: Sun, 15 Mar 2015 14:12:22 -0400
Message-ID: <CAPig+cR52GKNZkgsytUrb0m3wwY2T68cxjNB_OV+uLxvQUh=VA@mail.gmail.com>
References: <1426427399-22423-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 19:12:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXD1Z-0006y9-Sg
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 19:12:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997AbbCOSMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 14:12:24 -0400
Received: from mail-yh0-f49.google.com ([209.85.213.49]:34929 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855AbbCOSMX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 14:12:23 -0400
Received: by yhct68 with SMTP id t68so10746127yhc.2
        for <git@vger.kernel.org>; Sun, 15 Mar 2015 11:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XB9CZOMuxeefXYS4xmq7q/XMq5xLEp7Go2toKH5rZyM=;
        b=F+kBtvQJXXo8cjZu/pYR0rTC8byZ8r9amF7AXY3SkRFYAAe7PiTicqhmofDHhZtG9l
         nqIMr1KJiHytcTbyGA6Dp48aB4GqXEXNYZB07IOXHuOCZLcsrQ1ppSU0sU42UyzeOuuk
         NRDcM60nPZz3Fw1qnq/11NRxggZo0yJvMeAIUwbyOtnuy92F5aHwelGEReGvG931wQ7V
         p5zbAKXizSMtavlFwU4HOKlBL32+lKY1T37ZOJ5KVC7dkEP1j6xJEgyXN1Ym2DfsBfA9
         EQWvFy5FCm9IzHcTHdLNMBjyvbKaPIPGOjqEDBZXuS/Je9cp2mH3JGGiQwAGhD3hDXQD
         TdPg==
X-Received: by 10.170.134.198 with SMTP id a189mr53862117ykc.103.1426443142590;
 Sun, 15 Mar 2015 11:12:22 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Sun, 15 Mar 2015 11:12:22 -0700 (PDT)
In-Reply-To: <1426427399-22423-1-git-send-email-kuleshovmail@gmail.com>
X-Google-Sender-Auth: H6Du8Jc-UqGfwBTKWFHEvsqDMbA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265508>

In addition to points raised by Philip and Torsten...

On Sun, Mar 15, 2015 at 9:49 AM, Alexander Kuleshov
<kuleshovmail@gmail.com> wrote:
> add: add new --exclude option to git add

No need for redundant "to git add", since you already have the "add:" prefix.

> This patch introduces new --exclude option for the git add
> command.

This line merely repeats the Subject: line, thus can be dropped.

> We already have core.excludesfile configuration variable which indicates
> a path to file which contains patterns to exclude. This patch provides
> ability to pass --exclude option to the git add command to exclude paths
> from command line in addition to which found in the ignore files.

The commit message is missing the important justification for why this
new option is desirable, and why only git-add needs it.

> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
> diff --git a/builtin/add.c b/builtin/add.c
> index 3390933..5c602a6 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -244,6 +244,16 @@ static int ignore_removal_cb(const struct option *opt, const char *arg, int unse
>         return 0;
>  }
>
> +struct string_list exclude_list = STRING_LIST_INIT_NODUP;

Shouldn't this be declared static?

> +struct exclude_list *el;

Why is this declared globally when it's only needed locally by cmd_add()?

> +static int exclude_cb(const struct option *opt, const char *arg, int unset)
> +{
> +       struct string_list *exclude_list = opt->value;
> +       string_list_append(exclude_list, arg);
> +       return 0;
> +}
> +
>  static struct option builtin_add_options[] = {
>         OPT__DRY_RUN(&show_only, N_("dry run")),
>         OPT__VERBOSE(&verbose, N_("be verbose")),
> @@ -255,6 +265,9 @@ static struct option builtin_add_options[] = {
>         OPT_BOOL('u', "update", &take_worktree_changes, N_("update tracked files")),
>         OPT_BOOL('N', "intent-to-add", &intent_to_add, N_("record only the fact that the path will be added later")),
>         OPT_BOOL('A', "all", &addremove_explicit, N_("add changes from all tracked and untracked files")),
> +       { OPTION_CALLBACK, 0, "exclude", &exclude_list, N_("pattern"),
> +         N_("do no add files matching pattern to index"),
> +         0, exclude_cb },

Can this just be OPT_STRING_LIST instead of OPTION_CALLBACK?

>         { OPTION_CALLBACK, 0, "ignore-removal", &addremove_explicit,
>           NULL /* takes no arguments */,
>           N_("ignore paths removed in the working tree (same as --no-all)"),
> @@ -298,6 +311,7 @@ static int add_files(struct dir_struct *dir, int flags)
>
>  int cmd_add(int argc, const char **argv, const char *prefix)
>  {
> +       int i;
>         int exit_status = 0;
>         struct pathspec pathspec;
>         struct dir_struct dir;
> @@ -381,6 +395,11 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>                 if (!ignored_too) {
>                         dir.flags |= DIR_COLLECT_IGNORED;
>                         setup_standard_excludes(&dir);
> +
> +                       el = add_exclude_list(&dir, EXC_CMDL, "--exclude option");
> +                       for (i = 0; i < exclude_list.nr; i++)
> +                               add_exclude(exclude_list.items[i].string, "", 0, el, -(i+1));
> +
>                 }
>
>                 memset(&empty_pathspec, 0, sizeof(empty_pathspec));
> @@ -446,5 +465,6 @@ finish:
>                         die(_("Unable to write new index file"));
>         }
>
> +       string_list_clear(&exclude_list, 0);
>         return exit_status;
>  }
> --
> 2.3.3.472.g20ceeac
