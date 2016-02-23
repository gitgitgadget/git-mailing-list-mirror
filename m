From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [RFC/PATCH 1/1] format-patch: add an option to record base tree
 info
Date: Tue, 23 Feb 2016 20:00:15 +0800
Message-ID: <20160223120015.GA10488@wfg-t540p.sh.intel.com>
References: <1456109938-8568-1-git-send-email-xiaolong.ye@intel.com>
 <1456109938-8568-2-git-send-email-xiaolong.ye@intel.com>
 <xmqqmvqt8jgz.fsf@gitster.mtv.corp.google.com>
 <20160223014741.GA21025@wfg-t540p.sh.intel.com>
 <xmqqio1f3oi9.fsf@gitster.mtv.corp.google.com>
 <20160223091740.GA3830@wfg-t540p.sh.intel.com>
 <20160223103253.GE5273@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Xiaolong Ye <xiaolong.ye@intel.com>, git@vger.kernel.org,
	ying.huang@intel.com, philip.li@intel.com, julie.du@intel.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Christoph Hellwig <hch@lst.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	LKML <linux-kernel@vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
X-From: linux-kernel-owner@vger.kernel.org Tue Feb 23 13:00:36 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1aYBdn-0008Ec-NH
	for glk-linux-kernel-3@plane.gmane.org; Tue, 23 Feb 2016 13:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbcBWMAX (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 23 Feb 2016 07:00:23 -0500
Received: from mga14.intel.com ([192.55.52.115]:4499 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750737AbcBWMAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Feb 2016 07:00:21 -0500
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP; 23 Feb 2016 04:00:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,489,1449561600"; 
   d="scan'208";a="657799872"
Received: from liquan1-mobl1.ccr.corp.intel.com (HELO wfg-t540p.sh.intel.com) ([10.254.214.237])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Feb 2016 04:00:16 -0800
Received: from wfg by wfg-t540p.sh.intel.com with local (Exim 4.86)
	(envelope-from <fengguang.wu@intel.com>)
	id 1aYBdX-0002xU-Lp; Tue, 23 Feb 2016 20:00:15 +0800
Content-Disposition: inline
In-Reply-To: <20160223103253.GE5273@mwanda>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287045>

Hi Dan,

On Tue, Feb 23, 2016 at 01:32:53PM +0300, Dan Carpenter wrote:
> So this is the format for the first patch?
> 
> base commit: 0233b800c838ddda41db318ee396320b3c21a560

What's in my mind is lines like

base tree/branch: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
base commit: afd2ff9b7e1b367172f18ba7f693dfb62bdcb2dc
base patch-id: a849260a843115dbac4b1a330d44256ee6b16d7b

The point is one piece of information per line, so that new lines can
be added trivially in future, like

base patch-subject: Linux 4.4
base tag: v4.4

The exact format can be improved wherever suitable. For example, use
more suitable key name part (eg. "base commit" => "base-commit") or
value part (eg. "$tree_url $branch" to "$tree_url#$branch").

> Can we change it to include the name of the public tree we are starting
> from?
> 
> applies-to: 0233b800c838 git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git#master

No problem, just that I'd prefer breaking up such information into
multi "key: value" lines.

> Of course, my absolute prefered format would be:
> 
> applies-to: net-next 0233b800c838
> 
> I don't think that's possible though?  I often write that sort of a line
> in my emails to Dave already.

Yeah, that'd be most human readable. It does require people (and
scripts) to reach consensus on the tree/branch name, which may only be
possible for well known trees.

> Fengguang was suggesting something like this if we have to include
> unmerged patches:
> 
> applies-to: net-next 0233b800c838
> private patchset 1
> private patchset 2
> 
> I don't think git knows what a patchset is.

Git may not need to have patchset concept. Suppose a developer's local
branch has

        v4.4
        private commit 1, subject: do aaa
        private commit 2, subject: do bbb
        private commit 3, subject: do ccc
        private commit 4, subject: do ddd
        private commit 5, subject: do eee

If he decided to send commits 1-2 as one patchset, and 3-5 as another
patchset to LKML. The 2 cover letters would look like (only showing
useful fields):

        $ git format-patch commit 1..commit 2
        [PATCH 0/2]
        base commit: afd2ff9b7e1b367172f18ba7f693dfb62bdcb2dc

        $ git format-patch commit 3..commit 5
        [PATCH 0/3]
        base patch-subject: do bbb

The 0day robot will be able to find the suitable base and re-create
exactly the same tree object for both the above 2 patchsets based on
the first one's "base commit" and the second one's "base patch-subject".

> We would have to include the subject line for each unmerged patch.

That's a good idea!

> I think we should only do that if there is a cover letter, otherwise
> the it's too noisy.

Or if no cover letter, the information can be included in the first
patch, ie. [PATCH 1/N].

Thanks,
Fengguang
