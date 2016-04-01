From: Ye Xiaolong <xiaolong.ye@intel.com>
Subject: Re: [PATCH v2 3/4] format-patch: introduce --base=auto option
Date: Fri, 1 Apr 2016 13:07:49 +0800
Message-ID: <20160401050749.GA25392@yexl-desktop>
References: <1458723147-7335-1-git-send-email-xiaolong.ye@intel.com>
 <1458723147-7335-4-git-send-email-xiaolong.ye@intel.com>
 <xmqqbn65caqi.fsf@gitster.mtv.corp.google.com>
 <20160324041925.GB26582@yexl-desktop>
 <xmqq37rfajy1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 07:08:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alrK1-0002n3-VZ
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 07:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752964AbcDAFIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 01:08:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:64811 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706AbcDAFId (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 01:08:33 -0400
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP; 31 Mar 2016 22:08:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,425,1455004800"; 
   d="scan'208";a="678983525"
Received: from yexl-desktop.sh.intel.com (HELO localhost) ([10.239.159.26])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Mar 2016 22:08:32 -0700
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com
Content-Disposition: inline
In-Reply-To: <xmqq37rfajy1.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290506>

On Thu, Mar 24, 2016 at 10:01:58AM -0700, Junio C Hamano wrote:
>Ye Xiaolong <xiaolong.ye@intel.com> writes:
>
>> On Wed, Mar 23, 2016 at 11:25:41AM -0700, Junio C Hamano wrote:
>>>I also do not see the point of showing "parent id" which as far as I
>>>can see is just a random commit object name and show different
>>>output that is not even described what it is.  It would be better to
>>
>> Here is our consideration:
>> There is high chance that branch_get_upstream will retrun NULL(thus we
>> are not able to get exact base commit), since developers may checkout
>> branch from a local branch or a commit and haven't set "--set-upstream-to"
>> to track a remote branch, in this case, we want to provide likely useful
>> info(here is parent commit id and patch id)
>
>I do not agree with that reasoning at all, primarily because your
>"likely useful" is not justfied.
>
>Could you explain what makes you think that it is "likely" that the
>commit that matches "parent commit id" is available to the recipient
>of the patch?
>

Hi, Junio

Still want to discuss with you about the proposal that showing the "parent
commit-id as well as patch-id" when exact base commit is failed to get through
cmdline or upstream", from 0day robot's view, there would be 2 kinds of base tree
info appended at the bottom of patch message.

For the info starts with "base-commit: <xxx> ...", robot would know it
is reliable base commit, it would just checkout it and apply the prerequisite
patches and patchset for the work.

For the info starts with "parent-commit: <xxx>; parent-patch-id: <xxx>",
there are 3 situations 0day robot would need to handle:

1) parent commit is well-known public commit(e.g. one in Linus's tree),
   in this case, robot will just checkout the parent commit and apply the
   patchset accordingly.

2) parent commit is well-known in-flight patch, since 0day maintains the
   database of in-flight patches indexed by their patch-ids and
   commit-ids(of the git tree mentioned below), it also exports a git tree
   which holds all in-flight patches, where each patchset map to a new branch:

   https://github.com/0day-ci/linux/branches

   0day will find that patch in database by parent patch id, then do the
   checkout and apply work.

3) parent commit/patch-id is unknown, maybe because it's a
   - private patch;
   - public patch that's slightly modified locally;
   - public patch that's not covered by the 0day database
   all should be rare cases.

In practice, most developers may not feed exact commit id by --base=<xxx>
regularly when using git format-patch, this "showing parent commit" solution
could save developers' energy and reach a high coverage in the meantime.

Thanks,
Xiaolong.

>Whatever the reason is, if it _is_ likely, then I do not see a point
>in spending cycle to do get-upstream and merge-base, or giving an
>option to the user to explicitly specify the base.  Given that this
>series does these things, I'd have to conclude your "likely useful"
>is "might possibly turn out to be useful in some cases if you are
>lucky but is no way reliable" at best.
>
>Rather than throwing an unreliable information in the output and
>blindly proceeding, I'd think you would want to error out and tell
>the user to explicitly give the base without producing the patch
>output.  That way, you will not get patches with unreliable
>information.
>
>Suggesting to use set-upstream-to when you give that error message
>may also be helpful.
