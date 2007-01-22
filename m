From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] prune: --expire=time
Date: Sun, 21 Jan 2007 21:17:12 -0800
Message-ID: <7v3b63wsh3.fsf@assigned-by-dhcp.cox.net>
References: <7vy7o0klt1.fsf@assigned-by-dhcp.cox.net>
	<20070119034404.GA17521@spearce.org>
	<20070119104935.GA5189@moooo.ath.cx>
	<7vfya6hll3.fsf@assigned-by-dhcp.cox.net>
	<20070120111832.GA30368@moooo.ath.cx>
	<7vlkjw50nl.fsf@assigned-by-dhcp.cox.net>
	<20070121103724.GA23256@moooo.ath.cx>
	<7vejpo39zg.fsf@assigned-by-dhcp.cox.net>
	<20070121220114.GA24729@coredump.intra.peff.net>
	<45B415B1.30407@midwinter.com>
	<20070122015252.GA26934@coredump.intra.peff.net>
	<7vwt3fx1am.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701211813410.14248@woody.osdl.org>
	<7virezwzpz.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701211851310.14248@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 06:17:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8rYZ-00030l-9c
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 06:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbXAVFRQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 00:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbXAVFRQ
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 00:17:16 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:55057 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936AbXAVFRO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 00:17:14 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070122051713.QVJM9717.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Mon, 22 Jan 2007 00:17:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id E5HX1W00M1kojtg0000000; Mon, 22 Jan 2007 00:17:31 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701211851310.14248@woody.osdl.org> (Linus
	Torvalds's message of "Sun, 21 Jan 2007 18:58:22 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37394>

Linus Torvalds <torvalds@osdl.org> writes:

> ... I at the same time have to 
> admit that I worry about loose objects (and scary messages from 
> git-fsck-objects) potentially confusing new people.

I've been annoyed by those scary messages fsck-objects enough
and was wondering if we could make it less scary.  Especially
annoying is that the message about missing blobs and trees that
are only referred to by dangling commits.

> So hiding "git prune" behind "git gc" is probably a good thing (make 
> people learn just one thing they need to interface to), but maybe we need 
> a "--prune" flag to the gc command, and then perhaps just document that 
> you should be careful.

I am still undecided which one should be the default.

For interactive use by developers who work in their own
repositories, git-prune is safe because nothing else would be
working on their repositories at the time.  While I do not think
we should recommend using git-gc from a cron job, if they want
to do so, giving an extra --no-prune option in their cron script
would be much less annoying.

-- >8 --
[PATCH] git-gc: do not run prune mindlessly.

You should pass --no-prune if you ever want to run git-gc from
a cron job.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/git-gc.txt |   15 +++++++++++++--
 git-gc.sh                |   18 ++++++++++++++++--
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 2bcc949..7b650a7 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -8,7 +8,7 @@ git-gc - Cleanup unnecessary files and optimize the local repository
 
 SYNOPSIS
 --------
-'git-gc'
+'git-gc' [--no-prune]
 
 DESCRIPTION
 -----------
@@ -21,6 +21,18 @@ Users are encouraged to run this task on a regular basis within
 each repository to maintain good disk space utilization and good
 operating performance.
 
+OPTIONS
+-------
+
+--no-prune::
+	Usually `git-gc` packs refs, expires old reflog entries,
+	packs loose objects, removes unreferenced loose objects,
+	and removes old 'rerere' records.  Among these, removal
+	of unreferenced loose objects is an unsafe operation
+	while other git operations are in progress.  This option
+	disables this unsafe step.
+
+
 Configuration
 -------------
 
@@ -50,7 +62,6 @@ kept.  This defaults to 15 days.
 
 See Also
 --------
-gitlink:git-prune[1]
 gitlink:git-reflog[1]
 gitlink:git-repack[1]
 gitlink:git-rerere[1]
diff --git a/git-gc.sh b/git-gc.sh
index 6de55f7..ecd4b0e 100755
--- a/git-gc.sh
+++ b/git-gc.sh
@@ -4,12 +4,26 @@
 #
 # Cleanup unreachable files and optimize the repository.
 
-USAGE=''
+USAGE='git-gc [--no-prune]'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
 
+no_prune=
+while case $# in 0) break ;; esac
+do
+	case "$1" in
+	--no-prune)
+		no_prune=:
+		;;
+	--)
+		usage
+		;;
+	esac
+	shift
+done
+
 git-pack-refs --prune &&
 git-reflog expire --all &&
 git-repack -a -d -l &&
-git-prune &&
+$no_prune git-prune &&
 git-rerere gc || exit
-- 
1.5.0.rc2
