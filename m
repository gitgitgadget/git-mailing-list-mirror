From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] xread(): Fix read error when filtering >= 2GB on Mac OS X
Date: Sat, 17 Aug 2013 14:40:05 +0200
Message-ID: <1376743205-12618-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 17 15:17:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAgNF-0006YL-P8
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 15:16:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164Ab3HQNQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Aug 2013 09:16:04 -0400
Received: from mailer.zib.de ([130.73.108.11]:41817 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753092Ab3HQNQC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Aug 2013 09:16:02 -0400
X-Greylist: delayed 2112 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Aug 2013 09:16:01 EDT
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id r7HCeWPW021100;
	Sat, 17 Aug 2013 14:40:38 +0200 (CEST)
Received: from vss6.zib.de (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id r7HCeVKd006515;
	Sat, 17 Aug 2013 14:40:32 +0200 (MEST)
X-Mailer: git-send-email 1.8.4.rc0.11.g35f5eaa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232455>

Previously, filtering more than 2GB through an external filter (see
test) failed on Mac OS X 10.8.4 (12E55) with:

    error: read from external filter cat failed
    error: cannot feed the input to external filter cat
    error: cat died of signal 13
    error: external filter cat failed 141
    error: external filter cat failed

The reason is that read() immediately returns with EINVAL if len >= 2GB.
I haven't found any information under which specific conditions this
occurs.  My suspicion is that it happens when reading from a pipe, while
reading from a standard file should always be fine.  I haven't tested
any other version of Mac OS X, though I'd expect that other versions are
affected as well.

The problem is fixed by always reading less than 2GB in xread().
xread() doesn't guarantee to read all the requested data at once, and
callers are expected to gracefully handle partial reads.  Slicing large
reads into 2GB pieces should not hurt practical performance.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 t/t0021-conversion.sh | 9 +++++++++
 wrapper.c             | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index e50f0f7..aec1253 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -190,4 +190,13 @@ test_expect_success 'required filter clean failure' '
 	test_must_fail git add test.fc
 '
 
+test_expect_success 'filter large file' '
+	git config filter.largefile.smudge cat &&
+	git config filter.largefile.clean cat &&
+	dd if=/dev/zero of=2GB count=2097152 bs=1024 &&
+	echo "/2GB filter=largefile" >.gitattributes &&
+	git add 2GB 2>err &&
+	! grep -q "error" err
+'
+
 test_done
diff --git a/wrapper.c b/wrapper.c
index 6a015de..2a2f496 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -139,6 +139,14 @@ ssize_t xread(int fd, void *buf, size_t len)
 {
 	ssize_t nr;
 	while (1) {
+#ifdef __APPLE__
+		const size_t twoGB = (1l << 31);
+		/* len >= 2GB immediately fails on Mac OS X with EINVAL when
+		 * reading from pipe. */
+		if (len >= twoGB) {
+			len = twoGB - 1;
+		}
+#endif
 		nr = read(fd, buf, len);
 		if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
 			continue;
-- 
1.8.4.rc3.5.gfcb973a
