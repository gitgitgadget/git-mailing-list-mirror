From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH] branch: name detached HEAD analogous to status
Date: Sun, 22 Feb 2015 18:38:20 +0100
Message-ID: <71fc137d8015f6e81ab91cfcbcad4ec0fa0dc3e6.1424626271.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 22 18:38:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPaU8-0004wx-S0
	for gcvg-git-2@plane.gmane.org; Sun, 22 Feb 2015 18:38:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090AbbBVRiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2015 12:38:24 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54594 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752047AbbBVRiX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Feb 2015 12:38:23 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id DAD4C2061D
	for <git@vger.kernel.org>; Sun, 22 Feb 2015 12:38:21 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Sun, 22 Feb 2015 12:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:subject:date
	:message-id; s=smtpout; bh=15aVO7CjqTgDQaCSHYwrStCEmdw=; b=UyI89
	nldGGAKfYpc3tr9wM0WTOsshlnEFkgWESzvdfcDL0Z2XLUP2d4hohyIQ5bXvN+Ky
	u40gBZOezmaTdPGHKggnSGk5oFbLI++vwNkocSKCA6g4lWpTaTIGNJTm8UiZCwNw
	KgbWUSqXV/66JksksNvoYjsFYI78h/AuYNA/78=
X-Sasl-enc: vwIlA2G6mE4zoUWWtlnu0QD902Xt6MIycHZYGoWszuUv 1424626702
Received: from localhost (unknown [188.96.118.84])
	by mail.messagingengine.com (Postfix) with ESMTPA id 1AF4268012D;
	Sun, 22 Feb 2015 12:38:21 -0500 (EST)
X-Mailer: git-send-email 2.3.0.296.g32c87e1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264232>

"git status" carefully names a detached HEAD "at" resp. "from" a rev or
ref depending on whether the detached HEAD has moved since. "git branch"
always uses "from", which can be confusing, because a status-aware user
would interpret this as moved detached HEAD.

Make "git branch" use the same logic and wording.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---

Notes:
    The wording is still different:
    
    HEAD detached at %s
    * (detached at %s)
    
    for status (line 1) resp. branch (line 2). Maybe it's worthwhile to use the
    exact same string so that l10n output is guaranteed to be the same? E.g.
    
    a)
    HEAD detached at %s
    * (HEAD detached at %s)
    
    or
    b)
    HEAD (detached at %s)
    * (detached at %s)
    
    In case b), "git status" strings would need to change, in case a)
    only "git branch" strings which change anyway by this patch.

 builtin/branch.c         | 13 ++++++++++---
 t/t3203-branch-output.sh | 39 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index d8949cb..be391ee 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -589,9 +589,16 @@ static char *get_head_description(void)
 	else if (state.bisect_in_progress)
 		strbuf_addf(&desc, _("(no branch, bisect started on %s)"),
 			    state.branch);
-	else if (state.detached_from)
-		strbuf_addf(&desc, _("(detached from %s)"),
-			    state.detached_from);
+	else if (state.detached_from) {
+		unsigned char sha1[20];
+		if (!get_sha1("HEAD", sha1) &&
+		    !hashcmp(sha1, state.detached_sha1))
+			strbuf_addf(&desc, _("(detached at %s)"),
+				state.detached_from);
+		else
+			strbuf_addf(&desc, _("(detached from %s)"),
+				state.detached_from);
+	}
 	else
 		strbuf_addstr(&desc, _("(no branch)"));
 	free(state.branch);
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index ba4f98e..aaff885 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -96,7 +96,7 @@ test_expect_success 'git branch -v pattern does not show branch summaries' '
 
 test_expect_success 'git branch shows detached HEAD properly' '
 	cat >expect <<EOF &&
-* (detached from $(git rev-parse --short HEAD^0))
+* (detached at $(git rev-parse --short HEAD^0))
   branch-one
   branch-two
   master
@@ -106,4 +106,41 @@ EOF
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'git branch shows detached HEAD properly after moving' '
+	cat >expect <<EOF &&
+* (detached from $(git rev-parse --short HEAD))
+  branch-one
+  branch-two
+  master
+EOF
+	git reset --hard HEAD^1 &&
+	git branch >actual &&
+	test_i18ncmp expect actual
+'
+
+test_expect_success 'git branch shows detached HEAD properly from tag' '
+	cat >expect <<EOF &&
+* (detached at fromtag)
+  branch-one
+  branch-two
+  master
+EOF
+	git tag fromtag master &&
+	git checkout fromtag &&
+	git branch >actual &&
+	test_i18ncmp expect actual
+'
+
+test_expect_success 'git branch shows detached HEAD properly after moving from tag' '
+	cat >expect <<EOF &&
+* (detached from fromtag)
+  branch-one
+  branch-two
+  master
+EOF
+	git reset --hard HEAD^1 &&
+	git branch >actual &&
+	test_i18ncmp expect actual
+'
+
 test_done
-- 
2.3.0.296.g32c87e1
