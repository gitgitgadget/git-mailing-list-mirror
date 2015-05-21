From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/3] upload-pack: optionally allow fetching reachable sha1
Date: Thu, 21 May 2015 15:15:07 -0700
Message-ID: <xmqqioblh91w.fsf@gitster.dls.corp.google.com>
References: <1432068269-14895-1-git-send-email-fredrik.medley@gmail.com>
	<1432239819-21794-1-git-send-email-fredrik.medley@gmail.com>
	<1432239819-21794-3-git-send-email-fredrik.medley@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Fredrik Medley <fredrik.medley@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 00:15:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvYkF-0002sr-AR
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 00:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756316AbbEUWPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 18:15:10 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36894 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755334AbbEUWPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 18:15:09 -0400
Received: by igbsb11 with SMTP id sb11so19893422igb.0
        for <git@vger.kernel.org>; Thu, 21 May 2015 15:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-type;
        bh=ZDaTcbnFk/MqpcwiGNyZrfwg6GeHkNwNcTqkQ+8o7ZI=;
        b=SlMTO+xjwxuC15d6W0fierZZ2FG7nQQuIklwjqQFrYwEb6NH5ULTOvQ9znjUy1o/fR
         NdbkgBScyNGKYKrR11+Y7iKp1kXDhDMUnvOtK9PCs5VHgXq8X+hSOAvJ2zyQJrc1HsB0
         dC3B2+H0mQvWEtWUOIEM9nzqNHYE8+9hNlFYejOMqhcvLhxcNRPiaYz0jYAYyqv/Xzml
         L7mW+M2PdbR8Td1gPIb3fF1ZBCxtmiOL6zb0+SVv6M+l/YXuIbT78QLwSrwWWpTvNI3O
         1Be3gHruxiIEvHvHassDfDT58zg/D1uR9lZboUy9RfRx3clhCnnLkqMNDh3jN0ruCNJK
         qGfA==
X-Received: by 10.42.76.146 with SMTP id e18mr6081573ick.42.1432246508765;
        Thu, 21 May 2015 15:15:08 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:19:f810:32d8:695f])
        by mx.google.com with ESMTPSA id i185sm160460ioi.24.2015.05.21.15.15.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 May 2015 15:15:08 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269670>

Fredrik Medley <fredrik.medley@gmail.com> writes:

> --- a/Documentation/technical/protocol-capabilities.txt
> +++ b/Documentation/technical/protocol-capabilities.txt
> @@ -260,6 +260,13 @@ If the upload-pack server advertises this capability, fetch-pack may
>  send "want" lines with SHA-1s that exist at the server but are not
>  advertised by upload-pack.
>  
> +allow-reachable-sha1-in-want
> +----------------------

This is an underline applied to one line prior, and their length
must match.  I'll amend while applying (attached at end), so there
is no need to resend with correction unless you have other reasons
to do so.

> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 8a5f236..fdcc114 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1120,6 +1120,61 @@ test_expect_success 'fetch exact SHA1' '
>  	)
>  '

It looks like this new set of tests are well thought out; good job.

I spotted a few minor nits, though.  All I'll amend while applying
so there is no need to resend only to correct them.

> +for configallowtipsha1inwant in true false
> +do
> +	test_expect_success "shallow fetch reachable SHA1 (but not a ref), allowtipsha1inwant=$configallowtipsha1inwant" '
> +		mk_empty testrepo &&
> +		(
> +			cd testrepo &&
> +			git config uploadpack.allowtipsha1inwant $configallowtipsha1inwant &&
> +			git commit --allow-empty -m foo &&
> +			git commit --allow-empty -m bar
> +		) &&
> +		SHA1=$(git --git-dir=testrepo/.git rev-parse HEAD^) &&
> +		mk_empty shallow &&
> +		(
> +			cd shallow &&
> +			test_must_fail git fetch --depth=1 ../testrepo/.git $SHA1 &&

This tries to fetch one before the tip with "allowTipSHA1InWant" set
to true or false; either should fail.  Good.

> +			git --git-dir=../testrepo/.git config uploadpack.allowreachablesha1inwant true &&
> +			git fetch --depth=1 ../testrepo/.git $SHA1 &&

And regardless of allowTip setting, with allowReachable set to true,
fetching the reachable HEAD^ would succeed.  Good.

> +			git cat-file commit $SHA1 >/dev/null

Minor nit; drop ">/dev/null", as test framework will squelch the
output by default, and when the test is run with "-v" option, the
output would help debugging the script.

> +		)
> +	'
> +
> +	test_expect_success "deny fetch unreachable SHA1, allowtipsha1inwant=$configallowtipsha1inwant" '
> +		mk_empty testrepo &&
> +		(
> +			cd testrepo &&
> +			git config uploadpack.allowtipsha1inwant $configallowtipsha1inwant &&
> +			git commit --allow-empty -m foo &&
> +			git commit --allow-empty -m bar &&
> +			git commit --allow-empty -m xyz
> +		)

