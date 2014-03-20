From: Jeff King <peff@peff.net>
Subject: [PATCH 10/12] t0001: use test_must_fail
Date: Thu, 20 Mar 2014 19:19:50 -0400
Message-ID: <20140320231950.GJ8479@sigill.intra.peff.net>
References: <20140320231159.GA7774@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Tran <unsignedzero@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 00:19:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQmFi-0006Rt-6U
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 00:19:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760137AbaCTXTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 19:19:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:43602 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760049AbaCTXTw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 19:19:52 -0400
Received: (qmail 28167 invoked by uid 102); 20 Mar 2014 23:19:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Mar 2014 18:19:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Mar 2014 19:19:50 -0400
Content-Disposition: inline
In-Reply-To: <20140320231159.GA7774@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244613>

We've hand-rolled several "if" statements looking for
failures. We can use test_must_fail here, which is shorter
and more robust.

Note that we modify the commands slightly (to use "git init
foo" rather than "cd foo && git init") to avoid dealing with
a subshell, but this should not affect the outcome.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm pretty sure we can actually drop the "mkdir" in each of
these cases, too, but I was trying to leave things as close
to the original as possible.

 t/t0001-init.sh | 38 +++++++++++---------------------------
 1 file changed, 11 insertions(+), 27 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 9515da3..4560bba 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -85,15 +85,8 @@ test_expect_failure 'plain nested in bare through aliased command' '
 '
 
 test_expect_success 'plain with GIT_WORK_TREE' '
-	if (
-		mkdir plain-wt &&
-		cd plain-wt &&
-		GIT_WORK_TREE=$(pwd) git init
-	)
-	then
-		echo Should have failed -- GIT_WORK_TREE should not be used
-		false
-	fi
+	mkdir plain-wt &&
+	test_must_fail env GIT_WORK_TREE="$(pwd)/plain-wt" git init plain-wt
 '
 
 test_expect_success 'plain bare' '
@@ -106,15 +99,10 @@ test_expect_success 'plain bare' '
 '
 
 test_expect_success 'plain bare with GIT_WORK_TREE' '
-	if (
-		mkdir plain-bare-2 &&
-		cd plain-bare-2 &&
-		GIT_WORK_TREE=$(pwd) git --bare init
-	)
-	then
-		echo Should have failed -- GIT_WORK_TREE should not be used
-		false
-	fi
+	mkdir plain-bare-2 &&
+	test_must_fail \
+		env GIT_WORK_TREE="$(pwd)/plain-bare-2" \
+		git --bare init plain-bare-2
 '
 
 test_expect_success 'GIT_DIR bare' '
@@ -156,15 +144,11 @@ test_expect_success 'GIT_DIR & GIT_WORK_TREE (1)' '
 '
 
 test_expect_success 'GIT_DIR & GIT_WORK_TREE (2)' '
-
-	if (
-		mkdir git-dir-wt-2.git &&
-		GIT_WORK_TREE=$(pwd) GIT_DIR=git-dir-wt-2.git git --bare init
-	)
-	then
-		echo Should have failed -- --bare should not be used
-		false
-	fi
+	mkdir git-dir-wt-2.git &&
+	test_must_fail env \
+		GIT_WORK_TREE="$(pwd)" \
+		GIT_DIR=git-dir-wt-2.git \
+		git --bare init
 '
 
 test_expect_success 'reinit' '
-- 
1.9.0.560.g01ceb46
