From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] diff --check: do not unconditionally complain about trailing
 empty lines
Date: Mon, 11 Aug 2008 22:21:43 -0700
Message-ID: <7vabfist94.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 07:23:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSmLM-0006YR-QY
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 07:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbYHLFVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 01:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbYHLFVu
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 01:21:50 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54592 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbYHLFVu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 01:21:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2E3F356989;
	Tue, 12 Aug 2008 01:21:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EDAC656988; Tue, 12 Aug 2008 01:21:45 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9068065E-682E-11DD-BF52-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92068>

Recently "git diff --check" learned to detect new trailing blank lines
just like "git apply --whitespace" does.  However this check should not
trigger unconditionally.  This patch makes it honor the whitespace
settings from core.whitespace and gitattributes.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c                  |    3 ++-
 t/t4019-diff-wserror.sh |   21 ++++++++++++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 8746c60..6954f99 100644
--- a/diff.c
+++ b/diff.c
@@ -1631,7 +1631,8 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 		ecb.priv = &data;
 		xdi_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
 
-		if (data.trailing_blanks_start) {
+		if ((data.ws_rule & WS_TRAILING_SPACE) &&
+		    data.trailing_blanks_start) {
 			fprintf(o->file, "%s:%d: ends with blank lines.\n",
 				data.filename, data.trailing_blanks_start);
 			data.status = 1; /* report errors */
diff --git a/t/t4019-diff-wserror.sh b/t/t4019-diff-wserror.sh
index 0d9cbb6..dfa11f6 100755
--- a/t/t4019-diff-wserror.sh
+++ b/t/t4019-diff-wserror.sh
@@ -13,7 +13,8 @@ test_expect_success setup '
 	echo " 	HT and SP indent" >>F &&
 	echo "With trailing SP " >>F &&
 	echo "Carriage ReturnQ" | tr Q "\015" >>F &&
-	echo "No problem" >>F
+	echo "No problem" >>F &&
+	echo >>F
 
 '
 
@@ -160,4 +161,21 @@ test_expect_success 'with cr-at-eol (attribute)' '
 
 '
 
+test_expect_success 'trailing empty lines (1)' '
+
+	rm -f .gitattributes &&
+	test_must_fail git diff --check >output &&
+	grep "ends with blank lines." output &&
+	grep "trailing whitespace" output
+
+'
+
+test_expect_success 'trailing empty lines (2)' '
+
+	echo "F -whitespace" >.gitattributes &&
+	git diff --check >output &&
+	! test -s output
+
+'
+
 test_done
