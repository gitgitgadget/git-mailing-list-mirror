From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 5/6] fix const issues with some functions
Date: Tue, 16 Oct 2007 21:55:49 -0400
Message-ID: <1192586150-13743-6-git-send-email-nico@cam.org>
References: <1192586150-13743-1-git-send-email-nico@cam.org>
 <1192586150-13743-2-git-send-email-nico@cam.org>
 <1192586150-13743-3-git-send-email-nico@cam.org>
 <1192586150-13743-4-git-send-email-nico@cam.org>
 <1192586150-13743-5-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 03:56:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihy9T-0003Wi-2q
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 03:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935962AbXJQB4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 21:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934957AbXJQB4G
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 21:56:06 -0400
Received: from relais.videotron.ca ([24.201.245.36]:8510 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935934AbXJQBz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 21:55:59 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0JQ10063X9D2E630@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 16 Oct 2007 21:55:54 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.4.1212.gdb015
In-reply-to: <1192586150-13743-5-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61312>

Two functions, namely write_idx_file() and open_pack_file(), currently
return a const pointer.  However that pointer is either a copy of the
first argument, or set to a malloc'd buffer when that first argument
is null.  In the later case it is wrong to qualify that pointer as const
since ownership of the buffer is transferred to the caller to dispose of,
and obviously the free() function is not meant to be passed const
pointers.

Making the return pointer not const causes a warning when the first
argument is returned since that argument is also marked const.

The correct thing to do is therefore to remove the const qualifiers,
avoiding the need for ugly casts only to silence some warnings.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |    2 +-
 index-pack.c           |    8 ++++----
 pack-write.c           |    3 ++-
 pack.h                 |    2 +-
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 933c252..15d3750 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -652,7 +652,7 @@ static void write_pack_file(void)
 			umask(mode);
 			mode = 0444 & ~mode;
 
-			idx_tmp_name = (char *) write_idx_file(NULL,
+			idx_tmp_name = write_idx_file(NULL,
 					(struct pack_idx_entry **) written_list,
 					nr_written, sha1);
 			snprintf(tmpname, sizeof(tmpname), "%s-%s.pack",
diff --git a/index-pack.c b/index-pack.c
index c784dec..60173d5 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -106,7 +106,7 @@ static void use(int bytes)
 	consumed_bytes += bytes;
 }
 
-static const char *open_pack_file(const char *pack_name)
+static char *open_pack_file(char *pack_name)
 {
 	if (from_stdin) {
 		input_fd = 0;
@@ -686,15 +686,15 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 int main(int argc, char **argv)
 {
 	int i, fix_thin_pack = 0;
-	const char *curr_pack, *pack_name = NULL;
-	const char *curr_index, *index_name = NULL;
+	char *curr_pack, *pack_name = NULL;
+	char *curr_index, *index_name = NULL;
 	const char *keep_name = NULL, *keep_msg = NULL;
 	char *index_name_buf = NULL, *keep_name_buf = NULL;
 	struct pack_idx_entry **idx_objects;
 	unsigned char sha1[20];
 
 	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
+		char *arg = argv[i];
 
 		if (*arg == '-') {
 			if (!strcmp(arg, "--stdin")) {
diff --git a/pack-write.c b/pack-write.c
index 979bdff..665e2b2 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -17,7 +17,8 @@ static int sha1_compare(const void *_a, const void *_b)
  * the SHA1 hash of sorted object names. The objects array passed in
  * will be sorted by SHA1 on exit.
  */
-const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects, int nr_objects, unsigned char *sha1)
+char *write_idx_file(char *index_name, struct pack_idx_entry **objects,
+		     int nr_objects, unsigned char *sha1)
 {
 	struct sha1file *f;
 	struct pack_idx_entry **sorted_by_sha, **list, **last;
diff --git a/pack.h b/pack.h
index b57ba2d..b31b376 100644
--- a/pack.h
+++ b/pack.h
@@ -55,7 +55,7 @@ struct pack_idx_entry {
 	off_t offset;
 };
 
-extern const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects, int nr_objects, unsigned char *sha1);
+extern char *write_idx_file(char *index_name, struct pack_idx_entry **objects, int nr_objects, unsigned char *sha1);
 
 extern int verify_pack(struct packed_git *, int);
 extern void fixup_pack_header_footer(int, unsigned char *, const char *, uint32_t);
-- 
1.5.3.4.1212.gdb015
