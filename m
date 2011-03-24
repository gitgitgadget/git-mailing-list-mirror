From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3 0/5]rev-list and friends: --min-parents, --max-parents
Date: Thu, 24 Mar 2011 03:21:24 -0500
Message-ID: <20110324082108.GA30196@elie>
References: <20110321105628.GC16334@sigill.intra.peff.net>
 <cover.1300872923.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 24 09:21:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2fnW-0007id-TT
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 09:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933676Ab1CXIVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 04:21:32 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40594 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932228Ab1CXIVa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 04:21:30 -0400
Received: by iwn34 with SMTP id 34so9418989iwn.19
        for <git@vger.kernel.org>; Thu, 24 Mar 2011 01:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=mFfQiWNi9oivD0n7WeHsTrDQuYxQtUkCIBxq+x5ZWJI=;
        b=ftDCTLA5yBA2dHUVIoM/P+fla2a3WqnYhnnlwjB0ch+0xOZKK7Dey/vv7I+jEv4Nry
         jRMARl0/ptHBQUVzL8IuZ8woGj9WjdIOLLlbk08bLKqvT0+BAgzJR0w0fuhnCZ29dhvO
         8nwNoJARS9XuS/gKpIzznjayLy2ZWdrWdo7E8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pIrtdxTs9cSMIpDX9N+SnUzjjR6AFqoIeuaXPl8ry4rAvWB3oTWCMqdpMfG0NLTKVX
         jn5JHPIUNjIA+eG6rg2Gx7lJHGlsIu23iMgERDHwNg19bpZ4vi7IUvosuX79AksKvTPz
         iE/cjYrAoDBotdOEJrwLX/uvF6tvlBfRlsGaU=
Received: by 10.231.113.42 with SMTP id y42mr1411760ibp.68.1300954889963;
        Thu, 24 Mar 2011 01:21:29 -0700 (PDT)
Received: from elie ([68.255.102.141])
        by mx.google.com with ESMTPS id he40sm5659940ibb.33.2011.03.24.01.21.28
        (version=SSLv3 cipher=OTHER);
        Thu, 24 Mar 2011 01:21:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cover.1300872923.git.git@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169906>

Michael J Gruber wrote:

> Compared to what is currently in pu (which is v2+eps), v3 has:

Thanks.  I reviewed this by looking at what Junio queued in pu; it
looks very good.  With the following patch, it passes tests.

The use of "return" was surprising.  It seems this style has been
intended to work ever since v0.99.5~24^2~4 (Trapping exit in tests,
using return for errors, 2005-08-10).

It interacts poorly with test_when_finished but since these tests do
not use that function, they should be safe.  test_when_finished could
use some fixes to avoid future surprises but that's another story.

-- 8< --
Subject: tests: avoid nonportable {foo,bar} glob

Unlike bash and ksh, dash and busybox ash do not support brace
expansion (as in 'echo {hello,world}').  So when dash is sh,
t6009.13 (set up dodecapus) ends up pass a string beginning with
"root{1,2," to "git merge" verbatim and the test fails.

Fix it by introducing a variable to hold the list of parents for
the dodecapus and populating it in a more low-tech way.

While at it, simplify a little by combining this setup code with the
test it sets up for.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t6009-rev-list-parent.sh |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t6009-rev-list-parent.sh b/t/t6009-rev-list-parent.sh
index fc89d6d..3050740 100755
--- a/t/t6009-rev-list-parent.sh
+++ b/t/t6009-rev-list-parent.sh
@@ -112,20 +112,20 @@ test_expect_success 'rev-list override and infinities' '
 	check_revlist "--max-parents=0 --min-parents=1 --no-min-parents" one five
 '
 
-test_expect_success 'set up dodecapus' '
+test_expect_success 'dodecapus' '
 
+	roots= &&
 	for i in 1 2 3 4 5 6 7 8 9 10 11
 	do
-		git checkout -b root$i five || return
-		test_commit $i || return
+		git checkout -b root$i five &&
+		test_commit $i &&
+		roots="$roots root$i" ||
+		return
 	done &&
 	git checkout master &&
 	test_tick &&
-	git merge -m dodecapus root{1,2,3,4,5,6,7,8,9,10,11} &&
-	git tag dodecapus
-'
-
-test_expect_success 'test with dodecapus' '
+	git merge -m dodecapus $roots &&
+	git tag dodecapus &&
 
 	check_revlist "--min-parents=4" dodecapus tetrapus &&
 	check_revlist "--min-parents=8" dodecapus &&
-- 
1.7.4.1
