From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -i: move help to end of todo file
Date: Thu, 22 Nov 2007 12:30:10 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711221225570.27959@racer.site>
References: <7vlk8q7hzg.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0711221113360.27959@racer.site> <7vbq9m5wpa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 13:30:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvBCT-0005Bv-Ss
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 13:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbXKVMaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 07:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbXKVMaP
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 07:30:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:39930 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750719AbXKVMaO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 07:30:14 -0500
Received: (qmail invoked by alias); 22 Nov 2007 12:30:12 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp056) with SMTP; 22 Nov 2007 13:30:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18KwZY5Q4EK1fmSnp71lCB0JatZa60VUAYf8KZOB0
	43l2oStuxmVCib
X-X-Sender: gene099@racer.site
In-Reply-To: <7vbq9m5wpa.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65818>

Hi,

On Thu, 22 Nov 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > 	How about this?  I am hesitant to remove _everything_, since quite 
> > 	a few people seem to be allergic to man pages, so they fire up 
> > 	rebase -i without any clue.
> 
> Oh, I wouldn't dream of suggesting complete removal of the help
> text, 

I meant to "move" everything.  Sorry.

> but leaving the single line at the beginning is not an improvement.  
> What's on that single line is not particularly useful but that is a 
> separate issue.

Okay, so you'd like this better?

-- snipsnap --
[PATCH] rebase -i: move help to end of todo file

Many editors start in the first line, so the 9-line help text was an
annoyance.  So move it to the end.

Requested by Junio.

While at it, add a hint how to abort the rebase.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh    |   14 ++++++++------
 t/t3404-rebase-interactive.sh |    3 ++-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a6dc72a..58fde89 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -479,8 +479,13 @@ do
 		SHORTUPSTREAM=$(git rev-parse --short $UPSTREAM)
 		SHORTHEAD=$(git rev-parse --short $HEAD)
 		SHORTONTO=$(git rev-parse --short $ONTO)
-		cat > "$TODO" << EOF
-# Rebasing $SHORTUPSTREAM..$SHORTHEAD onto $SHORTONTO
+		git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
+			--abbrev=7 --reverse --left-right --cherry-pick \
+			$UPSTREAM...$HEAD | \
+			sed -n "s/^>/pick /p" > "$TODO"
+		cat >> "$TODO" << EOF
+
+# Rebase $SHORTUPSTREAM..$SHORTHEAD onto $SHORTONTO
 #
 # Commands:
 #  pick = use commit
@@ -488,12 +493,9 @@ do
 #  squash = use commit, but meld into previous commit
 #
 # If you remove a line here THAT COMMIT WILL BE LOST.
+# However, if you remove everything, the rebase will be aborted.
 #
 EOF
-		git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
-			--abbrev=7 --reverse --left-right --cherry-pick \
-			$UPSTREAM...$HEAD | \
-			sed -n "s/^>/pick /p" >> "$TODO"
 
 		has_action "$TODO" ||
 			die_abort "Nothing to do"
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index f1039d1..907c7f9 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -149,7 +149,8 @@ test_expect_success 'stop on conflicting pick' '
 	diff -u expect .git/.dotest-merge/patch &&
 	diff -u expect2 file1 &&
 	test 4 = $(grep -v "^#" < .git/.dotest-merge/done | wc -l) &&
-	test 0 = $(grep -v "^#" < .git/.dotest-merge/git-rebase-todo | wc -l)
+	test 0 = $(grep -ve "^#" -e "^$" < .git/.dotest-merge/git-rebase-todo |
+		wc -l)
 '
 
 test_expect_success 'abort' '
-- 
1.5.3.6.1977.g54d30
