From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 2/2] rerere: factor out common conflict search code
Date: Sat, 12 Feb 2011 23:09:58 -0500
Message-ID: <1297570198-21103-3-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1297134518-4387-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297570198-21103-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 13 05:10:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoTIW-0006Ot-Sr
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 05:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957Ab1BMEKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Feb 2011 23:10:43 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57724 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896Ab1BMEKj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 23:10:39 -0500
Received: by mail-vw0-f46.google.com with SMTP id 16so2440224vws.19
        for <git@vger.kernel.org>; Sat, 12 Feb 2011 20:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=zK7N6M+EWyTnQHMZSAPNxDFtAPTySV3ZByh3jKkqOy0=;
        b=wk4/6vn+8pG476Vm3ArSnnmDbs6COHTpr3yl8/5/Z6VTlYpecu8EPn1fzA8kT3TAcK
         3Sv0bg6dBtx2FZztsfjIfRv+WXMzo2Ic2hPkvPRmxRIk9pvkCjJmyqY7XT6fRJtzcpqC
         ONmbNATf4kHy7eZTsAMCBEIWMZmYOv8RocZrE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uIRSZQm1k3YrHo094v3ds8w3d9nFgOiVSUQc1mdD4oqLOgyGd2+JEVJDCPdYqSU3tX
         baeBKQL2K74XIfjXSMqNXBidDetidsf2tgUELJJeqHey6N8x0ibwjrn75Mj7EanB2vQo
         WIw9yRk4bdA/jQLSH58hBbfiT4KwiMmsNoGCs=
Received: by 10.220.201.197 with SMTP id fb5mr2985221vcb.53.1297570237927;
        Sat, 12 Feb 2011 20:10:37 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id i1sm823215vby.11.2011.02.12.20.10.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 12 Feb 2011 20:10:37 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297570198-21103-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166639>

A little bit of the code in the new rerere_remaining function is
shared with find_conflicts. Factor this out into a new function that
is called from the two mentioned functions. Apart from reducing code
duplication, it also means that the callers of find_conflict do not
need to handle the case when the util pointer is NULL, because that is
only set in rerere_remaining now.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 rerere.c |  105 +++++++++++++++++++++++++++++++------------------------------
 rerere.h |    2 +-
 2 files changed, 54 insertions(+), 53 deletions(-)

diff --git a/rerere.c b/rerere.c
index e5bccd5..d14fd9a 100644
--- a/rerere.c
+++ b/rerere.c
@@ -7,6 +7,9 @@
 #include "ll-merge.h"
 #include "attr.h"
 
+#define RESOLVED 0
+#define PUNTED 1
+#define THREE_STAGED 2
 void *RERERE_RESOLVED = &RERERE_RESOLVED;
 
 /* if rerere_enabled == -1, fall back to detection of .git/rr-cache */
@@ -347,75 +350,79 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 	return hunk_no;
 }
 
