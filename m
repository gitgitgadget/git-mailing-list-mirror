From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] builtin/grep: allow implicit --no-index
Date: Sun, 10 Jan 2016 20:54:31 -0500
Message-ID: <CAPig+cRXy=CBZBTC7fU5wHA3d9Acqh_WYD54DmY1sHj7rob9Pw@mail.gmail.com>
References: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com>
	<1452435597-12099-4-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 02:55:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIRhJ-0002QI-30
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 02:55:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757949AbcAKByd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2016 20:54:33 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:35295 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757760AbcAKByc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2016 20:54:32 -0500
Received: by mail-vk0-f66.google.com with SMTP id i129so4671147vkb.2
        for <git@vger.kernel.org>; Sun, 10 Jan 2016 17:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=9NWGYhb37xGeEKlKlc8DxjeKuw56wzVZJyUi+kWQqqM=;
        b=p5onVcuNGrvu2qsRS/nUYtbD2gwFAMfLoIdTssOQZymuOrkYRLgscd8mf9X2T/VEAW
         LoU7p0b3O0csazK9HLweEzJNCeM8ct/so+crheXtW9uxSQtsKpdftHRpo42oCPh4Bv9Q
         xrECJNtWjBpObvx6GkiweeG/CXPoDxLHQuJXydmRa0PMiiF67Ym4/LL05EuJChKXWXDE
         2I8dwLymnpBMEUUmNO0eH8Bph7pX06ugjvdum4Omx659zYZikYzKtgxGDK0+IzkOQjcg
         q3LDY8IEyS2/4EyMu2WalyYaRwbnZlFk6iq15nmrNtPEkc+ujW9ynRNALnb+DxxZc4PU
         D75Q==
X-Received: by 10.31.56.18 with SMTP id f18mr76811629vka.19.1452477271769;
 Sun, 10 Jan 2016 17:54:31 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 10 Jan 2016 17:54:31 -0800 (PST)
In-Reply-To: <1452435597-12099-4-git-send-email-t.gummerer@gmail.com>
X-Google-Sender-Auth: edNcsL5U4ZIikwMJJrMLODuZR10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283630>

On Sun, Jan 10, 2016 at 9:19 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Currently when git grep is used outside of a git repository without the
> --no-index option git simply dies.  For convenience, implicitly make git
> grep behave like git grep --no-index when it is called outside of a git
> repository.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
> diff --git a/builtin/grep.c b/builtin/grep.c
> @@ -19,6 +19,9 @@
> +#define GREP_NO_INDEX_EXPLICIT 1
> +#define GREP_NO_INDEX_IMPLICIT 2
> @@ -873,13 +881,21 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>         if (!show_in_pager && !opt.status_only)
>                 setup_pager();
>
> -       if (no_index && (untracked || cached))
> -               die(_("--cached or --untracked cannot be used with --no-index."));
> +       if (untracked || cached) {
> +               if (no_index == GREP_NO_INDEX_EXPLICIT)
> +                       die(_("--cached or --untracked cannot be used with --no-index."));
> +               else if (no_index == GREP_NO_INDEX_IMPLICIT)

Just below here when checking --untracked, you use a simple 'else'
rather than 'else if' to handle the other case of explicit vs
implicit. Why the inconsistency? Also, the ordering of 'if/else' arms
is opposite.

> +                       die(_("--cached or --untracked cannot be used outside a git repository."));
> +       }
>
>         if (no_index || untracked) {
>                 int use_exclude = (opt_exclude < 0) ? !no_index : !!opt_exclude;
> -               if (list.nr)
> -                       die(_("--no-index or --untracked cannot be used with revs."));
> +               if (list.nr) {
> +                       if (no_index == GREP_NO_INDEX_IMPLICIT)
> +                               die(_("cannot use revs outside of a git repository."));
> +                       else
> +                               die(_("--no-index or --untracked cannot be used with revs."));
> +               }
> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> @@ -821,6 +818,44 @@ test_expect_success 'outside of git repository' '
> +test_expect_success 'outside of git repository without --no-index' '
> +       rm -fr non &&
> +       mkdir -p non/git/sub &&
> +       echo hello >non/git/file1 &&
> +       echo world >non/git/sub/file2 &&
> +       {
> +               echo file1:hello &&
> +               echo sub/file2:world
> +       } >non/expect.full &&

Isn't the above just a complicated way of saying:

    cat <<-\EOF >non/expect.full &&
    file:hello
    sub/file2:world
    EOF

?

> +       echo file2:world >non/expect.sub &&
> +       (
> +               GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
> +               export GIT_CEILING_DIRECTORIES &&
> +               cd non/git &&
> +               git grep o >../actual.full &&
> +               test_cmp ../expect.full ../actual.full

Broken &&-chain.

> +               cd sub &&
> +               git grep o >../../actual.sub &&
> +               test_cmp ../../expect.sub ../../actual.sub
> +       ) &&
> +
> +       echo ".*o*" >non/git/.gitignore &&
> +       (
> +               GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
> +               export GIT_CEILING_DIRECTORIES &&
> +               cd non/git &&
> +               git grep --exclude-standard o >../actual.full &&
> +               test_cmp ../expect.full ../actual.full &&
> +
> +               {
> +                       echo ".gitignore:.*o*"

Broken &&-chain.

> +                       cat ../expect.full
> +               } >../expect.with.ignored &&
> +               git grep --no-exclude o >../actual.full &&
> +               test_cmp ../expect.with.ignored ../actual.full
> +       )
> +'
