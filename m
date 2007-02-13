From: Jeff King <peff@peff.net>
Subject: Re: Question on git fetch to bare repo
Date: Mon, 12 Feb 2007 23:54:42 -0500
Message-ID: <20070213045441.GA328@coredump.intra.peff.net>
References: <17867.41997.561756.679778@lisa.zopyra.com> <20070209023941.GE10574@coredump.intra.peff.net> <17872.53830.887188.137662@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Feb 13 05:54:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGpgn-0003ae-TJ
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 05:54:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030638AbXBMEyp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 23:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161016AbXBMEyp
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 23:54:45 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2983 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030638AbXBMEyo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 23:54:44 -0500
Received: (qmail 31135 invoked from network); 12 Feb 2007 23:54:48 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 12 Feb 2007 23:54:48 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Feb 2007 23:54:42 -0500
Content-Disposition: inline
In-Reply-To: <17872.53830.887188.137662@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39490>

On Mon, Feb 12, 2007 at 02:47:02PM -0600, Bill Lear wrote:

> The problem I have with doing all of my fetching and merging in my
> private repo is this: I have an update hook in my public repo that I
> use to communicate my changes to my peers.  The problem is when I pull
> from a peer's repo into my private repo, make some of my changes, and
> then publish (push) my changes to the public repo, HIS changes are
> pushed as well, and the update script naturally picks up on these and
> broadcasts them.  My peer group ends up getting the same update
> message about his commits that they have already received.  Multiply
> this among 6 peers and it becomes a real headache.

Interesting. Why not have your update hook know who you are, and send
out changes only for commits that are either authored by you, or
committed by you (depending on your workflow, these may have different
results)?

Something like this (mostly untested!) on top of the stock update hook:

diff --git a/templates/hooks--update b/templates/hooks--update
index d4253cb..1598f1b 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -55,6 +55,7 @@ projectdesc=$(cat $GIT_DIR/description)
 recipients=$(git-repo-config hooks.mailinglist)
 announcerecipients=$(git-repo-config hooks.announcelist)
 allowunannotated=$(git-repo-config --bool hooks.allowunannotated)
+authorfilter=$(git-repo-config hooks.authorfilter)
 
 # --- Check types
 newrev_type=$(git-cat-file -t "$newrev")
@@ -148,7 +149,7 @@ case "$refname_type" in
 			# This shows all log entries that are not already covered by
 			# another ref - i.e. commits that are now accessible from this
 			# ref that were previously not accessible
-			git-rev-list --pretty $newref $(git-rev-parse --not --all)
+			git-rev-list ${authorfilter:+--author="$authorfilter"} --pretty $newref $(git-rev-parse --not --all)
 			echo $LOGEND
 		else
 			# oldrev is valid
@@ -165,7 +166,7 @@ case "$refname_type" in
 			baserev=$(git-merge-base $oldrev $newrev)
 
 			# Commit with a parent
-			for rev in $(git-rev-list $newrev ^$baserev)
+			for rev in $(git-rev-list ${authorfilter:+--author="$authorfilter"} $newrev ^$baserev)
 			do
 				revtype=$(git-cat-file -t "$rev")
 				echo "       via  $rev ($revtype)"
@@ -190,7 +191,7 @@ case "$refname_type" in
 			fi
 			echo ""
 			echo $LOGBEGIN
-			git-rev-list --pretty $newrev ^$baserev
+			git-rev-list ${authorfilter:+--author="$authorfilter"} --pretty $newrev ^$baserev
 			echo $LOGEND
 			echo ""
 			echo "Diffstat:"


Just set hooks.authorfilter in your config to 'Bill Lear'.  Note that
this still gives the _full_ diffstat between the two endpoints. I would
think you would really want to show a diffstat for each filtered commit
individually. And you're probably not using this hook currently, but I
hope it should be obvious how to modify whatever you are using.

Of course, what you're doing now isn't _wrong_, once we fix the
"committing on tracking branches" problem (which it looks like you are
addressing below), so don't let me drag you too far from your workflow.
:)

> So, what I have (just now) tried to do (using the latest 1.5 code),

Good, 1.5 is much more pleasant to work with. :)

> [remote "origin"]
>         url = /repos/git/project
>         fetch = +refs/heads/*:refs/remotes/origin/*

So this means everything in your public repo's refs/heads/* is mirrored
in your private refs/remotes/origin/*.

> [branch "master"]
>         remote = origin
>         merge = refs/heads/master

And the local branch master will merge from origin's refs/heads/master.

> and no .git/remotes/origin exists.

Right, the config above supersedes it.

> I notice that this did not "clone" all the branches in my public repo:
> 
> % git branch
> * master
> 
> whereas in my public repo:
> 
> % cd /repos/git/project
> % git --bare branch
>   topic
> * master

It did clone it; git-branch just doesn't print remote branches by
default. Try 'git branch -a'. You can create a new topic branch from
your origin topic branch like this:

  git checkout -b topic origin/topic

If you want it to pull automagically from the upstream topic (when you
do a git-pull without any arguments), then you need a config similar to
what it automatically set up for master:

  [branch "topic"]
    remote = origin
    merge = refs/heads/topic

> I'm still not sure if I'm obeying the "don't develop on anything
> on the RHS of ':' dictum".

You are, because 1.5 makes it much harder to do so. Doing a
'git-checkout topic' won't work until you create a local topic branch.
With the detached head work in 1.5, you _can_ do this:

  git checkout origin/topic

but it will issue a warning.

-Peff
