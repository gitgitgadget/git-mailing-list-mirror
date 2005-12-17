From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Remove misguided branch disambiguation.
Date: Sat, 17 Dec 2005 01:37:38 -0800
Message-ID: <7virto12u5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Dec 17 10:39:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnYVa-0003qQ-Gu
	for gcvg-git@gmane.org; Sat, 17 Dec 2005 10:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbVLQJhk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Dec 2005 04:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbVLQJhk
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Dec 2005 04:37:40 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:8346 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932287AbVLQJhj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2005 04:37:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051217093641.QTSN20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 17 Dec 2005 04:36:41 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13777>

This removes the misguided attempt to refuse processing a branch
name xyzzy and insist it to be given as either heads/xyzzy or
tags/xyzzy when a tag xyzzy exists.  There was no reason to do
so --- the search order was predictable and well defined, so if
the user says xyzzy we should have taken the tag xyzzy in such a
case without complaining.

This incidentally fixes another subtle bug related to this.  If
such a duplicate branch/tag name happened to be a unique valid
prefix of an existing commit object name (say, "beef"), we did
not take the tag "beef" but after complaining used the commit
object whose name started with beef.

Another problem this fixes while introducing some confusion is
that there is no longer a reason to forbid a branch name HEAD
anymore.  In other words, now "git pull . ref1:HEAD" would work
as expected, once we revert "We do not like HEAD branch" patch.
It creates "HEAD" branch under ${GIT_DIR-.git}/refs/heads (or
fast-forwards if already exists) using the tip of ref1 branch
from the current repository, and merges it into the current
branch.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 sha1_name.c |   33 +++------------------------------
 1 files changed, 3 insertions(+), 30 deletions(-)

a012e1b2b5218729e148befd0705bd52962ac272
diff --git a/sha1_name.c b/sha1_name.c
index bf8f0f0..49e2cc3 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -238,7 +238,6 @@ static int get_sha1_basic(const char *st
 		NULL
 	};
 	const char **p;
-	int found = 0;
 
 	if (len == 40 && !get_sha1_hex(str, sha1))
 		return 0;
@@ -249,36 +248,10 @@ static int get_sha1_basic(const char *st
 
 	for (p = prefix; *p; p++) {
 		char *pathname = git_path("%s/%.*s", *p, len, str);
-
-		if (!read_ref(pathname, sha1)) {
-			/* Must be unique; i.e. when heads/foo and
-			 * tags/foo are both present, reject "foo".
-			 */
-			if (1 < found++)
-				return -1;
-		}
-
-		/* We want to allow .git/description file and
-		 * "description" branch to exist at the same time.
-		 * "git-rev-parse description" should silently skip
-		 * .git/description file as a candidate for
-		 * get_sha1().  However, having garbage file anywhere
-		 * under refs/ is not OK, and we would not have caught
-		 * ambiguous heads and tags with the above test.
-		 */
-		else if (**p && !access(pathname, F_OK)) {
-			/* Garbage exists under .git/refs */
-			return error("garbage ref found '%s'", pathname);
-		}
-	}
-	switch (found) {
-	case 0:
-		return -1;
-	case 1:
-		return 0;
-	default:
-		return error("ambiguous refname '%.*s'", len, str);
+		if (!read_ref(pathname, sha1))
+			return 0;
 	}
+	return -1;
 }
 
 static int get_sha1_1(const char *name, int len, unsigned char *sha1);
-- 
0.99.9.GIT
