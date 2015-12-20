From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] t1401: test reflog creation for git-symbolic-ref
Date: Sun, 20 Dec 2015 02:27:23 -0500
Message-ID: <20151220072723.GB30662@sigill.intra.peff.net>
References: <20151220072637.GA22102@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 20 08:27:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAYOw-0000WL-Dn
	for gcvg-git-2@plane.gmane.org; Sun, 20 Dec 2015 08:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137AbbLTH10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Dec 2015 02:27:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:44644 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754102AbbLTH1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2015 02:27:25 -0500
Received: (qmail 20118 invoked by uid 102); 20 Dec 2015 07:27:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 20 Dec 2015 01:27:26 -0600
Received: (qmail 11148 invoked by uid 107); 20 Dec 2015 07:27:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 20 Dec 2015 02:27:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Dec 2015 02:27:23 -0500
Content-Disposition: inline
In-Reply-To: <20151220072637.GA22102@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282759>

The current code writes a reflog entry whenever we update a
symbolic ref, but we never test that this is so. Let's add a
test to make sure upcoming refactoring doesn't cause a
regression.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1401-symbolic-ref.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index fbb4835..1f0dff3 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -98,4 +98,20 @@ test_expect_success 'symbolic-ref reports failure in exit code' '
 	test_must_fail git symbolic-ref HEAD refs/heads/whatever
 '
 
+test_expect_success 'symbolic-ref writes reflog entry' '
+	git checkout -b log1 &&
+	test_commit one &&
+	git checkout -b log2  &&
+	test_commit two &&
+	git checkout --orphan orphan &&
+	git symbolic-ref -m create HEAD refs/heads/log1 &&
+	git symbolic-ref -m update HEAD refs/heads/log2 &&
+	cat >expect <<-\EOF &&
+	update
+	create
+	EOF
+	git log --format=%gs -g >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.7.0.rc1.350.g9acc0f4
