From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: [PATCH] Disallow creating ambiguous branch names by default
Date: Wed, 17 Aug 2011 01:21:38 -0700
Message-ID: <1313569298-3879-1-git-send-email-conrad.irwin@gmail.com>
Cc: conrad.irwin@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 10:21:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtbNq-00039s-2g
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 10:21:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961Ab1HQIVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 04:21:49 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:40616 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853Ab1HQIVq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 04:21:46 -0400
Received: by iye16 with SMTP id 16so1454984iye.1
        for <git@vger.kernel.org>; Wed, 17 Aug 2011 01:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=cyOHZ24Io8+qhgcOEZ/bdDwV0CHnaGfJxCNgbZKij4I=;
        b=R5nuKLG0tT9sz1rS0LSYb++L4V7BsukOCF9cnUtu4fSWA4jgWR+jrvQEAtSselhGue
         L01EckY3o8xu+mAO22UIo/Mh/OLMFaCk17eECeWoj8Vmsl0lz5wyVAcwhslFhy74OODs
         n1y8dgs449maAROIPdOMsjGc0Dcn0uEDx3arQ=
Received: by 10.231.4.99 with SMTP id 35mr1538097ibq.85.1313569305948;
        Wed, 17 Aug 2011 01:21:45 -0700 (PDT)
Received: from localhost.localdomain (c-69-181-44-79.hsd1.ca.comcast.net [69.181.44.79])
        by mx.google.com with ESMTPS id q4sm333962ibb.32.2011.08.17.01.21.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Aug 2011 01:21:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.448.gc60f1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179503>

Before this change, it was comparatively easy to create a confusingly
named branch (like "origin/master" or "tag.1"). The former case is
particularly biting to newcomers, who suddenly find themselves needing
to handle nuances of the refs namespaces. The latter is something you're
not likely to want to do, the tag will take precedence when the name is
resolved meaning that your branch will be hard to use.

In both cases, git commands would omit a warning about "ambiguous refs"
if they noticed that this had occurred, however it feels nicer to help
users avoid getting into that situation to start with!

After this patch, git branch <foo>, git checkout -b <foo> and git branch
-m bar <foo> will all fail if <foo> is already a commit-ish; this
safety-net can be removed by passing the -f, -B or -M flags.

Signed-off-by: Conrad Irwin <conrad.irwin@gmail.com>

---

I considered adding a separate configuration variable to disable this
check permanently, but I couldn't find a convincing use-case. Perhaps
the closest is in `git branch $(git describe)` as a quick way to
bookmark a commit; but it seems like creating a tag might be a more
sensible option in that case. Would anyone want such a flag?

Conrad

 Documentation/git-branch.txt |    5 +++--
 branch.c                     |    2 ++
 builtin/branch.c             |    3 +++
 t/t2018-checkout-branch.sh   |   16 ++++++++++++++--
 t/t3200-branch.sh            |   33 +++++++++++++++++++++++++++++++++
 t/t6300-for-each-ref.sh      |    2 +-
 t/t7201-co.sh                |    4 ++--
 7 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index c50f189..415eae3 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -80,8 +80,9 @@ OPTIONS
 
 -f::
 --force::
-	Reset <branchname> to <startpoint> if <branchname> exists
-	already. Without `-f` 'git branch' refuses to change an existing branch.
+	Create the branch even when it might be confusing to do so (for
+	example a tag with that name already exists). If a branch with
+	the same name already exists, it will be reset to <start-point>.
 
 -m::
 	Move/rename a branch and the corresponding reflog.
diff --git a/branch.c b/branch.c
index c0c865a..f26154e 100644
--- a/branch.c
+++ b/branch.c
@@ -162,6 +162,8 @@ void create_branch(const char *head,
 		else if (!is_bare_repository() && head && !strcmp(head, name))
 			die("Cannot force update the current branch.");
 		forcing = 1;
+	} else if (!force && !get_sha1(name, sha1)) {
+		die("A branch named '%s' would be ambiguous.", name);
 	}
 
 	real_ref = NULL;
