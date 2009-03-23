From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/7] strbuf_branchname(): a wrapper for branch name
 shorthands
Date: Mon, 23 Mar 2009 00:58:35 -0700
Message-ID: <a552de75eb01f78046feaf7dc88e5e4833624ad5.1237791716.git.gitster@pobox.com>
References: <cover.1237791716.git.gitster@pobox.com>
 <431b1969fcde69959a23355fba6894fb69c8fa0c.1237791716.git.gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 09:01:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llf5r-0003W2-RY
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 09:01:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756766AbZCWH6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 03:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755599AbZCWH6v
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 03:58:51 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47521 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756684AbZCWH6t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 03:58:49 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3964B8683
	for <git@vger.kernel.org>; Mon, 23 Mar 2009 03:58:47 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 82C578682 for
 <git@vger.kernel.org>; Mon, 23 Mar 2009 03:58:46 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.349.ga64c
In-Reply-To: <431b1969fcde69959a23355fba6894fb69c8fa0c.1237791716.git.gitster@pobox.com>
In-Reply-To: <cover.1237791716.git.gitster@pobox.com>
References: <cover.1237791716.git.gitster@pobox.com>
X-Pobox-Relay-ID: 7022970E-1780-11DE-8A87-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114254>

The function takes a user-supplied string that is supposed to be a branch
name, and puts it in a strbuf after expanding possible shorthand notation.

A handful of open coded sequence to do this in the existing code have been
changed to use this helper function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 branch.c           |    7 +------
 builtin-branch.c   |    6 +-----
 builtin-checkout.c |   11 +++--------
 builtin-merge.c    |    5 ++---
 strbuf.c           |    9 +++++++++
 strbuf.h           |    2 ++
 6 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/branch.c b/branch.c
index 313bcf1..558f092 100644
--- a/branch.c
+++ b/branch.c
@@ -134,13 +134,8 @@ void create_branch(const char *head,
 	char *real_ref, msg[PATH_MAX + 20];
 	struct strbuf ref = STRBUF_INIT;
 	int forcing = 0;
-	int len;
 
-	len = strlen(name);
-	if (interpret_branch_name(name, &ref) != len) {
-		strbuf_reset(&ref);
-		strbuf_add(&ref, name, len);
-	}
+	strbuf_branchname(&ref, name);
 	strbuf_splice(&ref, 0, 0, "refs/heads/", 11);
 
 	if (check_ref_format(ref.buf))
diff --git a/builtin-branch.c b/builtin-branch.c
index cacd7da..7452db1 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -121,11 +121,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 			die("Couldn't look up commit object for HEAD");
 	}
 	for (i = 0; i < argc; i++, strbuf_release(&bname)) {
-		int len = strlen(argv[i]);
-
-		if (interpret_branch_name(argv[i], &bname) != len)
-			strbuf_add(&bname, argv[i], len);
-
+		strbuf_branchname(&bname, argv[i]);
 		if (kinds == REF_LOCAL_BRANCH && !strcmp(head, bname.buf)) {
 			error("Cannot delete the branch '%s' "
 			      "which you are currently on.", bname.buf);
diff --git a/builtin-checkout.c b/builtin-checkout.c
index a8d9d97..b268046 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -353,16 +353,11 @@ struct branch_info {
 static void setup_branch_path(struct branch_info *branch)
 {
 	struct strbuf buf = STRBUF_INIT;
-	int ret;
 
-	if ((ret = interpret_branch_name(branch->name, &buf))
-	    && ret == strlen(branch->name)) {
+	strbuf_branchname(&buf, branch->name);
+	if (strcmp(buf.buf, branch->name))
 		branch->name = xstrdup(buf.buf);
-		strbuf_splice(&buf, 0, 0, "refs/heads/", 11);
-	} else {
-		strbuf_addstr(&buf, "refs/heads/");
-		strbuf_addstr(&buf, branch->name);
-	}
+	strbuf_splice(&buf, 0, 0, "refs/heads/", 11);
 	branch->path = strbuf_detach(&buf, NULL);
 }
 
diff --git a/builtin-merge.c b/builtin-merge.c
index e94ea7c..6a51823 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -360,9 +360,8 @@ static void merge_name(const char *remote, struct strbuf *msg)
 	const char *ptr;
 	int len, early;
 
-	len = strlen(remote);
-	if (interpret_branch_name(remote, &bname) == len)
-		remote = bname.buf;
+	strbuf_branchname(&bname, remote);
+	remote = bname.buf;
 
 	memset(branch_head, 0, sizeof(branch_head));
 	remote_head = peel_to_type(remote, 0, NULL, OBJ_COMMIT);
diff --git a/strbuf.c b/strbuf.c
index bfbd816..a60b0ad 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -357,3 +357,12 @@ int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
 
 	return len;
 }
+
+int strbuf_branchname(struct strbuf *sb, const char *name)
+{
+	int len = strlen(name);
+	if (interpret_branch_name(name, sb) == len)
+		return 0;
+	strbuf_add(sb, name, len);
+	return len;
+}
diff --git a/strbuf.h b/strbuf.h
index 89bd36e..68923e1 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -131,4 +131,6 @@ extern int strbuf_getline(struct strbuf *, FILE *, int);
 extern void stripspace(struct strbuf *buf, int skip_comments);
 extern int launch_editor(const char *path, struct strbuf *buffer, const char *const *env);
 
+extern int strbuf_branchname(struct strbuf *sb, const char *name);
+
 #endif /* STRBUF_H */
-- 
1.6.2.1.349.ga64c
