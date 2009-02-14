From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] Teach the "@{-1} syntax to "git branch"
Date: Sat, 14 Feb 2009 01:37:43 -0800
Message-ID: <7vwsbtuzo8.fsf_-_@gitster.siamese.dyndns.org>
References: <7v4oyxzeay.fsf@gitster.siamese.dyndns.org>
 <76718490902132311j5add87bcpb103c951a8192b05@mail.gmail.com>
 <7vzlgpxz4g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 14 10:39:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYGzX-0003a2-4j
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 10:39:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbZBNJhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 04:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbZBNJhv
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 04:37:51 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48244 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbZBNJhu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 04:37:50 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 43FA3992CA;
	Sat, 14 Feb 2009 04:37:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8E565992C1; Sat,
 14 Feb 2009 04:37:45 -0500 (EST)
In-Reply-To: <7vzlgpxz4g.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 13 Feb 2009 23:21:19 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 24934648-FA7B-11DD-B73B-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109851>

This teaches the new "@{-1} syntax to refer to the previous branch to "git
branch".  After looking at somebody's faulty patch series on a topic
branch too long, if you decide it is not worth merging, you can just say:

    $ git checkout master
    $ git branch -D @{-1}

to get rid of it without having to type the name of the topic you now hate
so much for wasting a lot of your time.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Now comes with test.
 branch.c            |   19 ++++++++++++++-----
 builtin-branch.c    |   31 +++++++++++++++++++------------
 t/t0100-previous.sh |   26 ++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 17 deletions(-)
 create mode 100755 t/t0100-previous.sh

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
diff --git a/t/t0100-previous.sh b/t/t0100-previous.sh
new file mode 100755
index 0000000..db51b42
--- /dev/null
+++ b/t/t0100-previous.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+test_description='previous branch syntax @{-n}'
+
+. ./test-lib.sh
+
+test_expect_success 'branch -d @{-1}' '
+	test_commit A &&
+	git checkout -b junk &&
+	git checkout - &&
+	test "$(git symbolic-ref HEAD)" = refs/heads/master &&
+	git branch -d @{-1} &&
+	test_must_fail git rev-parse --verify refs/heads/junk
+'
+
+test_expect_success 'branch -d @{-12} when there is not enough switches yet' '
+	git reflog expire --expire=now &&
+	git checkout -b junk2 &&
+	git checkout - &&
+	test "$(git symbolic-ref HEAD)" = refs/heads/master &&
+	test_must_fail git branch -d @{-12} &&
+	git rev-parse --verify refs/heads/master
+'
+
+test_done
+
-- 
1.6.2.rc0.80.ge11dd
