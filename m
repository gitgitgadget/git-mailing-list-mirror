From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] teach the new "@{-1} syntax to "git branch"
Date: Fri, 13 Feb 2009 23:08:05 -0800
Message-ID: <7v4oyxzeay.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 14 08:10:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYEfm-0002T7-Vv
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 08:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbZBNHIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 02:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbZBNHIP
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 02:08:15 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53820 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbZBNHIO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 02:08:14 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D4F9C99CA2;
	Sat, 14 Feb 2009 02:08:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9ECCD99CA0; Sat,
 14 Feb 2009 02:08:07 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3C6EB122-FA66-11DD-88AB-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109835>

This teaches the new "@{-1} syntax to refer to the previous branch to "git
branch".  After looking at somebody's faulty patch series on a topic
branch too long, if you decide it is not worth merging, you can just say:

    $ git checkout master
    $ git branch -D @{-1}

to get rid of it without having to type the name of the topic you now hate
so much for wasting a lot of your time.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 branch.c         |   19 ++++++++++++++-----
 builtin-branch.c |   31 +++++++++++++++++++------------
 2 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/branch.c b/branch.c
index b1ac837..1f00e44 100644
--- a/branch.c
+++ b/branch.c
@@ -103,14 +103,22 @@ void create_branch(const char *head,
 	struct ref_lock *lock;
 	struct commit *commit;
 	unsigned char sha1[20];
-	char *real_ref, ref[PATH_MAX], msg[PATH_MAX + 20];
+	char *real_ref, msg[PATH_MAX + 20];
+	struct strbuf ref = STRBUF_INIT;
 	int forcing = 0;
+	int len;
 
-	snprintf(ref, sizeof ref, "refs/heads/%s", name);
-	if (check_ref_format(ref))
+	len = strlen(name);
+	if (interpret_nth_last_branch(name, &ref) != len) {
+		strbuf_reset(&ref);
+		strbuf_add(&ref, name, len);
+	}
+	strbuf_splice(&ref, 0, 0, "refs/heads/", 11);
+
+	if (check_ref_format(ref.buf))
 		die("'%s' is not a valid branch name.", name);
 
-	if (resolve_ref(ref, sha1, 1, NULL)) {
+	if (resolve_ref(ref.buf, sha1, 1, NULL)) {
 		if (!force)
 			die("A branch named '%s' already exists.", name);
 		else if (!is_bare_repository() && !strcmp(head, name))
@@ -142,7 +150,7 @@ void create_branch(const char *head,
 		die("Not a valid branch point: '%s'.", start_name);
 	hashcpy(sha1, commit->object.sha1);
 
-	lock = lock_any_ref_for_update(ref, NULL, 0);
+	lock = lock_any_ref_for_update(ref.buf, NULL, 0);
 	if (!lock)
 		die("Failed to lock ref for update: %s.", strerror(errno));
 
@@ -162,6 +170,7 @@ void create_branch(const char *head,
 	if (write_ref_sha1(lock, sha1, msg) < 0)
 		die("Failed to write ref: %s.", strerror(errno));
 
+	strbuf_release(&ref);
 	free(real_ref);
 }
 
diff --git a/builtin-branch.c b/builtin-branch.c
index 56a1971..504a981 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -99,6 +99,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 	const char *fmt, *remote;
 	int i;
 	int ret = 0;
+	struct strbuf bname = STRBUF_INIT;
 
 	switch (kinds) {
 	case REF_REMOTE_BRANCH:
@@ -119,20 +120,25 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 		if (!head_rev)
 			die("Couldn't look up commit object for HEAD");
 	}
-	for (i = 0; i < argc; i++) {
-		if (kinds == REF_LOCAL_BRANCH && !strcmp(head, argv[i])) {
+	for (i = 0; i < argc; i++, strbuf_release(&bname)) {
+		int len = strlen(argv[i]);
+
+		if (interpret_nth_last_branch(argv[i], &bname) != len)
+			strbuf_add(&bname, argv[i], len);
+
+		if (kinds == REF_LOCAL_BRANCH && !strcmp(head, bname.buf)) {
 			error("Cannot delete the branch '%s' "
-				"which you are currently on.", argv[i]);
+			      "which you are currently on.", bname.buf);
 			ret = 1;
 			continue;
 		}
 
 		free(name);
 
-		name = xstrdup(mkpath(fmt, argv[i]));
+		name = xstrdup(mkpath(fmt, bname.buf));
 		if (!resolve_ref(name, sha1, 1, NULL)) {
 			error("%sbranch '%s' not found.",
-					remote, argv[i]);
+					remote, bname.buf);
 			ret = 1;
 			continue;
 		}
@@ -152,22 +158,23 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 		if (!force &&
 		    !in_merge_bases(rev, &head_rev, 1)) {
 			error("The branch '%s' is not an ancestor of "
-				"your current HEAD.\n"
-				"If you are sure you want to delete it, "
-				"run 'git branch -D %s'.", argv[i], argv[i]);
+			      "your current HEAD.\n"
+			      "If you are sure you want to delete it, "
+			      "run 'git branch -D %s'.", bname.buf, bname.buf);
 			ret = 1;
 			continue;
 		}
 
 		if (delete_ref(name, sha1, 0)) {
 			error("Error deleting %sbranch '%s'", remote,
-			       argv[i]);
+			      bname.buf);
 			ret = 1;
 		} else {
 			struct strbuf buf = STRBUF_INIT;
-			printf("Deleted %sbranch %s (%s).\n", remote, argv[i],
-				find_unique_abbrev(sha1, DEFAULT_ABBREV));
-			strbuf_addf(&buf, "branch.%s", argv[i]);
+			printf("Deleted %sbranch %s (%s).\n", remote,
+			       bname.buf,
+			       find_unique_abbrev(sha1, DEFAULT_ABBREV));
+			strbuf_addf(&buf, "branch.%s", bname.buf);
 			if (git_config_rename_section(buf.buf, NULL) < 0)
 				warning("Update of config-file failed");
 			strbuf_release(&buf);
-- 
1.6.2.rc0.80.ge11dd
