From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 9/9] tag.c: implement '--merged' and '--no-merged' options
Date: Sun, 19 Jul 2015 21:20:07 +0200
Message-ID: <CAP8UFD0EXgt7ijdv2cY-HGuqcwjz=Z3-8KV7Xqk=-EBRp-QrGQ@mail.gmail.com>
References: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
	<1437256837-13378-1-git-send-email-Karthik.188@gmail.com>
	<1437256837-13378-3-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 19 21:20:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGu8K-0000W3-Du
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 21:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932914AbbGSTUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 15:20:12 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35355 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932906AbbGSTUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 15:20:09 -0400
Received: by wibxm9 with SMTP id xm9so75928357wib.0
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 12:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=I1frbbAZgyK+b5HiQWQk7RuX+i7QetJDCdUD4AC4/us=;
        b=LDTNaHw9tVN+R4K5pbrWrTpbQ2UvC02lcHhRhJDJ7AMvpmlzxg2hxqCIudKSE/GgAO
         L9IaUqo32zD9R3eEboMxodHiM15jdaknUef0VqbCepb+DkVQFG14JqFNkwlH0JUso0cg
         0PpBGbocZKcLeDmXrmww2O5dlYiEP4M/yGnpp8G0vYXM5lh3aTAtF2Fp4NQlMo5Ci7Ix
         Xzuynr5EHDjtV98bry5H3tWTTEnqSmjVCBARK4NFGTViV2SNVqkytDNvwCgF7yC8EFm7
         yyuhD86pyEObnJ7f9iGkcfSDV+6+G/Z2SQX8CvqUlEw/ulsZeORBwWlL1ME80hvQpPoC
         wWOQ==
X-Received: by 10.194.48.8 with SMTP id h8mr50938506wjn.82.1437333607689; Sun,
 19 Jul 2015 12:20:07 -0700 (PDT)
Received: by 10.194.221.229 with HTTP; Sun, 19 Jul 2015 12:20:07 -0700 (PDT)
In-Reply-To: <1437256837-13378-3-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274275>

On Sun, Jul 19, 2015 at 12:00 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>
> Using 'ref-filter' APIs implement the '--merged' and '--no-merged'
> options into 'tag.c'. The '--merged' option lets the user to only
> list tags merged into the named commit. The '--no-merged' option
> lets the user to only list tags not merged into the named commit.
> If no object is provided it assumes HEAD as the object.
>
> Add documentation and tests for the same.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Documentation/git-tag.txt | 10 +++++++++-
>  builtin/tag.c             |  6 +++++-
>  t/t7004-tag.sh            | 27 +++++++++++++++++++++++++++
>  3 files changed, 41 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 16e396c..74ed157 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -14,7 +14,7 @@ SYNOPSIS
>  'git tag' -d <tagname>...
>  'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
>         [--column[=<options>] | --no-column] [--sort=<key>] [--format=<format>]
> -       [<pattern>...]
> +       [(--merged | --no-merged) [<commit>]] [<pattern>...]

Maybe [--[no-]merged [<commit>]] instead of [(--merged | --no-merged)
[<commit>]].

>  'git tag' -v <tagname>...
>
>  DESCRIPTION
> @@ -169,6 +169,14 @@ This option is only applicable when listing tags without annotation lines.
>         `%09` to `\t` (TAB) and `%0a` to `\n` (LF).
>         The fields are same as those in `git for-each-ref`.
>
> +--merged [<commit>]::
> +       Only list tags whose tips are reachable from the
> +       specified commit (HEAD if not specified).
> +
> +--no-merged [<commit>]::
> +       Only list tags whose tips are not reachable from the
> +       specified commit (HEAD if not specified).

Here also you could write something like:

+--[no-]merged [<commit>]::
+       Only list tags whose tips are reachable, or not reachable
+       if --no-merged is used, from the specified commit
+       (HEAD if not specified).

>
>  CONFIGURATION
>  -------------
> diff --git a/builtin/tag.c b/builtin/tag.c
> index cae113b..0fa1d31 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -23,7 +23,7 @@ static const char * const git_tag_usage[] = {
>         N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] <tagname> [<head>]"),
>         N_("git tag -d <tagname>..."),
>         N_("git tag -l [-n[<num>]] [--contains <commit>] [--points-at <object>]"
> -               "\n\t\t[<pattern>...]"),
> +               "\n\t\t[--merged [<commit>]] [--no-merged [<commit>]] [<pattern>...]"),

[--[no-]merged [<commit>]] here too.

Thanks,
Christian.
