From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH] submodule status: properly pass options with --recursive
Date: Fri, 26 Oct 2012 15:07:11 -0400
Message-ID: <CABURp0op2+QUvusUmAFUxT8s8c02bB9V3=ag9gTTSiiN4t96OA@mail.gmail.com>
References: <5089BB2D.90400@web.de> <20121026131507.GA2747@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 26 21:07:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRpFy-0006c7-QB
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 21:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965309Ab2JZTHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 15:07:34 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:43668 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933966Ab2JZTHd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 15:07:33 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so2605102lag.19
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 12:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0609r79RhyJW1qEKc7RhB6VdIPNsKfKYEbSD9eo0ufs=;
        b=XJEYeWQiqXzHSBMkfu34RvHeJ7kyNNSYoOHMPhgUMD3eUqC3f7rL8xKAz6L7Tr0+kQ
         49HkynrJXNaIFwjPhWvQvfmMFof1fdvXDAPbnYJTnhXn3Yg2Fw9oF/VX7qHwciVFWO3t
         LnWkZtylgA6s0njT2URgjP4SmwhuFEVNjPJfEtiZrb4FjgVXLueWwwcgw1/3Pk8JcbVN
         /4KTPsMJINPADIzLzpPr9SgeV2qVscADY8AERTi7vzcXSZ7ovtzeqafT0tY+jbjjVabX
         keOGMRQj6Cb+G3kIhM9ahcY5Mo48S3cWmta0MDofUIHITUy9x55zjt+a+JWG04r8O41P
         +RGg==
Received: by 10.152.47.97 with SMTP id c1mr20903099lan.37.1351278452178; Fri,
 26 Oct 2012 12:07:32 -0700 (PDT)
Received: by 10.114.26.166 with HTTP; Fri, 26 Oct 2012 12:07:11 -0700 (PDT)
In-Reply-To: <20121026131507.GA2747@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208478>

On Fri, Oct 26, 2012 at 9:15 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Oct 26, 2012 at 12:20:29AM +0200, Jens Lehmann wrote:
>
>> When renaming orig_args to orig_flags in 98dbe63d (submodule: only
>> preserve flags across recursive status/update invocations) the call site
>> of the recursive cmd_status was forgotten. At that place orig_args is
>> still passed into the recursion, which is always empty now. This clears
>> all options when recursing, as that variable is never set.
>>
>> Fix that by renaming orig_args to orig_flags there too and add a test to
>> catch that bug.
>
> Thanks. I back-ported your patch on top of 98dbe63d so it can go to
> 'maint'. I'm curious, though: why didn't the test right before (which
> checks recursion for --cached) catch this?

I was wondering the same thing about why 'git submodule sync
--recursive --quiet' succeeded, so I checked on it.  The answer is
that "--quiet" sets GIT_QUIET=1, which is then inherited by the
recursive call. Indeed, Jens' new test passes even without the
accompanying fix.  :-\

The 'status --recursive --cached' test passes for two reasons.  The
first is that the test is checking for a cached change in a level-1
submodule, but it is the level-2+ submodules which do not get the
flags passed down correctly in "$@".  The 2nd reason is that the
$cached variable is _also_ inherited by the recursive call to
cmd_status, specifically because it is a call to cmd_status() and not
to '$SHELL git submodule status', where the latter would have cleared
the flags at startup, but the former does not.

I'm a bit wary about "fixing" the flags for the recursion machinery.
I'm starting to think $orig_flags is moot in almost all cases.  It
looks like clearing all the flags on each iteration would break 'git
submodule foreach --recursive --quiet' because it does not use
$orig_flags at all.  Who knows what other surprises lurk there.

Here's a fix for the test, though, even though it still does not fail
in the absence of the $orig_flags patch.

-- >8 --

diff --git i/t/t7407-submodule-foreach.sh w/t/t7407-submodule-foreach.sh
index 9b69fe2..8442b32 100755
--- i/t/t7407-submodule-foreach.sh
+++ w/t/t7407-submodule-foreach.sh
@@ -226,14 +226,14 @@ test_expect_success 'test "status --recursive"' '
        test_cmp expect actual
 '

-sed -e "/nested1 /s/.*/+$nested1sha1 nested1 (file2~1)/;/sub[1-3]/d"
< expect > expect2
+sed -e "/nested2 /s/.*/+$nested2sha1 nested1\/nested2
(file2~1)/;/sub[1-3]/d" < expect > expect2
 mv -f expect2 expect

 test_expect_success 'ensure "status --cached --recursive" preserves
the --cached flag' '
        (
                cd clone3 &&
                (
-                       cd nested1 &&
+                       cd nested1/nested2 &&
                        test_commit file2
                ) &&
                git submodule status --cached --recursive -- nested1 > ../actual
@@ -245,6 +245,14 @@ test_expect_success 'ensure "status --cached
--recursive" preserves the --cached
        test_cmp expect actual
 '
 test_expect_success 'use "git clone --recursive" to checkout all submodules' '
        git clone --recursive super clone4 &&
        (

Phil