diff --git a/builtin/branch.c b/builtin/branch.c
index 3142daa..6af1718 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -572,6 +572,9 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 	if (resolve_ref(newref.buf, sha1, 1, NULL) && !force)
 		die(_("A branch named '%s' already exists."), newref.buf + 11);
 
+	if (!get_sha1(newname, sha1) && !force)
+		die(_("A branch named '%s' would be ambiguous."), newname);
+
 	strbuf_addf(&logmsg, "Branch: renamed %s to %s",
 		 oldref.buf, newref.buf);
 
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index a42e039..26cc066 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -169,15 +169,27 @@ test_expect_success 'checkout -f -B to an existing branch with mergeable changes
 	test_must_fail test_dirty_mergeable
 '
 
-test_expect_success 'checkout -b <describe>' '
+test_expect_success 'checkout -B <describe>' '
 	git tag -f -m "First commit" initial initial &&
 	git checkout -f change1 &&
 	name=$(git describe) &&
-	git checkout -b $name &&
+	git checkout -B $name &&
 	git diff --exit-code change1 &&
 	echo "refs/heads/$name" >expect &&
 	git symbolic-ref HEAD >actual &&
 	test_cmp expect actual
 '
 
+test_expect_success 'checkout -b <tag-name> fails' '
+	git tag -f -m "First commit" initial initial &&
+	git checkout -f change1 &&
+	test_must_fail git checkout -b initial
+'
+
+test_expect_success 'checkout -B <tag-name> fails' '
+	git tag -f -m "First commit" initial initial &&
+	git checkout -f change1 &&
+	git checkout -B initial
+'
+
 test_done
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 9e69c8c..f3f4542 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -230,6 +230,39 @@ test_expect_success \
     'git tag foobar &&
      test_must_fail git branch --track my11 foobar'
 
+test_expect_success 'creating a branch called HEAD fails' '
+    test_must_fail git branch HEAD
+'
+
+test_expect_success 'creating a branch with an ambiguous name fails' '
+    git tag t/g &&
+    test_must_fail git branch t/g &&
+    git tag -d t/g
+'
+
+test_expect_success 'creating a branch with an ambigious name with -f' '
+    git tag t/g &&
+    git branch -f t/g &&
+    git branch -d t/g &&
+    git tag -d t/g
+'
+
+test_expect_success 'moving a branch to an ambiguous name with -m fails' '
+    git tag t/g &&
+    git branch bar &&
+    test_must_fail git branch -m bar t/g &&
+    git branch -d bar &&
+    git tag -d t/g
+'
+
+test_expect_success 'moving a branch to an ambiguous name with -M' '
+    git tag t/g &&
+    git branch b/h &&
+    git branch -M b/h t/g &&
+    git branch -d t/g &&
+    git tag -d t/g
+'
+
 # Keep this test last, as it changes the current branch
 cat >expect <<EOF
 $_z40 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 7dc8a51..37f0394 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -344,7 +344,7 @@ EOF
 test_expect_success 'Check ambiguous head and tag refs II (loose)' '
 	git checkout master &&
 	git tag ambiguous testtag^0 &&
-	git branch ambiguous testtag^0 &&
+	git branch -f ambiguous testtag^0 &&
 	git for-each-ref --format "%(refname:short)" refs/heads/ambiguous refs/tags/ambiguous >actual &&
 	test_cmp expected actual
 '
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 07fb53a..a488c5b 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -311,7 +311,7 @@ test_expect_success 'checkout to detach HEAD with HEAD^0' '
 test_expect_success 'checkout with ambiguous tag/branch names' '
 
 	git tag both side &&
-	git branch both master &&
+	git branch -f both master &&
 	git reset --hard &&
 	git checkout master &&
 
@@ -330,7 +330,7 @@ test_expect_success 'checkout with ambiguous tag/branch names' '
 	git checkout master &&
 
 	git tag frotz side &&
-	git branch frotz master &&
+	git branch -f frotz master &&
 	git reset --hard &&
 	git checkout master &&
 
-- 
1.7.6.448.gc60f1
