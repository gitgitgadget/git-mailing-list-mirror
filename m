From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/9] apply --whitespace=fix: fix handling of blank lines at
 the eof
Date: Fri,  4 Sep 2009 03:55:10 -0700
Message-ID: <1252061718-11579-2-git-send-email-gitster@pobox.com>
References: <1252061718-11579-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 04 12:55:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjWSC-0003iL-Rc
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 12:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756721AbZIDKz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 06:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755965AbZIDKz0
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 06:55:26 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61027 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755785AbZIDKzX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 06:55:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F0BE625EEA
	for <git@vger.kernel.org>; Fri,  4 Sep 2009 06:55:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=hyPh
	PC0zc5yb88PlxaDar9Bouxk=; b=gu8W5EdrfRMynSm3uHydOTfH4Rto60qxePbf
	HDncDSFE1znuHwU76y1LEgxOIWCC0vuEuFOxIb2RizuairuJc90WR4NFwdfH4Fn/
	jsbb49Q3ws3squO7/33rg1yDB47HniOza8GaoVQUqQvQ1Cm0kKIhGIeMHP3zlPSA
	aPXDSfg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=CVtsFM
	TGEphxrLKO8nWoAxXXcXF3udqlIv3biH+j8eES3cIcLYpNgWJWacQo06iE5R0Xda
	3pQCMXQpurZIxrdLurZSlQd/GpjJRPV+xkqOg1IEIP+Pah/SgSSrlxhcqPyGE6aW
	xJ2kRoR/fpE/AgO7QT0qKyC7K6X7g4Vw1m8ro=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ED95525EE9
	for <git@vger.kernel.org>; Fri,  4 Sep 2009 06:55:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6BD2E25EE8 for
 <git@vger.kernel.org>; Fri,  4 Sep 2009 06:55:25 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.2.313.g0425f
In-Reply-To: <1252061718-11579-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 739FE6E6-9941-11DE-82A7-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127714>

b94f2ed (builtin-apply.c: make it more line oriented, 2008-01-26) broke
the logic used to detect if a hunk adds blank lines at the end of the
file.  With the new code after that commit:

 - img holds the contents of the file that the hunk is being applied to;

 - preimage has the lines the hunk expects to be in img; and

 - postimage has the lines the hunk wants to update the part in img that
   corresponds to preimage with.

and we need to compare if the last line of preimage (not postimage)
matches the last line of img to see if the hunk applies at the end of the
file.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-apply.c          |    2 +-
 t/t4124-apply-ws-rule.sh |   29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 7a1ff04..5b5bde4 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2069,7 +2069,7 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 	if (applied_pos >= 0) {
 		if (ws_error_action == correct_ws_error &&
 		    new_blank_lines_at_end &&
-		    postimage.nr + applied_pos == img->nr) {
+		    preimage.nr + applied_pos == img->nr) {
 			/*
 			 * If the patch application adds blank lines
 			 * at the end, and if the patch applies at the
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index f83322e..6898722 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -148,4 +148,33 @@ do
 	done
 done
 
+
+test_expect_success 'blank at EOF with --whitespace=fix (1)' '
+	: these can fail depending on what we did before
+	git config --unset core.whitespace
+	rm -f .gitattributes
+
+	{ echo a; echo b; echo c; } >one &&
+	git add one &&
+	{ echo a; echo b; echo c; } >expect &&
+	{ cat expect; echo; } >one &&
+	git diff -- one >patch &&
+
+	git checkout one &&
+	git apply --whitespace=fix patch &&
+	test_cmp expect one
+'
+
+test_expect_success 'blank at EOF with --whitespace=fix (2)' '
+	{ echo a; echo b; echo c; } >one &&
+	git add one &&
+	{ echo a; echo c; } >expect &&
+	{ cat expect; echo; echo; } >one &&
+	git diff -- one >patch &&
+
+	git checkout one &&
+	git apply --whitespace=fix patch &&
+	test_cmp expect one
+'
+
 test_done
-- 
1.6.4.2.313.g0425f