+
+static int check_one_conflict(int i, int *type)
+{
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
+		struct cache_entry *e2 = active_cache[i];
+		struct cache_entry *e3 = active_cache[i + 1];
+		if (ce_stage(e2) == 2 &&
+		    ce_stage(e3) == 3 &&
+		    ce_same_name(e, e3) &&
+		    S_ISREG(e2->ce_mode) &&
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
 static int find_conflict(struct string_list *conflict)
 {
 	int i;
 	if (read_cache() < 0)
 		return error("Could not read index");
 
-	/*
-	 * Collect paths with conflict, mark them with NULL (punted) or
-	 * !NULL (eligible) in their ->util field.
-	 */
-	for (i = 0; i < active_nr; i++) {
+	for (i = 0; i < active_nr;) {
+		int conflict_type;
 		struct cache_entry *e = active_cache[i];
-		struct string_list_item *it;
-
-		if (!ce_stage(e))
-			continue;
-		it = string_list_insert(conflict, (const char *)e->name);
-		it->util = NULL;
-		if (ce_stage(e) == 1) {
-			if (active_nr <= ++i)
-				break;
-		}
-
-		/* Only handle regular files with both stages #2 and #3 */
-		if (i + 1 < active_nr) {
-			struct cache_entry *e2 = active_cache[i];
-			struct cache_entry *e3 = active_cache[i + 1];
-			if (ce_stage(e2) == 2 &&
-			    ce_stage(e3) == 3 &&
-			    ce_same_name(e, e3) &&
-			    S_ISREG(e2->ce_mode) &&
-			    S_ISREG(e3->ce_mode))
-				it->util = (void *) 1;
-		}
-
-		/* Skip the entries with the same name */
-		while (i < active_nr && ce_same_name(e, active_cache[i]))
-			i++;
-		i--; /* compensate for the outer loop */
+		i = check_one_conflict(i, &conflict_type);
+		if (conflict_type == THREE_STAGED)
+			string_list_insert(conflict, (const char *)e->name);
 	}
 	return 0;
 }
 
-void rerere_remaining(struct string_list *merge_rr)
+int rerere_remaining(struct string_list *merge_rr)
 {
 	int i;
-	struct string_list conflict = STRING_LIST_INIT_DUP;
-
-	/* Add punted paths */
-	find_conflict(&conflict);
-	for (i = 0; i < conflict.nr; i++) {
-		if (!conflict.items[i].util)
-			string_list_insert(merge_rr, conflict.items[i].string);
-	}
+	if (read_cache() < 0)
+		return error("Could not read index");
 
-	/* Mark already resolved paths */
-	for (i = 0; i < active_nr; i++) {
+	for (i = 0; i < active_nr;) {
+		int conflict_type;
 		struct cache_entry *e = active_cache[i];
-
-		if (!ce_stage(e)) {
+		i = check_one_conflict(i, &conflict_type);
+		if (conflict_type == PUNTED)
+			string_list_insert(merge_rr, (const char *)e->name);
+		else if (conflict_type == RESOLVED) {
 			struct string_list_item *it;
 			it = string_list_lookup(merge_rr, (const char *)e->name);
 			if (it != NULL) {
 				free(it->util);
 				it->util = RERERE_RESOLVED;
 			}
-			continue;
 		}
 	}
+	return 0;
 }
 
 static int merge(const char *name, const char *path)
@@ -504,8 +511,6 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 
 	for (i = 0; i < conflict.nr; i++) {
 		const char *path = conflict.items[i].string;
-		if (!conflict.items[i].util)
-			continue; /* punted */
 		if (!string_list_has_string(rr, path)) {
 			unsigned char sha1[20];
 			char *hex;
@@ -533,8 +538,6 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 		const char *path = rr->items[i].string;
 		const char *name = (const char *)rr->items[i].util;
 
-		if (!name)
-			continue;
 		if (has_rerere_resolution(name)) {
 			if (!merge(name, path)) {
 				if (rerere_autoupdate)
@@ -664,8 +667,6 @@ int rerere_forget(const char **pathspec)
 	find_conflict(&conflict);
 	for (i = 0; i < conflict.nr; i++) {
 		struct string_list_item *it = &conflict.items[i];
-		if (!conflict.items[i].util)
-			continue; /* punted */
 		if (!match_pathspec(pathspec, it->string, strlen(it->string),
 				    0, NULL))
 			continue;
diff --git a/rerere.h b/rerere.h
index ea2618b..595f49f 100644
--- a/rerere.h
+++ b/rerere.h
@@ -18,7 +18,7 @@ extern int rerere(int);
 extern const char *rerere_path(const char *hex, const char *file);
 extern int has_rerere_resolution(const char *hex);
 extern int rerere_forget(const char **);
-extern void rerere_remaining(struct string_list *);
+extern int rerere_remaining(struct string_list *);
 
 #define OPT_RERERE_AUTOUPDATE(v) OPT_UYN(0, "rerere-autoupdate", (v), \
 	"update the index with reused conflict resolution if possible")
-- 
1.7.4.rc2.33.g8a14f
