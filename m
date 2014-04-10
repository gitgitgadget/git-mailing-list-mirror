From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 9/9] sha1_name: add support for @{publish} marks
Date: Thu, 10 Apr 2014 14:04:46 -0500
Message-ID: <1397156686-31349-10-git-send-email-felipe.contreras@gmail.com>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 21:15:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYKS3-0006ua-Od
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 21:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758594AbaDJTPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 15:15:44 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:39878 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161210AbaDJTPj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 15:15:39 -0400
Received: by mail-ob0-f176.google.com with SMTP id wp18so4835068obc.7
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 12:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nrmkJsGXEA8WXhgDsXHvCMGtZfXEiKqnMiBAs/ZZoqk=;
        b=stuoVxmGvEfURAQO+56JTXkSKrBmm5i4cQuRlWquNga4/WtQPovnvgfHIb03P5KKbW
         Bcemxy1EqDEMaRUipXHcZuzq8+rVxq0VgP0ozHOk6lA7+BvjMtMm9LPisdLXk2O2Y4/P
         XZjy0+LvOTsyayu38mcbJPdg8jNROf2kvPnJhXOorJ66X6rFtgGoZ3Xu4gFn/nANI2s9
         jUeFxe+bwo/79wvEHS9x8B8rUWDx6JivTNdj0ZfVvX6Gn3APPQsoRh1wCK6YJRC2laLU
         XCQgLz2pgSDqF9djV32Gny8ChB8ZIaf3l8bx7DaD/Ph8DJfAHEHN1/aSFtgTkKjbP46Q
         85Ew==
X-Received: by 10.182.246.35 with SMTP id xt3mr15542083obc.39.1397157338654;
        Thu, 10 Apr 2014 12:15:38 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ii8sm8370274obb.11.2014.04.10.12.15.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Apr 2014 12:15:35 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc1
In-Reply-To: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246047>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/revisions.txt |  4 ++++
 sha1_name.c                 | 49 ++++++++++++++++++++++++++++-----------------
 t/t1508-at-combinations.sh  |  5 +++++
 3 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 5a286d0..fd01cb4 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -96,6 +96,10 @@ some output processing may assume ref names in UTF-8.
   refers to the branch that the branch specified by branchname is set to build on
   top of.  A missing branchname defaults to the current one.
 
+'<branchname>@\{publish\}', e.g. 'master@\{publish\}', '@\{p\}'::
+  The suffix '@\{publish\}' to a branchname refers to the remote branch to
+  push to. A missing branchname defaults to the current one.
+
 '<rev>{caret}', e.g. 'HEAD{caret}, v1.5.1{caret}0'::
   A suffix '{caret}' to a revision parameter means the first parent of
   that commit object.  '{caret}<n>' means the <n>th parent (i.e.
diff --git a/sha1_name.c b/sha1_name.c
index aa3f3e0..a36852d 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -415,9 +415,9 @@ static int ambiguous_path(const char *path, int len)
 	return slash;
 }
 
-static inline int upstream_mark(const char *string, int len)
+static inline int tracking_mark(const char *string, int len)
 {
-	const char *suffix[] = { "upstream", "u" };
+	const char *suffix[] = { "upstream", "u", "publish", "p" };
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(suffix); i++) {
@@ -475,7 +475,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 					nth_prior = 1;
 					continue;
 				}
-				if (!upstream_mark(str + at + 2, len - at - 3)) {
+				if (!tracking_mark(str + at + 2, len - at - 3)) {
 					reflog_len = (len-1) - (at+2);
 					len = at;
 				}
@@ -1057,10 +1057,11 @@ static void set_shortened_ref(struct strbuf *buf, const char *ref)
 	free(s);
 }
 
