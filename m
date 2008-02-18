From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 1/3] deref_tag: handle return value NULL
Date: Mon, 18 Feb 2008 08:31:54 +0100
Message-ID: <12033199162949-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 08:32:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR0UN-0007Ep-5n
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 08:32:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753707AbYBRHcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 02:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753639AbYBRHb7
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 02:31:59 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:58471 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325AbYBRHb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 02:31:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 8BE30680BF87;
	Mon, 18 Feb 2008 08:31:56 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TCr7sun8FOxp; Mon, 18 Feb 2008 08:31:56 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 6CAA76800674; Mon, 18 Feb 2008 08:31:56 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74236>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 builtin-show-ref.c |    3 +++
 merge-recursive.c  |    2 ++
 sha1_name.c        |    5 ++++-
 shallow.c          |    2 +-
 upload-pack.c      |    3 ++-
 5 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index 65051d1..a323633 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -86,6 +86,9 @@ match:
 			    sha1_to_hex(sha1));
 		if (obj->type == OBJ_TAG) {
 			obj = deref_tag(obj, refname, 0);
+			if (!obj)
+				die("git-show-ref: bad tag at ref %s (%s)", refname,
+				    sha1_to_hex(sha1));
 			hex = find_unique_abbrev(obj->sha1, abbrev);
 			printf("%s %s^{}\n", hex, refname);
 		}
diff --git a/merge-recursive.c b/merge-recursive.c
index dd52342..55ef76f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1673,6 +1673,8 @@ static struct commit *get_ref(const char *ref)
 	if (get_sha1(ref, sha1))
 		die("Could not resolve ref '%s'", ref);
 	object = deref_tag(parse_object(sha1), ref, strlen(ref));
+	if (!object)
+		return NULL;
 	if (object->type == OBJ_TREE)
 		return make_virtual_commit((struct tree*)object,
 			better_branch_name(ref));
diff --git a/sha1_name.c b/sha1_name.c
index be8489e..ed3c867 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -578,8 +578,11 @@ static int handle_one_ref(const char *path,
 	struct object *object = parse_object(sha1);
 	if (!object)
 		return 0;
-	if (object->type == OBJ_TAG)
+	if (object->type == OBJ_TAG) {
 		object = deref_tag(object, path, strlen(path));
+		if (!object)
+			return 0;
+	}
 	if (object->type != OBJ_COMMIT)
 		return 0;
 	insert_by_date((struct commit *)object, list);
diff --git a/shallow.c b/shallow.c
index dbd9f5a..212e62b 100644
--- a/shallow.c
+++ b/shallow.c
@@ -56,7 +56,7 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 			if (i < heads->nr) {
 				commit = (struct commit *)
 					deref_tag(heads->objects[i++].item, NULL, 0);
-				if (commit->object.type != OBJ_COMMIT) {
+				if (!commit || commit->object.type != OBJ_COMMIT) {
 					commit = NULL;
 					continue;
 				}
diff --git a/upload-pack.c b/upload-pack.c
index 7e04311..2307f58 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -575,7 +575,8 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	}
 	if (o->type == OBJ_TAG) {
 		o = deref_tag(o, refname, 0);
-		packet_write(1, "%s %s^{}\n", sha1_to_hex(o->sha1), refname);
+		if (o)
+			packet_write(1, "%s %s^{}\n", sha1_to_hex(o->sha1), refname);
 	}
 	return 0;
 }
-- 
1.5.4.1.gaf0ae
