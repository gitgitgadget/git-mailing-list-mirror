From: Jeff King <peff@peff.net>
Subject: Re: git am from scratch
Date: Thu, 19 Mar 2009 17:02:14 -0400
Message-ID: <20090319210214.GA17589@coredump.intra.peff.net>
References: <200903191609.24812.agruen@suse.de> <20090319201817.GE17028@coredump.intra.peff.net> <200903192142.49754.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Thu Mar 19 22:03:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkPP9-0005fW-DG
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 22:03:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748AbZCSVCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 17:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752541AbZCSVCZ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 17:02:25 -0400
Received: from peff.net ([208.65.91.99]:46121 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752137AbZCSVCY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 17:02:24 -0400
Received: (qmail 3644 invoked by uid 107); 19 Mar 2009 21:02:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 19 Mar 2009 17:02:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2009 17:02:14 -0400
Content-Disposition: inline
In-Reply-To: <200903192142.49754.agruen@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113828>

On Thu, Mar 19, 2009 at 09:42:49PM +0100, Andreas Gruenbacher wrote:

> > I don't think this has ever worked in any version of git.
> I did find a way to help myself in the end. Still it was still a major, 
> unnecessary annoyance.

Sure, and that is why I suggested a patch for git-am might be welcome;
it's not the right tool for the job, but it seems to be one that people
naturally think of.

> I ran into this problem when trying to reconstruct a project's history (after 
> going RCS -> CVS -> git many things were still wrong like unrelated RCS files 
> which ended up in the history, RCS files being moved to the Attic in the 
> original tree to indicate deletes [which means they will happily live on from 
> a CVS point of view], etc.).

Yikes. Out of curiosity, what did you use to do the CVS import?


Anyway, here is a not-very-well-tested patch to get "git am" to apply on
top of an empty repository (i.e., it worked on my utterly simplistic
test case and I didn't think too hard about what else might have been
broken). Maybe it will give a good start to somebody who wants to work
on this.

---
diff --git a/git-am.sh b/git-am.sh
index d339075..bcc600d 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -290,17 +290,23 @@ else
 		: >"$dotest/rebasing"
 	else
 		: >"$dotest/applying"
-		git update-ref ORIG_HEAD HEAD
+		if git rev-parse --quiet --verify HEAD; then
+			git update-ref ORIG_HEAD HEAD
+		else
+			rm -f "$GIT_DIR/ORIG_HEAD"
+		fi
 	fi
 fi
 
 case "$resolved" in
 '')
-	files=$(git diff-index --cached --name-only HEAD --) || exit
-	if test "$files"
-	then
-		: >"$dotest/dirtyindex"
-		die "Dirty index: cannot apply patches (dirty: $files)"
+	if git rev-parse --quiet --verify HEAD; then
+		files=$(git diff-index --cached --name-only HEAD --) || exit
+		if test "$files"
+		then
+			: >"$dotest/dirtyindex"
+			die "Dirty index: cannot apply patches (dirty: $files)"
+		fi
 	fi
 esac
 
@@ -541,7 +547,7 @@ do
 	fi
 
 	tree=$(git write-tree) &&
-	parent=$(git rev-parse --verify HEAD) &&
+	parent=$(git rev-parse --quiet --verify HEAD)
 	commit=$(
 		if test -n "$ignore_date"
 		then
@@ -552,7 +558,7 @@ do
 			GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"
 			export GIT_COMMITTER_DATE
 		fi &&
-		git commit-tree $tree -p $parent <"$dotest/final-commit"
+		git commit-tree $tree ${parent:+-p $parent} <"$dotest/final-commit"
 	) &&
 	git update-ref -m "$GIT_REFLOG_ACTION: $FIRSTLINE" HEAD $commit $parent ||
 	stop_here $this
