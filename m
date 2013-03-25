From: Jeff King <peff@peff.net>
Subject: [PATCH 6/9] streaming_write_entry: propagate streaming errors
Date: Mon, 25 Mar 2013 16:22:17 -0400
Message-ID: <20130325202216.GF16019@sigill.intra.peff.net>
References: <20130325201427.GA15798@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 25 21:22:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKDuq-0007Qg-TR
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 21:22:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758869Ab3CYUWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 16:22:21 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39346 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600Ab3CYUWU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 16:22:20 -0400
Received: (qmail 27918 invoked by uid 107); 25 Mar 2013 20:24:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Mar 2013 16:24:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Mar 2013 16:22:17 -0400
Content-Disposition: inline
In-Reply-To: <20130325201427.GA15798@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219084>

When we are streaming an index blob to disk, we store the
error from stream_blob_to_fd in the "result" variable, and
then immediately overwrite that with the return value of
"close". That means we catch errors on close (e.g., problems
committing the file to disk), but miss anything which
happened before then.

Signed-off-by: Jeff King <peff@peff.net>
---
 entry.c                      |  6 ++++--
 t/t1060-object-corruption.sh | 25 +++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/entry.c b/entry.c
index 17a6bcc..002b2f2 100644
--- a/entry.c
+++ b/entry.c
@@ -126,8 +126,10 @@ static int streaming_write_entry(struct cache_entry *ce, char *path,
 	fd = open_output_fd(path, ce, to_tempfile);
 	if (0 <= fd) {
 		result = stream_blob_to_fd(fd, ce->sha1, filter, 1);
-		*fstat_done = fstat_output(fd, state, statbuf);
-		result = close(fd);
+		if (!result) {
+			*fstat_done = fstat_output(fd, state, statbuf);
+			result = close(fd);
+		}
 	}
 	if (result && 0 <= fd)
 		unlink(path);
diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
index d36994a..0792132 100755
--- a/t/t1060-object-corruption.sh
+++ b/t/t1060-object-corruption.sh
@@ -24,6 +24,15 @@ test_expect_success 'setup corrupt repo' '
 	)
 '
 
+test_expect_success 'setup repo with missing object' '
+	git init missing &&
+	(
+		cd missing &&
+		test_commit content &&
+		rm -f "$(obj_to_file HEAD:content.t)"
+	)
+'
+
 test_expect_success 'streaming a corrupt blob fails' '
 	(
 		cd bit-error &&
@@ -31,4 +40,20 @@ test_expect_success 'streaming a corrupt blob fails' '
 	)
 '
 
+test_expect_success 'read-tree -u detects bit-errors in blobs' '
+	(
+		cd bit-error &&
+		rm content.t &&
+		test_must_fail git read-tree --reset -u FETCH_HEAD
+	)
+'
+
+test_expect_success 'read-tree -u detects missing objects' '
+	(
+		cd missing &&
+		rm content.t &&
+		test_must_fail git read-tree --reset -u FETCH_HEAD
+	)
+'
+
 test_done
-- 
1.8.2.13.g0f18d3c
