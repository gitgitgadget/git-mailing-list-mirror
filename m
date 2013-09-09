From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] rebase: fix run_specific_rebase's use of "return" on FreeBSD
Date: Mon,  9 Sep 2013 10:53:15 +0200
Message-ID: <1378716795-5420-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: avg@FreeBSD.org, christoph.mallon@gmx.de,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Sep 09 10:53:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIxE2-0004bv-7l
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 10:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161Ab3IIIxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 04:53:34 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37136 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750960Ab3IIIxd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 04:53:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r898rG9T009921
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 9 Sep 2013 10:53:16 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VIxDh-0004d3-Ka; Mon, 09 Sep 2013 10:53:17 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VIxDh-0001Q9-9r; Mon, 09 Sep 2013 10:53:17 +0200
X-Mailer: git-send-email 1.8.4.5.g8688bea
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 09 Sep 2013 10:53:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r898rG9T009921
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1379321602.13079@jj00hbDWJmOxU6HkVqQrDw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234318>

Since a1549e10, git-rebase--am.sh uses the shell's "return" statement, to
mean "return from the current file inclusion", which is POSIXly correct,
but badly interpreted on FreeBSD, which returns from the current
function, hence skips the finish_rebase statement that follows the file
inclusion.

Make the use of "return" portable by using the file inclusion as the last
statement of a function.

Reported-by: Christoph Mallon <christoph.mallon@gmx.de>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
I sent the patch inline in a conversation and got no feedback.
Resending as a proper patch.

 git-rebase.sh | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 8d7659a..226752f 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -167,13 +167,22 @@ You can run "git stash pop" or "git stash drop" at any time.
 	rm -rf "$state_dir"
 }
 
-run_specific_rebase () {
+run_specific_rebase_internal () {
 	if [ "$interactive_rebase" = implied ]; then
 		GIT_EDITOR=:
 		export GIT_EDITOR
 		autosquash=
 	fi
+	# On FreeBSD, the shell's "return" returns from the current
+	# function, not from the current file inclusion.
+	# run_specific_rebase_internal has the file inclusion as a
+	# last statement, so POSIX and FreeBSD's return will do the
+	# same thing.
 	. git-rebase--$type
+}
+
+run_specific_rebase () {
+	run_specific_rebase_internal
 	ret=$?
 	if test $ret -eq 0
 	then
-- 
1.8.4.5.g8688bea