Broken && chain

> +		SHA1_1=$(git --git-dir=testrepo/.git rev-parse HEAD^^) &&
> +		SHA1_2=$(git --git-dir=testrepo/.git rev-parse HEAD^) &&
> +		SHA1_3=$(git --git-dir=testrepo/.git rev-parse HEAD) &&
> +		(
> +			cd testrepo &&
> +			git reset --hard $SHA1_2 &&

We have one before the tip (SHA1_1), one after the tip and no longer
reachable (SHA1_3); SHA1_2 is sitting at the tip of a ref.

> +			git cat-file commit $SHA1_3 >/dev/null &&
> +			git cat-file commit $SHA1_3 >/dev/null

I think one of the latter two is $SHA1_1, i.e. you make sure SHA1_{1,2,3}
are there in testrepo.

> +		) &&
> +		mk_empty shallow &&
> +		(
> +			cd shallow &&
> +			test_must_fail git fetch ../testrepo/.git $SHA1_3 &&
> +			test_must_fail git fetch ../testrepo/.git $SHA1_1 &&

With allowTip only, whether it is set to true or false, fetching _1
or _3 that are not at tip will fail.  Good.

> +			git --git-dir=../testrepo/.git config uploadpack.allowreachablesha1inwant true &&
> +			git fetch ../testrepo/.git $SHA1_1 &&
> +			git cat-file commit $SHA1_1 >/dev/null &&

With allowReachable, _1 which is reachable from tip is possible,
regardless of the setting of allowTip.  Good.

> +			test_must_fail git cat-file commit $SHA1_2 >/dev/null &&

And fetching _1 will not pull in _2, which is _1's child, that we
did not ask for.  Good (but it is probably not very relevant for the
purpose of these tests).

> +			git fetch ../testrepo/.git $SHA1_2 &&
> +			git cat-file commit $SHA1_2 >/dev/null &&

And of course, _2 can be fetched.

> +			test_must_fail git fetch ../testrepo/.git $SHA1_3

And _3 that is not reachable cannot.

> +		)
> +	'
> +done

Again, very carefully covering combinations.  Good.




 Documentation/technical/protocol-capabilities.txt |  2 +-
 t/t5516-fetch-push.sh                             | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index 265fcab..eaab6b4 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -261,7 +261,7 @@ send "want" lines with SHA-1s that exist at the server but are not
 advertised by upload-pack.
 
 allow-reachable-sha1-in-want
-----------------------
+----------------------------
 
 If the upload-pack server advertises this capability, fetch-pack may
 send "want" lines with SHA-1s that exist at the server but are not
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index fdcc114..ec22c98 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1137,7 +1137,7 @@ do
 			test_must_fail git fetch --depth=1 ../testrepo/.git $SHA1 &&
 			git --git-dir=../testrepo/.git config uploadpack.allowreachablesha1inwant true &&
 			git fetch --depth=1 ../testrepo/.git $SHA1 &&
-			git cat-file commit $SHA1 >/dev/null
+			git cat-file commit $SHA1
 		)
 	'
 
@@ -1149,15 +1149,15 @@ do
 			git commit --allow-empty -m foo &&
 			git commit --allow-empty -m bar &&
 			git commit --allow-empty -m xyz
-		)
+		) &&
 		SHA1_1=$(git --git-dir=testrepo/.git rev-parse HEAD^^) &&
 		SHA1_2=$(git --git-dir=testrepo/.git rev-parse HEAD^) &&
 		SHA1_3=$(git --git-dir=testrepo/.git rev-parse HEAD) &&
 		(
 			cd testrepo &&
 			git reset --hard $SHA1_2 &&
-			git cat-file commit $SHA1_3 >/dev/null &&
-			git cat-file commit $SHA1_3 >/dev/null
+			git cat-file commit $SHA1_1 &&
+			git cat-file commit $SHA1_3
 		) &&
 		mk_empty shallow &&
 		(
@@ -1166,10 +1166,10 @@ do
 			test_must_fail git fetch ../testrepo/.git $SHA1_1 &&
 			git --git-dir=../testrepo/.git config uploadpack.allowreachablesha1inwant true &&
 			git fetch ../testrepo/.git $SHA1_1 &&
-			git cat-file commit $SHA1_1 >/dev/null &&
-			test_must_fail git cat-file commit $SHA1_2 >/dev/null &&
+			git cat-file commit $SHA1_1 &&
+			test_must_fail git cat-file commit $SHA1_2 &&
 			git fetch ../testrepo/.git $SHA1_2 &&
-			git cat-file commit $SHA1_2 >/dev/null &&
+			git cat-file commit $SHA1_2 &&
 			test_must_fail git fetch ../testrepo/.git $SHA1_3
 		)
 	'
-- 
2.4.1-439-gcfa393f
