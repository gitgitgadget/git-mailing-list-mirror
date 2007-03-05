From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] git-diff-tree or git-commit: wrong diff(stat)
Date: Mon, 05 Mar 2007 12:22:57 -0800
Message-ID: <7v3b4jzbha.fsf@assigned-by-dhcp.cox.net>
References: <20070305200751.GA13655@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Mon Mar 05 21:23:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOJi3-00079J-7b
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 21:23:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbXCEUW7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 15:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbXCEUW7
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 15:22:59 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:46221 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932194AbXCEUW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 15:22:58 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070305202259.SGUP24587.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Mon, 5 Mar 2007 15:22:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id X8Nx1W00d1kojtg0000000; Mon, 05 Mar 2007 15:22:58 -0500
In-Reply-To: <20070305200751.GA13655@moooo.ath.cx> (Matthias Lederhofer's
	message of "Mon, 5 Mar 2007 21:07:51 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41482>

Matthias Lederhofer <matled@gmx.net> writes:

> git-commit.sh uses git-diff-tree [options] HEAD --.  The '--' was
> added in 521f9c4d to prevent problems when HEAD exists as a file but
> git-diff-tree shows only differences below the current directory when
> '--' is used.  Hence git-commit in a subdirectory shows only stats for
> the subdirectory.

A cd_to_toplevel before that diff-tree should fix that,
shouldn't it?

For that matter, I think the commit hook should be run from a
known environment without getting affected by the user running
git-commit from a random subdirectory, and so should rerere.  So
how about....


 git-commit.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index be3677c..b8c00b8 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -622,6 +622,9 @@ else
 fi
 ret="$?"
 rm -f "$GIT_DIR/COMMIT_MSG" "$GIT_DIR/COMMIT_EDITMSG" "$GIT_DIR/SQUASH_MSG"
+
+cd_to_toplevel
+
 if test -d "$GIT_DIR/rr-cache"
 then
 	git-rerere
