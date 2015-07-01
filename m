From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/13] rerere: explain MERGE_RR management helpers
Date: Tue, 30 Jun 2015 23:04:55 -0700
Message-ID: <1435730699-9124-10-git-send-email-gitster@pobox.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 08:06:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAB9o-0004e5-MA
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 08:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbbGAGFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 02:05:37 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:36494 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbbGAGFS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 02:05:18 -0400
Received: by iecvh10 with SMTP id vh10so27779368iec.3
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 23:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=J3CqZAsSmFGI/7fKpua5CzIWvY+gYaRmhQpg5VMizSI=;
        b=UonrQoK6hMavbIKmjIDxqKFqwDgqvoTTayPQBBlSgcEzMz/iSYZPgjiE/BFZocx4Pr
         +x6hfIxc7k/lSLMycq+AVqupqanUxCmOVLvgmq2t4Omp3lOBQE0eyplpQR3WfTjCSnG0
         IDS8IaYdVMQ42lUZjXZMip8LnVhAxF6H32gir3/Cc2HTi66Pe52y4PvoLxuQwfU/jCfx
         Mkaf7poSf4pbF7pkQ3qDMWXTuIgwQ3Zv7Aq9pQSuxdBhTVLEwxbFYE7PqnWlc35tfqTE
         y2ang1SqJ6CFXhht1oS2z3OgzcKrRmZxleT6QAkcYSbprK6hAUl1zyYIutnrPv1ZCPzf
         f7CQ==
X-Received: by 10.107.26.207 with SMTP id a198mr34952520ioa.5.1435730718323;
        Tue, 30 Jun 2015 23:05:18 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:502c:1da0:e16d:2d77])
        by mx.google.com with ESMTPSA id bf10sm649386igb.12.2015.06.30.23.05.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 23:05:17 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc0-209-g5e1f148
In-Reply-To: <1435730699-9124-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273126>

Explain the internals of rerere as in-code comments, while
sprinkling "NEEDSWORK" comment to highlight iffy bits and
questionable assumptions.

This one covers the "$GIT_DIR/MERGE_RR" file and in-core merge_rr
that are used to keep track of the status of "rerere" session in
progress.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/rerere.c b/rerere.c
index 7ed20f1..d54bdb2 100644
--- a/rerere.c
+++ b/rerere.c
@@ -33,6 +33,13 @@ static int has_rerere_resolution(const char *hex)
 	return !stat(rerere_path(hex, "postimage"), &st);
 }
 
+/*
+ * $GIT_DIR/MERGE_RR file is a collection of records, each of which is
+ * "conflict ID", a HT and pathname, terminated with a NUL, and is
+ * used to keep track of the set of paths that "rerere" may need to
+ * work on (i.e. what is left by the previous invocation of "git
+ * rerere" during the current conflict resolution session).
+ */
 static void read_rr(struct string_list *rr)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -394,6 +401,14 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 	return hunk_no;
 }
 
+/*
+ * Look at a cache entry at "i" and see if it is not conflicting,
+ * conflicting and we are willing to handle, or conflicting and
+ * we are unable to handle, and return the determination in *type.
+ * Return the cache index to be looked at next, by skipping the
+ * stages we have already looked at in this invocation of this
+ * function.
+ */
 static int check_one_conflict(int i, int *type)
 {
 	const struct cache_entry *e = active_cache[i];
@@ -425,6 +440,17 @@ static int check_one_conflict(int i, int *type)
 	return i;
 }
 
+/*
+ * Scan the index and find paths that have conflicts that rerere can
+ * handle, i.e. the ones that has both stages #2 and #3.
+ *
+ * NEEDSWORK: we do not record or replay a previous "resolve by
+ * deletion" for a delete-modify conflict, as that is inherently risky
+ * without knowing what modification is being discarded.  The only
+ * safe case, i.e. both side doing the deletion and modification that
+ * are identical to the previous round, might want to be handled,
+ * though.
+ */
 static int find_conflict(struct string_list *conflict)
 {
 	int i;
@@ -441,6 +467,21 @@ static int find_conflict(struct string_list *conflict)
 	return 0;
 }
 
+/*
+ * The merge_rr list is meant to hold outstanding conflicted paths
+ * that rerere could handle.  Abuse the list by adding other types of
+ * entries to allow the caller to show "rerere remaining".
+ *
+ * - Conflicted paths that rerere does not handle are added
+ * - Conflicted paths that have been resolved are marked as such
+ *   by storing RERERE_RESOLVED to .util field (where conflict ID
+ *   is expected to be stored).
+ *
+ * Do *not* write MERGE_RR file out after calling this function.
+ *
+ * NEEDSWORK: we may want to fix the caller that implements "rerere
+ * remaining" to do this without abusing merge_rr.
+ */
 int rerere_remaining(struct string_list *merge_rr)
 {
 	int i;
-- 
2.5.0-rc0-209-g5e1f148
