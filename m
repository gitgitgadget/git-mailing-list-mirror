From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 09/18] rerere: explain MERGE_RR management helpers
Date: Fri, 17 Jul 2015 15:24:31 -0700
Message-ID: <1437171880-21590-10-git-send-email-gitster@pobox.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
 <1437171880-21590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 00:25:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGE3z-00049A-UA
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 00:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756170AbbGQWY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 18:24:58 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33635 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162AbbGQWY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 18:24:57 -0400
Received: by padck2 with SMTP id ck2so67051570pad.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 15:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=i4ZdbYInLDtl8cGreb+newTgz0Kuy/+A7ErPP14jRzE=;
        b=xquZmQcFmUDbopG2rFvjLz6OWLC3YpCA3hsT5mcWYXWwCeRt7fytn0XlWLgwozIj+4
         c9IsVsGpJp3DgJqNdg9qgN6b5JugDa+DLn3W4P5pNpeuS9pBSJ/ck5nWUQTpKjzGo/Hg
         NputqzApLOqTjhfBZrgYEb5SO1Zi7wCgPJ2HGDIAQ/WAbKXHnw7En/VzcThNKZPnZRtt
         65sfHtN7OXcr1bQaAkit6QGGIVLITjmZblrDCdEFDRW1JPWVWrMmXgrSMjAhv2F5igS+
         fqegUI7Q48crFO+viPHizb/S7A3yy3Wd0ViO8sepfXmkXGgmqfl6igwtwrvSI4eOAe/i
         MQeA==
X-Received: by 10.70.128.34 with SMTP id nl2mr33880516pdb.43.1437171896899;
        Fri, 17 Jul 2015 15:24:56 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id ob15sm12346009pdb.40.2015.07.17.15.24.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 15:24:55 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc2-340-g0cccc16
In-Reply-To: <1437171880-21590-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274113>

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
2.5.0-rc2-340-g0cccc16
