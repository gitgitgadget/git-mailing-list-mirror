From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git on afs
Date: Fri, 19 Oct 2007 02:06:24 -0400
Message-ID: <20071019060624.GK14735@spearce.org>
References: <20071018203106.GA13518@fries.net> <alpine.LFD.0.999.0710181543380.26902@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"Todd T. Fries" <todd@fries.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 08:06:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iil0Q-00042O-0N
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 08:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162AbXJSGGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 02:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754071AbXJSGGe
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 02:06:34 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48371 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbXJSGGd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 02:06:33 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iil04-0006lH-V8; Fri, 19 Oct 2007 02:06:25 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8143220FBAE; Fri, 19 Oct 2007 02:06:24 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710181543380.26902@woody.linux-foundation.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61654>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Thu, 18 Oct 2007, Todd T. Fries wrote:
> > 
> > 2) git presumes that DTYPE(de) != DT_DIR .. means the dirent is not a dir
> >    this is not true for afs
> 
> That's a major bug, and has nothing to do with AFS. Oops. 
> 
> If you look just a bit lower, you'll see that just a few lines down, git 
> handles DT_UNKNOWN correctly, and just does a lstat() on it as required. I 
> guess that logic should be moved up, or alternatively the exclude logic 
> should be moved down.
> 
> Your patch looks ok, but at the same time, I don't think it's really the 
> right thing to do, since it now does that lstat() twice.

What about this instead?  It avoids the double lstat() of Todd's
original patch but seems like it would fix the issue here.  Or did
I misunderstand the problem?


--8>--
From f290fc5f6ec5042b7c0393a300e4d3738b9090b8 Mon Sep 17 00:00:00 2001
From: Shawn O. Pearce <spearce@spearce.org>
Date: Fri, 19 Oct 2007 02:03:55 -0400
Subject: [PATCH] Correctly scan directories when DTYPE(de) is unknown

We have been presuming that if DTYPE(de) != DT_DIR than the item we
obtained from readdir() isn't a directory.  This is actually not
true, it could still be a directory, especially if the underlying
system we were compiled for doesn't have the d_type member of struct
dirent and we have enabled our compatability definition of DTYPE(de)
to always be DT_UNKNOWN.

If DTYPE(de) == DT_UNKNOWN we need to fall through and perform an
actual lstat() call to determine what the type of this item is so
we know how to proceed with our scanning.

Reported by Todd T. Fries while trying to use Git on AFS, which
apparently has DTYPE(de) != DT_DIR for directories.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 dir.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index eb6c3ab..d2597ff 100644
--- a/dir.c
+++ b/dir.c
@@ -487,9 +487,10 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 			    && in_pathspec(fullname, baselen + len, simplify))
 				dir_add_ignored(dir, fullname, baselen + len);
 			if (exclude != dir->show_ignored) {
-				if (!dir->show_ignored || DTYPE(de) != DT_DIR) {
+				if (!dir->show_ignored)
+					continue;
+				else if (DTYPE(de) != DT_DIR && DTYPE(de) != DT_UNKNOWN)
 					continue;
-				}
 			}
 
 			switch (DTYPE(de)) {
-- 
1.5.3.4.1249.g895be

-- 
Shawn.
