From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] object name: introduce ':::<oneline prefix>' notation
Date: Fri, 23 Feb 2007 19:32:08 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702231930290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Feb 23 19:33:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKfEB-0006fF-QO
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 19:33:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933167AbXBWScL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 13:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933173AbXBWScL
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 13:32:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:60319 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933167AbXBWScK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 13:32:10 -0500
Received: (qmail invoked by alias); 23 Feb 2007 18:32:09 -0000
X-Provags-ID: V01U2FsdGVkX19qglxF3G9qcmhmzEnsINsUfK5BpxgZQvzxgqOSUm
	pXCQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40460>


To name a commit, you can now say

	git rev-parse ':::Initial revision of "git"'

and it will return the hash of the first youngest commit whose
commit message (the oneline) begins with the given prefix.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I often do "git log --grep=bla" to find a certain commit, then 
	grab my mouse, mark the commit hash, and paste it into the command 
	line I really want to run on that commit.

	This allows me to throw away my mouse.

 sha1_name.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 2793de9..004c4e3 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -578,6 +578,54 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1)
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
+ * This interprets names like ':::Initial revision of "git"' by searching
+ * through history and returning the first commit whose message starts
+ * with the given string.
+ */
+
+#define ONELINE_SEEN (1u<<20)
+int get_sha1_oneline(const char *prefix, unsigned char *sha1)
+{
+	struct commit_list *list = NULL, *backup = NULL, *l;
+	struct commit *commit;
+
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
@@ -601,6 +649,8 @@ int get_sha1(const char *name, unsigned char *sha1)
 		int stage = 0;
 		struct cache_entry *ce = NULL;
 		int pos;
+		if (namelen > 3 && !prefixcmp(name + 1, "::"))
+			return get_sha1_oneline(name + 3, sha1);
 		if (namelen < 3 ||
 		    name[2] != ':' ||
 		    name[1] < '0' || '3' < name[1])
-- 
1.5.0.1.2246.geaab8-dirty
