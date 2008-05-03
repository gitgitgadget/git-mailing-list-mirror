From: Heikki Orsila <heikki.orsila@iki.fi>
Subject: [PATCH] Cleanup xread() loops to use read_in_full()
Date: Sat, 3 May 2008 16:27:26 +0300
Message-ID: <20080503132726.GA15655@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 15:28:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsHmk-0005Xn-Sb
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 15:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755136AbYECN1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 09:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754984AbYECN1b
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 09:27:31 -0400
Received: from zakalwe.fi ([80.83.5.154]:37365 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754891AbYECN1a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 09:27:30 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id C727F2BC8E; Sat,  3 May 2008 16:27:26 +0300 (EEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81078>

Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
---
 combine-diff.c |   17 ++++++++---------
 pack-write.c   |    8 ++------
 pkt-line.c     |   15 +++++----------
 sha1_file.c    |   14 ++++----------
 4 files changed, 19 insertions(+), 35 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index f1e7a4d..7420146 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -701,7 +701,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 		else if (0 <= (fd = open(elem->path, O_RDONLY)) &&
 			 !fstat(fd, &st)) {
 			size_t len = xsize_t(st.st_size);
-			size_t sz = 0;
+			ssize_t done;
 			int is_file, i;
 
 			elem->mode = canon_mode(st.st_mode);
@@ -716,14 +716,13 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 
 			result_size = len;
 			result = xmalloc(len + 1);
-			while (sz < len) {
-				ssize_t done = xread(fd, result+sz, len-sz);
-				if (done == 0 && sz != len)
-					die("early EOF '%s'", elem->path);
-				else if (done < 0)
-					die("read error '%s'", elem->path);
-				sz += done;
-			}
+
+			done = read_in_full(fd, result, len);
+			if (done < 0)
+				die("read error '%s'", elem->path);
+			else if (done < len)
+				die("early EOF '%s'", elem->path);
+
 			result[len] = 0;
 		}
 		else {
diff --git a/pack-write.c b/pack-write.c
index 665e2b2..c66c8af 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -183,7 +183,6 @@ void fixup_pack_header_footer(int pack_fd,
 
 char *index_pack_lockfile(int ip_out)
 {
-	int len, s;
 	char packname[46];
 
 	/*
@@ -193,11 +192,8 @@ char *index_pack_lockfile(int ip_out)
 	 * case, we need it to remove the corresponding .keep file
 	 * later on.  If we don't get that then tough luck with it.
 	 */
-	for (len = 0;
-		 len < 46 && (s = xread(ip_out, packname+len, 46-len)) > 0;
-		 len += s);
-	if (len == 46 && packname[45] == '\n' &&
-		memcmp(packname, "keep\t", 5) == 0) {
+	if (read_in_full(ip_out, packname, 46) == 46 && packname[45] == '\n' &&
+	    memcmp(packname, "keep\t", 5) == 0) {
 		char path[PATH_MAX];
 		packname[45] = 0;
 		snprintf(path, sizeof(path), "%s/pack/pack-%s.keep",
diff --git a/pkt-line.c b/pkt-line.c
index 355546a..f5d0086 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -65,16 +65,11 @@ void packet_write(int fd, const char *fmt, ...)
 
 static void safe_read(int fd, void *buffer, unsigned size)
 {
-	size_t n = 0;
-
-	while (n < size) {
-		ssize_t ret = xread(fd, (char *) buffer + n, size - n);
-		if (ret < 0)
-			die("read error (%s)", strerror(errno));
-		if (!ret)
-			die("The remote end hung up unexpectedly");
-		n += ret;
-	}
+	ssize_t ret = read_in_full(fd, buffer, size);
+	if (ret < 0)
+		die("read error (%s)", strerror(errno));
+	else if (ret < size)
+		die("The remote end hung up unexpectedly");
 }
 
 int packet_read_line(int fd, char *buffer, unsigned size)
diff --git a/sha1_file.c b/sha1_file.c
index c2ab7ea..3516777 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2466,16 +2466,10 @@ int index_path(unsigned char *sha1, const char *path, struct stat *st, int write
 
 int read_pack_header(int fd, struct pack_header *header)
 {
-	char *c = (char*)header;
-	ssize_t remaining = sizeof(struct pack_header);
-	do {
-		ssize_t r = xread(fd, c, remaining);
-		if (r <= 0)
-			/* "eof before pack header was fully read" */
-			return PH_ERROR_EOF;
-		remaining -= r;
-		c += r;
-	} while (remaining > 0);
+	if (read_in_full(fd, header, sizeof(*header)) < sizeof(*header))
+		/* "eof before pack header was fully read" */
+		return PH_ERROR_EOF;
+
 	if (header->hdr_signature != htonl(PACK_SIGNATURE))
 		/* "protocol error (pack signature mismatch detected)" */
 		return PH_ERROR_PACK_SIGNATURE;
-- 
1.5.4.4
