From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Documentation: format-patch --root clarifications
Date: Thu, 26 Mar 2009 18:29:25 +0100
Message-ID: <af6ac91054a35020e3cc4c9242f82cc96714ea7c.1238086612.git.trast@student.ethz.ch>
References: <Pine.LNX.4.64.0903231732150.6370@axis700.grange>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 22:12:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmwsH-000764-Px
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 22:12:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222AbZCZVK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 17:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbZCZVK5
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 17:10:57 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:6337 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751118AbZCZVK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 17:10:56 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 26 Mar 2009 22:11:18 +0100
Received: from localhost.localdomain ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 26 Mar 2009 18:29:59 +0100
X-Mailer: git-send-email 1.6.2.1.558.ge131
In-Reply-To: <Pine.LNX.4.64.0903231732150.6370@axis700.grange>
X-OriginalArrivalTime: 26 Mar 2009 17:29:59.0163 (UTC) FILETIME=[7CC7A4B0:01C9AE38]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114820>

Users were confused about the meaning and use of the --root option.
Notably, since 68c2ec7 (format-patch: show patch text for the root
commit, 2009-01-10), --root has nothing to do with showing the patch
text for the root commit any more.

Shorten and clarify the corresponding paragraph in the DESCRIPTION
section, document --root under OPTIONS, and add an explicit note that
root commits are formatted regardless.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Guennadi Liakhovetski wrote:
> On Mon, 23 Mar 2009, Thomas Rast wrote:
> 
> > > git-format-patch -1 produces a 0-byte long patch.
> > 
> > That is admittedly weird and probably deserves a fix and/or suggestion
> > to use --root.

I finally got around to looking at this again.  The 0-byte patch issue
is fixed since 1.6.2 (68c2ec7 mentioned above), so the above no longer
applies.  The patch merely tries to make this clearer in the
documentation.

> Yes, I can understand this, still from the high-level PoV, this looks 
> inconsistent:
> 
> git-format-patch HEAD
> 
> never produces anything, which means for me, I'm trying to extract commits 
> for a 0-length range.
> 
> git-format-patch HEAD^
> 
> Usually produces the "current" or the "last" commit - except if you're 
> currently on the first commit... But I'm not insisting on this one - maybe 
> you're right, it just _does_ look weird.
>
> Just try to forget about the meaning of the command. You are somewhere on 
> the commit timeline. You enter "some" command, which usually produces 
> exactly one - the most recent commit. So, I would expect this to work 
> always when there is at least one commit in the tree.

It's not like this is voodoo, the problem is that you're reading a
different meaning into the observable behaviour than what the revision
walker does.

First, note that rule 1 in the git-format-patch manpage simply states
that specifying a single <commit> is equivalent to specifying the
range '<commit>..', i.e., '<commit>..HEAD'.

With that out of the way, turn to man git-rev-list and note that
'<commit>..HEAD' is another way of spelling '^<commit> HEAD'.  Which
means to list all commits that are reachable from HEAD, but not
<commit>.  Thus, in *linear* history, 'HEAD^..' always means the
current commit, but that's just a special case.  If you're on a merge
commit, 'HEAD^..' only excludes commits reachable from the *first*
parent of the merge, so (unless the merge was trivial) this range
actually contains more than one commit.

And it should become clearer that in order to reach (and thus
include/exclude) anything, both ends of the revision range must
exist.  So if there is no parent of the current commit (i.e., it is a
root), you cannot use the HEAD^ syntax.

Admittedly, the special handling of <since> in git-format-patch
differs from all(?) other revision walking commands (log, rev-list,
bundle, fast-export).


 Documentation/git-format-patch.txt |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index c2eb5fa..c105925 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -40,15 +40,11 @@ There are two ways to specify which commits to operate on.
    REVISIONS" section in linkgit:git-rev-parse[1]) means the
    commits in the specified range.
 
-A single commit, when interpreted as a <revision range>
-expression, means "everything that leads to that commit", but
-if you write 'git format-patch <commit>', the previous rule
-applies to that command line and you do not get "everything
-since the beginning of the time".  If you want to format
-everything since project inception to one commit, say "git
-format-patch \--root <commit>" to make it clear that it is the
-latter case.  If you want to format a single commit, you can do
-this with "git format-patch -1 <commit>".
+The first rule takes precedence in the case of a single <commit>.  To
+apply the second rule, i.e., format everything since the beginning of
+history up until <commit>, use the '\--root' option: "git format-patch
+\--root <commit>".  If you want to format only <commit> itself, you
+can do this with "git format-patch -1 <commit>".
 
 By default, each output file is numbered sequentially from 1, and uses the
 first line of the commit message (massaged for pathname safety) as
@@ -182,6 +178,13 @@ not add any suffix.
 	applied.  By default the contents of changes in those files are
 	encoded in the patch.
 
+--root::
+	Treat the revision argument as a <revision range>, even if it
+	is just a single commit (that would normally be treated as a
+	<since>).  Note that root commits included in the specified
+	range are always formatted as creation patches, independently
+	of this flag.
+
 CONFIGURATION
 -------------
 You can specify extra mail header lines to be added to each message
-- 
1.6.2.1.558.ge131
