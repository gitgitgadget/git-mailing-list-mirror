From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add a new extended SHA1 syntax <name>:<num>
Date: Sun, 21 Aug 2005 02:43:54 -0700
Message-ID: <7vll2viq05.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Aug 21 11:44:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6mMx-0004sk-AD
	for gcvg-git@gmane.org; Sun, 21 Aug 2005 11:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbVHUJn4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Aug 2005 05:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbVHUJn4
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Aug 2005 05:43:56 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:686 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750907AbVHUJn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2005 05:43:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050821094355.DJQQ19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 21 Aug 2005 05:43:55 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The new notation is a short-hand for <name> followed by <num>
caret ('^') characters.  E.g. "master:4" is the fourth
generation ancestor of the current "master" branch head,
following the first parents; same as "master^^^^" but a bit more
readable.

This will be used in the updated "git show-branch" command.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 sha1_name.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

3a371474bc20e192b0e9d3b48fb7c84ca107b818
diff --git a/sha1_name.c b/sha1_name.c
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -191,9 +191,29 @@ static int get_parent(const char *name, 
 	return -1;
 }
 
+static int get_nth_ancestor(const char *name, int len,
+			    unsigned char *result, int generation)
+{
+	unsigned char sha1[20];
+	int ret = get_sha1_1(name, len, sha1);
+	if (ret)
+		return ret;
+
+	while (generation--) {
+		struct commit *commit = lookup_commit_reference(sha1);
+
+		if (!commit || parse_commit(commit) || !commit->parents)
+			return -1;
+		memcpy(sha1, commit->parents->item->object.sha1, 20);
+	}
+	memcpy(result, sha1, 20);
+	return 0;
+}
+
 static int get_sha1_1(const char *name, int len, unsigned char *sha1)
 {
 	int parent, ret;
+	const char *cp;
 
 	/* foo^[0-9] or foo^ (== foo^1); we do not do more than 9 parents. */
 	if (len > 2 && name[len-2] == '^' &&
@@ -210,6 +230,27 @@ static int get_sha1_1(const char *name, 
 	if (parent >= 0)
 		return get_parent(name, len, sha1, parent);
 
+	/* name:3 is name^^^,
+	 * name:12 is name^^^^^^^^^^^^, and
+	 * name: is name
+	 */
+	parent = 0;
+	for (cp = name + len - 1; name <= cp; cp--) {
+		int ch = *cp;
+		if ('0' <= ch && ch <= '9')
+			continue;
+		if (ch != ':')
+			parent = -1;
+		break;
+	}
+	if (!parent && *cp == ':') {
+		int len1 = cp - name;
+		cp++;
+		while (cp < name + len)
+			parent = parent * 10 + *cp++ - '0';
+		return get_nth_ancestor(name, len1, sha1, parent);
+	}
+
 	ret = get_sha1_basic(name, len, sha1);
 	if (!ret)
 		return 0;
