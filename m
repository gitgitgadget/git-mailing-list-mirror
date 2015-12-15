From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 2/3] format-patch: add an option to suppress commit hash
Date: Tue, 15 Dec 2015 01:52:04 +0000
Message-ID: <1450144325-182108-3-git-send-email-sandals@crustytoothpaste.net>
References: <1450144325-182108-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Stefan Beller <stefanbeller@gmail.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 15 02:52:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8emr-0000KK-TO
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 02:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933034AbbLOBwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 20:52:16 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47214 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932695AbbLOBwO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2015 20:52:14 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id CF5BB282CC;
	Tue, 15 Dec 2015 01:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1450144331;
	bh=G4UzrBCfJLNM9dhmsfjyf8nfeolj8/Qz5NJP/wWoEIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=adMTiWQIEoQFzxxerMTiXcOyzIvXY6h+3DCshP04lmXGKK4R4evBR4wQ/7NQ0Ac0V
	 yP9LOGDyAKMCnzudW0ck/9eumITcFFIIOaWLiwZr39fZ43F5Z+XHl+nMKimJAFa4Pv
	 fzA9xbbU0ND1NEOYBUrkL9XANXDSMxXF0q9H9Cuh/cIlWtAEll8uNBiArkPZiKIv9t
	 zqwujFGNAG/8heEDJT+GunqRDuOFDDV3TE1RM5PUu4Iljnz1exxJvmixz/j8QMjq5t
	 y/2hhAXMGIFOszVKU9+8NYWHtDcfVMGzACFS/ZiG0Ozg0U56zLOKH23lKwXmSqpjYc
	 1l2Zd67OFMjlzJzarkBdUpLieW5DbuD5XIztvO7g/RBxkTAYOAa9DyLtmzBfOMJGgY
	 kzmenvlvfzpH0KCwSF5jUeQLtKxHIKKRrmQw8EHzkvdK4lJuhE01YQkh3PyjoFnTx3
	 OJZKJ6l8N3xJDjoF1Y07qX9uMiJ0FJ7kGd7IAnBxq2snvfRONRD
X-Mailer: git-send-email 2.7.0.rc0.173.g4a846af
In-Reply-To: <1450144325-182108-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.49 ALL_TRUSTED,BAYES_00,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282462>

Oftentimes, patches created by git format-patch will be stored in
version control or compared with diff.  In these cases, two otherwise
identical patches can have different commit hashes, leading to diff
noise.  Teach git format-patch a --zero-commit option that instead
produces an all-zero hash to avoid this diff noise.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-format-patch.txt | 4 ++++
 builtin/log.c                      | 5 +++++
 log-tree.c                         | 3 ++-
 revision.h                         | 1 +
 t/t4014-format-patch.sh            | 7 +++++++
 5 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 40356491..e3cdaeb9 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -256,6 +256,10 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
 	using this option cannot be applied properly, but they are
 	still useful for code review.
 
+--zero-commit::
+  Output an all-zero hash in each patch's From header instead
+  of the hash of the commit.
+
 --root::
 	Treat the revision argument as a <revision range>, even if it
 	is just a single commit (that would normally be treated as a
diff --git a/builtin/log.c b/builtin/log.c
index 069bd3a9..e00cea75 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1196,6 +1196,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int cover_letter = -1;
 	int boundary_count = 0;
 	int no_binary_diff = 0;
+	int zero_commit = 0;
 	struct commit *origin = NULL;
 	const char *in_reply_to = NULL;
 	struct patch_ids ids;
@@ -1236,6 +1237,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    PARSE_OPT_NOARG | PARSE_OPT_NONEG, keep_callback },
 		OPT_BOOL(0, "no-binary", &no_binary_diff,
 			 N_("don't output binary diffs")),
+		OPT_BOOL(0, "zero-commit", &zero_commit,
+			 N_("output all-zero hash in From header")),
 		OPT_BOOL(0, "ignore-if-in-upstream", &ignore_if_in_upstream,
 			 N_("don't include a patch matching a commit upstream")),
 		{ OPTION_SET_INT, 'p', "no-stat", &use_patch_format, NULL,
@@ -1380,6 +1383,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	/* Always generate a patch */
 	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
 
+	rev.zero_commit = zero_commit;
+
 	if (!DIFF_OPT_TST(&rev.diffopt, TEXT) && !no_binary_diff)
 		DIFF_OPT_SET(&rev.diffopt, BINARY);
 
diff --git a/log-tree.c b/log-tree.c
index 35e78017..f70a30e1 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -342,7 +342,8 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 {
 	const char *subject = NULL;
 	const char *extra_headers = opt->extra_headers;
-	const char *name = oid_to_hex(&commit->object.oid);
+	const char *name = oid_to_hex(opt->zero_commit ?
+				      &null_oid : &commit->object.oid);
 
 	*need_8bit_cte_p = 0; /* unknown */
 	if (opt->total > 0) {
diff --git a/revision.h b/revision.h
index 5bc96868..23857c0e 100644
--- a/revision.h
+++ b/revision.h
@@ -135,6 +135,7 @@ struct rev_info {
 			pretty_given:1,
 			abbrev_commit:1,
 			abbrev_commit_given:1,
+			zero_commit:1,
 			use_terminator:1,
 			missing_newline:1,
 			date_mode_explicit:1,
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 890db117..2737ca63 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1431,4 +1431,11 @@ test_expect_success 'cover letter auto user override' '
 	test_line_count = 2 list
 '
 
+test_expect_success 'format-patch --zero-commit' '
+	git format-patch --zero-commit --stdout v2..v1 >patch2 &&
+	grep "^From " patch2 | sort | uniq >actual &&
+	echo "From $_z40 Mon Sep 17 00:00:00 2001" >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.7.0.rc0.194.g1187e4e.dirty
