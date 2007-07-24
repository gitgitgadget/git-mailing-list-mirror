From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] filter-branch: rewrite only refs which were not excluded by
 the options
Date: Tue, 24 Jul 2007 12:06:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707241205480.14781@racer.site>
References: <Pine.LNX.4.64.0707231829210.14781@racer.site>
 <46A5C615.24C24F0F@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 13:06:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDIDz-00075D-3L
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 13:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933424AbXGXLGk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 07:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933313AbXGXLGk
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 07:06:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:48053 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933289AbXGXLGj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 07:06:39 -0400
Received: (qmail invoked by alias); 24 Jul 2007 11:06:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 24 Jul 2007 13:06:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18J3MgftRwJcG0tOmaWSAJbrmgVM5ETxldh0nhUFu
	lybyhyLB9c0Q3V
X-X-Sender: gene099@racer.site
In-Reply-To: <46A5C615.24C24F0F@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53564>


The rev-list options can exclude some -- or all -- refs:

	git filter-branch <some-filter> master ^master

Without this patch, these refs are assumed to be deleted, or worse, they
are rewritten to some bogus merge bases.

So really exclude excluded refs from being rewritten.  This also allows
you to safely call

	git filter-branch <some-filter> --all <rev-list options>

to rewrite _all_ branches and tags.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
	On Tue, 24 Jul 2007, Johannes Sixt wrote:

	> Johannes Schindelin wrote:
	> 
	> > +# NEEDSWORK: we should sort the unmapped refs topologically first
	> > +while read ref
	> > +do
	> > +       sha1=$(git rev-parse "$ref"^0)
	> > +       test -f "$workdir"/../map/$sha1 && continue
	> > +       # Assign the boundarie(s) in the set of rewritten commits
	> > +       # as the replacement commit(s).
	> > +       # (This would look a bit nicer if --not --stdin worked.)
	> > +       for p in $((cd "$workdir"/../map; ls | sed "s/^/^/") |
	> > +               git rev-list $ref --boundary --stdin |
	> > +               sed -n "s/^-//p")
	> > +       do
	> > +               map $p >> "$workdir"/../map/$sha1
	> > +       done
	> > +done < "$tempdir"/heads
	> 
	> This logic seems to be borked, and I don't grok it. I was trying this:
	> 
	>    git-filter-branch -- --since=2007.01.10 \
	> 		refs/heads/topic refs/heads/master

	Actually, the error lay somewhere else.  If excluded, topic should 
	not have been a rewrite candidate.

	There might be something else looming here: what to do with

		git filter-branch --subdir-filter subdir/ topic master \
			^$(git merge-base topic master)

	when topic has no changes to the subdirectory, but master has?

	I guess the safest would be to 'test -f "$workdir"/../map/$p', and 
	if at least one is not there, leave 'topic' as is.  If at least 
	one is there, however, we want to warn the user that this is not 
	possible.  (Something like: this was an unchanged ancestor: $p1, 
	but that was a changed one: $p2.  Make up your mind what you 
	want.)

 git-filter-branch.sh     |    9 ++++++++-
 t/t7003-filter-branch.sh |    9 +++++++++
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 019a302..49b0f00 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -181,6 +181,7 @@ export GIT_DIR GIT_WORK_TREE=.
 
 # These refs should be updated if their heads were rewritten
 
+negatives="$(git rev-parse --revs-only "$@" | grep "^\^")"
 git rev-parse --revs-only --symbolic "$@" |
 while read ref
 do
@@ -196,7 +197,13 @@ do
 			grep "refs/\(tags\|heads\)/$ref$")"
 	esac
 
-	git check-ref-format "$ref" && echo "$ref"
+	# make sure we have a valid ref
+	git check-ref-format "$ref" || continue
+
+	# if the ref has been excluded by the other options, skip it
+	test -z "$(git rev-list -1 "$ref" $negatives)" && continue
+
+	echo "$ref"
 done > "$tempdir"/heads
 
 test -s "$tempdir"/heads ||
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index c9a820d..667eda7 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -164,4 +164,13 @@ test_expect_success 'only dwim refs/heads/$ref or refs/tags/$ref' '
 	git filter-branch -f master
 '
 
+test_expect_success 'do not update uninteresting refs' '
+	branch=$(git rev-parse branch) &&
+	master=$(git rev-parse master) &&
+	git filter-branch -f --env-filter "GIT_AUTHOR_EMAIL=xy@probl.em" \
+		master ^removed-author branch &&
+	test $branch = $(git rev-parse branch) &&
+	test $master != $(git rev-parse master)
+'
+
 test_done
-- 
1.5.3.rc2.32.g35c5b-dirty
