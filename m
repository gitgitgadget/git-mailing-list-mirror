From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] object name: introduce ':/<oneline prefix>' notation
Date: Sat, 24 Feb 2007 03:08:20 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702240307460.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sat Feb 24 03:23:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKmZp-0005sg-Ht
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 03:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933323AbXBXCXs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 21:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933347AbXBXCXs
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 21:23:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:47000 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933323AbXBXCXr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 21:23:47 -0500
Received: (qmail invoked by alias); 24 Feb 2007 02:08:21 -0000
X-Provags-ID: V01U2FsdGVkX1932uM5uFh39p4OlWyMuyhwYdWJClKK82EW6z7UpG
	GMhw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40498>


To name a commit, you can now say

	$ git rev-parse ':/Initial revision of "git"'

and it will return the hash of the youngest commit whose
commit message (the oneline) begins with the given prefix.

For future extension, a leading exclamation mark is treated
specially: if you want to match a commit message starting with
a '!', just repeat the exclamation mark. So, to match a commit
which starts with '!Hello World', use

	$ git show ':/!!Hello World'

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This obviously replaces the earlier patch.

 Documentation/git-rev-parse.txt |    7 +++++
 sha1_name.c                     |   58 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 081b9d6..41b8a51 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -193,6 +193,13 @@ blobs contained in a commit.
   and dereference the tag recursively until a non-tag object is
   found.
 
+* A colon, followed by a slash, followed by a text: this names
+  a commit whose commit message starts with the specified text.
+  This name returns the youngest matching commit which is
+  reachable from any ref.  If the commit message starts with a
+  '!', you have to repeat that;  the special sequence ':/!',
+  followed by something else than '!' is reserved for now.
+
 * A suffix ':' followed by a path; this names the blob or tree
   at the given path in the tree-ish object named by the part
   before the colon.
diff --git a/sha1_name.c b/sha1_name.c
index 2793de9..6ad2662 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -578,6 +578,62 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1)
 	return get_short_sha1(name, len, sha1, 0);
 }
 
+static int handle_one_ref(const char *path,
+		const unsigned char *sha1, int flag, void *cb_data)
+{
+	struct commit_list **list = cb_data;
+	struct object *object = parse_object(sha1);
+	if (!object)
+		return 0;
+	if (object->type == OBJ_TAG)
+		object = deref_tag(object, path, strlen(path));
+	if (object->type != OBJ_COMMIT)
+		return 0;
+	insert_by_date((struct commit *)object, list);
+	return 0;
+}
+
+/*
+ * This interprets names like ':/Initial revision of "git"' by searching
+ * through history and returning the first commit whose message starts
+ * with the given string.
+ *
+ * For future extension, ':/!' is reserved. If you want to match a message
+ * beginning with a '!', you have to repeat the exclamation mark.
+ */
+
+#define ONELINE_SEEN (1u<<20)
+int get_sha1_oneline(const char *prefix, unsigned char *sha1)
+{
+	struct commit_list *list = NULL, *backup = NULL, *l;
+	struct commit *commit;
+
+	if (prefix[0] == '!') {
+		if (prefix[1] != '!')
+			die ("Invalid search pattern: %s", prefix);
+		prefix++;
+	}
+	if (!save_commit_buffer)
+		return error("Could not expand oneline-name.");
+	for_each_ref(handle_one_ref, &list);
+	for (l = list; l; l = l->next)
+		commit_list_insert(l->item, &backup);
+	while ((commit = pop_most_recent_commit(&list, ONELINE_SEEN))) {
+		char *p;
+		parse_object(commit->object.sha1);
+		if (!commit->buffer || !(p = strstr(commit->buffer, "\n\n")))
+			continue;
+		if (!prefixcmp(p + 2, prefix)) {
+			hashcpy(sha1, commit->object.sha1);
+			break;
+		}
+	}
+	free_commit_list(list);
+	for (l = backup; l; l = l->next)
+		clear_commit_marks(l->item, ONELINE_SEEN);
+	return commit == NULL;
+}
+
 /*
  * This is like "get_sha1_basic()", except it allows "sha1 expressions",
  * notably "xyz^" for "parent of xyz"
@@ -601,6 +657,8 @@ int get_sha1(const char *name, unsigned char *sha1)
 		int stage = 0;
 		struct cache_entry *ce = NULL;
 		int pos;
+		if (namelen > 2 && name[1] == '/')
+			return get_sha1_oneline(name + 2, sha1);
 		if (namelen < 3 ||
 		    name[2] != ':' ||
 		    name[1] < '0' || '3' < name[1])
-- 
1.5.0.1.2250.g8afc1-dirty
