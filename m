From: Brian Hetro <whee@smaertness.net>
Subject: [PATCH] When nothing to git-commit, honor the git-status color
	setting.
Date: Sun, 26 Aug 2007 14:35:26 -0400
Message-ID: <20070826183526.GA16359@ruiner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 26 20:35:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPMxg-0007f5-FT
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 20:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755402AbXHZSfc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 14:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755371AbXHZSfb
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 14:35:31 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:2899 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755358AbXHZSfa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 14:35:30 -0400
Received: by an-out-0708.google.com with SMTP id d31so165897and
        for <git@vger.kernel.org>; Sun, 26 Aug 2007 11:35:29 -0700 (PDT)
Received: by 10.100.121.12 with SMTP id t12mr998639anc.1188153329303;
        Sun, 26 Aug 2007 11:35:29 -0700 (PDT)
Received: from smaertness.net ( [66.67.48.108])
        by mx.google.com with ESMTPS id d35sm3540089and.2007.08.26.11.35.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 26 Aug 2007 11:35:28 -0700 (PDT)
Received: by smaertness.net (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	whee@smaertness.net; Sun, 26 Aug 2007 14:35:27 -0400 (EDT)
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
X-PGP-Key: http://whee.smaertness.net/pubkey.asc
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56708>

Instead of disabling color all of the time during a git-commit, allow
the user's config preference in the situation where there is nothing
to commit.  In this situation, the status is printed to the terminal
and not sent to COMMIT_EDITMSG, so honoring the status color setting
is expected.

Signed-off-by: Brian Hetro <whee@smaertness.net>
---
 git-commit.sh |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index d7e7028..1d04f1f 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -49,10 +49,11 @@ run_status () {
 		export GIT_INDEX_FILE
 	fi
 
-	case "$status_only" in
-	t) color= ;;
-	*) color=--nocolor ;;
-	esac
+	if test "$status_only" = "t" -o "$use_status_color" = "t"; then
+		color=
+	else
+		color=--nocolor
+	fi
 	git runstatus ${color} \
 		${verbose:+--verbose} \
 		${amend:+--amend} \
@@ -556,6 +557,7 @@ fi
 if [ "$?" != "0" -a ! -f "$GIT_DIR/MERGE_HEAD" -a -z "$amend" ]
 then
 	rm -f "$GIT_DIR/COMMIT_EDITMSG" "$GIT_DIR/SQUASH_MSG"
+	use_status_color=t
 	run_status
 	exit 1
 fi
-- 
1.5.3.rc6.23.g0058-dirty
