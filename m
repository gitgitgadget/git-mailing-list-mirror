From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 09/23] refactor duplicated ref_newer() to remote.c
Date: Tue, 24 Feb 2009 04:50:57 -0500
Message-ID: <4d8bdf7e8275435b717f1eb13b5ba18dd37fe194.1235467368.git.jaysoffian@gmail.com>
References: <cover.1235467368.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 10:54:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbtzw-0002Ej-DG
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640AbZBXJvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 04:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754631AbZBXJvn
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:51:43 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:14095 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440AbZBXJvi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 04:51:38 -0500
Received: by an-out-0708.google.com with SMTP id c2so1048504anc.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 01:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=sxBollIYhphQ45JVrpG9N2lsCmFBpvQaQtRGP+DzT+s=;
        b=b+SQCD+3gCogmWhLhW3S1HJHoHFsOSenTsk/2jpQXOE3F6dPxUQOHCUKChLqQWME/1
         kChNzP2Hb3JPGi6TVRHfbtsW+Fdaf1TH1pcloEPJTSM6DFD19glk3t9H5sMSe9fOxQjf
         PlQiK/GjCovRylz7chehFZkpq9wiW6uro7YhI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=fs9FDD3O/ewWryYMdWdRll++IR1X3LZ3Y7FlOmO8TuT9YS6RMNUwHHYnmuju/uuoXY
         EtGOnt9urmsYF5khTBJuwTndQEdceK21yBBbnEmzG/S4WLUPZP4m+CHjG5ITmTBJa5Sp
         PPjpxpLcOAS5hf+abgzExYr4Mk/3nFENLpJWo=
Received: by 10.100.14.2 with SMTP id 2mr2004266ann.27.1235469097092;
        Tue, 24 Feb 2009 01:51:37 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id c9sm6246959ana.13.2009.02.24.01.51.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 01:51:36 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235467368.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111257>

ref_newer() appears to have been copied from builtin-send-pack.c to
http-push.c via cut and paste. This patch moves the function and its
helper unmark_and_free() to remote.c. There was a slight difference
between the two implementations, one used TMP_MARK for the mark, the
other used 1. Per Jeff King, I went with TMP_MARK as more correct.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-send-pack.c |   50 --------------------------------------------------
 http-push.c         |   49 -------------------------------------------------
 remote.c            |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 remote.h            |    1 +
 4 files changed, 50 insertions(+), 99 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 2fbfc29..9072905 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -1,6 +1,5 @@
 #include "cache.h"
 #include "commit.h"
-#include "tag.h"
 #include "refs.h"
 #include "pkt-line.h"
 #include "run-command.h"
@@ -84,55 +83,6 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 	return 0;
 }
 
-static void unmark_and_free(struct commit_list *list, unsigned int mark)
-{
-	while (list) {
-		struct commit_list *temp = list;
-		temp->item->object.flags &= ~mark;
-		list = temp->next;
-		free(temp);
-	}
-}
-
-static int ref_newer(const unsigned char *new_sha1,
-		     const unsigned char *old_sha1)
-{
-	struct object *o;
-	struct commit *old, *new;
-	struct commit_list *list, *used;
-	int found = 0;
-
-	/* Both new and old must be commit-ish and new is descendant of
-	 * old.  Otherwise we require --force.
-	 */
-	o = deref_tag(parse_object(old_sha1), NULL, 0);
-	if (!o || o->type != OBJ_COMMIT)
-		return 0;
-	old = (struct commit *) o;
-
-	o = deref_tag(parse_object(new_sha1), NULL, 0);
-	if (!o || o->type != OBJ_COMMIT)
-		return 0;
-	new = (struct commit *) o;
-
-	if (parse_commit(new) < 0)
-		return 0;
-
-	used = list = NULL;
-	commit_list_insert(new, &list);
-	while (list) {
-		new = pop_most_recent_commit(&list, 1);
-		commit_list_insert(new, &used);
-		if (new == old) {
-			found = 1;
-			break;
-		}
-	}
-	unmark_and_free(list, 1);
-	unmark_and_free(used, 1);
-	return found;
-}
-
 static struct ref *remote_refs, **remote_tail;
 
 static int receive_status(int in, struct ref *refs)
