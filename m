From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 09/13] refactor duplicated ref_newer() to remote.c
Date: Mon, 23 Feb 2009 01:28:57 -0500
Message-ID: <7f19e98ccc330d4094ffbb55ea06c35b91da9e55.1235368324.git.jaysoffian@gmail.com>
References: <cover.1235368324.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 07:31:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbULP-00072Y-OS
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 07:31:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225AbZBWG3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 01:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752175AbZBWG3b
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 01:29:31 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:12887 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbZBWG30 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 01:29:26 -0500
Received: by yx-out-2324.google.com with SMTP id 8so746768yxm.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 22:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=pNAcoSmp6PXLrhmVR5ZQXsG0Avjv2dYyZNPWZH45rsw=;
        b=EciC7Q23yYFA8W6/Zec92uetjI9ctl89NwG5TySEkeHczoQ+Z/G917QrtRqyq7RSvI
         OhqK6geGxb17rsem78z8+JjjrDK/8/Xe+XwcT98POJpQHMjfyyqJ/YmWdOEnK1rSPmWm
         kwF5huuVUMoby8PPAwbDs3n30rtRJvZUhxMKM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Q+TtvbYc/+0yjX0krDWRxZn7BA1zOMCKzUvuEyjuJISj7flTvZ1fiLutZ0yMpCsF1o
         K5HjHmuW6jo8K3/6YNlErYmqANK3jOSBb7neEaciDGqSyiwza+zwclIJbCEkPdBtu1uF
         ESGEXWy+cw9OEwqJS7UQEtfaZQYrvL1uyBqgQ=
Received: by 10.100.136.15 with SMTP id j15mr3470456and.129.1235370565864;
        Sun, 22 Feb 2009 22:29:25 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id d29sm4880067and.14.2009.02.22.22.29.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Feb 2009 22:29:25 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.223.gfed32
In-Reply-To: <cover.1235368324.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111099>

ref_newer() appears to have been copied from builtin-send-pack.c to
http-push.c via cut and paste. This patch moves the function and its
helper unmark_and_free() to remote.c.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
Hmm, I just noticed that the version in builtin-send-pack.c uses 1
whereas http-push.c uses TMP_MARK as the mark argument. I used the
version from builtin-send-pack.c. I don't know if this is signfificant.

 builtin-send-pack.c |   49 -------------------------------------------------
 http-push.c         |   49 -------------------------------------------------
 remote.c            |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 remote.h            |    1 +
 4 files changed, 50 insertions(+), 98 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 2fbfc29..186cecb 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -84,55 +84,6 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
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
index 2c010a1..5cb443f 100644
--- a/remote.c
+++ b/remote.c
@@ -5,6 +5,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "dir.h"
+#include "tag.h"
 
 static struct refspec s_tag_refspec = {
 	0,
@@ -1271,6 +1272,54 @@ int resolve_remote_symref(struct ref *ref, struct ref *list)
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
+		new = pop_most_recent_commit(&list, 1);
+		commit_list_insert(new, &used);
+		if (new == old) {
+			found = 1;
+			break;
+		}
+	}
+	unmark_and_free(list, 1);
+	unmark_and_free(used, 1);
+	return found;
+}
+
 /*
  * Return true if there is anything to report, otherwise false.
  */
diff --git a/remote.h b/remote.h
index 41b7ac2..e14d041 100644
--- a/remote.h
+++ b/remote.h
@@ -76,6 +76,7 @@ int check_ref_type(const struct ref *ref, int flags);
 void free_refs(struct ref *ref);
 
 int resolve_remote_symref(struct ref *ref, struct ref *list);
+int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1);
 
 /*
  * Removes and frees any duplicate refs in the map.
-- 
1.6.2.rc1.223.gfed32
