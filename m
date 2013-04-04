From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] t3600: test rm of path with changed leading symlinks
Date: Thu, 4 Apr 2013 15:06:21 -0400
Message-ID: <20130404190621.GA7484@sigill.intra.peff.net>
References: <20130404190211.GA15912@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: jpinheiro <7jpinheiro@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 21:06:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNpUv-0006Gv-RN
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 21:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764290Ab3DDTG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 15:06:28 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56232 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764260Ab3DDTG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 15:06:27 -0400
Received: (qmail 5287 invoked by uid 107); 4 Apr 2013 19:08:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Apr 2013 15:08:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2013 15:06:21 -0400
Content-Disposition: inline
In-Reply-To: <20130404190211.GA15912@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220071>

If we have a path "d/f" but replace "d" with a symlink to a
new directory "e", how should we handle "git rm d/f"?

It may seem at first like we need new protections to make
sure that we do not delete random content from "e/f".
However, we are already covered by git-rm's existing
protections: it is happy if the working tree file is either
already deleted, or if its content matches that of the index
and HEAD (and otherwise requires "-f").

Let's add some tests to make sure that these protections
remain in place when used across symlinks. We also want to
make sure that neither the symlink nor the pointed-to
directory is accidentally removed in an attempt to clean up
empty elements of the leading path.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t3600-rm.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index a2e1a03..9eaec08 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -659,4 +659,47 @@ test_expect_success 'rm of file when it has become a directory' '
 	test_path_is_file d/f
 '
 
+test_expect_success 'set up commit with d/f' '
+	rm -rf d e &&
+	mkdir d &&
+	echo content >d/f &&
+	git add d &&
+	git commit -m d
+'
+
+test_expect_success SYMLINKS 'replace dir with symlink to dir (file missing)' '
+	git reset --hard &&
+	rm -rf d e &&
+	mkdir e &&
+	ln -s e d &&
+	git rm d/f &&
+	test_must_fail git rev-parse --verify :d/f &&
+	test -h d &&
+	test_path_is_dir e
+'
+
+test_expect_success SYMLINKS 'replace dir with symlink to dir (same content)' '
+	git reset --hard &&
+	rm -rf d e &&
+	mkdir e &&
+	echo content >e/f &&
+	ln -s e d &&
+	git rm d/f &&
+	test_must_fail git rev-parse --verify :d/f &&
+	test -h d &&
+	test_path_is_dir e
+'
+
+test_expect_success SYMLINKS 'replace dir with symlink to dir (new content)' '
+	git reset --hard &&
+	rm -rf d e &&
+	mkdir e &&
+	echo changed >e/f &&
+	ln -s e d &&
+	test_must_fail git rm d/f &&
+	git rev-parse --verify :d/f &&
+	test -h d &&
+	test_path_is_file e/f
+'
+
 test_done
-- 
1.8.2.rc0.33.gd915649
