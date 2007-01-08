From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] --utf8 is now default for 'git-am'
Date: Mon, 08 Jan 2007 13:59:29 -0800
Message-ID: <7vlkkduqm6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jan 08 22:59:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H42Wr-0006Vy-GG
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 22:59:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbXAHV7c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 16:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbXAHV7c
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 16:59:32 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:54238 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964916AbXAHV7a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 16:59:30 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070108215930.XHQF16632.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Mon, 8 Jan 2007 16:59:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 8lyg1W00P1kojtg0000000; Mon, 08 Jan 2007 16:58:40 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36283>

Since we are talking about allowing potentially incompatible UI
changes in v1.5.0 iff the change improves the general situation,
I would say why not.

There is --no-utf8 flag to avoid re-coding from botching the log
message just in case, but we may not even need it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/git-am.txt |   19 ++++++++++++++++---
 git-am.sh                |    8 +++++---
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 910457d..53e81cb 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -9,7 +9,7 @@ git-am - Apply a series of patches in a mailbox
 SYNOPSIS
 --------
 [verse]
-'git-am' [--signoff] [--dotest=<dir>] [--utf8] [--binary] [--3way]
+'git-am' [--signoff] [--dotest=<dir>] [--utf8 | --no-utf8] [--binary] [--3way]
          [--interactive] [--whitespace=<option>] <mbox>...
 'git-am' [--skip | --resolved]
 
@@ -29,8 +29,21 @@ OPTIONS
 	Instead of `.dotest` directory, use <dir> as a working
 	area to store extracted patches.
 
---utf8, --keep::
-	Pass `-u` and `-k` flags to `git-mailinfo` (see
+--keep::
+	Pass `-k` flag to `git-mailinfo` (see gitlink:git-mailinfo[1]).
+
+--utf8::
+	Pass `-u` flag to `git-mailinfo` (see gitlink:git-mailinfo[1]).
+	The proposed commit log message taken from the e-mail
+	are re-coded into UTF-8 encoding (configuration variable
+	`i18n.commitencoding` can be used to specify project's
+	preferred encoding if it is not UTF-8).
++
+This was optional in prior versions of git, but now it is the
+default.   You could use `--no-utf8` to override this.
+
+--no-utf8::
+	Do not pass `-u` flag to `git-mailinfo` (see
 	gitlink:git-mailinfo[1]).
 
 --binary::
diff --git a/git-am.sh b/git-am.sh
index 7c0bb60..d9eb79d 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -2,7 +2,7 @@
 #
 # Copyright (c) 2005, 2006 Junio C Hamano
 
-USAGE='[--signoff] [--dotest=<dir>] [--utf8] [--binary] [--3way]
+USAGE='[--signoff] [--dotest=<dir>] [--utf8 | --no-utf8] [--binary] [--3way]
   [--interactive] [--whitespace=<option>] <mbox>...
   or, when resuming [--skip | --resolved]'
 . git-sh-setup
@@ -105,7 +105,7 @@ It does not apply to blobs recorded in its index."
 }
 
 prec=4
-dotest=.dotest sign= utf8= keep= skip= interactive= resolved= binary= ws= resolvemsg=
+dotest=.dotest sign= utf8=t keep= skip= interactive= resolved= binary= ws= resolvemsg=
 
 while case "$#" in 0) break;; esac
 do
@@ -128,7 +128,9 @@ do
 	-s|--s|--si|--sig|--sign|--signo|--signof|--signoff)
 	sign=t; shift ;;
 	-u|--u|--ut|--utf|--utf8)
-	utf8=t; shift ;;
+	shift ;; # this is now default
+	--no-u|--no-ut|--no-utf|--no-utf8)
+	utf8=; shift ;;
 	-k|--k|--ke|--kee|--keep)
 	keep=t; shift ;;
 
