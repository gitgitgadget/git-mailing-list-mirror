From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 2/2] Report errors when failing to launch the html browser in mingw.
Date: Wed, 17 Mar 2010 15:20:03 +0000
Message-ID: <87aau7dkon.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 17 16:36:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrvIe-0007Hi-Pk
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 16:36:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732Ab0CQPgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 11:36:43 -0400
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:46767 "EHLO
	smtp-out2.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752298Ab0CQPgn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Mar 2010 11:36:43 -0400
Received: from [172.23.170.140] (helo=anti-virus02-07)
	by smtp-out2.blueyonder.co.uk with smtp (Exim 4.52)
	id 1NrvIX-0004aA-Qm; Wed, 17 Mar 2010 15:36:41 +0000
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out3.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1NrvIX-0001Zo-8v; Wed, 17 Mar 2010 15:36:41 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id CE666217A8; Wed, 17 Mar 2010 15:36:40 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142401>

The mingw function to launch the system html browser is silent if the
target file does not exist leaving the user confused. Make it display
something.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 compat/mingw.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 9c10a4c..d6539ef 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1548,6 +1548,7 @@ void mingw_open_html(const char *unixpath)
 			const char *, const char *, const char *, INT);
 	T ShellExecute;
 	HMODULE shell32;
+	int r;
 
 	shell32 = LoadLibrary("shell32.dll");
 	if (!shell32)
@@ -1557,9 +1558,11 @@ void mingw_open_html(const char *unixpath)
 		die("cannot run browser");
 
 	printf("Launching default browser to display HTML ...\n");
-	ShellExecute(NULL, "open", htmlpath, NULL, "\\", 0);
-
+	r = (int)ShellExecute(NULL, "open", htmlpath, NULL, "\\", SW_SHOWNORMAL);
 	FreeLibrary(shell32);
+	if (r < 33) {
+		die("failed to launch browser for %.*s", MAX_PATH, unixpath);
+	}
 }
 
 int link(const char *oldpath, const char *newpath)
-- 
1.7.0.2.msysgit.0.3.g3c992.dirty
