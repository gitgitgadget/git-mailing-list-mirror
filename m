From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] git: make "git -C '' <cmd>" not to barf
Date: Fri, 6 Mar 2015 03:53:39 -0500
Message-ID: <CAPig+cSeTA=SfQDouP-WCaSjsMBkUg=9Qm8xxfp0jcq=+GSksg@mail.gmail.com>
References: <1425625534-11869-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 09:53:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTo0w-0000aR-7o
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 09:53:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbbCFIxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 03:53:41 -0500
Received: from mail-yk0-f181.google.com ([209.85.160.181]:40066 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbbCFIxk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 03:53:40 -0500
Received: by ykq142 with SMTP id 142so449516ykq.7
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 00:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=dj4KZwhELKOoQV1mh+8DR0uTLYGQkoaJHcRv29/Lm3c=;
        b=SCsLrtGmyRRIt8U6xpte+YcRIv3fS2JzHXX4a2GtngoljQTcCP47qKxpgPQHfdzmf6
         9oWmNn1SNOBRVOkvqqfhGW3i4YGJSdLGi/fDDqioe7JQs/61hxrrFEOxwLPQCTi39QJP
         Y8GWQqW1Ix67PpM0Y35jKJY4LTYsHrkvjFJUEnmA8r8mNE1NyI6l80+QfWT2frWXvU0b
         pAOD+gLg80Qm9OtiV5XaJOEq/vB+5/xlhPFYikqq1W4iqZKrhS6SXT87c+02i+UgPC4h
         qjtO0PGnygWjeDl3fmwSRXP2iN493VE0LyCt/eM2LzmVw5v0311F/A8BXgzO9YH4M1FE
         q5YA==
X-Received: by 10.236.63.6 with SMTP id z6mr11578318yhc.65.1425632020009; Fri,
 06 Mar 2015 00:53:40 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Fri, 6 Mar 2015 00:53:39 -0800 (PST)
In-Reply-To: <1425625534-11869-1-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: NJqihBHpIde_xEEixE3bfdFSz_g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264897>

On Fri, Mar 6, 2015 at 2:05 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> It now acts like "cd ''" and does not barf and treats
> it as a no-op.

What does "barf" mean in this context? Does the program crash? Spit
out nonsensical messages? Misbehave in some fashion? A good commit
message should explain the problem with sufficient detail so readers
don't need to guess what the "bad" behavior is.

> This is useful if a caller function
> does not want to change directory and hence gives no
> path value, which would have generally caused git to
> output an undesired error message.

This is an odd justification. A caller not wanting to change the
directory wouldn't pass -C in the first place. A better justification
might be that die()ing is unnecessarily harsh behavior for what
otherwise could be considered a no-op, citing "cd ''" as an example.

Also, write in imperative mood, as if you're instructing the code to
change itself.

Taking the above observations into consideration, you might say:

    git: treat `-C <path>' as a no-op when <path> is empty

    `git -C ""' unhelpfully dies with error "Cannot change to ''",
    whereas the shell treats `cd ""' as a no-op. Taking the shell's
    behavior as a precedent, teach git to treat `-C ""' as a no-op, as
    well.

> Included a simple test to check the same, as suggested
> by Junio.

It is a bit weak to say that Junio "suggested" the test, considering
that he actually wrote it[1].

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/git.c b/git.c
> index 8c7ee9c..d734afa 100644
> --- a/git.c
> +++ b/git.c
> @@ -204,10 +204,14 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>                                 fprintf(stderr, "No directory given for -C.\n" );
>                                 usage(git_usage_string);
>                         }
> -                       if (chdir((*argv)[1]))
> -                               die_errno("Cannot change to '%s'", (*argv)[1]);
> -                       if (envchanged)
> -                               *envchanged = 1;
> +                       if (*((*argv)[1]) == 0)

Saying '\0' rather than 0 would make the intent clearer.

> +                               ; /* DO not change directory if no directory is given*/
> +                       else {
> +                               if (chdir((*argv)[1]))
> +                                       die_errno("Cannot change to '%s'", (*argv)[1]);
> +                               if (envchanged)
> +                                       *envchanged = 1;
> +                       }

The 'if/else' statement you've composed (with an empty 'if' branch) is
unnecessarily complicated when a simple 'if' suffices:

    if (*(*argv)[1]) {
        if (chdir((*argv)[1]))
            die_errno("Cannot change to '%s'", (*argv)[1]);
        if (envchanged)
            *envchanged = 1;
    }

>                         (*argv)++;
>                         (*argc)--;
>                 } else {
> diff --git a/t/t0056-git-C.sh b/t/t0056-git-C.sh
> index 99c0377..a6b52f1 100755
> --- a/t/t0056-git-C.sh
> +++ b/t/t0056-git-C.sh
> @@ -14,6 +14,14 @@ test_expect_success '"git -C <path>" runs git from the directory <path>' '
>         test_cmp expected actual
>  '
>
> +test_expect_success '"git -C <path>" with an empty <path> is a no-op' '
> +       mkdir -p dir1/subdir &&
> +       cd dir1/subdir &&

When Junio composed this test[1], he intentionally wrapped it in a
subshell via '(' and ')'. The problem with dropping the subshell, as
you did here, is that the 'cd' in this test will still be in effect
when tests following this one are run, which typically will break
them. Wrapping the test in a subshell side-steps the problem because
the parent shell is not affected by 'cd' within the subshell. To
summarize: Don't remove the subshell from Junio's example.

(You lucked out in this case, by accident, since the following tests
are not impacted by such ill-behavior.)

> +       git -C "" rev-parse --show-prefix >actual &&
> +       echo subdir/ >expect

Broken &&-chain.

> +       test_cmp expect actual
> +'
> +
>  test_expect_success 'Multiple -C options: "-C dir1 -C dir2" is equivalent to "-C dir1/dir2"' '
>         test_create_repo dir1/dir2 &&
>         echo 1 >dir1/dir2/b.txt &&
> --
> 2.3.1.167.g7f4ba4b.dirty

[1]: http://article.gmane.org/gmane.comp.version-control.git/264871
