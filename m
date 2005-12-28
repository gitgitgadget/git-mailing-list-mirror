From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 4/6] git-describe: still prefer annotated tag under --all and --tags
Date: Tue, 27 Dec 2005 16:42:39 -0800
Message-ID: <7vk6dq2gsg.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0512241339120.14098@g5.osdl.org>
	<Pine.LNX.4.64.0512241409300.14098@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 28 01:43:30 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ErPPa-0003w8-PW
	for gcvg-git@gmane.org; Wed, 28 Dec 2005 01:43:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbVL1Amn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Dec 2005 19:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbVL1Amm
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Dec 2005 19:42:42 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:17608 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932428AbVL1Amk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2005 19:42:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051228004104.GRIW17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Dec 2005 19:41:04 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14088>

Even though --all and --tags can be used to include non
annotated tags in the reference point candidates, prefer to use
annotated tags if there are more than one refs that name the
same commit.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 describe.c |   34 +++++++++++++++++++++++++---------
 1 files changed, 25 insertions(+), 9 deletions(-)

43214fab3416d54dcf41a8f89c59484e9c930b23
diff --git a/describe.c b/describe.c
index ee38f5f..84d96b5 100644
--- a/describe.c
+++ b/describe.c
@@ -17,6 +17,7 @@ static int abbrev = DEFAULT_ABBREV;
 static int names = 0, allocs = 0;
 static struct commit_name {
 	const struct commit *commit;
+	int prio; /* annotated tag = 2, tag = 1, head = 0 */
 	char path[];
 } **name_array = NULL;
 
@@ -33,13 +34,16 @@ static struct commit_name *match(struct 
 	return NULL;
 }
 
-static void add_to_known_names(const char *path, const struct commit *commit)
+static void add_to_known_names(const char *path,
+			       const struct commit *commit,
+			       int prio)
 {
 	int idx;
 	int len = strlen(path)+1;
 	struct commit_name *name = xmalloc(sizeof(struct commit_name) + len);
 
 	name->commit = commit;
+	name->prio = prio; 
 	memcpy(name->path, path, len);
 	idx = names;
 	if (idx >= allocs) {
@@ -53,23 +57,32 @@ static void add_to_known_names(const cha
 static int get_name(const char *path, const unsigned char *sha1)
 {
 	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
+	struct object *object;
+	int prio;
+
 	if (!commit)
 		return 0;
+	object = parse_object(sha1);
 	/* If --all, then any refs are used.
 	 * If --tags, then any tags are used.
 	 * Otherwise only annotated tags are used.
 	 */
+	if (!strncmp(path, "refs/tags/", 10)) {
+		if (object->type == tag_type)
+			prio = 2;
+		else
+			prio = 1;
+	}
+	else
+		prio = 0;
+
 	if (!all) {
-		if (strncmp(path, "refs/tags/", 10))
+		if (!prio)
+			return 0;
+		if (!tags && prio < 2)
 			return 0;
-		if (!tags) {
-			struct object *object;
-			object = parse_object(sha1);
-			if (object->type != tag_type)
-				return 0;
-		}
 	}
-	add_to_known_names(all ? path : path + 10, commit);
+	add_to_known_names(all ? path + 5 : path + 10, commit, prio);
 	return 0;
 }
 
@@ -79,6 +92,9 @@ static int compare_names(const void *_a,
 	struct commit_name *b = *(struct commit_name **)_b;
 	unsigned long a_date = a->commit->date;
 	unsigned long b_date = b->commit->date;
+
+	if (a->prio != b->prio)
+		return b->prio - a->prio;
 	return (a_date > b_date) ? -1 : (a_date == b_date) ? 0 : 1;
 }
 
-- 
1.0.5-geb9d
