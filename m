From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] clean: new option --exclude-from
Date: Sun, 29 Nov 2015 21:24:04 -0500
Message-ID: <CAPig+cQMXgan0Hkm+HJt836Xm9AObxr8EW0DXb=puPzWD+v=Dg@mail.gmail.com>
References: <1448549065-16337-1-git-send-email-rouzier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: James <rouzier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 03:24:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3E8N-0002kc-RX
	for gcvg-git-2@plane.gmane.org; Mon, 30 Nov 2015 03:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447AbbK3CYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2015 21:24:07 -0500
Received: from mail-vk0-f46.google.com ([209.85.213.46]:36484 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbbK3CYG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2015 21:24:06 -0500
Received: by vkay187 with SMTP id y187so93838384vka.3
        for <git@vger.kernel.org>; Sun, 29 Nov 2015 18:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=YkXHnzcC5DZm3N3RqDeoBFhpnFHUj2Kqc2pX3ctimNU=;
        b=o4zOF9O02LORLkeKJbo2ZVCzH2r5QkkZLJuixnG6LA8GVt+7WLzmvRXBaPkwPCWY5i
         ZhhIecEE3q8mXyxavHiL2z3wUN2eJ891mgOkOlFeMv9fxSk1oCDHBc1R+E0HDZ6cwLcI
         xZKXBUNJNyhczOrwFSOVmD2SFKvDdKg5DJhPnboS+yD0gf02YlgQMXBdi81v6jD0at5R
         i4Y3sdAkdpCVqkZv8/8wvlKacTDvB9DN+SgVoV+3GLMYZWqjCxifqi+qZo9s3x0RntkD
         MrJwCPH8YuJSdvn3Oiqh42ei6lkrxIP1F6SkmTciB9DgACT+TKs/cHz3FxoBnwPALjHg
         bRPw==
X-Received: by 10.31.134.3 with SMTP id i3mr52226203vkd.14.1448850244374; Sun,
 29 Nov 2015 18:24:04 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Sun, 29 Nov 2015 18:24:04 -0800 (PST)
In-Reply-To: <1448549065-16337-1-git-send-email-rouzier@gmail.com>
X-Google-Sender-Auth: B8tG0sBzdgn7jej1gcw74KuLtYs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281800>

On Thu, Nov 26, 2015 at 9:44 AM, James <rouzier@gmail.com> wrote:
> From: James Rouzier <rouzier@gmail.com>
>
> Specify a file to read for exclude patterns.
> ---
> diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
> @@ -8,7 +8,7 @@ git-clean - Remove untracked files from the working tree
>  SYNOPSIS
>  --------
>  [verse]
> -'git clean' [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <path>...
> +'git clean' [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [--exclude-from <file>] [-x | -X] [--] <path>...

Common practice seems to be to include the '=' in the synopsis:
[--exclude-from=<file>]

>  DESCRIPTION
>  -----------
> @@ -61,6 +61,9 @@ OPTIONS
>         $GIT_DIR/info/exclude, also consider these patterns to be in the
>         set of the ignore rules in effect.
>
> +--exclude-from=<file>::
> +       Read exclude patterns from <file>; 1 per line.

s/;/,/ maybe?

> diff --git a/builtin/clean.c b/builtin/clean.c
> @@ -875,6 +875,16 @@ static void interactive_main_loop(void)
> +static int option_parse_exclude_from(const struct option *opt,
> +                                    const char *arg, int unset)

For consistency with the other callback function in this file, you'd
probably want to name this function exclude_from_cb().

> +{
> +       struct dir_struct *dir = opt->value;
> +
> +       add_excludes_from_file(dir, arg);
> +
> +       return 0;

Style: You can drop the blank line before 'return'.

> +}
> @@ -898,11 +908,15 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>                                 N_("remove whole directories")),
>                 { OPTION_CALLBACK, 'e', "exclude", &exclude_list, N_("pattern"),
>                   N_("add <pattern> to ignore rules"), PARSE_OPT_NONEG, exclude_cb },
> +               { OPTION_CALLBACK, 0, "exclude-from", &dir, N_("file"),
> +                       N_("exclude patterns are read from <file>"),

The existing descriptions all use imperative mood. This probably ought
to follow suit:

    N_("read exclude patterns from file"),

> +                       0, option_parse_exclude_from },
>                 OPT_BOOL('x', NULL, &ignored, N_("remove ignored files, too")),
>                 OPT_BOOL('X', NULL, &ignored_only,
>                                 N_("remove only ignored files")),
>                 OPT_END()
>         };
> +       memset(&dir, 0, sizeof(dir));

Style: Leave a blank line after the final declaration (before the memset).

Also, why move the memset() all the way up here as opposed, say, to
moving it just before the parse_options() invocation? Is it just to
make it easier for the next person who comes along wanting to
manipulate 'dir' early on (before git_config(), for instance)?

>         git_config(git_clean_config, NULL);
>         if (force < 0)
> @@ -913,7 +927,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>         argc = parse_options(argc, argv, prefix, options, builtin_clean_usage,
>                              0);
>
> -       memset(&dir, 0, sizeof(dir));
>         if (ignored_only)
>                 dir.flags |= DIR_SHOW_IGNORED;
>
> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> @@ -630,6 +630,41 @@ test_expect_success 'git clean -e' '
> +test_expect_success 'git clean --exclude-from' '
> +       rm -fr repo &&
> +       mkdir repo &&
> +       (
> +               cd repo &&
> +               git init &&
> +               touch known 1 2 3 &&

Unless the timestamp is significant, we normally avoid using 'touch'
and instead just use redirection to create empty files:

    >1
    >2
    >3

In this case, though, you're merely matching existing style in this
script, so 'touch' may be okay.

> +               git add known &&
> +               echo 1 >> .git/clean-exclude &&
> +               echo 2 >> .git/clean-exclude &&

Style: no space after redirection operator.

A here-doc may be cleaner and easier to maintain:

    cat >.git/clean-exclude <<-\EOF
    1
    2
    EOF

> +               git clean -f --exclude-from=.git/clean-exclude &&
> +               test -e 1 &&
> +               test -e 2 &&
> +               ! (test -e 3) &&

I see that you copied this from the "git clean -e" test, but it's not
obvious why parentheses are needed or wanted, and none of the other
tests use parentheses when negating the return of 'test', thus they
probably ought to be dropped.

> +               test -e known

Modern scripts would normally use test_path_is_file() and
test_path_is_missing() instead of 'test -e', however, you are again
matching existing style in this script, so 'test -e' may be
reasonable.

> +       )
> +'
> +
> +test_expect_success 'git clean -e --exclude-from' '
> +       rm -fr repo &&
> +       mkdir repo &&
> +       (
> +               cd repo &&
> +               git init &&
> +               touch known 1 2 3 &&
> +               git add known &&
> +               echo 1 >> .git/clean-exclude &&
> +               git clean -f -e 2 --exclude-from=.git/clean-exclude &&
> +               test -e 1 &&
> +               test -e 2 &&
> +               ! (test -e 3) &&
> +               test -e known
> +       )
> +'

Should a test be added which uses --exclude-from multiple times in the
same git-clean invocation?

Would it make sense add a test checking the behavior when the file
named by --exclude-from doesn't exist or is otherwise unusable as an
exclusion file?

>  test_expect_success SANITY 'git clean -d with an unreadable empty directory' '
>         mkdir foo &&
>         chmod a= foo &&
> --
> 2.3.6
