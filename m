From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH try2] Improve error output of git-rebase
Date: Sun, 17 Aug 2008 06:05:30 +0200
Message-ID: <1218945930-29281-1-git-send-email-s-beyer@gmx.net>
References: <7v1w0ocqow.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 06:09:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUZZZ-0006RE-6P
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 06:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbYHQEFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 00:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbYHQEFg
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 00:05:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:37940 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750712AbYHQEFg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 00:05:36 -0400
Received: (qmail invoked by alias); 17 Aug 2008 04:05:34 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp030) with SMTP; 17 Aug 2008 06:05:34 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/9daMQRRP9/QmJXqF1LD4C2khXAlDBzrYcY4ovFK
	WZxtkZDvXEXmWg
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KUZWE-0007cf-Np; Sun, 17 Aug 2008 06:05:30 +0200
X-Mailer: git-send-email 1.6.0.rc3.18.g7aea
In-Reply-To: <7v1w0ocqow.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92568>

"git rebase" without arguments on initial startup showed:

	fatal: Needed a single revision
	invalid upstream

This patch makes it show the ordinary usage string.

If .git/rebase-apply exists, this patch tries to make the error message
slightly more exact:
 - if .git/rebase-apply/applying exists, the error message supposes that
   we are in the middle of git-am
 - if .git/rebase-apply/rebasing exists, it is perhaps another rebase.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
	Hi,

	Junio C Hamano wrote:
	> Stephan Beyer <s-beyer@gmx.net> writes:
	>~
	> > ^...Stumbled across this today and looks for me like
	> > ^...a patch for 1.6.0 :-)
	>~
	> Is presense of "$dotest" or "$GIT_DIR/rebase-apply" a _sure sign_ that
	> allows you to say "A rebase is in progress" with confidence?

	Currently this is a sure sign that either a git-rebase or a git-am is
	in progress.
	I considered the existence of .git/rebase-apply/applying and
	.git/rebase-apply/rebasing as a good way to determine which one it is
	if .git/rebase-apply exists.

	Also there already are two error messages that could be used, so I
	use them and are only a little more exact.

	Regards,
	  Stephan

 git-rebase.sh |   23 ++++++++++++++++-------
 1 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 412e135..850c58a 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -146,6 +146,10 @@ is_interactive () {
 
 is_interactive "$@" && exec git-rebase--interactive "$@"
 
+# If no arguments are given and there is no git-am/git-rebase in
+# progress, print the usage string and die.
+test $# -ne 0 -o -d "$dotest" -o -d "$GIT_DIR"/rebase-apply || usage
+
 while test $# != 0
 do
 	case "$1" in
@@ -265,19 +269,24 @@ do
 	shift
 done
 
-# Make sure we do not have $GIT_DIR/rebase-apply
+# Make sure we do not have $GIT_DIR/rebase-apply nor $dotest
 if test -z "$do_merge"
 then
-	if mkdir "$GIT_DIR"/rebase-apply
+	if mkdir "$GIT_DIR"/rebase-apply 2>/dev/null
 	then
 		rmdir "$GIT_DIR"/rebase-apply
 	else
+		what='a patch application or another rebase.'
+		test -f "$GIT_DIR"/rebase-apply/applying &&
+			what='a patch application (git-am).'
+		test -f "$GIT_DIR"/rebase-apply/rebasing &&
+			what='another rebase.'
 		echo >&2 '
-It seems that I cannot create a '"$GIT_DIR"'/rebase-apply directory,
-and I wonder if you are in the middle of patch application or another
-rebase.  If that is not the case, please
+It seems that I cannot create a rebase-apply directory, and I wonder
+if you are in the middle of '"$what"'
+If that is not the case, please
 	rm -fr '"$GIT_DIR"'/rebase-apply
- and run me again.  I am stopping in case you still have something
+and run me again.  I am stopping in case you still have something
 valuable there.'
 		exit 1
 	fi
@@ -285,7 +294,7 @@ else
 	if test -d "$dotest"
 	then
 		die "previous rebase directory $dotest still exists." \
-			'try git-rebase < --continue | --abort >'
+			'Try git-rebase (--continue | --abort | --skip)'
 	fi
 fi
 
-- 
1.6.0.rc3.312.ge6010a
