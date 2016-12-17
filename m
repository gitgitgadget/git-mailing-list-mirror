Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EB231FF40
	for <e@80x24.org>; Sat, 17 Dec 2016 00:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933236AbcLQAr7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 19:47:59 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35328 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932929AbcLQAr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 19:47:57 -0500
Received: by mail-qk0-f171.google.com with SMTP id n204so107870492qke.2
        for <git@vger.kernel.org>; Fri, 16 Dec 2016 16:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MMffIs0LSGVxg7tMuKa/WdWvOOAonlYMjyE5JV+ARHo=;
        b=ATjtSt7NeSknlmJc7G9k0y5y19piFWCYnrbhpRqih3XSUZ0qO4OZe5RcXToWpeV0IB
         joN3sfReCy5Frj/rPxdZxl0JZmyjoxZciL0rC8NoKrovNCoubbvRcNH95gHewEl4CtlC
         KA85AelIGN9jKb/jk/PHo3g4I0AKh4I03xjHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MMffIs0LSGVxg7tMuKa/WdWvOOAonlYMjyE5JV+ARHo=;
        b=BAb7eK/9YssLX+Fm6JqIm/s/TTmNIssVN8B2wdI1Svm/OSovN3JN3WWnfeatlTc6co
         ftsvnUYc1FyCYvzTL+++2u4wIqbXo4FNYTfMDvo4cXU+YDGGVU6E9jQpx9Sm+Wf6M7W5
         bwp3zyL3s64gC488KeWU8otpIp9XzAAWoBGIEaZ78mSWER5xEMLompzlgoA32DfqNguI
         iPaSObiIdZPQwX1XsOhlWy+Q2eHEd+jJi9W8q6vRer6CNxXduOz0f11rGBmIreV51nU/
         6ywoBd+bE5OizZ8t4HGMYGx8k8vuY/Nqrx4PCuUK/zuuz5ihVnUTWeacS1P42zcfiKZX
         jXGA==
X-Gm-Message-State: AIkVDXIwcPERFCo0n6ewsqP0Gn1An1ezv3D1BYL1gItrc8xVj/8090B45s/Zlh5/obk/JnLUs94nkrDWZ1whMQ==
X-Received: by 10.55.144.70 with SMTP id s67mr6417364qkd.290.1481935675902;
 Fri, 16 Dec 2016 16:47:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.47.111 with HTTP; Fri, 16 Dec 2016 16:47:55 -0800 (PST)
In-Reply-To: <01020159037a8995-2d1da9d4-4a27-4b98-818b-432fc0ad8a52-000000@eu-west-1.amazonses.com>
References: <01020159037a8995-2d1da9d4-4a27-4b98-818b-432fc0ad8a52-000000@eu-west-1.amazonses.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Sat, 17 Dec 2016 00:47:55 +0000
Message-ID: <CAE5ih7-+tahL4=OrW6F6UPKKRg1KFkw32e=pnTx6j2WTZ-BhOw@mail.gmail.com>
Subject: Re: [PATCH] git-p4: Fix multi-path changelist empty commits
To:     George Vanburgh <george@vanburgh.me>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15 December 2016 at 17:14, George Vanburgh <george@vanburgh.me> wrote:
> From: George Vanburgh <gvanburgh@bloomberg.net>
>
> When importing from multiple perforce paths - we may attempt to import a =
changelist that contains files from two (or more) of these depot paths. Cur=
rently, this results in multiple git commits - one containing the changes, =
and the other(s) as empty commits. This behavior was introduced in commit 1=
f90a64 ("git-p4: reduce number of server queries for fetches", 2015-12-19).

That's definitely a bug, thanks for spotting that! Even more so for
adding a test case.

>
> Reproduction Steps:
>
> 1. Have a git repo cloned from a perforce repo using multiple depot paths=
 (e.g. //depot/foo and //depot/bar).
> 2. Submit a single change to the perforce repo that makes changes in both=
 //depot/foo and //depot/bar.
> 3. Run "git p4 sync" to sync the change from #2.
>
> Change is synced as multiple commits, one for each depot path that was af=
fected.
>
> Using a set, instead of a list inside p4ChangesForPaths() ensures that ea=
ch changelist is unique to the returned list, and therefore only a single c=
ommit is generated for each changelist.

The change looks good to me apart from one missing "&&" in the test
case (see below).

Possibly need to rewrap the comment line (I think there's a 72
character limit) ?

Luke


>
> Reported-by: James Farwell <jfarwell@vmware.com>
> Signed-off-by: George Vanburgh <gvanburgh@bloomberg.net>
> ---
>  git-p4.py               |  4 ++--
>  t/t9800-git-p4-basic.sh | 22 +++++++++++++++++++++-
>  2 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index fd5ca52..6307bc8 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -822,7 +822,7 @@ def p4ChangesForPaths(depotPaths, changeRange, reques=
tedBlockSize):
>                  die("cannot use --changes-block-size with non-numeric re=
visions")
>              block_size =3D None
>
> -    changes =3D []
> +    changes =3D set()
>
>      # Retrieve changes a block at a time, to prevent running
>      # into a MaxResults/MaxScanRows error from the server.
> @@ -841,7 +841,7 @@ def p4ChangesForPaths(depotPaths, changeRange, reques=
tedBlockSize):
>
>          # Insert changes in chronological order
>          for line in reversed(p4_read_pipe_lines(cmd)):
> -            changes.append(int(line.split(" ")[1]))
> +            changes.add(int(line.split(" ")[1]))
>
>          if not block_size:
>              break
> diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
> index 0730f18..4d72e0b 100755
> --- a/t/t9800-git-p4-basic.sh
> +++ b/t/t9800-git-p4-basic.sh
> @@ -131,6 +131,26 @@ test_expect_success 'clone two dirs, @all, conflicti=
ng files' '
>         )
>  '
>
> +test_expect_success 'clone two dirs, each edited by submit, single git c=
ommit' '
> +       (
> +               cd "$cli" &&
> +               echo sub1/f4 >sub1/f4 &&
> +               p4 add sub1/f4 &&
> +               echo sub2/f4 >sub2/f4 &&
> +               p4 add sub2/f4 &&
> +               p4 submit -d "sub1/f4 and sub2/f4"
> +       ) &&
> +       git p4 clone --dest=3D"$git" //depot/sub1@all //depot/sub2@all &&
> +       test_when_finished cleanup_git &&
> +       (
> +               cd "$git"

Missing &&

> +               git ls-files >lines &&
> +               test_line_count =3D 4 lines &&
> +               git log --oneline p4/master >lines &&
> +               test_line_count =3D 5 lines
> +       )
> +'
> +
>  revision_ranges=3D"2000/01/01,#head \
>                  1,2080/01/01 \
>                  2000/01/01,2080/01/01 \
> @@ -147,7 +167,7 @@ test_expect_success 'clone using non-numeric revision=
 ranges' '
>                 (
>                         cd "$git" &&
>                         git ls-files >lines &&
> -                       test_line_count =3D 6 lines
> +                       test_line_count =3D 8 lines
>                 )
>         done
>  '
>
> --
> https://github.com/git/git/pull/311
