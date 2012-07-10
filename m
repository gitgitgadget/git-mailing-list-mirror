From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 11/19] apply: accept -3/--3way command line option
Date: Tue, 10 Jul 2012 00:04:04 -0700
Message-ID: <1341903852-4815-12-git-send-email-gitster@pobox.com>
References: <1341903852-4815-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 09:05:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoUVY-0000bE-6A
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 09:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151Ab2GJHEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 03:04:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53232 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754141Ab2GJHEq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 03:04:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B67987DEB
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=2/xL
	hpcWFPUN9Z9WgDxPJJLGBv8=; b=xspHvu3m2tEZIN05fLZd1vSYhEaBVJfJuqyv
	REr8Mqxy+Qe4wgePxrK3msdVlsuGgRR0DrzKUD3X4eFjP8a5pXO/Gqjxzedv+NHK
	8QVvG4sSmJ9tRHkZohqYA/xUlkpvpl98wQpsedFKK7Lp5o/yf6lnjLiWH8kUI4U8
	TZ2u6d4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=DBLNKc
	zmPrBqFK/5o4rz2KsJRg1dkP0gtPagwWeJKvgv+p7+f00kN/sHLG/rC2pVnHopTI
	U4VVo+3ybUg2aeams9hBIoC1msjiJWxdTpXW6mpZljjq5+FAImCzRnlVYlIJS/og
	Hi3pUBFQ0l3n9zsrzjG2P0iTanm600a0BnLc4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD55D7DEA
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2552C7DE9 for
 <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:45 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.294.g68a9409
In-Reply-To: <1341903852-4815-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 877BA894-CA5D-11E1-A6E6-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201247>

Begin teaching the three-way merge fallback logic "git am -3" uses
to the underlying "git apply".  It only implements the command line
parsing part, and does not do anything interesting yet, other than
making sure that "--reject" and "--3way" are not given together, and
making "--3way" imply "--index".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c         | 25 +++++++++++++++++++++++--
 t/t4117-apply-reject.sh |  8 ++++++++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 7379687..51b695b 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -46,6 +46,7 @@ static int apply_with_reject;
 static int apply_verbosely;
 static int allow_overlap;
 static int no_add;
+static int threeway;
 static const char *fake_ancestor;
 static int line_termination = '\n';
 static unsigned int p_context = UINT_MAX;
@@ -3139,6 +3140,12 @@ static int load_preimage(struct image *image,
 	return 0;
 }
 
+static int try_threeway(struct image *image, struct patch *patch,
+			struct stat *st, struct cache_entry *ce)
+{
+	return -1; /* for now */
+}
+
 static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *ce)
 {
 	struct image image;
@@ -3146,8 +3153,11 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
 	if (load_preimage(&image, patch, st, ce) < 0)
 		return -1;
 
-	if (apply_fragments(&image, patch) < 0)
-		return -1; /* note with --reject this succeeds. */
+	if (apply_fragments(&image, patch) < 0) {
+		/* Note: with --reject, apply_fragments() returns 0 */
+		if (!threeway || try_threeway(&image, patch, st, ce) < 0)
+			return -1;
+	}
 	patch->result = image.buf;
 	patch->resultsize = image.len;
 	add_to_fn_table(patch);
@@ -4079,6 +4089,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			"apply a patch without touching the working tree"),
 		OPT_BOOLEAN(0, "apply", &force_apply,
 			"also apply the patch (use with --stat/--summary/--check)"),
+		OPT_BOOL('3', "3way", &threeway,
+			 "attempt three-way merge if a patch does not apply"),
 		OPT_FILENAME(0, "build-fake-ancestor", &fake_ancestor,
 			"build a temporary index based on embedded index information"),
 		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
@@ -4127,6 +4139,15 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	argc = parse_options(argc, argv, prefix, builtin_apply_options,
 			apply_usage, 0);
 
+	if (apply_with_reject && threeway)
+		die("--reject and --3way cannot be used together.");
+	if (cached && threeway)
+		die("--cached and --3way cannot be used together.");
+	if (threeway) {
+		if (is_not_gitdir)
+			die(_("--3way outside a repository"));
+		check_index = 1;
+	}
 	if (apply_with_reject)
 		apply = apply_verbosely = 1;
 	if (!force_apply && (diffstat || numstat || summary || check || fake_ancestor))
diff --git a/t/t4117-apply-reject.sh b/t/t4117-apply-reject.sh
index e9ccd16..8e15ecb 100755
--- a/t/t4117-apply-reject.sh
+++ b/t/t4117-apply-reject.sh
@@ -46,6 +46,14 @@ test_expect_success setup '
 	cat file1 >saved.file1
 '
 
+test_expect_success 'apply --reject is incompatible with --3way' '
+	test_when_finished "cat saved.file1 >file1" &&
+	git diff >patch.0 &&
+	git checkout file1 &&
+	test_must_fail git apply --reject --3way patch.0 &&
+	git diff --exit-code
+'
+
 test_expect_success 'apply without --reject should fail' '
 
 	if git apply patch.1
-- 
1.7.11.1.294.g68a9409