diff --git a/http-push.c b/http-push.c
index cfeed81..392533a 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1843,55 +1843,6 @@ static int is_zero_sha1(const unsigned char *sha1)
 	return 1;
 }
 
-static void unmark_and_free(struct commit_list *list, unsigned int mark)
-{
-	while (list) {
-		struct commit_list *temp = list;
-		temp->item->object.flags &= ~mark;
-		list = temp->next;
-		free(temp);
-	}
-}
-
-static int ref_newer(const unsigned char *new_sha1,
-		     const unsigned char *old_sha1)
-{
-	struct object *o;
-	struct commit *old, *new;
-	struct commit_list *list, *used;
-	int found = 0;
-
-	/* Both new and old must be commit-ish and new is descendant of
-	 * old.  Otherwise we require --force.
-	 */
-	o = deref_tag(parse_object(old_sha1), NULL, 0);
-	if (!o || o->type != OBJ_COMMIT)
-		return 0;
-	old = (struct commit *) o;
-
-	o = deref_tag(parse_object(new_sha1), NULL, 0);
-	if (!o || o->type != OBJ_COMMIT)
-		return 0;
-	new = (struct commit *) o;
-
-	if (parse_commit(new) < 0)
-		return 0;
-
-	used = list = NULL;
-	commit_list_insert(new, &list);
-	while (list) {
-		new = pop_most_recent_commit(&list, TMP_MARK);
-		commit_list_insert(new, &used);
-		if (new == old) {
-			found = 1;
-			break;
-		}
-	}
-	unmark_and_free(list, TMP_MARK);
-	unmark_and_free(used, TMP_MARK);
-	return found;
-}
-
 static void add_remote_info_ref(struct remote_ls_ctx *ls)
 {
 	struct strbuf *buf = (struct strbuf *)ls->userData;
diff --git a/remote.c b/remote.c
index 8fd8d23..f07ecf4 100644
--- a/remote.c
+++ b/remote.c
@@ -5,6 +5,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "dir.h"
+#include "tag.h"
 
 static struct refspec s_tag_refspec = {
 	0,
@@ -1274,6 +1275,54 @@ int resolve_remote_symref(struct ref *ref, struct ref *list)
 	return 1;
 }
 
+static void unmark_and_free(struct commit_list *list, unsigned int mark)
+{
+	while (list) {
+		struct commit_list *temp = list;
+		temp->item->object.flags &= ~mark;
+		list = temp->next;
+		free(temp);
+	}
+}
+
+int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1)
+{
+	struct object *o;
+	struct commit *old, *new;
+	struct commit_list *list, *used;
+	int found = 0;
+
+	/* Both new and old must be commit-ish and new is descendant of
+	 * old.  Otherwise we require --force.
+	 */
+	o = deref_tag(parse_object(old_sha1), NULL, 0);
+	if (!o || o->type != OBJ_COMMIT)
+		return 0;
+	old = (struct commit *) o;
+
+	o = deref_tag(parse_object(new_sha1), NULL, 0);
+	if (!o || o->type != OBJ_COMMIT)
+		return 0;
+	new = (struct commit *) o;
+
+	if (parse_commit(new) < 0)
+		return 0;
+
+	used = list = NULL;
+	commit_list_insert(new, &list);
+	while (list) {
+		new = pop_most_recent_commit(&list, TMP_MARK);
+		commit_list_insert(new, &used);
+		if (new == old) {
+			found = 1;
+			break;
+		}
+	}
+	unmark_and_free(list, TMP_MARK);
+	unmark_and_free(used, TMP_MARK);
+	return found;
+}
+
 /*
  * Return true if there is anything to report, otherwise false.
  */
diff --git a/remote.h b/remote.h
index 6ff0cda..1f78a0a 100644
--- a/remote.h
+++ b/remote.h
@@ -74,6 +74,7 @@ int check_ref_type(const struct ref *ref, int flags);
 void free_refs(struct ref *ref);
 
 int resolve_remote_symref(struct ref *ref, struct ref *list);
+int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1);
 
 /*
  * Removes and frees any duplicate refs in the map.
-- 
1.6.2.rc1.291.g83eb
