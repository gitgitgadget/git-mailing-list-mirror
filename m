From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] commit-tree: teach -x <extra>
Date: Wed,  9 Nov 2011 13:01:35 -0800
Message-ID: <1320872495-7545-4-git-send-email-gitster@pobox.com>
References: <1320872495-7545-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 22:01:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROFHJ-0000X7-FR
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 22:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756784Ab1KIVBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Nov 2011 16:01:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47015 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756785Ab1KIVBn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 16:01:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E11DA65AC
	for <git@vger.kernel.org>; Wed,  9 Nov 2011 16:01:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=zDLW
	dyqx1Mg2i//yll8zLyGQatU=; b=sIF8h2XNhT/ZaR8VGpgcLMbOzBVrla0ubHQL
	hPryKIkz5YdYHi4EGiqM2CV4BvFTO1tYFcg7wiq/yNjmQnct5qzSBIFVqVw9dpij
	L/xutQRDV7qH1kvb1SQhZO4CniyDZzEJsXPrURxUF7yJqTxm0zgobxfBBF8zCrMc
	z4gpv6g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=DZIVXS
	9iAmTF3RDgD+ERfmiL9DQJi0mCrn+mF/7vXahXaqDXr580rvdh5UHnEjyMpIzELR
	uJIha5FqTx8m9vN3soYrjQk32KeFmb6MKWZxecQHaAMfrry88ep9QMDArMCLV1tz
	C3wq0zin7OOJ5bdh3mRhSRLgyj3ge+XHF4aSY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D828A65AA
	for <git@vger.kernel.org>; Wed,  9 Nov 2011 16:01:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4DD4265A5 for
 <git@vger.kernel.org>; Wed,  9 Nov 2011 16:01:42 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc1.82.gde0f9
In-Reply-To: <1320872495-7545-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 067413F0-0B16-11E1-8814-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185167>

By feeding the header part of the original commit with this parameter,
e.g. -x "$(git cat-file commit $commit | sed -n -e /^$/q -e p)", extra
headers of another commit can be transplanted to the resulting commit.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-commit-tree.txt |    3 ++-
 builtin/commit-tree.c             |   20 ++++++++++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index cfb9906..060e79d 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git commit-tree' <tree> [(-p <parent>)...] < changelog
-'git commit-tree' [(-p <parent>)...] [(-m <message>)...] [(-F <file>)...] <tree>
+'git commit-tree' [(-p <parent>)...] [(-m <message>)...] [(-F <file>)...]
+    [(-x <extra>)...]<tree>
 
 DESCRIPTION
 -----------
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index db5b6e5..8b0a223 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -9,7 +9,7 @@
 #include "builtin.h"
 #include "utf8.h"
 
-static const char commit_tree_usage[] = "git commit-tree [(-p <sha1>)...] [-m <message>] <sha1> < changelog";
+static const char commit_tree_usage[] = "git commit-tree [(-p <sha1>)...] [-m <message>] [-x <extra>] <sha1> < changelog";
 
 static void new_parent(struct commit *parent, struct commit_list **parents_p)
 {
@@ -32,6 +32,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	unsigned char tree_sha1[20];
 	unsigned char commit_sha1[20];
 	struct strbuf buffer = STRBUF_INIT;
+	struct commit_extra_header *extra = NULL, **extra_tail = &extra;
 
 	git_config(git_default_config, NULL);
 
@@ -86,6 +87,20 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
+		if (!strcmp(arg, "-x")) {
+			struct commit_extra_header *x;
+			if (argc <= ++i)
+				usage(commit_tree_usage);
+			x = read_commit_extra_header_lines(argv[i], strlen(argv[i]));
+			if (x) {
+				*extra_tail = x;
+				while (x->next)
+					x = x->next;
+				extra_tail = &x->next;
+			}
+			continue;
+		}
+
 		if (get_sha1(arg, tree_sha1))
 			die("Not a valid object name %s", arg);
 		if (got_tree)
@@ -98,7 +113,8 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 			die_errno("git commit-tree: failed to read");
 	}
 
-	if (commit_tree(buffer.buf, tree_sha1, parents, commit_sha1, NULL)) {
+	if (commit_tree_extended(buffer.buf, tree_sha1, parents, commit_sha1,
+				 NULL, extra)) {
 		strbuf_release(&buffer);
 		return 1;
 	}
-- 
1.7.8.rc1.82.gde0f9
