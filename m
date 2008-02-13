From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: new stacked git feature
Date: Wed, 13 Feb 2008 01:08:06 +0100
Message-ID: <20080213000806.GB25839@diana.vm.bytemark.co.uk>
References: <20080111194946.GA7504@redhat.com> <1202834567.14175.68.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jason Baron <jbaron@redhat.com>,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	Yann Dirson <ydirson@altern.org>, git <git@vger.kernel.org>
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Wed Feb 13 01:09:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP5Bx-00046k-UD
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 01:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180AbYBMAJD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Feb 2008 19:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156AbYBMAJD
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 19:09:03 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1314 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041AbYBMAJA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 19:09:00 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JP5AV-0006vl-00; Wed, 13 Feb 2008 00:08:07 +0000
Content-Disposition: inline
In-Reply-To: <1202834567.14175.68.camel@pc1117.cambridge.arm.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73717>

On 2008-02-12 16:42:46 +0000, Catalin Marinas wrote:

> The background of this discussion is to have two or more StGIT
> repositories and keep them in sync. An idea is to share the exported
> patches directory and automatically synchronise them between various
> repositories (we already have a 'stg sync' command which I use for
> this kind of things but it's not automated).
>
> Yet another idea is to add some metadata to each commit log,
> something like a unique id so that one can recreate the stack with
> only a GIT revision id, without knowing the base.

I've been trying to come up with a good way to represent undo
information, and my current plan is this:

  * Every time the patch stack is modified (that is, any time an StGit
    command modifies anything at all), a new commit is made to a log
    branch. Each StGit branch has one such log branch.

  * The tree of a log commit contains:

      - A "patches" subtree, with one subtree per patch, named after
        the patch.

          + Each patch tree contains an "a" and a "b" tree, and a blob
            with the commit details including the sha1 of the commit
            object we use to represent the patch.

      - "applied" and "unapplied" blobs.

      - A version stamp blob, to make it easier to extend the log
        format in the future if we ever need to.

  * The log commit has one or more parents: zero or more log commits,
    and the current branch head commit.

This has a couple of features:

  * The log contains all the information necessary for resetting back
    to any given prior state. We might lose the commit objects of
    unapplied patches since they aren't reachable from the branch
    head, but we can recreate equivalent commit objects.

      - This means that one could pull a log branch from another
        repository and continue working on it.

      - It also means that all the other StGit metadata becomes
        redundant.

  * The log is able to represent any state, even "broken" states. This
    means that it's possible to undo "stg repair".

  * The log can represent nonlinear history -- that is, forks and
    merges in the state of the patch stack -- but, like git, says
    nothing about how the result of a merge is to be computed.

I've started to build this, but haven't gotten very far yet.

I wasn't planning to try to build patch stack merging until later, but
here's how I imagine it would work:

  1. All patches are popped, and set to a special "conflicting" state
     with three or more "a" trees: a.ours, a.theirs, a.base0, a.base1,
     a.base2, .... Similarly for the "b" tree and the commit details.
     (Of course, trivial conflicts could be sorted out automatically
     at this point.)

  2. The merged stack base is created with a normal recursive merge.

  3. When a conflicting patch is pushed, we do the following:

       1. For each of .ours, .theirs, .base0, ..., create a new "b"
          tree just like we do when we normally push a patch. If there
          are conflicts, autoresolve them like merge-recursive does
          internally.

       2. Create the single new "b" tree by making a recursive merge
          of all these updated "b" trees. Represent any conflicts like
          we usually do when pushing patches.

I haven't even gotten far enough to test if this kind of merging gives
sane results, but I think it might.

=46eedback welcome on all of this, obviously.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
