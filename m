From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] merge: allow fast-forwarding to an annotated but
 unsigned tag
Date: Tue,  5 Jun 2012 12:58:32 -0700
Message-ID: <1338926312-4239-3-git-send-email-gitster@pobox.com>
References: <1338926312-4239-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 21:58:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbztx-0001tj-CS
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 21:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294Ab2FET6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 15:58:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56864 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751845Ab2FET6i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 15:58:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C3949FD1
	for <git@vger.kernel.org>; Tue,  5 Jun 2012 15:58:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=A1BR
	sLuwqreADgk5U1zsg+dxvrg=; b=fbEMo0ByQrGo8vV7Vnzlb7j+9lEW5M3Z4juD
	Ko1Vg0GqkDOkT5WWEx9CtaVXEGySup1PjcZsdaaHLCxM/VR4bXTYlu6p07ZOibSm
	nhPh1v5wKsJJmeNXdWhSHATFllZRUPiEqFyfaEaf/lzerblqIiTRCNN5NA5poW6l
	LSWwgNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=n/gXXb
	HVAh4ordhW1/dQAsk1JLGHWzqB7CrRsXFozDbhqPJscEI3ONd8mFzmWAr1E2dhwP
	IeqTPjgBBS/P1/UiP4XWLrAebxbJ9DCplWsZ0S9pP+qN4NhZTxj5yNlHRa59gsjV
	lGmI9k3ASG9EzFcOBGYDb7jZx/NIugt9l3th8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0410E9FCF
	for <git@vger.kernel.org>; Tue,  5 Jun 2012 15:58:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7257C9FCE for
 <git@vger.kernel.org>; Tue,  5 Jun 2012 15:58:37 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc1.37.g09843ac
In-Reply-To: <1338926312-4239-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D6D791C6-AF48-11E1-B124-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199285>

Update the merging_signed_tag() helper to check if the tag object
actually has a signature-looking string, so that we do not forbid
fast-forwarding to an annotated but unsigned tag.  By definition,
there will be no signed payload in such a tag to be moved to the
mergetag header, so we are not losing anything by fast-forwarding.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c  | 14 +++++++++++++-
 t/t7600-merge.sh | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 23389f2..82d343c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -28,6 +28,7 @@
 #include "remote.h"
 #include "fmt-merge-msg.h"
 #include "gpg-interface.h"
+#include "tag.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -1102,10 +1103,21 @@ static void write_merge_state(void)
 static int merging_signed_tag(struct commit *parent)
 {
 	struct merge_remote_desc *desc = merge_remote_util(parent);
+	unsigned long size;
+	enum object_type type;
+	char *buf;
+	size_t sig_offset;
 
 	if (!desc || !desc->obj || desc->obj->type != OBJ_TAG)
 		return 0;
-	return 1;
+
+	buf = read_sha1_file(desc->obj->sha1, &type, &size);
+	if (!buf || type != OBJ_TAG) {
+		free(buf);
+		return 0; /* error will be caught downstream */
+	}
+	sig_offset = parse_signature(buf, size);
+	return (sig_offset < size);
 }
 
 int cmd_merge(int argc, const char **argv, const char *prefix)
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 9e27bbf..3c48327 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -695,4 +695,42 @@ test_expect_success GPG 'merge --no-edit tag should skip editor' '
 	test_cmp actual expect
 '
 
+test_expect_success 'merge ff annotated tag should just ff' '
+	git reset --hard c0 &&
+	git commit --allow-empty -m "A newer commit" &&
+	git tag -a -m "An annotated tag" anno &&
+	git reset --hard c0 &&
+
+	# This should not even bother with an editor session; "false"
+	# will ensure that an attempt to run the editor is caught.
+	EDITOR=false git merge anno &&
+
+	git rev-parse anno^0 >expect &&
+	git rev-parse HEAD >actual &&
+	test_cmp actual expect &&
+
+	git rev-parse c0^0 >expect &&
+	git rev-parse HEAD^ >actual &&
+	test_cmp actual expect
+'
+
+test_expect_success 'merge --no-ff annotated tag' '
+	git reset --hard c0 &&
+	git commit --allow-empty -m "A newer commit" &&
+	git tag -f -a -m "An annotated tag" anno &&
+	git reset --hard c0 &&
+
+	EDITOR=./editor git merge --no-ff --edit anno &&
+	git rev-parse anno^0 >expect &&
+	git rev-parse HEAD^2 >actual &&
+	test_cmp actual expect &&
+
+	git rev-parse c0^0 >expect &&
+	git rev-parse HEAD^ >actual &&
+	test_cmp actual expect &&
+
+	git cat-file commit HEAD >raw &&
+	grep "An annotated tag" raw
+'
+
 test_done
-- 
1.7.11.rc1.37.g09843ac
