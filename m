From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v2 10/11] test-lib: make it possible to override how test code is eval'd
Date: Wed,  4 Jun 2014 17:01:26 -0400
Message-ID: <1401915687-8602-11-git-send-email-rhansen@bbn.com>
References: <1401176460-31564-1-git-send-email-rhansen@bbn.com>
 <1401915687-8602-1-git-send-email-rhansen@bbn.com>
Cc: rhansen@bbn.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 23:02:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsIK8-0005VM-8H
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 23:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbaFDVCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 17:02:04 -0400
Received: from smtp.bbn.com ([128.33.0.80]:30036 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339AbaFDVCB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 17:02:01 -0400
Received: from socket.bbn.com ([192.1.120.102]:34542)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WsIJs-000IYY-Dx; Wed, 04 Jun 2014 17:02:00 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 399803FFFC
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1401915687-8602-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250790>

If a command named 'test_eval_override' exists, use it instead of
'eval' to run the test code.

This is needed to support zsh test cases:  test-lib.sh must be sourced
in sh emulation mode due to fundamental incompatibilities between the
POSIX sh language and the zsh language.  When a function is defined
while zsh is emulating some shell, zsh notes the shell that is being
emulated and records it along with the function definition.  This
enables zsh to temporarily re-enable the shell emulation mode whenever
the function is called, allowing zsh scripts to mix and match code
written for different shell languages.  (This description of zsh shell
emulation is not completely accurate, but it's close enough.)

Because test_eval_ is defined while zsh is in sh emulation mode, the
shell code passed as an argument to test_expect_success would normally
be evaluated in sh emulation mode.  However, with this change, it is
now possible to evaluate the test code in zsh mode by adding the
following line to a zsh-based test script:

    emulate -R zsh -c 'test_eval_override () { eval "$*"; }'

With test_eval_override defined in zsh emulation mode, the call to
test_eval_override from test_eval_ will temporarily cause zsh to
switch from sh emulation mode to zsh emulation mode.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 t/test-lib.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index c081668..3779634 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -414,7 +414,12 @@ maybe_setup_valgrind () {
 test_eval_ () {
 	# This is a separate function because some tests use
 	# "return" to end a test_expect_success block early.
-	eval </dev/null >&3 2>&4 "$*"
+	if command -v test_eval_override >/dev/null 2>&1
+	then
+		test_eval_override "$*"
+	else
+		eval "$*"
+	fi </dev/null >&3 2>&4
 }
 
 test_run_ () {
-- 
2.0.0
