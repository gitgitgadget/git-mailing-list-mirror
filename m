From: Tony Finch <dot@dotat.at>
Subject: A workflow for local patch maintenance
Date: Tue, 8 Oct 2013 19:12:22 +0100
Message-ID: <alpine.LSU.2.00.1310081906250.5715@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 08 20:35:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTc82-0006dM-B0
	for gcvg-git-2@plane.gmane.org; Tue, 08 Oct 2013 20:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011Ab3JHSfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Oct 2013 14:35:25 -0400
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:45426 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957Ab3JHSfY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Oct 2013 14:35:24 -0400
X-Greylist: delayed 1379 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Oct 2013 14:35:24 EDT
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:51583)
	by ppsw-32.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.156]:25)
	with esmtpa (EXTERNAL:fanf2) id 1VTble-0001J2-2V (Exim 4.80_167-5a66dd3) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Tue, 08 Oct 2013 19:12:22 +0100
Received: from fanf2 by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1VTble-0001xY-NG (Exim 4.72) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Tue, 08 Oct 2013 19:12:22 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235783>

This is a copy of an article I published at
http://fanf.livejournal.com/128282.html
I'm sending a copy here because I'm interested to know what other ways
there might be of handling this situation.

--

We often need to patch the software that we run in order to fix bugs
quickly rather than wait for an official release, or to add functionality
that we need. In many cases we have to maintain a locally-developed patch
for a significant length of time, across multiple upstream releases,
either because it is not yet ready for incorporation into a stable
upstream version, or because it is too specific to our setup so will not
be suitable for passing upstream without significant extra work.

I have been experimenting with a git workflow in which I have a feature
branch per patch. (Usually there is only one patch for each change we
make.) To move them on to a new feature release, I tag the feature branch
heads (to preserve history), rebase them onto the new release version, and
octopus merge them to create a new deployment version. This is rather
unsatisfactory, because there is a lot of tedious per-branch work, and I
would prefer to have branches recording the development of our patches
rather than a series of tags.

Here is a git workflow suggested by Ian Jackson which I am trying out
instead. I don't yet have much experience with it; I am writing it down
now as a form of documentation.

There are three branches:

upstream, which is where public releases live
working, which is where development happens
deployment, which is what we run

Which branch corresponds to upstream may change over time, for instance
when we move from one stable version to the next one.

The working branch exists on the developer's workstation and is not
normally published. There might be multiple working branches for
work-in-progress. They get rebased a lot.

Starting from an upstream version, a working branch will have a number of
mature patches. The developer works on top of these in
commit-early-commit-often mode, without worrying about order of changes or
cleanliness. Every so often we use git rebase --interactive to tidy up the
patch set. Often we'll use the "squash" command to combine new commits
with the mature patches that they amend. Sometimes it will be rebased onto
a new upstream version.

When the working branch is ready, we use the commands below to update the
deployment branch. The aim is to make it look like updates from the
working branch are repeatedly merged into the deployment branch. This is
so that we can push updated versions of the patch set to a server without
having to use --force, and pulling updates into a checked out version is
just a fast-forward. However this isn't a normal merge since the tree at
the head of deployment always matches the most recent good version of
working. (This is similar to what stg publish does.) Diagramatically,

     |
    1.1
     | \
     |  `A---B-- 1.1-patched
     |    \       |
     |     \      |
     |      `C-- 1.1-revised
     |            |
    2.0           |
     | \          |
     |  `-C--D-- 2.0-patched
     |            |
    3.1           |
     | \          |
     |  `-C--E-- 3.1-patched
     |            |
  upstream        |
              deployment

The horizontal-ish lines are different rebased versions of the patch set.
Letters represent patches and numbers represent version tags. The tags on
the deployment branch are for the install scripts so I probably won't need
one on every update.

Ideally we would be able to do this with the following commands:

    $ git checkout deployment
    $ git merge -s theirs working

However there is an "ours" merge strategy but not a "theirs" merge
strategy. Johannes Sixt described how to simulate git merge -s theirs in a
post to the git mailing list in 2010.
http://article.gmane.org/gmane.comp.version-control.git/163631
So the commands are:

    $ git checkout deployment
    $ git merge --no-commit -s ours working
    $ git read-tree -m -u working
    $ git commit -m "Update to $(git describe working)"

Mark Wooding suggested the following more plumbing-based version, which
unlike the above does not involve switching to the deployment branch.

    $ d=$(git rev-parse deployment)
    $ w=$(git rev-parse working)
    $ c=$(echo "Update to $(git describe working)" |
          git commit-tree -p $d -p $w working^{tree})
    $ git update-ref deployment $c $d
    $ unset c d w

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
Forties, Cromarty: East, veering southeast, 4 or 5, occasionally 6 at first.
Rough, becoming slight or moderate. Showers, rain at first. Moderate or good,
occasionally poor at first.
