From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Git rebase using "wrong" commit
Date: Tue, 20 Oct 2009 15:21:04 +0200
Message-ID: <200910201521.05526.trast@student.ethz.ch>
References: <1256037982.7122.31.camel@gridbug.soton.smoothwall.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Thomas Adam <thomas.adam@smoothwall.net>
To: Philip Allison <philip.allison@smoothwall.net>
X-From: git-owner@vger.kernel.org Tue Oct 20 15:21:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Eeu-0000is-7x
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 15:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbZJTNVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 09:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751942AbZJTNVm
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 09:21:42 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:57204 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751863AbZJTNVl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 09:21:41 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Tue, 20 Oct
 2009 15:21:43 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Tue, 20 Oct
 2009 15:21:39 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <1256037982.7122.31.camel@gridbug.soton.smoothwall.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130794>

Philip Allison wrote:
> Please find attached a working copy of the repository, just before any
> attempted rebase.
[...]
> bug/2 has, effectively, been merged into master; bug/1 has not; hence,
> there is not (on master) any equivalent change to that which was made to
> resolve the conflict.

Ok, so I gather the (simplified) history looks like

  *------A  (master)
   \\__   \
    \  \   \
     B--M1--M2  (topic)

where A and B conflict, so M2 is nontrivial.  B is the *second* parent
to M1, which I originally thought would affect the 'rebase -p', but it
doesn't; see below.  (You're talking about bug/2, but the repository
shows bug/2 == master, so there are only two branches involved.)

> 	Occasionally, we want to release some bug fixes, but not others.  IOW,
> when integration/bug-fixes comes to be rebased onto master, we wish to
> preserve some of the topic branch merges, but not others.  This usually
> works fine, but an issue has cropped up where there is a conflict
> between two fixes, and only one of the two bug fixes has been released;
> now, when we come to perform the rebase, it is not working as desired.

The inherent difficulty with doing a rebase here is, what about the
merges?  By definition, git-rebase needs to somehow "rebuild" the
commits, as defined by the changes they do, on the new base.

There are several ways how merges can be rebased, and you tried some:

* Not at all; discard the merges.  The result would be

    *---A  (master)
         \
          \
           B'  (topic)

  B' will differ substantially from B because there will be a (rebase)
  conflict.  This is the normal mode of operation, as you noticed:

> "git rebase -i master" output (whilst on HEAD of integration/bug-fixes):
> 
> -----
> pick b17a93c Fix file 1
> 
> # Rebase cd8273f..9f79ca3 onto cd8273f
> -----

* Attempt to rebuild merges; this is the -p flag.  Assume for a second
  that you have a different history

    *---A  (master)
     \   
      \   
       C---M2  (topic2)
          /
         *

  where M2 is a merge with some other branch.  'git rebase -i -p
  master topic2' will attempt to build

    *---A  (master)
         \   
          \   
           C---M2  (topic2)
              /
             *

  Going back to your scenario, this means building

  *------A--.  (master)
   \      \  \
    \      \  \
     B-----M1--M2  (topic)

  Now there appears to be some bug with rebase -p, because it insists
  that there is no work at all to do (the buffer is just 'noop').
  However, rebase -p is known to be somewhat ill-defined and broken.
  I think that in this case, what actually happens is that the merge
  from master to topic confuses the initialisation of $REWRITTEN in

	# line 668
	for c in $(git merge-base --all $HEAD $UPSTREAM)
	do
		echo $ONTO > "$REWRITTEN"/$c || die "blah"
        done

  because suddenly the merge-base is A, meaning that the later test

	# line 712
	for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -s -f2-)
	do
		if test -f "$REWRITTEN"/$p -a \( $p != $ONTO -o $sha1 = $first_after_upstream \)

  fails for all commits except M2.  So what's *actually* rewritten is
  M2; but doing so is pointless in rebase's eyes, because it assumes
  the topic will be based on master eventually, so merging master into
  it is a no-op.  Hence there is nothing to do.

> 	The "-m" and "-p" options to rebase don't seem to be helping. I have
> tried getting rebase to "pick 2bc19f9" via -i, but that isn't working
> either:

-m means something entirely different, namely that git-rebase should
use an (internal) merge instead of format-patch|am, which has some
advantages but a big speed disadvantage.  This doesn't matter for
rebase -i as it never uses format-patch|am.

As for manually picking merge commits, that fails because you're just
trying to fool git-cherry-pick into doing something it can't.

> 	We have a specific branch (integration/bug-fixes) which is under
> continual rebase, shared amongst several developers.
[...]
> At the moment I don't know where to go from here, short of manually
> recreating the branch as I want it, which I am loathe to do.

Note that there is no real reason to rebase continually unless you
want to kick out flawed topics or old versions of branches.  For
example, git.git only rebases 'next' immediately after a release.
Furthermore, even if you go for the 'pu' model which is rebuilt all
the time, you can automate this with a script.  There is one in the
'todo' branch of git.git, called PU.

(I myself just use a list of topics I want merged, and a simple 'git
merge $topic' loop.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
