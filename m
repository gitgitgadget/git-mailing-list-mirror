From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/4] Teach git-describe to display distances from tags.
Date: Sat, 27 Jan 2007 01:54:13 -0500
Message-ID: <20070127065413.GC10380@spearce.org>
References: <a23c4e55ca5c09f742fa2a047e45613e7797e720.1169880681.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jan 27 07:54:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAhS9-0001tQ-Fy
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 07:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160AbXA0GyR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 01:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbXA0GyR
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 01:54:17 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49372 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbXA0GyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 01:54:16 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HAhS2-00082w-L6; Sat, 27 Jan 2007 01:54:14 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6183020FBAE; Sat, 27 Jan 2007 01:54:13 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <a23c4e55ca5c09f742fa2a047e45613e7797e720.1169880681.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37926>

Junio C Hamano <junkio@cox.net>:
> However, I suspect that we could do better with Shawn's new
> fangled describe implementation that actually counts the
> distance between what is described and the tag.  We could add
> "number of commits since the tag" somewhere, to describe:
>
>   v2.6.20-rc5-256-g419dd83
>   v2.6.20-rc5-217-gde14569
>
> to say that the first one has 256 commits accumulated since the
> given tag "v2.6.20-rc5" and the second one has only 217
> commits, to get the sense of how busy the development activity
> is.
>
> Is it useful?  That is something I am not sure.

Yes, its very useful.  If you get two different describes at different
times from a non-rewinding branch and they both come up with the same
tag name, you can tell which is the 'newer' one by distance.  This is
rather common in practice, so its incredibly useful.

Credit for this idea also goes to Jakub Narebski for suggesting:

    v2.6.20-rc5+256-g419dd83
    v2.6.20-rc5+217-gde14569

The + format is much easier to read and understand than the - format
original proposed by Junio.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-describe.txt |   23 ++++++++++++++---------
 builtin-describe.c             |    3 ++-
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index a615996..b3e9276 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -14,8 +14,8 @@ DESCRIPTION
 -----------
 The command finds the most recent tag that is reachable from a
 commit, and if the commit itself is pointed at by the tag, shows
-the tag.  Otherwise, it suffixes the tag name with abbreviated
-object name of the commit.
+the tag.  Otherwise, it suffixes the tag name with the number of
+additional commits and the abbreviated object name of the commit.
 
 
 OPTIONS
@@ -54,12 +54,17 @@ EXAMPLES
 With something like git.git current tree, I get:
 
 	[torvalds@g5 git]$ git-describe parent
-	v1.0.4-g2414721b
+	v1.0.4+14-g2414721
 
-i.e. the current head of my "parent" branch is based on v1.0.4,
-but since it has a few commits on top of that, it has added the
-git hash of the thing to the end: "-g" + 8-char shorthand for
-the commit `2414721b194453f058079d897d13c4e377f92dc6`.
+i.e. the current head of my "parent" branch is based on v1.0.4.
+But since my parent branch has a few commits on top of that,
+describe has added the number of additional commits ("+14") and
+the hash of the tip commit ("-g2414721") to the end.
+
+The number of additional commits is an estimate of the number
+of commits which would be displayed by "git log v1.0.4..parent".
+The hash suffix is "-g" + 8-char abbreviation for the tip commit
+of parent (which was `2414721b194453f058079d897d13c4e377f92dc6`).
 
 Doing a "git-describe" on a tag-name will just show the tag name:
 
@@ -70,13 +75,13 @@ With --all, the command can use branch heads as references, so
 the output shows the reference path as well:
 
 	[torvalds@g5 git]$ git describe --all --abbrev=4 v1.0.5^2
-	tags/v1.0.0-g975b
+	tags/v1.0.0+21-g975b
 
 	[torvalds@g5 git]$ git describe --all --abbrev=0 v1.0.5^2
 	tags/v1.0.0
 
 	[torvalds@g5 git]$ git describe --all HEAD^
-	heads/lt/describe-g975b
+	heads/lt/describe+5-g975b
 
 SEARCH STRATEGY
 ---------------
diff --git a/builtin-describe.c b/builtin-describe.c
index 70578dc..6e59e75 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -191,7 +191,8 @@ static void describe(const char *arg, int last_one)
 	if (!abbrev)
 		printf("%s\n", all_matches[0].name->path);
 	else
-		printf("%s-g%s\n", all_matches[0].name->path,
+		printf("%s+%d-g%s\n", all_matches[0].name->path,
+			all_matches[0].depth,
 			find_unique_abbrev(cmit->object.sha1, abbrev));
 
 	if (!last_one)
-- 
1.5.0.rc2.g8a816
