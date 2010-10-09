From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 3/5] add function check_ok_to_remove()
Date: Sat,  9 Oct 2010 15:52:58 +0200
Message-ID: <1286632380-7002-4-git-send-email-drizzd@aon.at>
References: <7v4oepaup7.fsf@alter.siamese.dyndns.org>
Cc: gitster@pobox.com, Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 09 15:53:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4ZrX-0003Jt-R6
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 15:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760287Ab0JINxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 09:53:20 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51825 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755480Ab0JINxF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 09:53:05 -0400
Received: by bwz15 with SMTP id 15so854493bwz.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 06:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=bBPKApJTTCdDk+eqHjMMcNlJh42WVZFRiUMA22Z9Je8=;
        b=hvkjulCPSTDKnFdVrYczZkEIoCVhLMqcDNTfEsyvFDbebmpt9P72m260iRNpPObAw5
         Ygul9jVcJkGE1PjjaQSyoi71CN+gloTesoUx+71SBmQGEBYKVaeB47nwpZm9DHq86ycU
         RAyDEb0EF7CB8SE78QCxvMOXKCyYmT32Btf28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=TjaYJ22e9iD6lQqtg8WD3TKADFHskyHrZsdMQ/VL8rGBLwnvEMJDpSzqr5WwiAiOhH
         HeDPAQXIrAx6W29pOXGQH3tUCObcmSWSJgzhVUJvgMz+Cy7fmykAVYRVHDGsj+VYdjXM
         Qwsh4svLzjCOhmWJN4xHf5fJlc/TW3JhATsNg=
Received: by 10.204.57.146 with SMTP id c18mr3145296bkh.205.1286632383699;
        Sat, 09 Oct 2010 06:53:03 -0700 (PDT)
Received: from darc.lan (p549A51C3.dip.t-dialin.net [84.154.81.195])
        by mx.google.com with ESMTPS id l14sm2329415bkb.19.2010.10.09.06.53.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 06:53:02 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1P4ZrN-0001se-63; Sat, 09 Oct 2010 15:53:13 +0200
X-Mailer: git-send-email 1.7.1.571.gba4d01
In-Reply-To: <7v4oepaup7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158590>

This wraps some inline code into the function check_ok_to_remove(),
which will later be used for leading path components as well.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 unpack-trees.c |  107 ++++++++++++++++++++++++++++++-------------------------
 1 files changed, 58 insertions(+), 49 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 803445a..df1c920 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1127,14 +1127,65 @@ static int verify_clean_subdirectory(struct cache_entry *ce,
  * See if we can find a case-insensitive match in the index that also
  * matches the stat information, and assume it's that other file!
  */
-static int icase_exists(struct unpack_trees_options *o, struct cache_entry *dst, struct stat *st)
+static int icase_exists(struct unpack_trees_options *o, const char *name, int len, struct stat *st)
 {
 	struct cache_entry *src;
 
-	src = index_name_exists(o->src_index, dst->name, ce_namelen(dst), 1);
+	src = index_name_exists(o->src_index, name, len, 1);
 	return src && !ie_match_stat(o->src_index, src, st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
 }
 
+static int check_ok_to_remove(const char *name, int len, int dtype,
+			      struct cache_entry *ce, struct stat *st,
+			      enum unpack_trees_error_types error_type,
+			      struct unpack_trees_options *o)
+{
+	struct cache_entry *result;
+
+	/*
+	 * It may be that the 'lstat()' succeeded even though
+	 * target 'ce' was absent, because there is an old
+	 * entry that is different only in case..
+	 *
+	 * Ignore that lstat() if it matches.
+	 */
+	if (ignore_case && icase_exists(o, name, len, st))
+		return 0;
+
+	if (o->dir && excluded(o->dir, name, &dtype))
+		/*
+		 * ce->name is explicitly excluded, so it is Ok to
+		 * overwrite it.
+		 */
+		return 0;
+	if (S_ISDIR(st->st_mode)) {
+		/*
+		 * We are checking out path "foo" and
+		 * found "foo/." in the working tree.
+		 * This is tricky -- if we have modified
+		 * files that are in "foo/" we would lose
+		 * them.
+		 */
+		if (verify_clean_subdirectory(ce, error_type, o) < 0)
+			return -1;
+		return 0;
+	}
+
+	/*
+	 * The previous round may already have decided to
+	 * delete this path, which is in a subdirectory that
+	 * is being replaced with a blob.
+	 */
+	result = index_name_exists(&o->result, name, len, 0);
+	if (result) {
+		if (result->ce_flags & CE_REMOVE)
+			return 0;
+	}
+
+	return o->gently ? -1 :
+		add_rejected_path(o, error_type, name);
+}
+
 /*
  * We do not want to remove or overwrite a working tree file that
  * is not tracked, unless it is ignored.
@@ -1151,55 +1202,13 @@ static int verify_absent_1(struct cache_entry *ce,
 	if (has_symlink_or_noent_leading_path(ce->name, ce_namelen(ce)))
 		return 0;
 
-	if (!lstat(ce->name, &st)) {
-		int dtype = ce_to_dtype(ce);
-		struct cache_entry *result;
-
-		/*
-		 * It may be that the 'lstat()' succeeded even though
-		 * target 'ce' was absent, because there is an old
-		 * entry that is different only in case..
-		 *
-		 * Ignore that lstat() if it matches.
-		 */
-		if (ignore_case && icase_exists(o, ce, &st))
-			return 0;
-
-		if (o->dir && excluded(o->dir, ce->name, &dtype))
-			/*
-			 * ce->name is explicitly excluded, so it is Ok to
-			 * overwrite it.
-			 */
-			return 0;
-		if (S_ISDIR(st.st_mode)) {
-			/*
-			 * We are checking out path "foo" and
-			 * found "foo/." in the working tree.
-			 * This is tricky -- if we have modified
-			 * files that are in "foo/" we would lose
-			 * them.
-			 */
-			if (verify_clean_subdirectory(ce, error_type, o) < 0)
-				return -1;
-			return 0;
-		}
-
-		/*
-		 * The previous round may already have decided to
-		 * delete this path, which is in a subdirectory that
-		 * is being replaced with a blob.
-		 */
-		result = index_name_exists(&o->result, ce->name, ce_namelen(ce), 0);
-		if (result) {
-			if (result->ce_flags & CE_REMOVE)
-				return 0;
-		}
-
-		return o->gently ? -1 :
-			add_rejected_path(o, error_type, ce->name);
-	}
+	if (!lstat(ce->name, &st))
+		return check_ok_to_remove(ce->name, ce_namelen(ce),
+				ce_to_dtype(ce), ce, &st,
+				error_type, o);
 	return 0;
 }
+
 static int verify_absent(struct cache_entry *ce,
 			 enum unpack_trees_error_types error_type,
 			 struct unpack_trees_options *o)
-- 
1.7.1.571.gba4d01
