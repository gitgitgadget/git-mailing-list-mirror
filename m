From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [RFC/PATCH 1/1] format-patch: add an option to record base tree
 info
Date: Wed, 24 Feb 2016 15:07:27 +0800
Message-ID: <20160224070727.GA23808@wfg-t540p.sh.intel.com>
References: <1456109938-8568-2-git-send-email-xiaolong.ye@intel.com>
 <xmqqmvqt8jgz.fsf@gitster.mtv.corp.google.com>
 <20160223014741.GA21025@wfg-t540p.sh.intel.com>
 <xmqqio1f3oi9.fsf@gitster.mtv.corp.google.com>
 <20160223091740.GA3830@wfg-t540p.sh.intel.com>
 <20160223103253.GE5273@mwanda>
 <20160223120015.GA10488@wfg-t540p.sh.intel.com>
 <20160223133135.GF5273@mwanda>
 <20160224025519.GB16562@wfg-t540p.sh.intel.com>
 <xmqqpovmmxhv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
	Xiaolong Ye <xiaolong.ye@intel.com>, git@vger.kernel.org,
	ying.huang@intel.com, philip.li@intel.com, julie.du@intel.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Christoph Hellwig <hch@lst.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	LKML <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Wed Feb 24 08:07:43 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1aYTXz-0006Br-5J
	for glk-linux-kernel-3@plane.gmane.org; Wed, 24 Feb 2016 08:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757226AbcBXHHe (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 24 Feb 2016 02:07:34 -0500
Received: from mga02.intel.com ([134.134.136.20]:25165 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750931AbcBXHHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Feb 2016 02:07:32 -0500
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP; 23 Feb 2016 23:07:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,493,1449561600"; 
   d="scan'208";a="658355940"
Received: from wfg-t540p.sh.intel.com ([10.239.197.212])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Feb 2016 23:07:28 -0800
Received: from wfg by wfg-t540p.sh.intel.com with local (Exim 4.86)
	(envelope-from <fengguang.wu@intel.com>)
	id 1aYTXj-0006Me-UV; Wed, 24 Feb 2016 15:07:27 +0800
Content-Disposition: inline
In-Reply-To: <xmqqpovmmxhv.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287173>

On Tue, Feb 23, 2016 at 10:30:04PM -0800, Junio C Hamano wrote:
> Fengguang Wu <fengguang.wu@intel.com> writes:
> 
> > The necessary lines for the robot are
> >
> >         base commit:
> >         base patch-id:
> > or
> >         base tree-id:
> >         base patch-id:
> 
> I will not repeat why a commit object name would be more appropriate
> than a tree object name here (please see my response to HPA).

Yes I see that reasoning in your other email.

> > The "base tree-id" will be useful if the submitted patchset is based
> > on a public (maintainer) commit.
> >
> > The "base patch-id" will be useful if the submitted patchset is based
> > on another patchset someone (likely the developer himself) posted to
> > the mailing list.
> 
> Is there a database of in-flight patches indexed by their patch-ids
> with a large enough coverage (hopefully those who maintain such a

Yes, the 0day robot internally maintains such a patch-id => commit-id
(of the below git tree) database for in-flight patches.

We exported a git tree which holds all in-flight patches, where each
patchset maps to a new branch:

https://github.com/0day-ci/linux/branches

We monitor dozens of linux kernel mailing lists, the coverage is
pretty good for the linux kernel project.

> database are using the --stable version of the patch-id for indexing
> the patches)?

Right, we do use the --stable option.

> I am wondering how well this scales, especially if a
> well-known commit named by "base commit" needs to be checked out and
> then many in-flight patches identified by "base patch-id"s need to
> be applied on top of it, to prepare the tree-ish the patch being
> evaluated can be applied to.

The database is effectively a key-value store, in the scale of 1000
new mappings per day. If we only keep 100 days data, there will be
100k mappings, which could be hold in 10MB memory.

> This starts to sound more like something you would want to write in
> the cover letter, or the trailer block next to Signed-off-by: at the
> end of the first patch in the series.

Yes, that's roughly what the current patch does, except in the latter
case we add new info after diffstat.

> Or even after the mail
> signature at the very end of the message (incidentally that would
> probably minimize the damage to the Git codebase needed for this
> addition--you should be able to do this without touching anything
> other than builtin/log.c).

That's an interesting place. It looks worth trying. 

Thanks,
Fengguang
