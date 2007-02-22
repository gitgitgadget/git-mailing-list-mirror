From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-status: do not be totally useless in a read-only repository.
Date: Thu, 22 Feb 2007 00:28:49 -0800
Message-ID: <7vmz36k33y.fsf@assigned-by-dhcp.cox.net>
References: <7virdx1e58.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 22 09:29:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HK9K1-0007FI-25
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 09:29:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbXBVI2x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 03:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbXBVI2x
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 03:28:53 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:38245 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494AbXBVI2w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 03:28:52 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070222082850.XMOP3546.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Thu, 22 Feb 2007 03:28:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SYUp1W0051kojtg0000000; Thu, 22 Feb 2007 03:28:50 -0500
In-Reply-To: <7virdx1e58.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 19 Feb 2007 23:28:35 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40339>

This makes git-status work semi-decently in a read-only
repository.  Earlier, the command simply died with "cannot lock
the index file" before giving any useful information to the
user.

Because index won't be updated in a read-only repository,
stat-dirty paths appear in the "Changed but not updated" list.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

  Junio C Hamano <junkio@cox.net> writes:

  >  [gmane=http://thread.gmane.org/gmane.comp.version-control.git]
  >
  > * "git status" is not a read-only operation.
  >
  >   It needs to do enough lstat(2) to run "update-index --refresh" to come
  >   up with the information it needs to give.  We could do so internally
  >   without writing out the result to the index (there is a patch to do
  >   this) even if a repository is not writable.
  >
  >     $gmane/39205
  >     $gmane/39206
  >
  >   However, a big downside of this approach is that doing so
  >   unconditionally would mean the expensive lstat(2) is wasted
  >   afterwards.
  >
  >     $gmane/39246
  >
  >   Currently an workaround is to run git-runstatus and live with the fact
  >   that otherwise unmodified but stat-dirty paths to show up in the
  >   output.  I think (iff somebody feels strongly about it) a possible
  >   compromise would be to see if we can update the index, and do what the
  >   current code does if we can, and otherwise fall back on the new code
  >   that does the internal "update-index --refresh".

  I did not feel strongly enough about it, so here is another
  approach.

 git-commit.sh |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index ec506d9..cfa1511 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -13,10 +13,10 @@ git-rev-parse --verify HEAD >/dev/null 2>&1 || initial_commit=t
 case "$0" in
 *status)
 	status_only=t
-	unmerged_ok_if_status=--unmerged ;;
+	;;
 *commit)
 	status_only=
-	unmerged_ok_if_status= ;;
+	;;
 esac
 
 refuse_partial () {
@@ -389,16 +389,17 @@ else
 	USE_INDEX="$THIS_INDEX"
 fi
 
-GIT_INDEX_FILE="$USE_INDEX" \
-	git-update-index -q $unmerged_ok_if_status --refresh || exit
-
-################################################################
-# If the request is status, just show it and exit.
-
-case "$0" in
-*status)
+case "$status_only" in
+t)
+	# This will silently fail in a read-only repository, which is
+	# what we want.
+	GIT_INDEX_FILE="$USE_INDEX" git-update-index -q --unmerged --refresh
 	run_status
 	exit $?
+	;;
+'')
+	GIT_INDEX_FILE="$USE_INDEX" git-update-index -q --refresh || exit
+	;;
 esac
 
 ################################################################
-- 
1.5.0.1.619.g04c5c
