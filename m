From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/9] apply: accept -3/--3way command line option
Date: Thu, 10 May 2012 15:32:48 -0700
Message-ID: <1336689173-15822-5-git-send-email-gitster@pobox.com>
References: <1336689173-15822-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 00:33:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSbvY-0006Py-J4
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 00:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561Ab2EJWdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 18:33:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36672 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932534Ab2EJWdC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 18:33:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 668D08430
	for <git@vger.kernel.org>; Thu, 10 May 2012 18:33:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=TyIP
	sjU3gm2pSe+PX7DRcJWOYRE=; b=nlrGgaHFB9MBP2xhbAkBLO+l5mbsoluiQgti
	04cRinPkNjQ4N1+tXLeMj2y9X4yZJeLRLqAlAtKuZYZ+iDspeDz86YpnL7VyWqUh
	mKayLRIU/qB+b5+xRr8FkGgPs7ku5H0heU42Sukna48CzhIJ5K3ssUCUYkokMtss
	kwyRO4U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=oA/z5y
	j3PUmTdd/rc7qSXK667IA8cwt9z0ERQtV5/Q3ItQckObKYG4Ga2u4Mc61FF6w6rt
	0vNWL9tay6EptFVAOxdF5n0OiWfCAM0uQS91QVLkPK4fW3yePW173+ay7Fc6Nlu4
	U/i7TrgBEaHnQ5hdclQXZ1kj7B6ayIbGYqo1I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E866842F
	for <git@vger.kernel.org>; Thu, 10 May 2012 18:33:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D13D6842D for
 <git@vger.kernel.org>; Thu, 10 May 2012 18:33:01 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.1.574.g840b38f
In-Reply-To: <1336689173-15822-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1A1BA5FC-9AF0-11E1-A224-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197644>

This is the beginning of teaching the three-way merge fallback logic "git
am -3" uses to the underlying "git apply".  It only implements the command
line parsing part, and does not do anything interesting yet, other than
making sure that "--reject" and "--3way" are not given together.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c         | 19 +++++++++++++++++--
 t/t4117-apply-reject.sh |  8 ++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 2a31023..fcd5bdf 100644
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
@@ -3072,6 +3073,12 @@ static int load_preimage(struct image *image,
 	return 0;
 }
 
+static int try_threeway_fallback(struct image *image, struct patch *patch,
+				 struct stat *st, struct cache_entry *ce)
+{
+	return -1; /* for now */
+}
+
 static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *ce)
 {
 	struct image image;
@@ -3079,8 +3086,11 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
 	if (load_preimage(&image, patch, st, ce) < 0)
 		return -1;
 
-	if (apply_fragments(&image, patch) < 0)
-		return -1; /* note with --reject this succeeds. */
+	if (apply_fragments(&image, patch) < 0) {
+		/* Note: with --reject, the above call succeeds. */
+		if (!threeway || try_threeway_fallback(&image, patch, st, ce) < 0)
+			return -1;
+	}
 	patch->result = image.buf;
 	patch->resultsize = image.len;
 	add_to_fn_table(patch);
@@ -3992,6 +4002,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			"apply a patch without touching the working tree"),
 		OPT_BOOLEAN(0, "apply", &force_apply,
 			"also apply the patch (use with --stat/--summary/--check)"),
+		OPT_BOOL('3', "3way", &threeway,
+			 "attempt three-way merge if a patch does not apply"),
 		OPT_FILENAME(0, "build-fake-ancestor", &fake_ancestor,
 			"build a temporary index based on embedded index information"),
 		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
@@ -4040,6 +4052,9 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	argc = parse_options(argc, argv, prefix, builtin_apply_options,
 			apply_usage, 0);
 
+	if (apply_with_reject && threeway)
+		die("--reject and --3way cannot be used together.");
+
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
1.7.10.1.574.g840b38f
