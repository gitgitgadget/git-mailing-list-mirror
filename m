From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/2] merge-recursive: eliminate flush_buffer() in favor of write_in_full()
Date: Fri, 3 Aug 2012 14:16:25 +0200
Message-ID: <853d452639066df2487b5766160ec2ebb692eab4.1343995614.git.trast@student.ethz.ch>
References: <6668871a0573c4d82d914137e3c7ff31fa8ce1ef.1343995614.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ralf Thielow <ralf.thielow@gmail.com>, <jk@jk.gs>,
	<stimming@tuhh.de>, <git@vger.kernel.org>,
	<worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 14:16:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxGnw-00005a-QR
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 14:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693Ab2HCMQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 08:16:29 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:7669 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753589Ab2HCMQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 08:16:27 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 3 Aug
 2012 14:16:20 +0200
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 3 Aug
 2012 14:16:26 +0200
X-Mailer: git-send-email 1.7.12.rc1.219.gb14e69c
In-Reply-To: <6668871a0573c4d82d914137e3c7ff31fa8ce1ef.1343995614.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202829>

flush_buffer() is a thin wrapper around write_in_full() with two very
confusing properties:

* It runs a loop to handle short reads, ensuring that we write
  everything.  But that is precisely what write_in_full() does!

* It checks for a return value of 0 from write_in_full(), which cannot
  happen: it returns this value only if count=0, but flush_buffer()
  will never call write_in_full() in this case.

Remove it.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Much easier than worrying about the "disk full?" message.

 merge-recursive.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index a7bb212..3d4eb82 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -613,23 +613,6 @@ static char *unique_path(struct merge_options *o, const char *path, const char *
 	return newpath;
 }
 
-static void flush_buffer(int fd, const char *buf, unsigned long size)
-{
-	while (size > 0) {
-		long ret = write_in_full(fd, buf, size);
-		if (ret < 0) {
-			/* Ignore epipe */
-			if (errno == EPIPE)
-				break;
-			die_errno("merge-recursive");
-		} else if (!ret) {
-			die(_("merge-recursive: disk full?"));
-		}
-		size -= ret;
-		buf += ret;
-	}
-}
-
 static int dir_in_way(const char *path, int check_working_copy)
 {
 	int pos, pathlen = strlen(path);
@@ -788,7 +771,7 @@ static void update_file_flags(struct merge_options *o,
 			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
 			if (fd < 0)
 				die_errno(_("failed to open '%s'"), path);
-			flush_buffer(fd, buf, size);
+			write_in_full(fd, buf, size);
 			close(fd);
 		} else if (S_ISLNK(mode)) {
 			char *lnk = xmemdupz(buf, size);
-- 
1.7.12.rc1.219.gb14e69c
