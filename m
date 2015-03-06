From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] log: decorate detached HEAD differently
Date: Fri,  6 Mar 2015 17:15:16 +0100
Message-ID: <015d6992d2c2165045117f763d9ce3131979c2db.1425658434.git.git@drmicha.warpmail.net>
References: <CAPc5daWz-Xa7q6f9RzgTP4has8DcCG4QgK7SMGNbH6KGnEyr2Q@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Julien Cretel <j.cretel@umail.ucc.ie>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 17:15:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTuuK-0001Dx-H9
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 17:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbbCFQPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 11:15:19 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40642 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751430AbbCFQPS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2015 11:15:18 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 95D3920A5D
	for <git@vger.kernel.org>; Fri,  6 Mar 2015 11:15:16 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Fri, 06 Mar 2015 11:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=qfBFZdygfsyjPm
	i6GobfgPv6U9U=; b=jDAphVPQt3MSxnMRFzK6QYMgmmbbUbYr0vLtJt+GxJR02U
	13BwVaLFiAqPiVlEfK8wBdog72AylQM90P2G67gH5vUXfW04iPu+zMw3+VCwdIB9
	+wexyT/NDMOdwV4qQ+sNl/6JQDLkmU5+db4PhG669omVpF5AFLtFO+dARRthQ=
X-Sasl-enc: hksHVYvaPNKMRZUAwSKL9HRR4RF/bcxPCTkMH8MN/lek 1425658517
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 4E7E3C002A5;
	Fri,  6 Mar 2015 11:15:17 -0500 (EST)
X-Mailer: git-send-email 2.3.1.303.g5174db1
In-Reply-To: <CAPc5daWz-Xa7q6f9RzgTP4has8DcCG4QgK7SMGNbH6KGnEyr2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264936>

"git status" and "git branch" let the user know when the HEAD is
detached, as well as the current branch, while "git log --decorate" does not.

Change the decoration by a non-detached HEAD pointing to branch foo to
"HEAD->foo". This can be seen as giving more information about the
decoration item itself in the same way as we prefix tags by "tag: ".

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---

Notes:
    v2 decorates the HEAD pointing to master as "HEAD->master", a detached
    HEAD just as "HEAD". The "->" hopefully conveys the symlink nature - a
    "=" would be confusing.
    
    Somehow I still prefer "detached HEAD", dunno. Maybe in addition?
    
    Note that now a checked branch is listed twice, once as target of the
    HEAD, once as branch: They are two different refs and colored differently.

 log-tree.c                             | 8 +++++++-
 t/t4013/diff.log_--decorate=full_--all | 2 +-
 t/t4013/diff.log_--decorate_--all      | 2 +-
 t/t4207-log-decoration-colors.sh       | 2 +-
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 7f0890e..38862bb 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -118,8 +118,11 @@ static int add_ref_decoration(const char *refname, const unsigned char *sha1, in
 		type = DECORATION_REF_TAG;
 	else if (!strcmp(refname, "refs/stash"))
 		type = DECORATION_REF_STASH;
-	else if (!strcmp(refname, "HEAD"))
+	else if (!strcmp(refname, "HEAD")) {
+		unsigned char junk_sha1[20];
 		type = DECORATION_REF_HEAD;
+		refname = resolve_ref_unsafe("HEAD", 0, junk_sha1, NULL);
+	}
 
 	if (!cb_data || *(int *)cb_data == DECORATE_SHORT_REFS)
 		refname = prettify_refname(refname);
@@ -198,6 +201,9 @@ void format_decorations_extended(struct strbuf *sb,
 		strbuf_addstr(sb, decorate_get_color(use_color, decoration->type));
 		if (decoration->type == DECORATION_REF_TAG)
 			strbuf_addstr(sb, "tag: ");
+		else if (decoration->type == DECORATION_REF_HEAD &&
+			 strcmp(decoration->name, "HEAD"))
+			strbuf_addstr(sb, "HEAD->");
 		strbuf_addstr(sb, decoration->name);
 		strbuf_addstr(sb, color_reset);
 		prefix = separator;
diff --git a/t/t4013/diff.log_--decorate=full_--all b/t/t4013/diff.log_--decorate=full_--all
index 44d4525..3758ae9 100644
--- a/t/t4013/diff.log_--decorate=full_--all
+++ b/t/t4013/diff.log_--decorate=full_--all
@@ -5,7 +5,7 @@ Date:   Mon Jun 26 00:06:00 2006 +0000
 
     Rearranged lines in dir/sub
 
-commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD, refs/heads/master)
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD->refs/heads/master, refs/heads/master)
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
diff --git a/t/t4013/diff.log_--decorate_--all b/t/t4013/diff.log_--decorate_--all
index 27d3eab..df702ae 100644
--- a/t/t4013/diff.log_--decorate_--all
+++ b/t/t4013/diff.log_--decorate_--all
@@ -5,7 +5,7 @@ Date:   Mon Jun 26 00:06:00 2006 +0000
 
     Rearranged lines in dir/sub
 
-commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD, master)
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD->master, master)
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index 925f577..0437ff2 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -44,7 +44,7 @@ test_expect_success setup '
 '
 
 cat >expected <<EOF
-${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_HEAD}HEAD${c_reset}${c_commit},\
+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_HEAD}HEAD->master${c_reset}${c_commit},\
  ${c_tag}tag: v1.0${c_reset}${c_commit},\
  ${c_tag}tag: B${c_reset}${c_commit},\
  ${c_branch}master${c_reset}${c_commit})${c_reset} B
-- 
2.3.1.303.g5174db1
