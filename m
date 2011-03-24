From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3 0/5]rev-list and friends: --min-parents, --max-parents
Date: Thu, 24 Mar 2011 04:42:31 -0500
Message-ID: <20110324094231.GC32092@elie>
References: <20110321105628.GC16334@sigill.intra.peff.net>
 <cover.1300872923.git.git@drmicha.warpmail.net>
 <20110324082108.GA30196@elie>
 <4D8B0712.6010300@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 24 10:42:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2h43-0004i9-GL
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 10:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644Ab1CXJmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 05:42:38 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48473 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755743Ab1CXJmg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 05:42:36 -0400
Received: by iwn34 with SMTP id 34so9482432iwn.19
        for <git@vger.kernel.org>; Thu, 24 Mar 2011 02:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=mQhfi60TSms4wau5E289Dano/mV/cALp/w7z4tojmhU=;
        b=YSKeJUDEOUiCtvj9TetdQYOqIO2kzX5EyCp7MLh+PW09Sx1d0ijSJIBJDnTZekXNYA
         mVyf5WekfR+Ffwfey2YffLEdrIHXOA+WCcM9rLoTupA9GU3CXKJZD2zIlMCPozqpNzCa
         yV9aV9C8G1Fim7Kx9MHUnBaVr20V+kVvq0I7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=i2kGka/ztx6jb25sDPX/hk0QyiFR7XSqCEgskxjQrVF4VWSEmjslSyAYXz9HU0GgRe
         /+Hi0t3hThUzjvl/uGpptKNbKaTDeJvM39TsnkBdD8jxYQbLcI/6oWfOVLxhT5JHUIfx
         Gzc+Nw/4lI6xuyDeAb6cVDRT8UaR2YS9julJI=
Received: by 10.43.45.67 with SMTP id uj3mr12511068icb.442.1300959756165;
        Thu, 24 Mar 2011 02:42:36 -0700 (PDT)
Received: from elie (adsl-68-255-102-141.dsl.chcgil.sbcglobal.net [68.255.102.141])
        by mx.google.com with ESMTPS id xi12sm2057289icb.18.2011.03.24.02.42.34
        (version=SSLv3 cipher=OTHER);
        Thu, 24 Mar 2011 02:42:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D8B0712.6010300@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169908>

Michael J Gruber wrote:

> What's the simplest way to run the tests so that they catch
> non-POSIXisms?

In theory: use posh from <git://git.debian.org/users/clint/posh.git>.

In practice, testing with dash seems to work well for catching these.
dash tends to be less buggy but more forgiving because some people
(like me :)) use it day-to-day.

> I thought it's considered bad style to mix setup and actual test?
> Personally, I don't care either way. I just didn't want to have these 12
> extra commits in the initial setup (forcing me to adjust all tests).

Other test frameworks (inspired by JUnit?) like to separate errors
from set-up, tear-down, and the meat of the tests, but the git's test
suite doesn't do that.  Its goal is to test git rather than to track
bugs in the harness.

Still, many scripts include a test that sets up some state to be
shared by later tests.  This way, if git is severely broken (e.g., it
segfaults), then even the setup will fail; and meanwhile, it means it
is still possible to safely skip other individual tests with
GIT_SKIP_TESTS.

Anyway, I shouldn't have included such a tiny nit with the brace
expansion fix.  Sorry about that.  Here's a more minimal patch.

-- 8< --
Subject: tests: avoid nonportable {foo,bar} glob

Unlike bash and ksh, dash and busybox ash do not support brace
expansion (as in 'echo {hello,world}').  So when dash is sh,
t6009.13 (set up dodecapus) ends up passing a string beginning with
"root{1,2," to "git merge" verbatim and the test fails.

Fix it by introducing a variable to hold the list of parents for
the dodecapus and populating it in a more low-tech way.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t6009-rev-list-parent.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/t/t6009-rev-list-parent.sh b/t/t6009-rev-list-parent.sh
index fc89d6d..b30834d 100755
--- a/t/t6009-rev-list-parent.sh
+++ b/t/t6009-rev-list-parent.sh
@@ -114,14 +114,16 @@ test_expect_success 'rev-list override and infinities' '
 
 test_expect_success 'set up dodecapus' '
 
+	roots= &&
 	for i in 1 2 3 4 5 6 7 8 9 10 11
 	do
 		git checkout -b root$i five || return
 		test_commit $i || return
+		roots="$roots root$i" || return
 	done &&
 	git checkout master &&
 	test_tick &&
-	git merge -m dodecapus root{1,2,3,4,5,6,7,8,9,10,11} &&
+	git merge -m dodecapus $roots &&
 	git tag dodecapus
 '
 
-- 
1.7.4.1
