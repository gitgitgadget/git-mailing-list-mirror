From: Jeff King <peff@peff.net>
Subject: [PATCH 2/5] t5550: break submodule config test into multiple
 sub-tests
Date: Thu, 28 Apr 2016 09:37:04 -0400
Message-ID: <20160428133704.GB25319@sigill.intra.peff.net>
References: <20160428133534.GA19056@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Users <git@vger.kernel.org>, Jens.Lehmann@web.de
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 15:37:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avm84-0004dh-2W
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 15:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbcD1NhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 09:37:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:58295 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750847AbcD1NhI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 09:37:08 -0400
Received: (qmail 25547 invoked by uid 102); 28 Apr 2016 13:37:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 09:37:07 -0400
Received: (qmail 9583 invoked by uid 107); 28 Apr 2016 13:37:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 09:37:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Apr 2016 09:37:04 -0400
Content-Disposition: inline
In-Reply-To: <20160428133534.GA19056@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292877>

Right now we test only the cloning case, but there are other
interesting cases (e.g., fetching). Let's pull the setup
bits into their own test, which will make things flow more
logically once we start adding more tests which use the
setup.

Let's also introduce some whitespace to the clone-test to
split the two parts: making sure it fails without our
cmdline config, and that it succeeds with it.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5550-http-fetch-dumb.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 81cc57f..e8e91bb 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -91,17 +91,21 @@ test_expect_success 'configured username does not override URL' '
 	expect_askpass pass user@host
 '
 
-test_expect_success 'cmdline credential config passes into submodules' '
+test_expect_success 'set up repo with http submodules' '
 	git init super &&
 	set_askpass user@host pass@host &&
 	(
 		cd super &&
 		git submodule add "$HTTPD_URL/auth/dumb/repo.git" sub &&
 		git commit -m "add submodule"
-	) &&
+	)
+'
+
+test_expect_success 'cmdline credential config passes to submodule via clone' '
 	set_askpass wrong pass@host &&
 	test_must_fail git clone --recursive super super-clone &&
 	rm -rf super-clone &&
+
 	set_askpass wrong pass@host &&
 	git -c "credential.$HTTPD_URL.username=user@host" \
 		clone --recursive super super-clone &&
-- 
2.8.1.617.gbdccc2d
