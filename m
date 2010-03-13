From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH/RFC 01/12] commit-tree: allow indirect tree references
Date: Fri, 12 Mar 2010 23:52:53 -0500
Message-ID: <1268455984-19061-2-git-send-email-lodatom@gmail.com>
References: <1268455984-19061-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 13 05:53:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqJLy-0007Xi-Tn
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 05:53:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756333Ab0CMExR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 23:53:17 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:38432 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755979Ab0CMExP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 23:53:15 -0500
Received: by qw-out-2122.google.com with SMTP id 9so447878qwb.37
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 20:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=W/ubELE1VbSGBQO6feGvSryAKzX9DuWIAQ8rDJRvTW0=;
        b=mdml+4pp8nkPeOTKCh+GEyNFwuIQQKaXDFM+g+VNlkFbfVWUpA7vZ6W+L3sICfAFYt
         e433p0FaPj5VwLphxhMZoKfEicne8wCK6ZZKbIuZ4+mvMwgmba7MaJBsJbTrPDJjdcLs
         JPR3j5EetrE0tCBfl4U2sUobvYv6BWC0Z+/uM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LYhi70P+DAU2wBLvXOPuKwpFLKqEdl78MddzX6Qtyn1mPFO6pfIBaTX/CsBERCehPW
         85c9aC5STPryv7+bS03HFRsGJU5Qz/S5X2Eu3TuUVpYpBShJLPXROQ7z/mGZdu4If4Fn
         wZaNKN3GO5/QntscQ28Nd9vgX14/DoTONqySI=
Received: by 10.229.44.70 with SMTP id z6mr3025914qce.6.1268455994573;
        Fri, 12 Mar 2010 20:53:14 -0800 (PST)
Received: from localhost.localdomain (c-68-50-174-152.hsd1.dc.comcast.net [68.50.174.152])
        by mx.google.com with ESMTPS id 22sm1694110qyk.10.2010.03.12.20.53.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Mar 2010 20:53:14 -0800 (PST)
X-Mailer: git-send-email 1.7.0.2
In-Reply-To: <1268455984-19061-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142074>

'git commit-tree' was the last remaining built-in to accept a <tree> but
not a <tree-ish> (an indirect tree reference through a commit or tag
object.)

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
A similar thing should be done for the parent commits.  As far as I can 
tell, this is the only command that requires a commit object, not a tag.

 Documentation/git-commit-tree.txt |    4 +-
 builtin/commit-tree.c             |   13 ++++++----
 t/t1101-commit-tree-indirect.sh   |   49 +++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 7 deletions(-)
 create mode 100755 t/t1101-commit-tree-indirect.sh

diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index 6188854..67b6bc0 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -8,7 +8,7 @@ git-commit-tree - Create a new commit object
 
 SYNOPSIS
 --------
-'git commit-tree' <tree> [-p <parent commit>]\* < changelog
+'git commit-tree' <tree-ish> [-p <parent commit>]\* < changelog
 
 DESCRIPTION
 -----------
@@ -35,7 +35,7 @@ state was.
 
 OPTIONS
 -------
-<tree>::
+<tree-ish>::
 	An existing tree object
 
 -p <parent commit>::
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 90dac34..96a421e 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -97,16 +97,19 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	struct commit_list *parents = NULL;
-	unsigned char tree_sha1[20];
-	unsigned char commit_sha1[20];
+	unsigned char sha1[20];
 	struct strbuf buffer = STRBUF_INIT;
+	struct tree *tree;
 
 	git_config(git_default_config, NULL);
 
 	if (argc < 2 || !strcmp(argv[1], "-h"))
 		usage(commit_tree_usage);
-	if (get_sha1(argv[1], tree_sha1))
+	if (get_sha1(argv[1], sha1))
 		die("Not a valid object name %s", argv[1]);
+	tree = parse_tree_indirect(sha1);
+	if (!tree)
+		die("%s is not a valid 'tree' object", argv[1]);
 
 	for (i = 2; i < argc; i += 2) {
 		unsigned char sha1[20];
@@ -124,8 +127,8 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	if (strbuf_read(&buffer, 0, 0) < 0)
 		die_errno("git commit-tree: failed to read");
 
-	if (!commit_tree(buffer.buf, tree_sha1, parents, commit_sha1, NULL)) {
-		printf("%s\n", sha1_to_hex(commit_sha1));
+	if (!commit_tree(buffer.buf, tree->object.sha1, parents, sha1, NULL)) {
+		printf("%s\n", sha1_to_hex(sha1));
 		return 0;
 	}
 	else
diff --git a/t/t1101-commit-tree-indirect.sh b/t/t1101-commit-tree-indirect.sh
new file mode 100755
index 0000000..905bad7
--- /dev/null
+++ b/t/t1101-commit-tree-indirect.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Mark Lodato
+#
+
+test_description='git commit-tree works with indirect references'
+
+. ./test-lib.sh
+
+get_tree() {
+	git cat-file commit $1 | sed -n -e 's/^tree //p'
+}
+
+test_expect_success 'prepare the repository' '
+	touch a &&
+	git add a &&
+	git commit -m x &&
+	git tag -a -m x tag-commit &&
+	git tag -a -m x tag-tree HEAD^{tree} &&
+	git tag -a -m x tag-blob HEAD:a &&
+	git tag -a -m x tag-tag-commit tag-commit
+'
+
+expected_tree="$(get_tree HEAD)"
+
+test_success() {
+	test_expect_success "commit-tree succeeds with $2" '
+		id="$(echo x | git commit-tree '"$1"')" &&
+		tree="$(get_tree $id)" &&
+		test "x$tree" = "x$expected_tree"
+	'
+}
+test_failure() {
+	test_expect_code 128 "commit-tree fails with $2" '
+		echo x | git commit-tree '"$1"' 2>/dev/null
+	'
+}
+
+test_failure HEAD:a "a blob"
+test_success HEAD^{tree} "a tree"
+test_success HEAD "HEAD"
+test_success master "a branch"
+test_failure foo "an invalid object name"
+test_failure tag-blob "a tag pointing to a blob"
+test_success tag-tree "a tag pointing to a tree"
+test_success tag-commit "a tag pointing to a commit"
+test_success tag-tag-commit "a tag pointing to a tag (to a commit)"
+
+test_done
-- 
1.7.0.2
