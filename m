From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] builtin-bundle create - use lock_file semantics
Date: Sun, 12 Aug 2007 08:53:02 -0400
Message-ID: <11869231822803-git-send-email-mdl123@verizon.net>
Cc: Git Mailing List <git@vger.kernel.org>,
	Mark Levedahl <mdl123@verizon.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 14:53:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKCwT-000797-Oh
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 14:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757957AbXHLMxL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 08:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758140AbXHLMxK
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 08:53:10 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:60673 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757789AbXHLMxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 08:53:09 -0400
Received: from fal-l07294-lp.us.ray.com ([71.246.233.117])
 by vms046.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JMN003R9VSG96G1@vms046.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 12 Aug 2007 07:53:05 -0500 (CDT)
X-Mailer: git-send-email 1.5.3.rc4.78.g5acb3-dirty
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55680>

git bundle create would leave an invalid, partially written bundle if
an error occured during creation. Fix that using lock_file.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 builtin-bundle.c |   51 +++++++++++++++++++++++++++++++--------------------
 1 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index f4b4f03..82e00f5 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -186,10 +186,20 @@ static int list_heads(struct bundle_header *header, int argc, const char **argv)
 	return list_refs(&header->references, argc, argv);
 }
 
+/* create_bundle uses lock_file, delete if write fails */
+static inline void lwrite_or_die(int fd, const void *buf, size_t count, struct lock_file *lock)
+{
+	if (write_in_full(fd, buf, count) != count) {
+		rollback_lock_file(lock);
+		die("Unable to write bundle");
+	}
+}
+
 static int create_bundle(struct bundle_header *header, const char *path,
 		int argc, const char **argv)
 {
 	int bundle_fd = -1;
+	struct lock_file lock;
 	const char **argv_boundary = xmalloc((argc + 4) * sizeof(const char *));
 	const char **argv_pack = xmalloc(5 * sizeof(const char *));
 	int i, ref_count = 0;
@@ -198,17 +208,9 @@ static int create_bundle(struct bundle_header *header, const char *path,
 	struct child_process rls;
 	FILE *rls_fout;
 
-	/*
-	 * NEEDSWORK: this should use something like lock-file
-	 * to create temporary that is cleaned up upon error.
-	 */
-	bundle_fd = (!strcmp(path, "-") ? 1 :
-			open(path, O_CREAT | O_EXCL | O_WRONLY, 0666));
-	if (bundle_fd < 0)
-		return error("Could not create '%s': %s", path, strerror(errno));
-
 	/* write signature */
-	write_or_die(bundle_fd, bundle_signature, strlen(bundle_signature));
+	bundle_fd = hold_lock_file_for_update(&lock, path, 1);
+	lwrite_or_die(bundle_fd, bundle_signature, strlen(bundle_signature), &lock);
 
 	/* init revs to list objects for pack-objects later */
 	save_commit_buffer = 0;
@@ -230,7 +232,7 @@ static int create_bundle(struct bundle_header *header, const char *path,
 	while (fgets(buffer, sizeof(buffer), rls_fout)) {
 		unsigned char sha1[20];
 		if (buffer[0] == '-') {
-			write_or_die(bundle_fd, buffer, strlen(buffer));
+			lwrite_or_die(bundle_fd, buffer, strlen(buffer), &lock);
 			if (!get_sha1_hex(buffer + 1, sha1)) {
 				struct object *object = parse_object(sha1);
 				object->flags |= UNINTERESTING;
@@ -242,13 +244,17 @@ static int create_bundle(struct bundle_header *header, const char *path,
 		}
 	}
 	fclose(rls_fout);
-	if (finish_command(&rls))
+	if (finish_command(&rls)) {
+		rollback_lock_file(&lock);
 		return error("rev-list died");
+	}
 
 	/* write references */
 	argc = setup_revisions(argc, argv, &revs, NULL);
-	if (argc > 1)
+	if (argc > 1) {
+		rollback_lock_file(&lock);
 		return error("unrecognized argument: %s'", argv[1]);
+	}
 
 	for (i = 0; i < revs.pending.nr; i++) {
 		struct object_array_entry *e = revs.pending.objects + i;
@@ -307,17 +313,19 @@ static int create_bundle(struct bundle_header *header, const char *path,
 		}
 
 		ref_count++;
-		write_or_die(bundle_fd, sha1_to_hex(e->item->sha1), 40);
-		write_or_die(bundle_fd, " ", 1);
-		write_or_die(bundle_fd, ref, strlen(ref));
-		write_or_die(bundle_fd, "\n", 1);
+		lwrite_or_die(bundle_fd, sha1_to_hex(e->item->sha1), 40, &lock);
+		lwrite_or_die(bundle_fd, " ", 1, &lock);
+		lwrite_or_die(bundle_fd, ref, strlen(ref), &lock);
+		lwrite_or_die(bundle_fd, "\n", 1, &lock);
 		free(ref);
 	}
-	if (!ref_count)
+	if (!ref_count) {
+		rollback_lock_file(&lock);
 		die ("Refusing to create empty bundle.");
+	}
 
 	/* end header */
-	write_or_die(bundle_fd, "\n", 1);
+	lwrite_or_die(bundle_fd, "\n", 1, &lock);
 
 	/* write pack */
 	argv_pack[0] = "pack-objects";
@@ -339,8 +347,11 @@ static int create_bundle(struct bundle_header *header, const char *path,
 		write(rls.in, sha1_to_hex(object->sha1), 40);
 		write(rls.in, "\n", 1);
 	}
-	if (finish_command(&rls))
+	if (finish_command(&rls)) {
+		rollback_lock_file(&lock);
 		return error ("pack-objects died");
+	}
+	commit_lock_file(&lock);
 	return 0;
 }
 
-- 
1.5.3.rc4.78.g5acb3-dirty
