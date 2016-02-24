From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [RFC/PATCH 1/1] format-patch: add an option to record base tree
 info
Date: Wed, 24 Feb 2016 10:30:01 +0800
Message-ID: <20160224023001.GA16562@wfg-t540p.sh.intel.com>
References: <1456109938-8568-1-git-send-email-xiaolong.ye@intel.com>
 <1456109938-8568-2-git-send-email-xiaolong.ye@intel.com>
 <xmqqmvqt8jgz.fsf@gitster.mtv.corp.google.com>
 <20160223014741.GA21025@wfg-t540p.sh.intel.com>
 <xmqqio1f3oi9.fsf@gitster.mtv.corp.google.com>
 <20160223091740.GA3830@wfg-t540p.sh.intel.com>
 <87r3g3jj54.fsf@x220.int.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Xiaolong Ye <xiaolong.ye@intel.com>, git@vger.kernel.org,
	ying.huang@intel.com, philip.li@intel.com, julie.du@intel.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
X-From: linux-kernel-owner@vger.kernel.org Wed Feb 24 03:30:40 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1aYPDq-0007kb-CC
	for glk-linux-kernel-3@plane.gmane.org; Wed, 24 Feb 2016 03:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755103AbcBXCaa (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 23 Feb 2016 21:30:30 -0500
Received: from mga01.intel.com ([192.55.52.88]:57560 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753677AbcBXCa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Feb 2016 21:30:28 -0500
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP; 23 Feb 2016 18:30:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,492,1449561600"; 
   d="scan'208";a="658241253"
Received: from wfg-t540p.sh.intel.com ([10.239.197.212])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Feb 2016 18:30:02 -0800
Received: from wfg by wfg-t540p.sh.intel.com with local (Exim 4.86)
	(envelope-from <fengguang.wu@intel.com>)
	id 1aYPDF-0004Rj-IO; Wed, 24 Feb 2016 10:30:01 +0800
Content-Disposition: inline
In-Reply-To: <87r3g3jj54.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287160>

Hi Eric,

On Tue, Feb 23, 2016 at 01:56:07PM -0600, Eric W. Biederman wrote:
> 
> Fengguag Wu, Xiaolong Ye, have you attempted to use the truncated
> sha1 of the file the patch applies to?  Git already places a file sha1
> at the top of a patch.  See the index line?
> 
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index eccd925c6e82..3c3f8172c734 100644

Yes we've evaluated to make use of that index. The conclusion is,
it helps make a better guess, however it's still a guessing work
and far from perfect.

A simple accounting shows only 1/5 files will be changed between
two major kernel releases:

        wfg /c/linux% git ls-files |wc -l    
        52915
        wfg /c/linux% git diff --name-only v4.3 v4.4|wc -l                               
        10606

That means a huge number candidate base tree IDs matching the given
blob IDs.

> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> 
> As I understand it you are aiming for making a good guess what the patch
> or patches apply to, having a set of file hashes looks like it would
> give you that.
> 
> All it should take is to iterate over a patchset and for each file in
> the patchset capture the first file hash.  Then in the smallish set of
> maintainer trees see if that set of file hashes matches any of their
> recent commits.  You should be able to prune the set of possible
> maintainer trees even more by looking at the mailling list or lists
> the patch was submitted to.
 
We actually start with the above thinking half year ago. Yes it'll
help narrow down the list of candidate maintainer trees. And the
chance will be increased if the patchset modifies multiple files,
and the fact some files are modified more frequently than the others.
However it's still fundamentally a guess work. The best choice is to
ask for explicit "base tree ID".

> Before we talk about adding anything more I think we need a clear
> picture of what you have tried with what already exists.  A decade ago
> part of the problem was that not everyone used git.  At best it will
> take a little while before everyone upgrades to a version of git diff
> containing your changes, and if possibly even longer if they have to
> start specifying an additional option when a diff is generated.

That's a good concern. It may take year long delay before reaching
reasonable population of the new feature.

To speedup the process, we could advocate the new git option in 0day
robot's error reports. Since we catch errors in ~10 LKML patches each
day, within months most kernel developers should get the tips on how
to set it up and enable the feature by default.

Thanks,
Fengguang
