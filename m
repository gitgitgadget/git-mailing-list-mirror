From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3 v2] add: introduce new --exclude option
Date: Sun, 15 Mar 2015 20:56:38 -0400
Message-ID: <CAPig+cS5GKHCeT3zY_oV-kKBT-Os4xn-8J3iew7741UCLYLYyA@mail.gmail.com>
References: <1426446383-5264-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 01:56:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXJKm-0001gD-Qd
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 01:56:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbbCPA4k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Mar 2015 20:56:40 -0400
Received: from mail-yh0-f54.google.com ([209.85.213.54]:36055 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350AbbCPA4j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Mar 2015 20:56:39 -0400
Received: by yhjf44 with SMTP id f44so12498994yhj.3
        for <git@vger.kernel.org>; Sun, 15 Mar 2015 17:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=EI0E4BRtfRq32Gp9wCaCzWtjq2uMwK7J3hEq9nkRnUg=;
        b=QZAkiYvntsz2IcstQEXlCTBea7ZHcAK8AXmmrCUIbuUF193CnHuPkePV+GCtIMcKvS
         RlbCYEdy5RxgSR0PPWNbBN0Er9W9nsLceRIQo4Lw6u4v7TEG7/BcDquNI5nTgAWUKPRq
         p/hkAPQ2ZYeRrNT/wQ99yDhr+jDjbD/NbM71uXOwxbhQAsPoVZLsUi2Ub0W+ZX1KGUlN
         QMMr7AlZZuxniyOSkzsZA2tFaAXUsJrdV17mRo3VJxlXaY55fN4WoZEYlg/Cl0bAGajj
         74Nsl+sdT9LBThDoSAWZW4PvEV9kEBdz1qhWpxbEsTgi/NAa8lQ7Pvr3b9sW0WdVsTID
         ujHQ==
X-Received: by 10.236.41.78 with SMTP id g54mr45646170yhb.112.1426467398618;
 Sun, 15 Mar 2015 17:56:38 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Sun, 15 Mar 2015 17:56:38 -0700 (PDT)
In-Reply-To: <1426446383-5264-1-git-send-email-kuleshovmail@gmail.com>
X-Google-Sender-Auth: rM805mojB4kxO07n_q-R4WtNGLc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265540>

On Sun, Mar 15, 2015 at 3:06 PM, Alexander Kuleshov
<kuleshovmail@gmail.com> wrote:
> We already have core.excludesfile configuration variable which indica=
tes
> a path to file which contains patterns to exclude. This patch provide=
s
> ability to pass --exclude option to the git add command to exclude pa=
ths
> from command line in addition to which specified in the ignore files.
>
> This option can be useful in a case when we have a directory with som=
e *.ext
> files which have changes and we want to commit all files besides one =
for now.
> It can be too annoying to touch .gitignore for this.

Won't this lead to unintuitive behavior? The 'excludes' mechanism does
not unconditionally ignore; instead, it ignores _untracked_ files.
Consider file "foo" which is already tracked. Make a temporary change
to "foo" which you don't intend to commit. Since "foo" is tracked, the
command 'git add . --exclude=3Dfoo' will still add "foo" to the index,
despite the use of --exclude. Most people would probably find such
behavior surprising and undesirable.

The negative pathspec mentioned by Junio[1], on the other hand, does
not suffer this shortcoming.

More below.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/265493/focu=
s=3D265518

> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> Helped-by: Philip Oakley <philipoakley@iee.org>
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
> diff --git a/builtin/add.c b/builtin/add.c
> index 3390933..e165fbc 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -244,6 +244,8 @@ static int ignore_removal_cb(const struct option =
*opt, const char *arg, int unse
>         return 0;
>  }
>
> +static struct string_list exclude_list =3D STRING_LIST_INIT_NODUP;
> +
>  static struct option builtin_add_options[] =3D {
>         OPT__DRY_RUN(&show_only, N_("dry run")),
>         OPT__VERBOSE(&verbose, N_("be verbose")),
> @@ -255,6 +257,8 @@ static struct option builtin_add_options[] =3D {
>         OPT_BOOL('u', "update", &take_worktree_changes, N_("update tr=
acked files")),
>         OPT_BOOL('N', "intent-to-add", &intent_to_add, N_("record onl=
y the fact that the path will be added later")),
>         OPT_BOOL('A', "all", &addremove_explicit, N_("add changes fro=
m all tracked and untracked files")),
> +       OPT_STRING_LIST(0, "exclude", &exclude_list, N_("pattern"),
> +                       N_("do not add files matching pattern to inde=
x")),
>         { OPTION_CALLBACK, 0, "ignore-removal", &addremove_explicit,
>           NULL /* takes no arguments */,
>           N_("ignore paths removed in the working tree (same as --no-=
all)"),
> @@ -305,6 +309,7 @@ int cmd_add(int argc, const char **argv, const ch=
ar *prefix)
>         int add_new_files;
>         int require_pathspec;
>         char *seen =3D NULL;
> +       struct exclude_list *el;

This variable is only used within the 'if (!ignored_too)' block below,
so its declaration should be moved there.

>         git_config(add_config, NULL);
>
> @@ -379,8 +384,14 @@ int cmd_add(int argc, const char **argv, const c=
har *prefix)
>                 /* Set up the default git porcelain excludes */
>                 memset(&dir, 0, sizeof(dir));
>                 if (!ignored_too) {
> +                       int i;
>                         dir.flags |=3D DIR_COLLECT_IGNORED;
>                         setup_standard_excludes(&dir);
> +
> +                       el =3D add_exclude_list(&dir, EXC_CMDL, "--ex=
clude option");
> +                       for (i =3D 0; i < exclude_list.nr; i++)
> +                               add_exclude(exclude_list.items[i].str=
ing, "", 0, el, -(i+1));
> +
>                 }
>
>                 memset(&empty_pathspec, 0, sizeof(empty_pathspec));
> @@ -446,5 +457,6 @@ finish:
>                         die(_("Unable to write new index file"));
>         }
>
> +       string_list_clear(&exclude_list, 0);
>         return exit_status;
>  }
> --
> 2.3.3.472.g20ceeac.dirty
