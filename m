From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 1/2] commit: add parse_commit_repl() to replace commits at
	parsing time
Date: Tue, 17 Aug 2010 03:58:59 +0200
Message-ID: <20100817015901.5592.25471.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 03:59:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlBSt-0006iX-R5
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 03:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754305Ab0HQB7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Aug 2010 21:59:42 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:33368 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751987Ab0HQB7m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Aug 2010 21:59:42 -0400
Received: from style.boubyland (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6944381802F;
	Tue, 17 Aug 2010 03:59:35 +0200 (CEST)
X-git-sha1: 275bfe92156af7b1dfa9c7f7ca5ce3202efecb2c 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153683>

The function parse_commit() is not safe regarding replaced commits
because it uses the buffer of the replacement commit but the object
part of the commit struct stay the same. Especially the sha1 is not
changed so it doesn't match the content of the commit.

To fix that, this patch adds a new function that takes a
"struct commit **" instead of a "struct commit *" so we can
change the commit pointer that is passed to us.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 commit.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 commit.h |    6 ++++++
 2 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/commit.c b/commit.c
index 652c1ba..f170179 100644
--- a/commit.c
+++ b/commit.c
@@ -316,6 +316,49 @@ int parse_commit(struct commit *item)
 	return ret;
 }
 
+int parse_commit_repl(struct commit **commit)
+{
+	enum object_type type;
+	void *buffer;
+	unsigned long size;
+	int ret;
+	const unsigned char *repl;
+	struct commit *item = *commit;
+
+	if (!item)
+		return -1;
+	if (item->object.parsed)
+		return 0;
+	buffer = read_sha1_file_repl(item->object.sha1, &type, &size, &repl);
+	if (!buffer)
+		return error("Could not read %s",
+			     sha1_to_hex(item->object.sha1));
+
+	if (item->object.sha1 != repl) {
+		struct commit *repl_item = lookup_commit(repl);
+		if (!repl_item) {
+			free(buffer);
+			return error("Bad replacement %s for commit %s",
+				     sha1_to_hex(repl),
+				     sha1_to_hex(item->object.sha1));
+		}
+		repl_item->object.flags = item->object.flags;
+		*commit = item = repl_item;
+	} else if (type != OBJ_COMMIT) {
+		free(buffer);
+		return error("Object %s not a commit",
+			     sha1_to_hex(item->object.sha1));
+	}
+
+	ret = parse_commit_buffer(item, buffer, size);
+	if (save_commit_buffer && !ret) {
+		item->buffer = buffer;
+		return 0;
+	}
+	free(buffer);
+	return ret;
+}
+
 int find_commit_subject(const char *commit_buffer, const char **subject)
 {
 	const char *eol;
diff --git a/commit.h b/commit.h
index a3618f8..d3dfebb 100644
--- a/commit.h
+++ b/commit.h
@@ -39,6 +39,12 @@ struct commit *lookup_commit_reference_gently(const unsigned char *sha1,
 
 int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size);
 
+int parse_commit_repl(struct commit **item);
+
+/*
+ * parse_commit() is deprecated, because it's buggy regarding replacements.
+ * Use parse_commit_repl() instead.
+ */
 int parse_commit(struct commit *item);
 
 /* Find beginning and length of commit subject. */
-- 
1.7.2.1.351.g275bf
