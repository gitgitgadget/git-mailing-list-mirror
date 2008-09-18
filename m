From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] sha1_file: link() returns -1 on failure, not errno
Date: Fri, 19 Sep 2008 00:24:46 +0200
Message-ID: <1221776686-13284-1-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 19 00:26:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgRwx-0007wa-2p
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 00:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757447AbYIRWZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 18:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757438AbYIRWZF
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 18:25:05 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:8491 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756063AbYIRWZE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 18:25:04 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 19 Sep 2008 00:25:01 +0200
Received: from localhost.localdomain ([84.75.157.245]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 19 Sep 2008 00:25:01 +0200
X-Mailer: git-send-email 1.6.0.2.489.gb13a
X-OriginalArrivalTime: 18 Sep 2008 22:25:01.0748 (UTC) FILETIME=[6444FF40:01C919DD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96246>

5723fe7 changed the call to use link() directly instead of through a
custom wrapper, but forgot that it returns 0 or -1, not 0 or errno.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>

---
 sha1_file.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 9ee1ed1..aec81bb 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2136,7 +2136,9 @@ static void write_sha1_file_prepare(const void *buf, unsigned long len,
  */
 int move_temp_to_file(const char *tmpfile, const char *filename)
 {
-	int ret = link(tmpfile, filename);
+	int ret = 0;
+	if (link(tmpfile, filename))
+		ret = errno;
 
 	/*
 	 * Coda hack - coda doesn't like cross-directory links,
-- 
tg: (97d7fee..) t/link-returns-minus1 (depends on: origin/master)
