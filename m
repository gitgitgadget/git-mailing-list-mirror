From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v3 1/2] rerere "remaining"
Date: Wed, 16 Feb 2011 05:47:44 -0500
Message-ID: <1297853265-18993-2-git-send-email-martin.von.zweigbergk@gmail.com>
References: <7vbp2dnjkt.fsf@alter.siamese.dyndns.org>
 <1297853265-18993-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 11:48:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppew8-0001q4-1j
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 11:48:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758879Ab1BPKsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 05:48:39 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42445 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755067Ab1BPKsh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 05:48:37 -0500
Received: by qwa26 with SMTP id 26so1127592qwa.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 02:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=JLIltN0yVJkaGrWB2TJyfhCgDMKQShZGfqJaapGoz+o=;
        b=wO7V9E65xf7OWRpyAeRK4r+Vl5oo/uFgAUT3sUgP6URGY1iPZA8Xsk95EWtKeQxmY4
         bYJ4TTumec7m1+qAO+fbeWJB1aHupYSFPoFeGMXWOAahH+1WDiubQaYPOwkeGpY/BmGo
         sRiAPsRgxs5E3cbFYQAa/U38DEfg/lp/+L55Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Vaxbt+tlohyYhOzGic7kwdmIaXRWGf5/zCrVResmc19YCXlejT/Z1UokcMj8D7qyU9
         uAG3gArZnUcGcoOqha0SQGiRxGWveqjGwyIU0fhe6faQBA5XWUyltshwKkI3+Xe60/WL
         R1xXi81yIUB/LuYlJBsqTcBqLLI5bPQ+6jrKg=
Received: by 10.224.89.72 with SMTP id d8mr521777qam.225.1297853317123;
        Wed, 16 Feb 2011 02:48:37 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id c8sm1339vcc.33.2011.02.16.02.48.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Feb 2011 02:48:36 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297853265-18993-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166955>

From: Junio C Hamano <gitster@pobox.com>

After "rerere" resolves conflicts by reusing old resolution, there would
be three kinds of paths with conflict in the index:

 * paths that have been resolved in the working tree by rerere;
 * paths that need further work whose resolution could be recorded;
 * paths that need resolving that rerere won't help.

When the user wants a list of paths that need hand-resolving, output from
"rerere status" does not help, as it shows only the second category, but
the paths in the third category still needs work (rerere only makes sense
for regular files that have both our side and their side, and does not
help other kinds of conflicts, e.g. "we modified, they deleted").

The new subcommand "rerere remaining" can be used to show both. As
opposed to "rerere status", this subcommand also skips printing paths
that have been added to the index, since these paths are already
resolved and are no longer "remaining".

Initial patch provided by Junio. Refactored and modified to skip
resolved paths by Martin. Commit message mostly by Junio.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---

Junio, I wasn't sure how to handle the sign-off etc, so feel free to
modify those as appropriate.

 builtin/rerere.c |   17 +++++++++--
 rerere.c         |   79 +++++++++++++++++++++++++++++++++++++++++++++++-------
 rerere.h         |    8 +++++
 3 files changed, 91 insertions(+), 13 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 642bf35..7b9fe18 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -8,7 +8,7 @@
 #include "xdiff-interface.h"
 
 static const char * const rerere_usage[] = {
-	"git rerere [clear | status | diff | gc]",
+	"git rerere [clear | status | remaining | diff | gc]",
 	NULL,
 };
 
@@ -154,9 +154,20 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 	} else if (!strcmp(argv[0], "gc"))
 		garbage_collect(&merge_rr);
 	else if (!strcmp(argv[0], "status"))
-		for (i = 0; i < merge_rr.nr; i++)
+		for (i = 0; i < merge_rr.nr; i++) {
 			printf("%s\n", merge_rr.items[i].string);
-	else if (!strcmp(argv[0], "diff"))
+		}
+	else if (!strcmp(argv[0], "remaining")) {
+		rerere_remaining(&merge_rr);
+		for (i = 0; i < merge_rr.nr; i++) {
+			if (merge_rr.items[i].util != RERERE_RESOLVED)
+				printf("%s\n", merge_rr.items[i].string);
+			else
+				/* prepare for later call to
+				 * string_list_clear() */
+				merge_rr.items[i].util = NULL;
+		}
+	} else if (!strcmp(argv[0], "diff"))
 		for (i = 0; i < merge_rr.nr; i++) {
 			const char *path = merge_rr.items[i].string;
 			const char *name = (const char *)merge_rr.items[i].util;
diff --git a/rerere.c b/rerere.c
index d260843..1240d06 100644
--- a/rerere.c
+++ b/rerere.c
@@ -7,6 +7,11 @@
 #include "ll-merge.h"
 #include "attr.h"
 
+#define RESOLVED 0
+#define PUNTED 1
+#define THREE_STAGED 2
+void *RERERE_RESOLVED = &RERERE_RESOLVED;
+
 /* if rerere_enabled == -1, fall back to detection of .git/rr-cache */
 static int rerere_enabled = -1;
 
@@ -345,21 +350,75 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 	return hunk_no;
 }
 
