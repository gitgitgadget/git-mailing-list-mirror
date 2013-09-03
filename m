From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] Teach git to change to a given directory using -C option
Date: Tue, 3 Sep 2013 03:42:45 -0400
Message-ID: <CAPig+cTQrjmiKYWoo57BTBNS0nuR+NMDf8uCk5EqAvcMzr0iVA@mail.gmail.com>
References: <20130902133911.GA23924@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 09:43:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGlGc-0005fz-Qv
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 09:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653Ab3ICHmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 03:42:49 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:37757 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932502Ab3ICHmr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 03:42:47 -0400
Received: by mail-la0-f46.google.com with SMTP id eh20so4233473lab.5
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 00:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=34lY+h1we0rmCfoqAdU7ftfuFr2SW/9/zgEa5mc2Vuo=;
        b=JcSMukyikKoVf35g5QXYnuAxb/6z7cnQsQG29mH9/ejAs0++wLW952fJXR+m9Ti0hI
         uIuJSHAaXNemSFAezpRGRKpX4oYu4sxkDJb9Ot0htnpb1XBUKxQZuK6GPLv/Ac3eL/dr
         mHK+5PF1Lzl9C2Pyhnt6F2xV39WmSw4+GxKMID7/YGUjmScTSVYPX7kG1XrcuSk3oWr7
         2ji51WGiBBpH0mdpqIx6n5WIqA3k6BIvVMS5+6btaQ69CudfIhwgjOYUcuZ7E4ieVAlv
         f0WTZzQSvxENljHvVwwtW1xIvJk96x7QH+0zi+tiHUdC4YNmgdmeExBg06K7OGClCGvx
         Y+MQ==
X-Received: by 10.152.36.98 with SMTP id p2mr25207745laj.14.1378194165975;
 Tue, 03 Sep 2013 00:42:45 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Tue, 3 Sep 2013 00:42:45 -0700 (PDT)
In-Reply-To: <20130902133911.GA23924@gmail.com>
X-Google-Sender-Auth: jWkgagcjlADzbDh4xpIdFtOkLPk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233704>

On Mon, Sep 2, 2013 at 9:39 AM, Nazri Ramliy <ayiehere@gmail.com> wrote:
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 83edf30..7a1369a 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -395,6 +395,20 @@ displayed. See linkgit:git-help[1] for more information,
>  because `git --help ...` is converted internally into `git
>  help ...`.
>
> +-C <path>::
> +       Run as if git were started in <path> instead of the current working
> +       directory. If multiple -C options are given, subsequent relative <path>
> +       arguments are interpreted relative to the previous effective directory:
> +       "-C /usr -C src" is equivalent to "-C /usr/src", while "-C src -C /usr"
> +       is equivalent to "C /usr". This option affects options that expect path

No wish to bike-shed, however, I find "effective directory" somewhat
difficult to digest due to its jargony feel. It also seems ambiguous
(to me) since "previous effective directory" may mean "directory when
git was run" or "directory set by most recent -C". My earlier
suggestion

    When multiple -C options are given, each subsequent non-absolute
    -C <path> is interpreted relative to the preceding -C <path>.

avoided jargon and left no room for ambiguity.

However, perhaps the examples are clear enough to make excessive prose
explanation unnecessary, thus:

    Run as if git was started in <path> instead of the current
    working directory. Multiple -C options are allowed and acted upon
    in the order given, thus "-C /usr -C src" is equivalent to "-C
    /usr/src", and "-C src -C /usr" is equivalent to "C /usr". This
    option affects ...

> diff --git a/t/t0056-git-C.sh b/t/t0056-git-C.sh
> new file mode 100755
> index 0000000..7dc1e48
> --- /dev/null
> +++ b/t/t0056-git-C.sh
> @@ -0,0 +1,83 @@
> +#!/bin/sh
> +
> +test_description='"-C <path>" option and its effects on other path-related options'
> +
> +. ./test-lib.sh
> +
> +test_expect_success '"git -C <path>" runs git from the directory <path>' '
> +       test_create_repo dir1 &&
> +       echo 1 >dir1/a.txt &&
> +       (cd dir1 && git add a.txt && git commit -m "initial in dir1") &&
> +       echo "initial in dir1" >expected &&
> +       git -C dir1 log --format=%s >actual &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success 'Multiple -C options: "-C dir1 -C dir2" is equivalent to "-C dir1/dir2"' '
> +       test_create_repo dir1/dir2 &&
> +       echo 1 >dir1/dir2/a.txt &&
> +       git -C dir1/dir2 add a.txt &&
> +       expected="initial in dir1/dir2"
> +       echo $expected >expected &&
> +       git -C dir1/dir2 commit -m "$expected" &&

It's curious that this test uses a variable ($expected) to avoid
repeating literal "initial in dir1/dir2", however, the previous test
repeats its literal "initial in dir1". (IMHO, the repeated literal
actually makes the test a bit easier to read, and it's not likely to
be a maintenance burden.)

> +       git -C dir1 -C dir2 log --format=%s >actual &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success 'Relative followed by fullpath: "-C ./here -C /there" is equivalent to "-C /there"' '
> +       echo "initial in dir1/dir2" >expected &&
> +       git -C dir1 -C "$PWD/dir1/dir2" log --format=%s >actual &&

It is suggested in t/README that, for Windows (MSYS bash)
compatibility, you should use $(pwd) rather than $PWD.

> +       test_cmp expected actual
> +'
> +
> +test_done
> --
> 1.8.4.24.g5fcd118
