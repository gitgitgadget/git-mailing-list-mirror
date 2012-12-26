From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] merge-tree: add comments to clarify what these functions
 are doing
Date: Wed, 26 Dec 2012 15:03:39 -0800
Message-ID: <1356563020-13919-5-git-send-email-gitster@pobox.com>
References: <1356563020-13919-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 27 00:04:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1To01F-0007FV-Mm
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 00:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497Ab2LZXDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 18:03:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33967 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142Ab2LZXDv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 18:03:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5D3CA329
	for <git@vger.kernel.org>; Wed, 26 Dec 2012 18:03:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=pPd3
	MIQvNFh1F6Entei6het3YDA=; b=c5MrEGgI2foxHDS62z1MtwBMbDMwzczuih+1
	zPC8CCFe0kv1paaaF+sAE4wSvG+UGI5RAJLPxyTLjoMlIPI4TNkCZt9SZXnd1ukz
	lX+CUPcHxdNlLJ21UjkkdaKBpWMPNuHJ6WWH3h1bXb6u9ATWsT126XJy3zN4ubeq
	vCcVEbM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=qxvzUE
	mnlt58YE7KlilRb8KHbKae52b9ooE87h35UQtzkpk22VutDTsdMXA36fPypzeRk5
	OLkDmITs7LCbwJ7WPtcgqmCFbWBKaoPpZ4CNZijULL1kbATcD0bGERBYuBmKAitt
	GXUoxrBdEYeN3sgzDNIXJiVpKJVk4XJ9R9dIo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4841A328
	for <git@vger.kernel.org>; Wed, 26 Dec 2012 18:03:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D4E1A327 for
 <git@vger.kernel.org>; Wed, 26 Dec 2012 18:03:50 -0500 (EST)
X-Mailer: git-send-email 1.8.1.rc3.356.g686f81c
In-Reply-To: <1356563020-13919-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 82C4193E-4FB0-11E2-859F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212164>

Rename the "branch1" parameter given to resolve() to "ours", to
clarify what is going on.  Also, annotate the unresolved_directory()
function with some comments to show what decisions are made in each
step, and highlight two bugs that need to be fixed.

Add two tests to t4300 to illustrate these bugs.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge-tree.c  | 26 ++++++++++++++++++++++----
 t/t4300-merge-tree.sh | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 95de162..5704d51 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -172,17 +172,17 @@ static char *traverse_path(const struct traverse_info *info, const struct name_e
 	return make_traverse_path(path, info, n);
 }
 
-static void resolve(const struct traverse_info *info, struct name_entry *branch1, struct name_entry *result)
+static void resolve(const struct traverse_info *info, struct name_entry *ours, struct name_entry *result)
 {
 	struct merge_list *orig, *final;
 	const char *path;
 
-	/* If it's already branch1, don't bother showing it */
-	if (!branch1)
+	/* If it's already ours, don't bother showing it */
+	if (!ours)
 		return;
 
 	path = traverse_path(info, result);
-	orig = create_entry(2, branch1->mode, branch1->sha1, path);
+	orig = create_entry(2, ours->mode, ours->sha1, path);
 	final = create_entry(0, result->mode, result->sha1, path);
 
 	final->link = orig;
@@ -205,6 +205,15 @@ static int unresolved_directory(const struct traverse_info *info, struct name_en
 	}
 	if (!S_ISDIR(p->mode))
 		return 0;
+	/*
+	 * NEEDSWORK: this is broken. The path can originally be a file
+	 * and then one side may have turned it into a directory, in which
+	 * case we return and let the three-way merge as if the tree were
+	 * a regular file.  If the path that was originally a tree is
+	 * now a file in either branch, fill_tree_descriptor() below will
+	 * die when fed a blob sha1.
+	 */
+
 	newbase = traverse_path(info, p);
 	buf0 = fill_tree_descriptor(t+0, n[0].sha1);
 	buf1 = fill_tree_descriptor(t+1, n[1].sha1);
@@ -288,20 +297,29 @@ static int threeway_callback(int n, unsigned long mask, unsigned long dirmask, s
 	/* Same in both? */
 	if (same_entry(entry+1, entry+2)) {
 		if (entry[0].sha1) {
+			/* Modified identically */
 			resolve(info, NULL, entry+1);
 			return mask;
 		}
+		/* "Both added the same" is left unresolved */
 	}
 
 	if (same_entry(entry+0, entry+1)) {
 		if (entry[2].sha1 && !S_ISDIR(entry[2].mode)) {
+			/* We did not touch, they modified -- take theirs */
 			resolve(info, entry+1, entry+2);
 			return mask;
 		}
+		/*
+		 * If we did not touch a directory but they made it
+		 * into a file, we fall through and unresolved()
+		 * recurses down.  Likewise for the opposite case.
+		 */
 	}
 
 	if (same_entry(entry+0, entry+2)) {
 		if (entry[1].sha1 && !S_ISDIR(entry[1].mode)) {
+			/* We modified, they did not touch -- take ours */
 			resolve(info, NULL, entry+1);
 			return mask;
 		}
diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
index 46c3fe7..03e8fca 100755
--- a/t/t4300-merge-tree.sh
+++ b/t/t4300-merge-tree.sh
@@ -254,4 +254,48 @@ EXPECTED
 	test_cmp expected actual
 '
 
+test_expect_failure 'turn file to tree' '
+	git reset --hard initial &&
+	rm initial-file &&
+	mkdir initial-file &&
+	test_commit "turn-file-to-tree" "initial-file/ONE" "CCC" &&
+	git merge-tree initial initial turn-file-to-tree >actual &&
+	cat >expect <<-\EOF &&
+	added in remote
+	  their  100644 43aa4fdec31eb92e1fdc2f0ce6ea9ddb7c32bcf7 initial-file/ONE
+	@@ -0,0 +1 @@
+	+CCC
+	removed in remote
+	  base   100644 e79c5e8f964493290a409888d5413a737e8e5dd5 initial-file
+	  our    100644 e79c5e8f964493290a409888d5413a737e8e5dd5 initial-file
+	@@ -1 +0,0 @@
+	-initial
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_failure 'turn tree to file' '
+	git reset --hard initial &&
+	mkdir dir &&
+	test_commit "add-tree" "dir/path" "AAA" &&
+	test_commit "add-another-tree" "dir/another" "BBB" &&
+	rm -fr dir &&
+	test_commit "make-file" "dir" "CCC" &&
+	git merge-tree add-tree add-another-tree make-file >actual &&
+	cat >expect <<-\EOF &&
+	added in local
+	  our    100644 ba629238ca89489f2b350e196ca445e09d8bb834 dir/another
+	removed in remote
+	  base   100644 43d5a8ed6ef6c00ff775008633f95787d088285d dir/path
+	  our    100644 43d5a8ed6ef6c00ff775008633f95787d088285d dir/path
+	@@ -1 +0,0 @@
+	-AAA
+	added in remote
+	  their  100644 43aa4fdec31eb92e1fdc2f0ce6ea9ddb7c32bcf7 dir
+	@@ -0,0 +1 @@
+	+CCC
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.1.rc3.356.g686f81c
