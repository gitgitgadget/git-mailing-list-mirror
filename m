From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/6] git-describe: --tags and --abbrev
Date: Tue, 27 Dec 2005 16:42:31 -0800
Message-ID: <7vpsni2gso.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0512241339120.14098@g5.osdl.org>
	<Pine.LNX.4.64.0512241409300.14098@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 28 01:43:24 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ErPPV-0003w8-7j
	for gcvg-git@gmane.org; Wed, 28 Dec 2005 01:43:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbVL1Ami (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Dec 2005 19:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbVL1Amh
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Dec 2005 19:42:37 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:49092 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932428AbVL1Ame (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2005 19:42:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051228004237.SNLR25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Dec 2005 19:42:37 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14084>

With --tags, not just annontated tags, but also any ref under
refs/tags/ are used to name the revision.

The number of digits is configurable with the --abbrev=<n> option.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 describe.c |   33 +++++++++++++++++++++++++++------
 1 files changed, 27 insertions(+), 6 deletions(-)

970d400993d27a3228bccd72c0ddba767ebbbfff
diff --git a/describe.c b/describe.c
index ba49d00..ee38f5f 100644
--- a/describe.c
+++ b/describe.c
@@ -5,9 +5,14 @@
 
 #define SEEN (1u << 0)
 
-static const char describe_usage[] = "git-describe [--all] <committish>*";
+static const char describe_usage[] =
+"git-describe [--all] [--tags] [--abbrev=<n>] <committish>*";
 
 static int all = 0;	/* Default to annotated tags only */
+static int tags = 0;	/* But allow any tags if --tags is specified */
+
+#define DEFAULT_ABBREV 8 /* maybe too many */
+static int abbrev = DEFAULT_ABBREV;
 
 static int names = 0, allocs = 0;
 static struct commit_name {
@@ -50,13 +55,19 @@ static int get_name(const char *path, co
 	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
 	if (!commit)
 		return 0;
+	/* If --all, then any refs are used.
+	 * If --tags, then any tags are used.
+	 * Otherwise only annotated tags are used.
+	 */
 	if (!all) {
-		struct object *object;
 		if (strncmp(path, "refs/tags/", 10))
 			return 0;
-		object = parse_object(sha1);
-		if (object->type != tag_type)
-			return 0;
+		if (!tags) {
+			struct object *object;
+			object = parse_object(sha1);
+			if (object->type != tag_type)
+				return 0;
+		}
 	}
 	add_to_known_names(all ? path : path + 10, commit);
 	return 0;
@@ -96,7 +107,7 @@ static void describe(struct commit *cmit
 		n = match(c);
 		if (n) {
 			printf("%s-g%s\n", n->path,
-			       find_unique_abbrev(cmit->object.sha1, 8));
+			       find_unique_abbrev(cmit->object.sha1, abbrev));
 			return;
 		}
 	}
@@ -115,6 +126,16 @@ int main(int argc, char **argv)
 			all = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--tags")) {
+			tags = 1;
+			continue;
+		}
+		if (!strncmp(arg, "--abbrev=", 9)) {
+			abbrev = strtoul(arg + 9, NULL, 10);
+			if (abbrev < 4 || 40 <= abbrev)
+				abbrev = DEFAULT_ABBREV;
+			continue;
+		}
 		if (get_sha1(arg, sha1) < 0)
 			usage(describe_usage);
 		cmit = lookup_commit_reference(sha1);
-- 
1.0.5-geb9d
