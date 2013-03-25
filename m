From: Jeff King <peff@peff.net>
Subject: [PATCH 5/9] add test for streaming corrupt blobs
Date: Mon, 25 Mar 2013 16:21:34 -0400
Message-ID: <20130325202134.GE16019@sigill.intra.peff.net>
References: <20130325201427.GA15798@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 25 21:22:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKDuA-0006FO-Ay
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 21:22:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933270Ab3CYUVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 16:21:38 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39343 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933156Ab3CYUVi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 16:21:38 -0400
Received: (qmail 27901 invoked by uid 107); 25 Mar 2013 20:23:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Mar 2013 16:23:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Mar 2013 16:21:34 -0400
Content-Disposition: inline
In-Reply-To: <20130325201427.GA15798@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219083>

We do not have many tests for handling corrupt objects. This
new test at least checks that we detect a byte error in a
corrupt blob object while streaming it out with cat-file.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1060-object-corruption.sh | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100755 t/t1060-object-corruption.sh

diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
new file mode 100755
index 0000000..d36994a
--- /dev/null
+++ b/t/t1060-object-corruption.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+
+test_description='see how we handle various forms of corruption'
+. ./test-lib.sh
+
+# convert "1234abcd" to ".git/objects/12/34abcd"
+obj_to_file() {
+	echo "$(git rev-parse --git-dir)/objects/$(git rev-parse "$1" | sed 's,..,&/,')"
+}
+
+# Convert byte at offset "$2" of object "$1" into '\0'
+corrupt_byte() {
+	obj_file=$(obj_to_file "$1") &&
+	chmod +w "$obj_file" &&
+	printf '\0' | dd of="$obj_file" bs=1 seek="$2"
+}
+
+test_expect_success 'setup corrupt repo' '
+	git init bit-error &&
+	(
+		cd bit-error &&
+		test_commit content &&
+		corrupt_byte HEAD:content.t 10
+	)
+'
+
+test_expect_success 'streaming a corrupt blob fails' '
+	(
+		cd bit-error &&
+		test_must_fail git cat-file blob HEAD:content.t
+	)
+'
+
+test_done
-- 
1.8.2.13.g0f18d3c
