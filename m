From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: [PATCH] rebase -p: seed first commit in case it's before the
 merge bases.
Date: Sat, 17 Jan 2009 21:57:51 -0600
Organization: Exigence
Message-ID: <20090117215751.60ade90a.stephen@exigencecorp.com>
References: <496F6AC3.7050704@drmicha.warpmail.net>
	<cover.1232233454.git.stephen@exigencecorp.com>
	<ac1a4533de095f916dd68029793c8ee6eb02d200.1232233454.git.stephen@exigencecorp.com>
	<a524993b13ee586cf0e8fbd3b6459ccd6767c6d8.1232233454.git.stephen@exigencecorp.com>
	<alpine.DEB.1.00.0901180041540.3586@pacific.mpi-cbg.de>
	<alpine.DEB.1.00.0901180108480.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Stephan Beyer <s-beyer@gmx.net>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 18 04:59:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOOoj-0006U3-F2
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 04:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276AbZARD54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 22:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752705AbZARD5z
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 22:57:55 -0500
Received: from smtp122.sat.emailsrvr.com ([66.216.121.122]:38921 "EHLO
	smtp122.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849AbZARD5y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 22:57:54 -0500
Received: from relay2.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay2.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id DD218DD5E1;
	Sat, 17 Jan 2009 22:57:52 -0500 (EST)
Received: by relay2.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTPSA id 8649CCFD89;
	Sat, 17 Jan 2009 22:57:52 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901180108480.3586@pacific.mpi-cbg.de>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106137>


> > However, I have a strong feeling that just piling onto the current
> > code will not fix the underlying issues.
> 
> BTW just to clarify what I mean by "underlying issues": if you say
> "git rebase -i" in Sitaram's test case, you will see the two commits
> -- as expected.
> 
> However, if you add "-p", all of a sudden you will only see "noop".
> IMO there is no excuse that the code can hide them at all.  If the
> commits are reachable from HEAD but not from $UPSTREAM, they have to
> be in the list.  As simple as that.

Agreed--the rewritten-parent probing being rooted at the merge bases
was not good enough.

> Another thing that I find horribly wrong: there is a "touch
> $REWRITTEN/sha1".  There was a simple design in the beginning: the
> files in $REWRITTEN are actually a mapping from old SHA-1 (file name)
> to new SHA-1 (content).  This was broken, without any good
> explanation.

Perhaps it is not "good", but the explanation a blank REWRITTEN/sha1 is
used a marker during the probe phase that this commit will be rewritten.
So when looking at any of its children commits, they should be rewritten
if a REWRITTEN/parentSha1 exists. Then as the rewriting actually happens,
they get filled in with the new sha1. I cribbed this approach from
Stephan's sequencer rewrite of rebase-i-p.

If you want a different data structure, be it file based, or bash/list
based, or whatever, to track "this commit will eventually be rewritten
but we haven't gotten there yet" during the probe, then we could go back
to leaving REWRITTEN/sha1 alone until after the sha1 commit has been
rebased.

I'm open to suggestions.

Also, as you seem to realize, the current bug stems from not knowing how
to initialize the rewritten data structure. For Sitaram's case, the
first commit is behind any of the merge bases, so marking its parents
(if they exist) as rewritten to ONTO seems reasonable.

If there are no parents, as you point out, I added a "-o sha1 = FIRST"
that should also get the ball rolling. It's another hack, but does this
address your concern until a large refactoring happens?

-------------------------- git-rebase--interactive.sh --------------------------
index c8b0861..8740d9f 100755
@@ -604,11 +604,18 @@ first and then run 'git rebase --continue' again."
 				echo $ONTO > "$REWRITTEN"/$c ||
 					die "Could not init rewritten commits"
 			done
+			# Along with the merge bases, look at the first commit's
+			# parent (which may be before the merge base) and mark it
+			# as rewritten to ONTO
+			FIRST="$(git rev-list --reverse --first-parent $UPSTREAM..$HEAD | head -n 1)"
+			for p in $(git rev-list --parents -1 $FIRST | cut -d' ' -f2)
+			do
+				echo $ONTO > "$REWRITTEN/$p"
+			done
 			# No cherry-pick because our first pass is to determine
 			# parents to rewrite and skipping dropped commits would
 			# prematurely end our probe
 			MERGES_OPTION=
-			first_after_upstream="$(git rev-list --reverse --first-parent $UPSTREAM..$HEAD | head -n 1)"
 		else
 			MERGES_OPTION="--no-merges --cherry-pick"
 		fi
@@ -629,12 +636,12 @@ first and then run 'git rebase --continue' again."
 				preserve=t
 				for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -f2-)
 				do
-					if test -f "$REWRITTEN"/$p -a \( $p != $UPSTREAM -o $sha1 = $first_after_upstream \)
+					if test -f "$REWRITTEN"/$p -a $p != $UPSTREAM
 					then
 						preserve=f
 					fi
 				done
-				if test f = "$preserve"
+				if test f = "$preserve" -o $sha1 = $FIRST
 				then
 					touch "$REWRITTEN"/$sha1
 					echo "pick $shortsha1 $rest" >> "$TODO"

(I'm adding the other 3 cc's back after my failed patch attempt
stripped them out--sorry, guys.)

- Stephen
