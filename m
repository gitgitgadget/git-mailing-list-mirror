From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 2/2] branch: name detached HEAD analogous to status
Date: Fri,  6 Mar 2015 16:04:07 +0100
Message-ID: <0ece5e04a3fb38bdc1201036d65ed98199758ba5.1425653932.git.git@drmicha.warpmail.net>
References: <54EB4579.3000103@xiplink.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 16:04:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTtna-0002gy-Qr
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 16:04:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699AbbCFPEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 10:04:15 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:59173 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754239AbbCFPEM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2015 10:04:12 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 96AC9209BD
	for <git@vger.kernel.org>; Fri,  6 Mar 2015 10:04:10 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Fri, 06 Mar 2015 10:04:11 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references:in-reply-to:references; s=
	smtpout; bh=iJxicPU9ewhh2PcsxPCzFRr24mI=; b=eqh2A2WjgL1PCUkXpa/Z
	lgA3vwhYhJEEZva1QDCI6i77ZLXXg/7EwoN4Ab22aTiHCHmR06pjEg0+lFZE6jjx
	UvUQw0efKrW/Onfillpc43lG+sS60svP/EDf3WMnzWay5ZTKM9U7SB7riW5ZtJSK
	81UrGB1wThtmsWe3XNDwTPc=
X-Sasl-enc: 4OR9xoJ61y8tjVxdcWqeuOtgPOp7BFNt0mK1xTdouXUe 1425654251
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 75C1668017B;
	Fri,  6 Mar 2015 10:04:11 -0500 (EST)
X-Mailer: git-send-email 2.3.1.303.g5174db1
In-Reply-To: <54EB4579.3000103@xiplink.com>
In-Reply-To: <cover.1425653932.git.git@drmicha.warpmail.net>
References: <cover.1425653932.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264927>

"git status" carefully names a detached HEAD "at" resp. "from" a rev or
ref depending on whether the detached HEAD has moved since. "git branch"
always uses "from", which can be confusing, because a status-aware user
would interpret this as moved detached HEAD.

Make "git branch" use the same logic and wording.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---

Notes:
    v2 uses the info from refactored wt-status.
    
    In addition, it tries to make sure that branch and status use the same
    strings:
    
    HEAD detached at %s
    * (HEAD detached at %s)
    
    (status first line, branch second line)
    
    Unfortunately, status strings are broken into pieces, so this can
    be achieved by comments only.

 builtin/branch.c         | 13 ++++++++++---
 t/t3203-branch-output.sh | 39 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index d8949cb..4c54240 100644
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
+		/* TRANSLATORS: make sure these match _("HEAD detached at ")
+		   and _("HEAD detached from ") in wt-status.c */
+		if (state.detached_at)
+			strbuf_addf(&desc, _("(HEAD detached at %s)"),
+				state.detached_from);
+		else
+			strbuf_addf(&desc, _("(HEAD detached from %s)"),
+				state.detached_from);
+	}
 	else
 		strbuf_addstr(&desc, _("(no branch)"));
 	free(state.branch);
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index ba4f98e..f51d0f3 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -96,7 +96,7 @@ test_expect_success 'git branch -v pattern does not show branch summaries' '
 
 test_expect_success 'git branch shows detached HEAD properly' '
 	cat >expect <<EOF &&
-* (detached from $(git rev-parse --short HEAD^0))
+* (HEAD detached at $(git rev-parse --short HEAD^0))
   branch-one
   branch-two
   master
@@ -106,4 +106,41 @@ EOF
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'git branch shows detached HEAD properly after moving' '
+	cat >expect <<EOF &&
+* (HEAD detached from $(git rev-parse --short HEAD))
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
+* (HEAD detached at fromtag)
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
+* (HEAD detached from fromtag)
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
2.3.1.303.g5174db1