-static const char *get_upstream_branch(const char *name_buf, int len)
+static const char *get_tracking_branch(const char *name_buf, int len, char type)
 {
 	char *name = xstrndup(name_buf, len);
 	struct branch *branch = branch_get(*name ? name : NULL);
+	char *tracking = NULL;
 
 	/*
 	 * Upstream can be NULL only if branch refers to HEAD and HEAD
@@ -1068,23 +1069,35 @@ static const char *get_upstream_branch(const char *name_buf, int len)
 	 */
 	if (!branch)
 		die(_("HEAD does not point to a branch"));
-	if (!branch->merge || !branch->merge[0]->dst) {
-		if (!ref_exists(branch->refname))
-			die(_("No such branch: '%s'"), name);
-		if (!branch->merge) {
-			die(_("No upstream configured for branch '%s'"),
-				branch->name);
+	switch (type) {
+	case 'u':
+		if (!branch->merge || !branch->merge[0]->dst) {
+			if (!ref_exists(branch->refname))
+				die(_("No such branch: '%s'"), name);
+			if (!branch->merge) {
+				die(_("No upstream configured for branch '%s'"),
+					branch->name);
+			}
+			die(
+				_("Upstream branch '%s' not stored as a remote-tracking branch"),
+				branch->merge[0]->src);
+		}
+		tracking = branch->merge[0]->dst;
+		break;
+	case 'p':
+		if (!branch->push.dst) {
+			die(_("No publish configured for branch '%s'"),
+					branch->name);
 		}
-		die(
-			_("Upstream branch '%s' not stored as a remote-tracking branch"),
-			branch->merge[0]->src);
+		tracking = branch->push.dst;
+		break;
 	}
 	free(name);
 
-	return branch->merge[0]->dst;
+	return tracking;
 }
 
-static int interpret_upstream_mark(const char *name, int namelen,
+static int interpret_tracking_mark(const char *name, int namelen,
 				   int at, struct strbuf *buf)
 {
 	int len;
@@ -1092,14 +1105,14 @@ static int interpret_upstream_mark(const char *name, int namelen,
 	if (name[at + 1] != '{' || name[namelen - 1] != '}')
 		return -1;
 
-	len = upstream_mark(name + at + 2, namelen - at - 3);
+	len = tracking_mark(name + at + 2, namelen - at - 3);
 	if (!len)
 		return -1;
 
 	if (memchr(name, ':', at))
 		return -1;
 
-	set_shortened_ref(buf, get_upstream_branch(name, at));
+	set_shortened_ref(buf, get_tracking_branch(name, at, name[at + 2]));
 	return len + at + 3;
 }
 
@@ -1150,7 +1163,7 @@ int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
 		if (len > 0)
 			return reinterpret(name, namelen, len, buf);
 
-		len = interpret_upstream_mark(name, namelen, at - name, buf);
+		len = interpret_tracking_mark(name, namelen, at - name, buf);
 		if (len > 0)
 			return len;
 	}
diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index 078e119..f67aab3 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -32,6 +32,7 @@ fail() {
 test_expect_success 'setup' '
 	test_commit master-one &&
 	test_commit master-two &&
+	git checkout -b publish-branch &&
 	git checkout -b upstream-branch &&
 	test_commit upstream-one &&
 	test_commit upstream-two &&
@@ -46,6 +47,7 @@ test_expect_success 'setup' '
 	test_commit new-two &&
 	git branch -u master old-branch &&
 	git branch -u upstream-branch new-branch
+	git branch -p publish-branch new-branch
 '
 
 check HEAD ref refs/heads/new-branch
@@ -61,8 +63,11 @@ check "HEAD@{u}" ref refs/heads/upstream-branch
 check "@{u}@{1}" commit upstream-one
 check "@{-1}@{u}" ref refs/heads/master
 check "@{-1}@{u}@{1}" commit master-one
+check "@{p}" ref refs/heads/publish-branch
+check "HEAD@{p}" ref refs/heads/publish-branch
 check "@" commit new-two
 check "@@{u}" ref refs/heads/upstream-branch
+check "@@{p}" ref refs/heads/publish-branch
 check "@@/at-test" ref refs/heads/@@/at-test
 check "@/at-test" ref refs/heads/@/at-test
 check "@at-test" ref refs/heads/@at-test
-- 
1.9.1+fc1
