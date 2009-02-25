From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 05/21] move duplicated ref_newer() to remote.c
Date: Wed, 25 Feb 2009 03:32:12 -0500
Message-ID: <dbbbee22dfc7337f5b0f1be94434035d5ec22467.1235546708.git.jaysoffian@gmail.com>
References: <cover.1235546707.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 09:35:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcFF2-0000Xo-Q1
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 09:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759379AbZBYIcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 03:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759317AbZBYIcs
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 03:32:48 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:52135 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759184AbZBYIcp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 03:32:45 -0500
Received: by an-out-0708.google.com with SMTP id c2so1348060anc.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 00:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Y3aAkLc+cZ+ZOjp/frQNbQL0pHb8Y0AnROD5m/hB8Tk=;
        b=ZYPrwI04oVLjzg8vhgYl+YeCJNwnX2FgAxObthAUhD2oc5TM5kFPZu9a0RfNzKIaCu
         XcOsknapy1POemAo8ZTE/kZ+QKrHn1Y8a1z9x/zkFaYrf0dIk0aPmqpC98qrAQrXveuI
         Fp7BuUs0wiORpM3TZWXlhFzM3EyNppf6tLlBw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=NAMpmrEImwrRM9rK0sNWRVwb63UXmgdXy6H4IiAqR7/uk7J89Ae5By8hCm4JYZGTQW
         bsnW/st56IuZXqPEf8G8r6pfEPaogn4Cr9OH/KYmmeuiX5oqkso3Wzra2maemou/Z23G
         kgyJOSZivilt7wUA+PpNfx/ZYEJcNvwjmWXy8=
Received: by 10.100.131.16 with SMTP id e16mr806965and.67.1235550762036;
        Wed, 25 Feb 2009 00:32:42 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id b37sm7713144ana.17.2009.02.25.00.32.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Feb 2009 00:32:40 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235546707.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111404>

ref_newer() appears to have been copied from builtin-send-pack.c to
http-push.c via cut and paste. This patch moves the function and its
helper unmark_and_free() to remote.c. There was a slight difference
between the two implementations, one used TMP_MARK for the mark, the
other used 1. Per Jeff King, I went with TMP_MARK as more correct.

This is in preparation for being able to call it from builtin-remote.c

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
index 01aae77..c8b7ea4 100644
--- a/remote.c
+++ b/remote.c
@@ -5,6 +5,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "dir.h"
+#include "tag.h"
 
 static struct refspec s_tag_refspec = {
 	0,
@@ -1269,6 +1270,54 @@ int resolve_remote_symref(struct ref *ref, struct ref *list)
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
index 56ca8b1..c0666a0 100644
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
