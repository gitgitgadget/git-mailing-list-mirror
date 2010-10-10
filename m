From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/3] bisect: improve error message of 'bisect log' while not
	bisecting
Date: Sun, 10 Oct 2010 23:48:56 +0200
Message-ID: <1286747338-8521-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 23:49:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P53lt-0006zp-26
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 23:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069Ab0JJVtZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Oct 2010 17:49:25 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:59279 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab0JJVtY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 17:49:24 -0400
Received: from [127.0.1.1] (p5B130D54.dip0.t-ipconnect.de [91.19.13.84])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0McAjL-1PNYDZ3ohj-00Jbe8; Sun, 10 Oct 2010 23:49:03 +0200
X-Mailer: git-send-email 1.7.3.1.148.g2fffa
X-Provags-ID: V02:K0:o5xTFrXQ5R5PZLLg53cY0V+djcTfcwGugL6/W41UA7a
 T7s9QRxJzNmL7KNvAGalDRXcqvfQfnq/Oiv3WmfLwXGzyDcCVM
 uEH/I96UzBvaTDNZK4WLUv5XaMpkej8tYyVFi6iB16cJH1G+DP
 GDCucyzcaXkrwdOrDFaJPG6J1vOS3YOA30LcaZLs8RhAru3s39
 zFwpguXziES95JWMfyncg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158720>

'git bisect log' is implemented by a direct invocation of 'cat
"$GIT_DIR/BISECT_LOG"', without any sanity checks.  Consequently,
running 'git bisect log' while not bisecting leads to an error,
because the bisect logfile doesn't exists.  The accompanying error
message

  cat: /path/to/repo/.git/BISECT_LOG: No such file or directory

is neither very helpful nor very friendly.

Instead of blindly trying to cat the log file, first check whether
there is a bisection going on (i.e. the bisect logfile exists), and
die with a more appropriate error message when not.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 git-bisect.sh |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 6e2acb8..3a4bf81 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -412,6 +412,10 @@ bisect_run () {
     done
 }
=20
+bisect_log () {
+	test -s "$GIT_DIR/BISECT_LOG" || die "We are not bisecting."
+	cat "$GIT_DIR/BISECT_LOG"
+}
=20
 case "$#" in
 0)
@@ -438,7 +442,7 @@ case "$#" in
     replay)
 	bisect_replay "$@" ;;
     log)
-	cat "$GIT_DIR/BISECT_LOG" ;;
+	bisect_log ;;
     run)
         bisect_run "$@" ;;
     *)
--=20
1.7.3.1.148.g2fffa
