From: Fredrik Medley <fredrik.medley@gmail.com>
Subject: Re: [PATCH v5 3/3] upload-pack: optionally allow fetching reachable sha1
Date: Sat, 23 May 2015 01:55:12 +0200
Message-ID: <CABA5-zm3LqA+BAHj0EegoXmTuaNobhEHyD0v2kg=VfCzzqx-+A@mail.gmail.com>
References: <1432068269-14895-1-git-send-email-fredrik.medley@gmail.com>
 <1432239819-21794-1-git-send-email-fredrik.medley@gmail.com>
 <1432239819-21794-3-git-send-email-fredrik.medley@gmail.com> <xmqqioblh91w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 23 01:55:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvwmy-0008Bm-0W
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 01:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945980AbbEVXzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 19:55:35 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35980 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945968AbbEVXze (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 19:55:34 -0400
Received: by lbbqq2 with SMTP id qq2so22326733lbb.3
        for <git@vger.kernel.org>; Fri, 22 May 2015 16:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dKxsdOyxmVFdBmX4zDUsf6QKJEbNTlvSGUkTLrLOLA8=;
        b=LiCXPe06r99hCYBlquOx6hcfIpvVCXSiVrS6Sw6SIF/7SflGeUiUdZ4Z2R6w0BDbb1
         BL/wbsV5ZikLVH/80tgcjkZGLBh9Z43IEIaftM7ZjSsIXb9qs/uhQliyFldqoANA8pJb
         guPM8YInvMRMLTXDFls4moi8L0uztPBUeLSfyODcRgkoBJVuGgi9dbrlcTqo8ZXwA5/y
         iW9QR9WIiFpZXkq7nVq1tOCEeHCL/EKRIOqCDzQc8Vg4/TBa+gk87IwPLalbed4z5pvZ
         fT//z0O1laUBYN/2WvAxzAfpnELMa6uQsC/kceCRnFN+oCISOqg+hrqUsoYv0pbKE1OX
         ri9A==
X-Received: by 10.152.42.242 with SMTP id r18mr8433967lal.8.1432338932748;
 Fri, 22 May 2015 16:55:32 -0700 (PDT)
Received: by 10.114.246.235 with HTTP; Fri, 22 May 2015 16:55:12 -0700 (PDT)
In-Reply-To: <xmqqioblh91w.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269780>

2015-05-22 0:15 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> Fredrik Medley <fredrik.medley@gmail.com> writes:
>
>> --- a/Documentation/technical/protocol-capabilities.txt
>> +++ b/Documentation/technical/protocol-capabilities.txt
>> @@ -260,6 +260,13 @@ If the upload-pack server advertises this capability, fetch-pack may
>>  send "want" lines with SHA-1s that exist at the server but are not
>>  advertised by upload-pack.
>>
>> +allow-reachable-sha1-in-want
>> +----------------------
>
> This is an underline applied to one line prior, and their length
> must match.  I'll amend while applying (attached at end), so there
> is no need to resend with correction unless you have other reasons
> to do so.
>
>> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
>> index 8a5f236..fdcc114 100755
>> --- a/t/t5516-fetch-push.sh
>> +++ b/t/t5516-fetch-push.sh
>> @@ -1120,6 +1120,61 @@ test_expect_success 'fetch exact SHA1' '
>>       )
>>  '
>
> It looks like this new set of tests are well thought out; good job.
>
> I spotted a few minor nits, though.  All I'll amend while applying
> so there is no need to resend only to correct them.

I agree on all your comments and your proposed amendment further down
looks good.
Should the test code contain the explanations you've written in this email?

