From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Don't allow combination of -g and --reverse as it doesn't work
Date: Sun, 19 Aug 2007 22:33:43 -0400
Message-ID: <20070820023343.GA16229@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 04:33:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMx5T-0001aB-Bb
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 04:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755195AbXHTCds (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 22:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755058AbXHTCds
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 22:33:48 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:34712 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753689AbXHTCdr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2007 22:33:47 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IMx5C-0008Sg-Dg; Sun, 19 Aug 2007 22:33:34 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4687320FBAE; Sun, 19 Aug 2007 22:33:44 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56167>

The --walk-reflogs logic and the --reverse logic are completely
incompatible with one another.  Attempting to use both at the same
time leads to confusing results that sometimes violates the user's
formatting options or ignores the user's request to see the reflog
message and timestamp.

Unfortunately the implementation of both of these features is glued
onto the side of the revision walking machinary in such a way that
they are probably not going to be easy to make them compatible with
each other.  Rather than offering the user confusing results we are
better off bailing out with an error message until such a time as
the implementations can be refactored to be compatible.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This addresses the "log -g --reverse horribly insane" issue I posted
 about earlier today.  Based on Junio's reply I'm not trying to fix
 it for 1.5.3 but instead just tell the user it is not currently
 supported by the implementation.


 Documentation/git-log.txt      |    1 +
 Documentation/git-rev-list.txt |    3 +++
 revision.c                     |    3 +++
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 5a90f65..1e6dbd9 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -49,6 +49,7 @@ include::pretty-options.txt[]
 -g, \--walk-reflogs::
 	Show commits as they were recorded in the reflog. The log contains
 	a record about how the tip of a reference was changed.
+	Cannot be combined with --reverse.
 	See also gitlink:git-reflog[1].
 
 --decorate::
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 1c19781..cbbc234 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -298,6 +298,8 @@ used in the output.  When the starting commit is specified as
 'commit@{now}', output also uses 'commit@\{timestamp}' notation
 instead.  Under '\--pretty=oneline', the commit message is
 prefixed with this information on the same line.
++
+Cannot be combined with --reverse.
 
 --merge::
 
@@ -373,6 +375,7 @@ By default, the commits are shown in reverse chronological order.
 --reverse::
 
 	Output the commits in reverse order.
+	Cannot be combined with --walk-reflogs.
 
 Object Traversal
 ~~~~~~~~~~~~~~~~
diff --git a/revision.c b/revision.c
index 7d32a89..51fff0e 100644
--- a/revision.c
+++ b/revision.c
@@ -1277,6 +1277,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		compile_grep_patterns(revs->grep_filter);
 	}
 
+	if (revs->reverse && revs->reflog_info)
+		die("cannot combine --reverse with --walk-reflogs");
+
 	return left;
 }
 
-- 
1.5.3.rc5.40.g2f82
