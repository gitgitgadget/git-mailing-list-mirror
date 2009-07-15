From: Theodore Tso <tytso@mit.edu>
Subject: Re: Dividing up a large merge.
Date: Wed, 15 Jul 2009 08:28:28 -0400
Message-ID: <20090715122828.GA6570@mit.edu>
References: <20090714233246.GA25390@huya.quicinc.com> <3e8340490907141716j77df346es1f894d6a7f6cb0aa@mail.gmail.com> <20090715002926.GA26630@huya.quicinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bryan Donlan <bdonlan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: davidb@quicinc.com
X-From: git-owner@vger.kernel.org Wed Jul 15 14:28:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MR3bM-0005Xg-Bf
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 14:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754322AbZGOM2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 08:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754214AbZGOM2j
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 08:28:39 -0400
Received: from THUNK.ORG ([69.25.196.29]:56514 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753922AbZGOM2i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 08:28:38 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1MR3b5-0001qn-7C; Wed, 15 Jul 2009 08:28:31 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1MR3b2-00073A-KV; Wed, 15 Jul 2009 08:28:28 -0400
Content-Disposition: inline
In-Reply-To: <20090715002926.GA26630@huya.quicinc.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123304>

On Tue, Jul 14, 2009 at 05:29:26PM -0700, davidb@quicinc.com wrote:
> No real developer branches with conflicts (I make those be
> fixed), but several upstreams.  We have many developers busily
> doing work, and one or more other companies is also working on
> the same code.  Meanwhile, the mainline kernel advances at it's
> own astounding rate.

If you hare maintaining a large number of changes over a long-term
(which in the case of the kernel can be measured in a month or two),
it's often much easier to maintain things as a series of patches.

That way you can merge each patch one at a time.

If you already have everything in a git tree, I'd suggest pulling it
apart into separate patches, by using "git format-patch".  Note that
if you have multiple merges into tree, this will go much more smoothly
if you can separate things into a single linear stream.

This is also a good reason why if you have partial work that is
complete enough to be merged into mainline, it is ***much*** better to
try pushing patches to mainline earlier rather than later.  Waiting
until you are 100% done and the work is completely certified involves
a large number of risks; for example, what if people complain about
work that was done early on?  Or if the design was fundamentally
flawed from the get-go?  At the minimum, you will save a huge amount
of effort if you post a request-for-comment version of the patches up
front.

And, if you believe your release cycle is going to run for more than,
say, 2-3 months, I suggest that you keep things in a single linear
patch stream.  You can keep the patch series under git control, and
then rebase periodically; I'd suggest rebasing once a mainline release
happens (i.e., when 2.6.X is released), and then again after most of
the major changes have been merged in and the tree has settled down
(i.e., after 2.6.X-rc2 or 2.6.X-rc3).

> The real issue is that there isn't any single individual who
> understands all of the code that conflicts.  It has to be divided
> up somehow, I'm just trying to figure out a better way of doing
> it.

Yeah, that's another prime argument for maintaining your changes as a
patch queue.  I use a combination of quilt plus git.  So the rebasing
methodology becomes:

# pop all patches
guilt pop -a			
# update the base of the patches
git pull origin			
# start trying to apply each of the patches, one at a time
# next_patch:
guilt push -a
# when you get a failure, the push will stop and tell you it can't 
# apply a patch; so force apply the patch:
guilt push -f
# 
# this will leave some patch .rej files; resolve the patch failures
# for all of the files.    Use "git add" once the patches have been resolved
# also make sure that any files that were added by the patch that was 
# force applied are also manually marked as needing added using "git add".
# Once you are sure the patch is properly merged, do this:
guilt refresh --diffstat
# Check the changes made to the patch; I normally create a symlink from
# .git/patches/<work-branch-for-quilt> to patches in the top level, i.e.
# "ln -s .git/patches/master patches"; if you can't remember the name of the
# patch, you can get it via the command "guilt applied | tail -1"
(cd patches; git diff name-of-patch)
# now repeat with the next set of patches by going back to next_patch, above

I normally keep an indication of the version that the patch series is
based upon via a comment in the first line of the series file, like
this: "# BASE v2.6.30-rc3" or sometimes like this "# BASE 6ab2792".
This can be useful when creating automated scripts to test the patch
series, since they know what version to apply the patches against.

In your case, the first person to start the rebase should change the
"# BASE" comment, and then apply those patches which he/she is most
familiar with.  When you hit a point where you need someone else's
expertise, you can do a "(cd patches; git commit -a)" to commit all of
the changes in the patch queue so far, and then let someone else take
over.  

They would then do:

# Pop all of the patches off the next developers work directory
guilt pop -a
# Update the patch queue
(cd patches; guilt pull)
# Now we need to make sure we have the latest kernel patches from mainline
git fetch
# Now update the work directory to the version specified by the patch
# series file
git merge $(head patches/series | sed -e 's/# BASE //')
# Now resume trying to apply patches, one at a time...
# next_patch
guilt push -a
# if there is a failed patch, force apply it and resolve patch rejects
guilt push -f
# refresh the patch
guilt refresh --diffstat
# .... and so on

My biggest suggestion, though, is to try to merge partial work earlier
rather than later.  I'd try getting a partially functioning device
driver merged first, and then try to get the optimizations applied
earlier.  If you don't want people using it in production, that's what
the EXPERIMENTAL tag is for...


						- Ted
