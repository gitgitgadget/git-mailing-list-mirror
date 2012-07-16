From: Michael Schubert <mschub@elegosoft.com>
Subject: [PATCH 1/2] refs: disallow ref components starting with hyphen
Date: Mon, 16 Jul 2012 14:13:00 +0200
Message-ID: <1342440781-18816-2-git-send-email-mschub@elegosoft.com>
References: <1342440781-18816-1-git-send-email-mschub@elegosoft.com>
Cc: Michael Schubert <mschub@elegosoft.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 14:16:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqkDr-00077f-4W
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 14:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942Ab2GPMQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 08:16:15 -0400
Received: from schu.io ([178.77.73.177]:57307 "EHLO
	lvps178-77-73-177.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751182Ab2GPMQN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2012 08:16:13 -0400
Received: from myhost.elego.de (i59F7870A.versanet.de [89.247.135.10])
	by lvps178-77-73-177.dedicated.hosteurope.de (Postfix) with ESMTPSA id F095D14954001;
	Mon, 16 Jul 2012 14:16:12 +0200 (CEST)
X-Mailer: git-send-email 1.7.11.2.196.ga22866b
In-Reply-To: <1342440781-18816-1-git-send-email-mschub@elegosoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201514>

Currently, we allow refname components to start with a hyphen. There's
no good reason to do so and it troubles the parseopt infrastructure.
Explicitly refuse refname components starting with a hyphen inside
check_refname_component().

Revert 63486240, which is obsolete now.

Signed-off-by: Michael Schubert <mschub@elegosoft.com>
---
 builtin/tag.c | 3 ---
 refs.c        | 2 ++
 sha1_name.c   | 2 --
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 7b1be85..c99fb42 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -403,9 +403,6 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
 
 static int strbuf_check_tag_ref(struct strbuf *sb, const char *name)
 {
-	if (name[0] == '-')
-		return -1;
-
 	strbuf_reset(sb);
 	strbuf_addf(sb, "refs/tags/%s", name);
 
diff --git a/refs.c b/refs.c
index da74a2b..5714681 100644
--- a/refs.c
+++ b/refs.c
@@ -62,6 +62,8 @@ static int check_refname_component(const char *refname, int flags)
 		if (refname[1] == '\0')
 			return -1; /* Component equals ".". */
 	}
+	if (refname[0] == '-')
+		return -1; /* Component starts with '-'. */
 	if (cp - refname >= 5 && !memcmp(cp - 5, ".lock", 5))
 		return -1; /* Refname ends with ".lock". */
 	return cp - refname;
diff --git a/sha1_name.c b/sha1_name.c
index 5d81ea0..132d369 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -892,8 +892,6 @@ int strbuf_branchname(struct strbuf *sb, const char *name)
 int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
 {
 	strbuf_branchname(sb, name);
-	if (name[0] == '-')
-		return -1;
 	strbuf_splice(sb, 0, 0, "refs/heads/", 11);
 	return check_refname_format(sb->buf, 0);
 }
-- 
1.7.11.2.196.ga22866b
