From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] commit-tree: disallow an empty single-parent commit.
Date: Fri, 24 Feb 2006 04:20:54 -0800
Message-ID: <7vslq99cd5.fsf_-_@assigned-by-dhcp.cox.net>
References: <m1slqahyxt.fsf@ebiederm.dsl.xmission.com>
	<7v1wxtgv02.fsf@assigned-by-dhcp.cox.net>
	<m18xs1dmp3.fsf@ebiederm.dsl.xmission.com>
	<7vy8019d44.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 13:21:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCbwQ-0003QQ-QB
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 13:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWBXMU4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 07:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWBXMU4
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 07:20:56 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:19600 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932115AbWBXMUz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 07:20:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060224121726.XQHH17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 24 Feb 2006 07:17:26 -0500
To: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <7vy8019d44.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 24 Feb 2006 04:04:43 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16698>

Allow "git-commit-tree v2.6.15^{tree} -p HEAD", instead of
requiring "git-commit-tree `git rev-parse v2.6.15^{tree}` -p
HEAD".  The parent parameter that follows -p uses get_sha1() to
understand the extended notation, and there is little reason not
to allow it for the tree object name parameter.

Also make the check_valid() function simpler.  This function
which predates sha1_object_info() so it had to do things by hand
but there is no reason to read the data just to discard anymore.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * Replacement patch.  Very lightly tested.

 commit-tree.c |   27 ++++++++++++++++++++-------
 1 files changed, 20 insertions(+), 7 deletions(-)

8f97300b2580b43905ce11eef21e77c5e8e809a6
diff --git a/commit-tree.c b/commit-tree.c
index 88871b0..b1d816c 100644
--- a/commit-tree.c
+++ b/commit-tree.c
@@ -43,14 +43,11 @@ static void add_buffer(char **bufp, unsi
 
 static void check_valid(unsigned char *sha1, const char *expect)
 {
-	void *buf;
 	char type[20];
-	unsigned long size;
 
-	buf = read_sha1_file(sha1, type, &size);
-	if (!buf || strcmp(type, expect))
-		die("%s is not a valid '%s' object", sha1_to_hex(sha1), expect);
-	free(buf);
+	if (sha1_object_info(sha1, type, NULL) || strcmp(type, expect))
+		die("%s is not a valid '%s' object",
+		    sha1_to_hex(sha1), expect);
 }
 
 /*
@@ -75,6 +72,19 @@ static int new_parent(int idx)
 	return 1;
 }
 
+static int check_empty_commit(const unsigned char *tree_sha1,
+			      const unsigned char *parent_sha1)
+{
+	unsigned char sha1[20];
+	char refit[50];
+	sprintf(refit, "%s^{tree}", sha1_to_hex(parent_sha1));
+	if (get_sha1(refit, sha1))
+		die("cannot determine tree in parent commit.");
+	if (!memcmp(sha1, tree_sha1, 20))
+		return error ("empty commit?  aborting.");
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	int i;
@@ -90,7 +100,7 @@ int main(int argc, char **argv)
 
 	git_config(git_default_config);
 
-	if (argc < 2 || get_sha1_hex(argv[1], tree_sha1) < 0)
+	if (argc < 2 || get_sha1(argv[1], tree_sha1) < 0)
 		usage(commit_tree_usage);
 
 	check_valid(tree_sha1, "tree");
@@ -105,6 +115,9 @@ int main(int argc, char **argv)
 	}
 	if (!parents)
 		fprintf(stderr, "Committing initial tree %s\n", argv[1]);
+	if (parents == 1)
+		if (check_empty_commit(tree_sha1, parent_sha1[0]))
+			exit(1);
 
 	init_buffer(&buffer, &size);
 	add_buffer(&buffer, &size, "tree %s\n", sha1_to_hex(tree_sha1));
-- 
1.2.3.g7465
