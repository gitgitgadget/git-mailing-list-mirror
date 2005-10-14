From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Introduce notation "ref^{type}".
Date: Thu, 13 Oct 2005 23:03:49 -0700
Message-ID: <7vd5m8ws6y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Oct 14 08:04:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQIfl-0003RF-H1
	for gcvg-git@gmane.org; Fri, 14 Oct 2005 08:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbVJNGDv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Oct 2005 02:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbVJNGDv
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Oct 2005 02:03:51 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:28861 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932183AbVJNGDv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2005 02:03:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051014060341.TQJ16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Oct 2005 02:03:41 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10100>

Existing "tagname^0" notation means "dereference tag zero or more
times until you cannot dereference it anymore, and make sure it is a
commit -- otherwise barf".  But tags do not necessarily reference
commit objects.

This commit introduces a bit more generalized notation, "ref^{type}".
Existing "ref^0" is a shorthand for "ref^{commit}".  If the type
is empty, it just dereferences tags until it hits a non-tag object.

With this, "git-rev-parse --verify 'junio-gpg-pub^{}'" shows the blob
object name -- there is no need to manually read the tag object and
find out the object name anymore.

"git-rev-parse --verify 'HEAD^{tree}'" can be used to find out the
tree object name of the HEAD commit.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * This is another preparation, which is not strictly needed but
   for notational consistency.  The next one is the gem in the
   series -- upload-pack starts sending extra information on
   refs it has using this notation, so that client side can find
   out what each tag on the remote side refers to without first
   getting them.

 sha1_name.c |   83 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 83 insertions(+), 0 deletions(-)

applies-to: 8edf2fed07b27673ab24e1bb40a0887f757d60b0
24552507a1fd71c707199bca0a225f2715a6759b
diff --git a/sha1_name.c b/sha1_name.c
index 4e9a052..75c688e 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1,5 +1,8 @@
 #include "cache.h"
+#include "tag.h"
 #include "commit.h"
+#include "tree.h"
+#include "blob.h"
 
 static int find_short_object_filename(int len, const char *name, unsigned char *sha1)
 {
@@ -274,6 +277,82 @@ static int get_nth_ancestor(const char *
 	return 0;
 }
 
+static int peel_onion(const char *name, int len, unsigned char *sha1)
+{
+	unsigned char outer[20];
+	const char *sp;
+	const char *type_string = NULL;
+	struct object *o;
+
+	/*
+	 * "ref^{type}" dereferences ref repeatedly until you cannot
+	 * dereference anymore, or you get an object of given type,
+	 * whichever comes first.  "ref^{}" means just dereference
+	 * tags until you get a non-tag.  "ref^0" is a shorthand for
+	 * "ref^{commit}".  "commit^{tree}" could be used to find the
+	 * top-level tree of the given commit.
+	 */
+	if (len < 4 || name[len-1] != '}')
+		return -1;
+
+	for (sp = name + len - 1; name <= sp; sp--) {
+		int ch = *sp;
+		if (ch == '{' && name < sp && sp[-1] == '^')
+			break;
+	}
+	if (sp <= name)
+		return -1;
+
+	sp++; /* beginning of type name, or closing brace for empty */
+	if (!strncmp(commit_type, sp, 6) && sp[6] == '}')
+		type_string = commit_type;
+	else if (!strncmp(tree_type, sp, 4) && sp[4] == '}')
+		type_string = tree_type;
+	else if (!strncmp(blob_type, sp, 4) && sp[4] == '}')
+		type_string = blob_type;
+	else if (sp[0] == '}')
+		type_string = NULL;
+	else
+		return -1;
+
+	if (get_sha1_1(name, sp - name - 2, outer))
+		return -1;
+
+	o = parse_object(outer);
+	if (!o)
+		return -1;
+	if (!type_string) {
+		o = deref_tag(o);
+		memcpy(sha1, o->sha1, 20);
+	}
+	else {
+		/* At this point, the syntax look correct, so
+		 * if we do not get the needed object, we should
+		 * barf.
+		 */
+
+		while (1) {
+			if (!o)
+				return -1;
+			if (o->type == type_string) {
+				memcpy(sha1, o->sha1, 20);
+				return 0;
+			}
+			if (o->type == tag_type)
+				o = ((struct tag*) o)->tagged;
+			else if (o->type == commit_type)
+				o = &(((struct commit *) o)->tree->object);
+			else
+				return error("%.*s: expected %s type, but the object dereferences to %s type",
+					     len, name, type_string,
+					     o->type);
+			if (!o->parsed)
+				parse_object(o->sha1);
+		}
+	}
+	return 0;
+}
+
 static int get_sha1_1(const char *name, int len, unsigned char *sha1)
 {
 	int parent, ret;
@@ -315,6 +394,10 @@ static int get_sha1_1(const char *name, 
 		return get_nth_ancestor(name, len1, sha1, parent);
 	}
 
+	ret = peel_onion(name, len, sha1);
+	if (!ret)
+		return 0;
+
 	ret = get_sha1_basic(name, len, sha1);
 	if (!ret)
 		return 0;
---
@@GIT_VERSION@@
