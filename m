From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git-rebase fails when a commit message contains a diff
Date: Thu, 08 Nov 2007 18:18:39 -0800
Message-ID: <7v640cxitc.fsf@gitster.siamese.dyndns.org>
References: <20071109011214.GA5903@diku.dk>
	<7vlk98xkm3.fsf@gitster.siamese.dyndns.org>
	<7vhcjwxk1s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Nov 09 03:19:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqJSa-0004N7-Bt
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 03:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758104AbXKICSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 21:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758686AbXKICSr
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 21:18:47 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:47272 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103AbXKICSr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 21:18:47 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id DBEA22FB;
	Thu,  8 Nov 2007 21:19:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 0404C93B0B;
	Thu,  8 Nov 2007 21:19:02 -0500 (EST)
In-Reply-To: <7vhcjwxk1s.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 08 Nov 2007 17:51:59 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64116>

I wonder if this is a sensible thing to do, regardless of the
issue of commit log message that contains anything.

The patch replaces git-rebase with git-rebase--interactive.  The
only difference from the existing "git-rebase -i" is if the
command is called without "-i" the initial "here is the to-do
list. please rearrange the lines, modify 'pick' to 'edit' or
whatever as appropriate" step is done without letting the user
edit the list.

---

 Makefile                                    |    2 +-
 git-rebase--interactive.sh => git-rebase.sh |   14 ++++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 0d5590f..f0e5e38 100644
--- a/Makefile
+++ b/Makefile
@@ -214,7 +214,7 @@ SCRIPT_SH = \
 	git-clean.sh git-clone.sh git-commit.sh \
 	git-ls-remote.sh \
 	git-merge-one-file.sh git-mergetool.sh git-parse-remote.sh \
-	git-pull.sh git-rebase.sh git-rebase--interactive.sh \
+	git-pull.sh git-rebase.sh \
 	git-repack.sh git-request-pull.sh \
 	git-sh-setup.sh \
 	git-am.sh \
diff --git a/git-rebase--interactive.sh b/git-rebase.sh
similarity index 98%
rename from git-rebase--interactive.sh
rename to git-rebase.sh
index 76dc679..1dd6f6d 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase.sh
@@ -11,7 +11,7 @@
 # http://article.gmane.org/gmane.comp.version-control.git/22407
 
 USAGE='(--continue | --abort | --skip | [--preserve-merges] [--verbose]
-	[--onto <branch>] <upstream> [<branch>])'
+	[--interactive] [--onto <branch>] <upstream> [<branch>])'
 
 . git-sh-setup
 require_work_tree
@@ -25,6 +25,7 @@ REWRITTEN="$DOTEST"/rewritten
 PRESERVE_MERGES=
 STRATEGY=
 VERBOSE=
+INTERACTIVE=
 test -d "$REWRITTEN" && PRESERVE_MERGES=t
 test -f "$DOTEST"/strategy && STRATEGY="$(cat "$DOTEST"/strategy)"
 test -f "$DOTEST"/verbose && VERBOSE=t
@@ -346,6 +347,9 @@ do_rest () {
 while test $# != 0
 do
 	case "$1" in
+	--interactive|-i)
+		INTERACTIVE=t
+		;;
 	--continue)
 		comment_for_reflog continue
 
@@ -504,9 +508,11 @@ EOF
 			die_abort "Nothing to do"
 
 		cp "$TODO" "$TODO".backup
-		git_editor "$TODO" ||
-			die "Could not execute editor"
-
+		case "$INTERACTIVE" in
+		t)
+			git_editor "$TODO" || die "Could not execute editor"
+			;;
+		esac
 		has_action "$TODO" ||
 			die_abort "Nothing to do"
 
