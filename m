From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] commit-tree: update the command line parsing
Date: Wed,  9 Nov 2011 13:01:33 -0800
Message-ID: <1320872495-7545-2-git-send-email-gitster@pobox.com>
References: <1320872495-7545-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 22:01:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROFHI-0000X7-Ck
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 22:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756783Ab1KIVBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Nov 2011 16:01:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46875 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753104Ab1KIVBj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 16:01:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F4C76596
	for <git@vger.kernel.org>; Wed,  9 Nov 2011 16:01:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=9hR6
	7+icl76Ca6eXuQwPQwrCYeg=; b=MEIgG37afpL48qaf4oC3fVwdtILdE6TPTGE8
	KF/Ckke1K9KYFN7yfzvz9VwAtT51jN9ReX6Somo7EfX68nHQUghYe5cwtwhTdXEG
	uoLgiH3K6ti3ZUJU6+ydeu6kXLLSniR75vJz/jxiuW9OVtx3oRG1usa+yeJkT5jw
	Wf/2rms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=nEVTwH
	44gs0iouzgTXluDlcYN34GKvsmHqR+EPbHIXsF6fSIsmGJ3Ncsf+NmL2sBAdLJvR
	swFzjTpdkBXaDjl0VNPmcPlTxWgNVi2bNUUT7gj/OFYAjzu5EgnLD0bAOT/I/8qE
	7JTzUtztYTJA4PHLZG5K7hUs6GgjTclG35aE8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 174076595
	for <git@vger.kernel.org>; Wed,  9 Nov 2011 16:01:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F2266594 for
 <git@vger.kernel.org>; Wed,  9 Nov 2011 16:01:38 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc1.82.gde0f9
In-Reply-To: <1320872495-7545-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 044498A2-0B16-11E1-AD8E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185169>

We have kept the original "git commit-tree <tree> -p <parent> ..." syntax
forever, but "git commit-tree -p <parent> -p <parent> ... <tree>" would be
more intuitive way to spell it. Dashed flags along with their arguments
come first and then the "thing" argument after the flags.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit-tree.c |   31 ++++++++++++++++++-------------
 1 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index d083795..92cfbaf 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -27,7 +27,7 @@ static void new_parent(struct commit *parent, struct commit_list **parents_p)
 
 int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 {
-	int i;
+	int i, got_tree = 0;
 	struct commit_list *parents = NULL;
 	unsigned char tree_sha1[20];
 	unsigned char commit_sha1[20];
@@ -37,20 +37,25 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 
 	if (argc < 2 || !strcmp(argv[1], "-h"))
 		usage(commit_tree_usage);
-	if (get_sha1(argv[1], tree_sha1))
-		die("Not a valid object name %s", argv[1]);
 
-	for (i = 2; i < argc; i += 2) {
-		unsigned char sha1[20];
-		const char *a, *b;
-		a = argv[i]; b = argv[i+1];
-		if (!b || strcmp(a, "-p"))
-			usage(commit_tree_usage);
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		if (!strcmp(arg, "-p")) {
+			unsigned char sha1[20];
+			if (argc <= ++i)
+				usage(commit_tree_usage);
+			if (get_sha1(argv[i], sha1))
+				die("Not a valid object name %s", argv[i]);
+			assert_sha1_type(sha1, OBJ_COMMIT);
+			new_parent(lookup_commit(sha1), &parents);
+			continue;
+		}
 
-		if (get_sha1(b, sha1))
-			die("Not a valid object name %s", b);
-		assert_sha1_type(sha1, OBJ_COMMIT);
-		new_parent(lookup_commit(sha1), &parents);
+		if (get_sha1(arg, tree_sha1))
+			die("Not a valid object name %s", arg);
+		if (got_tree)
+			die("Cannot give more than one trees");
+		got_tree = 1;
 	}
 
 	if (strbuf_read(&buffer, 0, 0) < 0)
-- 
1.7.8.rc1.82.gde0f9
