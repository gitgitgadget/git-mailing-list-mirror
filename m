From: Jeff King <peff@peff.net>
Subject: [PATCH] bisect: visualize with git-log if gitk is unavailable
Date: Mon, 21 Mar 2011 09:14:22 -0400
Message-ID: <20110321131422.GA24382@sigill.intra.peff.net>
References: <AANLkTinS87obXcgbcFZ8L-UjZUQL96SzpHp84Y6-yX6v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Maxin john <maxin@maxinbjohn.info>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 14:14:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1ewJ-0002Cj-8T
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 14:14:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385Ab1CUNO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 09:14:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56935
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753334Ab1CUNOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 09:14:25 -0400
Received: (qmail 13550 invoked by uid 107); 21 Mar 2011 13:15:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 Mar 2011 09:15:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Mar 2011 09:14:22 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinS87obXcgbcFZ8L-UjZUQL96SzpHp84Y6-yX6v@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169593>

If gitk is not available in the PATH, bisect ends up
exiting with the shell's 127 error code, confusing the git
wrapper into thinking that bisect is not a git command.

We already fallback to git-log if there doesn't seem to be a
graphical display available. We should do the same if gitk
is not available in our PATH at all. This not only fixes the
ugly error message, but is a much more sensible default than
failing to show the user anything.

Reported by Maxin John.

Tested-by: Maxin B. John <maxin@maxinbjohn.info>
Signed-off-by: Jeff King <peff@peff.net>
---
 git-bisect.sh |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index c21e33c..415a8d0 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -288,10 +288,12 @@ bisect_visualize() {
 
 	if test $# = 0
 	then
-		case "${DISPLAY+set}${SESSIONNAME+set}${MSYSTEM+set}${SECURITYSESSIONID+set}" in
-		'')	set git log ;;
-		set*)	set gitk ;;
-		esac
+		if test -n "${DISPLAY+set}${SESSIONNAME+set}${MSYSTEM+set}${SECURITYSESSIONID+set}" &&
+		   type gitk >/dev/null 2>&1; then
+			set gitk
+		else
+			set git log
+		fi
 	else
 		case "$1" in
 		git*|tig) ;;
-- 
1.7.2.5.22.g853c5
