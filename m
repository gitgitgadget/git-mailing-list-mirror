From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 10/10] git p4 test: fix badp4dir test
Date: Wed, 27 Jun 2012 08:01:03 -0400
Message-ID: <1340798463-14499-11-git-send-email-pw@padd.com>
References: <1340798463-14499-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 14:04:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sjqz1-0007Jw-DO
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 14:04:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086Ab2F0ME2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 08:04:28 -0400
Received: from honk.padd.com ([74.3.171.149]:57620 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755458Ab2F0ME1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 08:04:27 -0400
Received: from arf.padd.com (unknown [50.55.159.91])
	by honk.padd.com (Postfix) with ESMTPSA id 14277D02;
	Wed, 27 Jun 2012 05:04:27 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 6F3B431383; Wed, 27 Jun 2012 08:04:24 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.130.gb957a79
In-Reply-To: <1340798463-14499-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200723>

The construct used to get the return code was flawed, in that
errors in the &&-chain before the semicolon were not caught.  Use
the standard test_expect_code instead.

Set PATH in a subshell instead of relying on the bashism of
setting it just for a single command.

And fix the grep line so it doesn't worry about grep segfaults,
and doesn't fail for i18n issues.

Reported-by: Johannes Sixt <j.sixt@viscovery.net>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9800-git-p4-basic.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index befd823..07c2e15 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -134,9 +134,13 @@ test_expect_success 'exit when p4 fails to produce marshaled output' '
 	exit 1
 	EOF
 	chmod 755 badp4dir/p4 &&
-	PATH="$TRASH_DIRECTORY/badp4dir:$PATH" git p4 clone --dest="$git" //depot >errs 2>&1 ; retval=$? &&
-	test $retval -eq 1 &&
-	test_must_fail grep -q Traceback errs
+	(
+		PATH="$TRASH_DIRECTORY/badp4dir:$PATH" &&
+		export PATH &&
+		test_expect_code 1 git p4 clone --dest="$git" //depot >errs 2>&1
+	) &&
+	cat errs &&
+	! test_i18ngrep Traceback errs
 '
 
 test_expect_success 'clone bare' '
-- 
1.7.11.1.69.gd505fd2