-static int find_conflict(struct string_list *conflict)
+static int check_one_conflict(int i, int *type)
 {
-	int i;
-	if (read_cache() < 0)
-		return error("Could not read index");
-	for (i = 0; i+1 < active_nr; i++) {
+	struct cache_entry *e = active_cache[i];
+	struct string_list_item *it;
+
+	if (!ce_stage(e)) {
+		*type = RESOLVED;
+		return i + 1;
+	}
+
+	*type = PUNTED;
+	if (ce_stage(e) == 1) {
+		if (active_nr <= ++i)
+			return i + 1;
+	}
+
+	/* Only handle regular files with both stages #2 and #3 */
+	if (i + 1 < active_nr) {
 		struct cache_entry *e2 = active_cache[i];
-		struct cache_entry *e3 = active_cache[i+1];
+		struct cache_entry *e3 = active_cache[i + 1];
 		if (ce_stage(e2) == 2 &&
 		    ce_stage(e3) == 3 &&
-		    ce_same_name(e2, e3) &&
+		    ce_same_name(e, e3) &&
 		    S_ISREG(e2->ce_mode) &&
-		    S_ISREG(e3->ce_mode)) {
-			string_list_insert(conflict, (const char *)e2->name);
-			i++; /* skip over both #2 and #3 */
+		    S_ISREG(e3->ce_mode))
+			*type = THREE_STAGED;
+	}
+
+	/* Skip the entries with the same name */
+	while (i < active_nr && ce_same_name(e, active_cache[i]))
+		i++;
+	return i;
+}
+
+static int find_conflict(struct string_list *conflict)
+{
+	int i;
+	if (read_cache() < 0)
+		return error("Could not read index");
+
+	for (i = 0; i < active_nr;) {
+		int conflict_type;
+		struct cache_entry *e = active_cache[i];
+		i = check_one_conflict(i, &conflict_type);
+		if (conflict_type == THREE_STAGED)
+			string_list_insert(conflict, (const char *)e->name);
+	}
+	return 0;
+}
+
+int rerere_remaining(struct string_list *merge_rr)
+{
+	int i;
+	if (read_cache() < 0)
+		return error("Could not read index");
+
+	for (i = 0; i < active_nr;) {
+		int conflict_type;
+		struct cache_entry *e = active_cache[i];
+		i = check_one_conflict(i, &conflict_type);
+		if (conflict_type == PUNTED)
+			string_list_insert(merge_rr, (const char *)e->name);
+		else if (conflict_type == RESOLVED) {
+			struct string_list_item *it;
+			it = string_list_lookup(merge_rr, (const char *)e->name);
+			if (it != NULL) {
+				free(it->util);
+				it->util = RERERE_RESOLVED;
+			}
 		}
 	}
 	return 0;
diff --git a/rerere.h b/rerere.h
index eaa9004..595f49f 100644
--- a/rerere.h
+++ b/rerere.h
@@ -6,11 +6,19 @@
 #define RERERE_AUTOUPDATE   01
 #define RERERE_NOAUTOUPDATE 02
 
+/*
+ * Marks paths that have been hand-resolved and added to the
+ * index. Set in the util field of such paths after calling
+ * rerere_remaining.
+ */
+extern void *RERERE_RESOLVED;
+
 extern int setup_rerere(struct string_list *, int);
 extern int rerere(int);
 extern const char *rerere_path(const char *hex, const char *file);
 extern int has_rerere_resolution(const char *hex);
 extern int rerere_forget(const char **);
+extern int rerere_remaining(struct string_list *);
 
 #define OPT_RERERE_AUTOUPDATE(v) OPT_UYN(0, "rerere-autoupdate", (v), \
 	"update the index with reused conflict resolution if possible")
-- 
1.7.4.rc2.33.g8a14f
