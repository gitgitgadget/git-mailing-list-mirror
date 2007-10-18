From: Jeff King <peff@peff.net>
Subject: [PATCH] t5516: test update of local refs on push
Date: Thu, 18 Oct 2007 02:17:46 -0400
Message-ID: <20071018061746.GA29531@coredump.intra.peff.net>
References: <20071018045358.GB14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Perry Wagle <wagle@cs.indiana.edu>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 08:18:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiOhk-0002T6-Ra
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 08:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831AbXJRGRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 02:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754752AbXJRGRu
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 02:17:50 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4551 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754530AbXJRGRt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 02:17:49 -0400
Received: (qmail 511 invoked by uid 111); 18 Oct 2007 06:17:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Oct 2007 02:17:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2007 02:17:46 -0400
Content-Disposition: inline
In-Reply-To: <20071018045358.GB14735@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61490>

The first test (updating local refs) should succeed, but the
second one (not updating on error) currently fails.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5516-fetch-push.sh |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index ca46aaf..dd329d7 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -244,4 +244,32 @@ test_expect_success 'push with colon-less refspec (4)' '
 
 '
 
+test_expect_success 'push updates local refs' '
+
+	rm -rf parent child &&
+	mkdir parent && cd parent && git init &&
+		echo one >foo && git add foo && git commit -m one &&
+	cd .. &&
+	git clone parent child && cd child &&
+		echo two >foo && git commit -a -m two &&
+		git push &&
+	test $(git rev-parse master) = $(git rev-parse remotes/origin/master)
+
+'
+
+test_expect_success 'push does not update local refs on failure' '
+
+	rm -rf parent child &&
+	mkdir parent && cd parent && git init &&
+		echo one >foo && git add foo && git commit -m one &&
+		echo exit 1 >.git/hooks/pre-receive &&
+		chmod +x .git/hooks/pre-receive &&
+	cd .. &&
+	git clone parent child && cd child &&
+		echo two >foo && git commit -a -m two || exit 1
+		git push && exit 1
+	test $(git rev-parse master) != $(git rev-parse remotes/origin/master)
+
+'
+
 test_done
-- 
1.5.3.4.1162.gc3e8e-dirty
