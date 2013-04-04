From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] t3600: test behavior of reverse-d/f conflict
Date: Thu, 4 Apr 2013 15:03:58 -0400
Message-ID: <20130404190358.GB4063@sigill.intra.peff.net>
References: <20130404190211.GA15912@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: jpinheiro <7jpinheiro@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 21:04:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNpSd-00046u-KP
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 21:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764066Ab3DDTEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 15:04:06 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56218 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763705Ab3DDTEF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 15:04:05 -0400
Received: (qmail 5191 invoked by uid 107); 4 Apr 2013 19:05:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Apr 2013 15:05:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2013 15:03:58 -0400
Content-Disposition: inline
In-Reply-To: <20130404190211.GA15912@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220069>

The previous commit taught "rm" that it is safe to consider
"d/f" removed when "d" has become a non-directory. This
patch adds a test for the opposite: a file "d" that becomes
a directory.

In this case, "git rm" does need to complain, because we
should not be removing arbitrary content under "d". Git
already behaves correctly, but let's make sure that remains
the case by protecting the behavior with a test.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t3600-rm.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 73772b2..a2e1a03 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -647,4 +647,16 @@ test_expect_success SYMLINKS 'rm of d/f when d has become a dangling symlink' '
 	test_path_is_missing d
 '
 
+test_expect_success 'rm of file when it has become a directory' '
+	rm -rf d &&
+	>d &&
+	git add d &&
+	rm -f d &&
+	mkdir d &&
+	>d/f &&
+	test_must_fail git rm d &&
+	git rev-parse --verify :d &&
+	test_path_is_file d/f
+'
+
 test_done
-- 
1.8.2.rc0.33.gd915649
