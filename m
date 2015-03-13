From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 1/2] reset: enable '-' short-hand for previous branch
Date: Fri, 13 Mar 2015 16:48:10 -0400
Message-ID: <CAPig+cTuCtS6EKr9AqGkH_dDkxdYtk9ZfkpCLDLY9XYQO04ANA@mail.gmail.com>
References: <1426270716-22405-1-git-send-email-sudshekhar02@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>
To: Sudhanshu Shekhar <sudshekhar02@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 21:48:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWWVE-0000Vj-Iz
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 21:48:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300AbbCMUsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 16:48:11 -0400
Received: from mail-yh0-f53.google.com ([209.85.213.53]:44048 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbbCMUsL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2015 16:48:11 -0400
Received: by yhzz6 with SMTP id z6so13085104yhz.11
        for <git@vger.kernel.org>; Fri, 13 Mar 2015 13:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=6uLK13uxh5iIawDN8dd3m09QtCKhVbMz03vynt5Fd5k=;
        b=bZyaWuuF+XUqIoxOEw87nE5+Xb2GPWDuXHK7qLfQT+JKnWqNNRnbq8g8ZTzdz3zfZC
         GKK/Mhb6ef6L+yG+DO/7s/pEtWtGAe8Tss9fplOVxAPwsMslJiOYKo0IQgPBGZ3ktUTn
         bcVxdVf5bt+Jvxa13scryV1Fa68U9SfQzPZhtB2iZkr9s4AWzSPRAxuujk9TUBYc+n9h
         IgTs6R0Mlxg0vV5+xM9U5+eXlMceIss99DsMeoE5+UBKugqd7sxadWnlXhxufGSOV9Y4
         X5aAXdeRljyR7bj2sPg/lXhSjuvA4x4VQC+3k0EkVjxoEsKCunbbu/gysor1MQv0JsuL
         DSKQ==
X-Received: by 10.170.56.80 with SMTP id 77mr12893181yky.2.1426279690223; Fri,
 13 Mar 2015 13:48:10 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Fri, 13 Mar 2015 13:48:10 -0700 (PDT)
In-Reply-To: <1426270716-22405-1-git-send-email-sudshekhar02@gmail.com>
X-Google-Sender-Auth: Nyv5Do48KMLcn3B_-onpz80v20k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265420>

On Fri, Mar 13, 2015 at 2:18 PM, Sudhanshu Shekhar
<sudshekhar02@gmail.com> wrote:
> git reset '-' will reset to the previous branch. To reset a file named
> "-" use either "git reset ./-" or "git reset -- -".
>
> Change error message to treat single "-" as an ambigous revision or
> path rather than a bad flag.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Helped-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> Signed-off-by: Sudhanshu Shekhar <sudshekhar02@gmail.com>
> ---
> I have changed the logic to ensure argv[0] isn't changed at any point.
> Creating a modified_argv0 variable let's me do that.
>
> I couldn't think of any other way to achieve this, apart from changing things
> directly in the sha1_name.c file (like Junio's changes). Please let me know
> if some further changes are needed.
>
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 4c08ddc..bc50e14 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -192,6 +192,7 @@ static void parse_args(struct pathspec *pathspec,
>  {
>         const char *rev = "HEAD";
>         unsigned char unused[20];
> +       const char *modified_argv0 = argv[0];

This variable is only needed inside the 'if (argv[0])' block below, so
its declaration should be moved there. Also the initialization to
argv[0] is wasted since the assignment is overwritten below.

The variable name itself could be better. Unlike a name such as
'orig_arg0', "modified" doesn't tell us much. Modified how? Modified
to be what? Consideration where and how the variable is used, we can
see that it will be holding a value that _might_ be a "rev". This
suggests a better name such as 'maybe_rev' or something similar.

>         /*
>          * Possible arguments are:
>          *
> @@ -205,10 +206,17 @@ static void parse_args(struct pathspec *pathspec,
>          */
>
>         if (argv[0]) {
> +               if (!strcmp(argv[0], "-")) {
> +                       modified_argv0 = "@{-1}";
> +               }
> +               else {

Style: cuddle the 'else' and braces: "} else {"

> +                       modified_argv0 = argv[0];
> +               }

The unnecessary braces make this harder to read than it could be since
it is so spread out vertically. Dropping the braces would help. The
ternary operator ?: might improve readability (though it might also
make it worse).

>                 if (!strcmp(argv[0], "--")) {
>                         argv++; /* reset to HEAD, possibly with paths */
>                 } else if (argv[1] && !strcmp(argv[1], "--")) {
> -                       rev = argv[0];
> +                       rev = modified_argv0;
>                         argv += 2;
>                 }
>                 /*
> @@ -216,14 +224,15 @@ static void parse_args(struct pathspec *pathspec,
>                  * has to be unambiguous. If there is a single argument, it
>                  * can not be a tree
>                  */
> -               else if ((!argv[1] && !get_sha1_committish(argv[0], unused)) ||
> -                        (argv[1] && !get_sha1_treeish(argv[0], unused))) {
> +               else if ((!argv[1] && !get_sha1_committish(modified_argv0, unused)) ||
> +                        (argv[1] && !get_sha1_treeish(modified_argv0, unused))) {
>                         /*
>                          * Ok, argv[0] looks like a commit/tree; it should not
>                          * be a filename.
>                          */
>                         verify_non_filename(prefix, argv[0]);
> -                       rev = *argv++;
> +                       rev = modified_argv0;
> +                       argv++;

Good. This is much better than the previous rounds, and is the sort of
solution I had hoped to see when prodding you in previous reviews to
avoid argv[] kludges. Unlike the previous band-aid approach, this
demonstrates that you took the time to understand the overall logic
flow rather than merely plopping in a "quick fix".

>                 } else {
>                         /* Otherwise we treat this as a filename */
>                         verify_filename(prefix, argv[0], 1);
> diff --git a/setup.c b/setup.c
> index 979b13f..b621b62 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -200,7 +200,7 @@ void verify_filename(const char *prefix,
>                      int diagnose_misspelt_rev)
>  {
>         if (*arg == '-')
> -               die("bad flag '%s' used after filename", arg);
> +               die("ambiguous argument '%s': unknown revision or path", arg);

The conditional is only checking if the first character of 'arg' is
hyphen; it's not checking if 'arg' is exactly "-". It's purpose is to
recognize -flags or --flags, so it's inappropriate to change the error
message like this. I think this also doesn't help the case when there
really is a file named "-", since this conditional will just claim
that it's ambiguous.

It might or might not be appropriate to add a special case here to
allow an exact "-" to fall through to the check_filename() call below,
however, it would be necessary to thoroughly check for possible
repercussions first. (I haven't checked.) If all else fails, you could
change parse_args() to do something a bit ugly like this:

    const char *f = strcmp(argv[0], "-") ? argv[0] : "./-";
    verify_filename(prefix, f);

>         if (check_filename(prefix, arg))
>                 return;
>         die_verify_filename(prefix, arg, diagnose_misspelt_rev);
> --

By now, you've had a taste of what it's like to participate in the Git
project and what will be expected of you, and GSoC mentors have
(hopefully) formed an opinion of your abilities and how you interact
with reviewers, so I'm not sure that it makes sense for you to
resubmit again. Junio's proposal[1] to generalize "-" recognition as
an alias for @{-1} may be worth pursing by someone, but may be too
large for a micro-project.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/265260
