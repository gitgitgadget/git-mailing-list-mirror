From: Phil Hord <hordp@cisco.com>
Subject: [PATCH] t7407: Fix recursive submodule test
Date: Fri, 26 Oct 2012 15:13:54 -0400
Message-ID: <1351278834-28867-1-git-send-email-hordp@cisco.com>
References: <CABURp0op2+QUvusUmAFUxT8s8c02bB9V3=ag9gTTSiiN4t96OA@mail.gmail.com>
Cc: phil.hord@gmail.com, Jens Lehmann <Jens.Lehmann@web.de>,
	Jeff King <peff@peff.net>, Phil Hord <hordp@cisco.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 26 21:14:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRpMJ-0002tf-7Q
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 21:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966094Ab2JZTOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 15:14:06 -0400
Received: from rcdn-iport-9.cisco.com ([173.37.86.80]:54270 "EHLO
	rcdn-iport-9.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933966Ab2JZTOF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 15:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1526; q=dns/txt; s=iport;
  t=1351278845; x=1352488445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=pVlmvUvZixzsoq50AVOK1zBmQ5aQnlgqigr6XUt/5Qc=;
  b=RVNd/aLJi6GpumnulxkPER2VGK1du8OW3jf5qA88fBhti+VGnMbq3wop
   1DUhWY28X2PJslJVoDZW2lCCTCj4xKwQTzBBQx/jTRNW7M/2tZiQZl7Ph
   3hXMNLk+i5tFyEPVyOy+M0LTE0HcAy94aewQn/8lKWQHvP0ipFuEAOgYN
   w=;
X-IronPort-AV: E=Sophos;i="4.80,654,1344211200"; 
   d="scan'208";a="132799426"
Received: from rcdn-core2-4.cisco.com ([173.37.113.191])
  by rcdn-iport-9.cisco.com with ESMTP; 26 Oct 2012 19:14:04 +0000
Received: from ipsn-lnx-hordp.cisco.com (dhcp-64-100-104-96.cisco.com [64.100.104.96])
	by rcdn-core2-4.cisco.com (8.14.5/8.14.5) with ESMTP id q9QJE3HV030344;
	Fri, 26 Oct 2012 19:14:03 GMT
X-Mailer: git-send-email 1.8.0.2.gd008466.dirty
In-Reply-To: <CABURp0op2+QUvusUmAFUxT8s8c02bB9V3=ag9gTTSiiN4t96OA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208481>

A test in t7404-submodule-foreach purports to test that
the --cached flag is properly noticed by --recursive calls
to the foreach command as it descends into nested
submodules.  However, the test really does not perform this
test since the change it looks for is in a top-level
submodule handled by the first invocation of the command.
To properly test for the flag being passed to recursive
invocations, the change must be buried deeper in the
hierarchy.

Move the change one level deeper so it properly verifies
the recursive machinery of the 'git submodule status'
command.

Signed-off-by: Phil Hord <hordp@cisco.com>
---
 t/t7407-submodule-foreach.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 9b69fe2..107b4b7 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -226,14 +226,14 @@ test_expect_success 'test "status --recursive"' '
 	test_cmp expect actual
 '
 
-sed -e "/nested1 /s/.*/+$nested1sha1 nested1 (file2~1)/;/sub[1-3]/d" < expect > expect2
+sed -e "/nested2 /s/.*/+$nested2sha1 nested1\/nested2 (file2~1)/;/sub[1-3]/d" < expect > expect2
 mv -f expect2 expect
 
 test_expect_success 'ensure "status --cached --recursive" preserves the --cached flag' '
 	(
 		cd clone3 &&
 		(
-			cd nested1 &&
+			cd nested1/nested2 &&
 			test_commit file2
 		) &&
 		git submodule status --cached --recursive -- nested1 > ../actual
-- 
1.8.0.2.gd008466.dirty