>
>> +for configallowtipsha1inwant in true false
>> +do
>> +     test_expect_success "shallow fetch reachable SHA1 (but not a ref), allowtipsha1inwant=$configallowtipsha1inwant" '
>> +             mk_empty testrepo &&
>> +             (
>> +                     cd testrepo &&
>> +                     git config uploadpack.allowtipsha1inwant $configallowtipsha1inwant &&
>> +                     git commit --allow-empty -m foo &&
>> +                     git commit --allow-empty -m bar
>> +             ) &&
>> +             SHA1=$(git --git-dir=testrepo/.git rev-parse HEAD^) &&
>> +             mk_empty shallow &&
>> +             (
>> +                     cd shallow &&
>> +                     test_must_fail git fetch --depth=1 ../testrepo/.git $SHA1 &&
>
> This tries to fetch one before the tip with "allowTipSHA1InWant" set
> to true or false; either should fail.  Good.
>
>> +                     git --git-dir=../testrepo/.git config uploadpack.allowreachablesha1inwant true &&
>> +                     git fetch --depth=1 ../testrepo/.git $SHA1 &&
>
> And regardless of allowTip setting, with allowReachable set to true,
> fetching the reachable HEAD^ would succeed.  Good.
>
>> +                     git cat-file commit $SHA1 >/dev/null
>
> Minor nit; drop ">/dev/null", as test framework will squelch the
> output by default, and when the test is run with "-v" option, the
> output would help debugging the script.
>
>> +             )
>> +     '
>> +
>> +     test_expect_success "deny fetch unreachable SHA1, allowtipsha1inwant=$configallowtipsha1inwant" '
>> +             mk_empty testrepo &&
>> +             (
>> +                     cd testrepo &&
>> +                     git config uploadpack.allowtipsha1inwant $configallowtipsha1inwant &&
>> +                     git commit --allow-empty -m foo &&
>> +                     git commit --allow-empty -m bar &&
>> +                     git commit --allow-empty -m xyz
>> +             )
>
> Broken && chain
>
>> +             SHA1_1=$(git --git-dir=testrepo/.git rev-parse HEAD^^) &&
>> +             SHA1_2=$(git --git-dir=testrepo/.git rev-parse HEAD^) &&
>> +             SHA1_3=$(git --git-dir=testrepo/.git rev-parse HEAD) &&
>> +             (
>> +                     cd testrepo &&
>> +                     git reset --hard $SHA1_2 &&
>
> We have one before the tip (SHA1_1), one after the tip and no longer
> reachable (SHA1_3); SHA1_2 is sitting at the tip of a ref.
>
>> +                     git cat-file commit $SHA1_3 >/dev/null &&
>> +                     git cat-file commit $SHA1_3 >/dev/null
>
> I think one of the latter two is $SHA1_1, i.e. you make sure SHA1_{1,2,3}
> are there in testrepo.

Yes, that was intended.

>
>> +             ) &&
>> +             mk_empty shallow &&
>> +             (
>> +                     cd shallow &&
>> +                     test_must_fail git fetch ../testrepo/.git $SHA1_3 &&
>> +                     test_must_fail git fetch ../testrepo/.git $SHA1_1 &&
>
> With allowTip only, whether it is set to true or false, fetching _1
> or _3 that are not at tip will fail.  Good.
>
>> +                     git --git-dir=../testrepo/.git config uploadpack.allowreachablesha1inwant true &&
>> +                     git fetch ../testrepo/.git $SHA1_1 &&
>> +                     git cat-file commit $SHA1_1 >/dev/null &&
>
> With allowReachable, _1 which is reachable from tip is possible,
> regardless of the setting of allowTip.  Good.
>
>> +                     test_must_fail git cat-file commit $SHA1_2 >/dev/null &&
>
> And fetching _1 will not pull in _2, which is _1's child, that we
> did not ask for.  Good (but it is probably not very relevant for the
> purpose of these tests).
>
>> +                     git fetch ../testrepo/.git $SHA1_2 &&
>> +                     git cat-file commit $SHA1_2 >/dev/null &&
>
> And of course, _2 can be fetched.
>
>> +                     test_must_fail git fetch ../testrepo/.git $SHA1_3
>
> And _3 that is not reachable cannot.
>
>> +             )
>> +     '
>> +done
>
> Again, very carefully covering combinations.  Good.
>
>
>
>
>  Documentation/technical/protocol-capabilities.txt |  2 +-
>  t/t5516-fetch-push.sh                             | 14 +++++++-------
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
> index 265fcab..eaab6b4 100644
> --- a/Documentation/technical/protocol-capabilities.txt
> +++ b/Documentation/technical/protocol-capabilities.txt
> @@ -261,7 +261,7 @@ send "want" lines with SHA-1s that exist at the server but are not
>  advertised by upload-pack.
>
>  allow-reachable-sha1-in-want
> -----------------------
> +----------------------------
>
>  If the upload-pack server advertises this capability, fetch-pack may
>  send "want" lines with SHA-1s that exist at the server but are not
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index fdcc114..ec22c98 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1137,7 +1137,7 @@ do
>                         test_must_fail git fetch --depth=1 ../testrepo/.git $SHA1 &&
>                         git --git-dir=../testrepo/.git config uploadpack.allowreachablesha1inwant true &&
>                         git fetch --depth=1 ../testrepo/.git $SHA1 &&
> -                       git cat-file commit $SHA1 >/dev/null
> +                       git cat-file commit $SHA1
>                 )
>         '
>
> @@ -1149,15 +1149,15 @@ do
>                         git commit --allow-empty -m foo &&
>                         git commit --allow-empty -m bar &&
>                         git commit --allow-empty -m xyz
> -               )
> +               ) &&
>                 SHA1_1=$(git --git-dir=testrepo/.git rev-parse HEAD^^) &&
>                 SHA1_2=$(git --git-dir=testrepo/.git rev-parse HEAD^) &&
>                 SHA1_3=$(git --git-dir=testrepo/.git rev-parse HEAD) &&
>                 (
>                         cd testrepo &&
>                         git reset --hard $SHA1_2 &&
> -                       git cat-file commit $SHA1_3 >/dev/null &&
> -                       git cat-file commit $SHA1_3 >/dev/null
> +                       git cat-file commit $SHA1_1 &&
> +                       git cat-file commit $SHA1_3
>                 ) &&
>                 mk_empty shallow &&
>                 (
> @@ -1166,10 +1166,10 @@ do
>                         test_must_fail git fetch ../testrepo/.git $SHA1_1 &&
>                         git --git-dir=../testrepo/.git config uploadpack.allowreachablesha1inwant true &&
>                         git fetch ../testrepo/.git $SHA1_1 &&
> -                       git cat-file commit $SHA1_1 >/dev/null &&
> -                       test_must_fail git cat-file commit $SHA1_2 >/dev/null &&
> +                       git cat-file commit $SHA1_1 &&
> +                       test_must_fail git cat-file commit $SHA1_2 &&
>                         git fetch ../testrepo/.git $SHA1_2 &&
> -                       git cat-file commit $SHA1_2 >/dev/null &&
> +                       git cat-file commit $SHA1_2 &&
>                         test_must_fail git fetch ../testrepo/.git $SHA1_3
>                 )
>         '
> --
> 2.4.1-439-gcfa393f
>
