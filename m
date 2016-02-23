From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [RFC/PATCH 1/1] format-patch: add an option to record base tree
 info
Date: Tue, 23 Feb 2016 09:47:41 +0800
Message-ID: <20160223014741.GA21025@wfg-t540p.sh.intel.com>
References: <1456109938-8568-1-git-send-email-xiaolong.ye@intel.com>
 <1456109938-8568-2-git-send-email-xiaolong.ye@intel.com>
 <xmqqmvqt8jgz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Xiaolong Ye <xiaolong.ye@intel.com>, git@vger.kernel.org,
	ying.huang@intel.com, philip.li@intel.com, julie.du@intel.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 02:48:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY25P-0007X2-V4
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 02:48:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754219AbcBWBsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 20:48:18 -0500
Received: from mga04.intel.com ([192.55.52.120]:59551 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752159AbcBWBsR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 20:48:17 -0500
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP; 22 Feb 2016 17:47:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,487,1449561600"; 
   d="scan'208";a="657484750"
Received: from byao2-mobl.ccr.corp.intel.com (HELO wfg-t540p.sh.intel.com) ([10.254.215.134])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Feb 2016 17:47:50 -0800
Received: from wfg by wfg-t540p.sh.intel.com with local (Exim 4.86)
	(envelope-from <fengguang.wu@intel.com>)
	id 1aY24j-0002A8-KI; Tue, 23 Feb 2016 09:47:41 +0800
Content-Disposition: inline
In-Reply-To: <xmqqmvqt8jgz.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287006>

Hi Junio,

On Sun, Feb 21, 2016 at 08:19:56PM -0800, Junio C Hamano wrote:
> Xiaolong Ye <xiaolong.ye@intel.com> writes:
> 
> > It would be helpful for maintainers or reviewers to know the base tree
> > info of the patches created by git format-patch. Teach git format-patch
> > a --base-tree-info option to record these info.
> >
> > Signed-off-by: Xiaolong Ye <xiaolong.ye@intel.com>
> > ---
> 
> I have a mixed feeling about this one, primarily because this was
> already tried quite early in the life of "format-patch" command.
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/9694/focus=9757
> 
> Only the name is different (it was called "applies-to" and named a
> tree object).

Either commit or tree object will work for us. We can use it in
v2 if you prefer tree object.

> The approach the patch I am responding to takes, which is to touch
> diff.[ch], is probably flawed.  Even if we assume, for the sake of
> reviewing, that "which commit (or tree) this patch applies to" is a
> good thing to add, this is useful only to the very first patch in
> the series.  Hence its output should come from some function in
> builtin/log.c that iterates over commits and done for only the first
> one in a series, not by the diff machinery that is called by that
> loop iterating over commits.

For patchset with a cover letter, builtin/log.c is the best place to
put the base tree info:

	[PATCH 0/3] add base tree info here
	[PATCH 1/3]
	[PATCH 2/3]
	[PATCH 3/3]

For the others, it looks the best place for the new info is right
after the diffstat of the first patch:

	[PATCH 1/3] add base tree info here
	[PATCH 2/3]
	[PATCH 3/3]

Since the diffstat is shown in diff.c, we add a few lines of code
after diff.c calls diff_summary().

> It is unclear what your goal is, and "would be helpful" is just as
> convincing as saying it would be helpful to record the phase of the
> moon when the commit was made.  A typical patch rarely touches all
> the files in the project, so there will be multiple commits in the
> existing history of the project to which the patch would apply
> cleanly.
>
> Is it your goal to insist on one exact commit the patch is applied
> to?

Right. Our goal is fully automated patch testing, where the base tree
info is required for *reliably* avoid reporting false positives.

A clean git-apply does not guarantee the resulted code is logically
consistent and hence testable by 3rd party. For a 3rd party tester to
provide useful and trustable test reports, he must apply the patch to
exactly the same base as the patch submitter.

For example, suppose a developer posted a patch to file A to add a
call to func_foo(). The test robot could apply it cleanly to latest
kernel git tree, eg. v4.5-rc5, and continue to build test it. Suppose
v4.5-rc5 included another commit to rename func_foo() to func_bar() in
file B. As a result, the robot will catch and report a build error
"func_foo() not defined" to the developer, who will then complain "but
my patch is based on v4.4, you tested my patch on the wrong base".

Without the base tree info, what we do now is a lot of dirty guess
works, trying the same patch on some "maybe suitable" bases and see if
they'll trigger the same error. For example, this is one of the error
reports the 0day robot auto sent to LKML:

        https://lists.01.org/pipermail/kbuild-all/2016-February/017385.html
        Re: [PATCH 2/2] kernel: sched: fix preempt_disable_ip recording for preempt_disable()

        [auto build test ERROR on tip/sched/core]
        [also build test ERROR on v4.5-rc3 next-20160211]
        [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

We sent 300+ "/maybe/ your patch has problem" reports like that in
each month. Whose quality can be greatly improved if we can be 100%
sure about the test errors.

> Or are you OK as long as the patch is applied to the
> same set of blobs the diff was taken from?  A developer may have a
> few unrelated and private commits on top of Linus's released
> version, on top of which she builds a series.  As long as the paths
> touched by the patches in this series do not overlap with the paths

As shown in the above example, "no overlap paths" is not a sufficient
condition for "patches are irrelevant". Because patch A may change
definition of a function in one file while patch B may reference that
function in another file.

So there is no easy mechanical way for a script to remove the several
non-Linus commits and can still provide useful base commit info.

However if we teach this patch to include one more line:

        base patch-id: HASH

And the developer's local patches are

        mainline tree
        private patchset 1
        private patchset 2

The developer will likely have already post patchset 2's base
patchset 1 to the mailing list, then our robot already know about
patchset 1's patch ids, therefore being able to apply patchset 2
to the correct base.

> touched by the initial few unrelated and private commits, such a
> series should be testable directly on top of Linus's released
> version, without forcing her to first rebase the series to remove
> these initial few unrelated and private commits from her history
> before running "format-patch --base-commit" (your patch is recording
> the commit object name, and it shouldn't call it tree-info), but you

Yes for now. In future, people might find adding such lines being
helpful to 3rd party developers:

        base tree/branch: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

And if that feature is feasible, what would be the general suitable
name or form for this option?

        --base-tree=<none|commit|url|all>

> are forcing her to do so because these private commits will not be
> available to those who apply her patches.

In normal cases, a developer may

1) setup local topic branches

Which will reduce the chance that base commit is some unrelated
private local changes.

2) base his branch on either mainline or some subsystem tree

As long as it's based on a public available tree/commit, we'll have
very good chance to find that tree and apply patch to exactly the same
base. Because we monitor 600+ public kernel git trees:

        https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/tree/repo/linux

> If you are OK with accepting a patch application to a tree with the
> same blobs the diff was taken from, then the format-patch output
> already has all the necessary information.  For each "diff --git"
> part, there is the "index $old..$new" line that records preimage and
> postimage blob object ID, so you should be able to find a tree that
> has the matching blobs in the paths mentioned in the patch, and it
> is guaranteed that the patch would apply cleanly to such a tree.
> 
> Of course, that requires the recipient of the patch to have the all
> the blobs mentioned as the preimage in the patch, but it would be a
> reasonable assumption, as your patch assumes that the recipient has
> the commit, and if he has a commit by definition he would have all
> the blobs recorded by that commit.
> 
> Incidentally, the "index $old..$new" lines are what make "am -3"
> possible.

Thanks for the info. We've studied the information provided by the
index line and concluded that it can hardly help us find the right
tree object -- there are too many tree objects that contain the same
blob index. So we end up wrote this patch.

Thanks,
Fengguang
