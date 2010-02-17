From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 4/6] fast-import: make default pack size unlimited
Date: Wed, 17 Feb 2010 14:05:54 -0500
Message-ID: <1266433556-1987-5-git-send-email-nico@fluxnic.net>
References: <1266433556-1987-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 20:06:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhpEQ-0005G9-F7
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 20:06:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754059Ab0BQTGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 14:06:14 -0500
Received: from relais.videotron.ca ([24.201.245.36]:11748 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804Ab0BQTGG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 14:06:06 -0500
Received: from localhost.localdomain ([66.130.28.92])
 by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KY000GRF2DZ9K50@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 17 Feb 2010 14:06:02 -0500 (EST)
X-Mailer: git-send-email 1.7.0.23.gf5ef4
In-reply-to: <1266433556-1987-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140250>

Now that fast-import is creating packs with index version 2, there is
no point limiting the pack size by default.  A pack split will still
happen if off_t is not sufficiently large to hold large offsets.

While updating the doc, let's remove the "packfiles fit on CDs"
suggestion.  Pack files created by fast-import are still suboptimal and
a 'git repack -a -f -d' or even 'git gc --aggressive' would be a pretty
good idea before considering storage on CDs.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 Documentation/git-fast-import.txt |    5 +----
 fast-import.c                     |   12 ++++++------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 6764ff1..19082b0 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -45,10 +45,7 @@ OPTIONS
 
 --max-pack-size=<n>::
 	Maximum size of each output packfile.
-	The default is 4 GiB as that is the maximum allowed
-	packfile size (due to file format limitations). Some
-	importers may wish to lower this, such as to ensure the
-	resulting packfiles fit on CDs.
+	The default is unlimited.
 
 --big-file-threshold=<n>::
 	Maximum size of a blob that fast-import will attempt to
diff --git a/fast-import.c b/fast-import.c
index 9d7ab09..d2f45b1 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -191,7 +191,7 @@ struct mark_set
 struct last_object
 {
 	struct strbuf data;
-	uint32_t offset;
+	off_t offset;
 	unsigned int depth;
 	unsigned no_swap : 1;
 };
@@ -279,7 +279,7 @@ struct recent_command
 
 /* Configured limits on output */
 static unsigned long max_depth = 10;
-static off_t max_packsize = (1LL << 32) - 1;
+static off_t max_packsize;
 static uintmax_t big_file_threshold = 512 * 1024 * 1024;
 static int force_update;
 static int pack_compression_level = Z_DEFAULT_COMPRESSION;
@@ -315,7 +315,7 @@ static unsigned int pack_id;
 static struct sha1file *pack_file;
 static struct packed_git *pack_data;
 static struct packed_git **all_packs;
-static unsigned long pack_size;
+static off_t pack_size;
 
 /* Table of objects we've written. */
 static unsigned int object_entry_alloc = 5000;
@@ -1068,7 +1068,7 @@ static int store_object(
 	deflateEnd(&s);
 
 	/* Determine if we should auto-checkpoint. */
-	if ((pack_size + 60 + s.total_out) > max_packsize
+	if ((max_packsize && (pack_size + 60 + s.total_out) > max_packsize)
 		|| (pack_size + 60 + s.total_out) < pack_size) {
 
 		/* This new object needs to *not* have the current pack_id. */
@@ -1101,7 +1101,7 @@ static int store_object(
 	crc32_begin(pack_file);
 
 	if (delta) {
-		unsigned long ofs = e->idx.offset - last->offset;
+		off_t ofs = e->idx.offset - last->offset;
 		unsigned pos = sizeof(hdr) - 1;
 
 		delta_count_by_type[type]++;
@@ -1170,7 +1170,7 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 	int status = Z_OK;
 
 	/* Determine if we should auto-checkpoint. */
-	if ((pack_size + 60 + len) > max_packsize
+	if ((max_packsize && (pack_size + 60 + len) > max_packsize)
 		|| (pack_size + 60 + len) < pack_size)
 		cycle_packfile();
 
-- 
1.7.0.23.gf5ef4
