From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 78/86] builtin/show-branch: replace prefixcmd() with
 has_prefix()
Date: Sat, 09 Nov 2013 08:07:11 +0100
Message-ID: <20131109070720.18178.42384.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:15:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2lN-0001Sp-TS
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:15:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758692Ab3KIHPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:15:03 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:37733 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933459Ab3KIHOW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:14:22 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id A950D96;
	Sat,  9 Nov 2013 08:14:21 +0100 (CET)
X-git-sha1: f183272dfb3ef631d1841b34b2b09951ad709be5 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237557>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/show-branch.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 001f29c..dc0b406 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -285,7 +285,7 @@ static void show_one_commit(struct commit *commit, int no_name)
 		pp_commit_easy(CMIT_FMT_ONELINE, commit, &pretty);
 		pretty_str = pretty.buf;
 	}
-	if (!prefixcmp(pretty_str, "[PATCH] "))
+	if (has_prefix(pretty_str, "[PATCH] "))
 		pretty_str += 8;
 
 	if (!no_name) {
@@ -396,7 +396,7 @@ static int append_head_ref(const char *refname, const unsigned char *sha1, int f
 {
 	unsigned char tmp[20];
 	int ofs = 11;
-	if (prefixcmp(refname, "refs/heads/"))
+	if (!has_prefix(refname, "refs/heads/"))
 		return 0;
 	/* If both heads/foo and tags/foo exists, get_sha1 would
 	 * get confused.
@@ -410,7 +410,7 @@ static int append_remote_ref(const char *refname, const unsigned char *sha1, int
 {
 	unsigned char tmp[20];
 	int ofs = 13;
-	if (prefixcmp(refname, "refs/remotes/"))
+	if (!has_prefix(refname, "refs/remotes/"))
 		return 0;
 	/* If both heads/foo and tags/foo exists, get_sha1 would
 	 * get confused.
@@ -422,7 +422,7 @@ static int append_remote_ref(const char *refname, const unsigned char *sha1, int
 
 static int append_tag_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
-	if (prefixcmp(refname, "refs/tags/"))
+	if (!has_prefix(refname, "refs/tags/"))
 		return 0;
 	return append_ref(refname + 5, sha1, 0);
 }
@@ -453,9 +453,9 @@ static int append_matching_ref(const char *refname, const unsigned char *sha1, i
 		return 0;
 	if (fnmatch(match_ref_pattern, tail, 0))
 		return 0;
-	if (!prefixcmp(refname, "refs/heads/"))
+	if (has_prefix(refname, "refs/heads/"))
 		return append_head_ref(refname, sha1, flag, cb_data);
-	if (!prefixcmp(refname, "refs/tags/"))
+	if (has_prefix(refname, "refs/tags/"))
 		return append_tag_ref(refname, sha1, flag, cb_data);
 	return append_ref(refname, sha1, 0);
 }
@@ -480,11 +480,11 @@ static int rev_is_head(char *head, int headlen, char *name,
 	if ((!head[0]) ||
 	    (head_sha1 && sha1 && hashcmp(head_sha1, sha1)))
 		return 0;
-	if (!prefixcmp(head, "refs/heads/"))
+	if (has_prefix(head, "refs/heads/"))
 		head += 11;
-	if (!prefixcmp(name, "refs/heads/"))
+	if (has_prefix(name, "refs/heads/"))
 		name += 11;
-	else if (!prefixcmp(name, "heads/"))
+	else if (has_prefix(name, "heads/"))
 		name += 6;
 	return !strcmp(head, name);
 }
@@ -813,7 +813,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				has_head++;
 		}
 		if (!has_head) {
-			int offset = !prefixcmp(head, "refs/heads/") ? 11 : 0;
+			int offset = has_prefix(head, "refs/heads/") ? 11 : 0;
 			append_one_rev(head + offset);
 		}
 	}
-- 
1.8.4.1.566.geca833c
