From: Ye Xiaolong <xiaolong.ye@intel.com>
Subject: Re: [PATCH v2 3/4] format-patch: introduce --base=auto option
Date: Thu, 24 Mar 2016 12:19:25 +0800
Message-ID: <20160324041925.GB26582@yexl-desktop>
References: <1458723147-7335-1-git-send-email-xiaolong.ye@intel.com>
 <1458723147-7335-4-git-send-email-xiaolong.ye@intel.com>
 <xmqqbn65caqi.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 05:20:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiwkp-0005Hv-4D
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 05:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbcCXEUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 00:20:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:38006 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750890AbcCXEUC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 00:20:02 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP; 23 Mar 2016 21:20:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,383,1455004800"; 
   d="scan'208";a="940415598"
Received: from yexl-desktop.sh.intel.com (HELO localhost) ([10.239.159.26])
  by orsmga002.jf.intel.com with ESMTP; 23 Mar 2016 21:19:59 -0700
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com
Content-Disposition: inline
In-Reply-To: <xmqqbn65caqi.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289708>

On Wed, Mar 23, 2016 at 11:25:41AM -0700, Junio C Hamano wrote:
>Xiaolong Ye <xiaolong.ye@intel.com> writes:
>
>> +
>> +	diff_setup(&diffopt);
>> +	DIFF_OPT_SET(&diffopt, RECURSIVE);
>> +	diff_setup_done(&diffopt);
>
>It is annoying that you moved "diff" stuff here (if it can be
>initialized once at the beginning and then reused over and over,
>it should have been done here from the beginning at PATCH 2/4).

My bad, I will put "diff" stuff at the beginning at PATCH 2/4.
>
>> +	if (!strcmp(base_commit, "auto")) {
>> +		curr_branch = branch_get(NULL);
>> +		upstream = branch_get_upstream(curr_branch, NULL);
>> +		if (upstream) {
>> +			if (get_sha1(upstream, sha1))
>> +				die(_("Failed to resolve '%s' as a valid ref."), upstream);
>> +			base = lookup_commit_or_die(sha1, "upstream base");
>> +			oidcpy(&bases->base_commit, &base->object.oid);
>> +		} else {
>> +			commit_patch_id(prerequisite_head, &diffopt, sha1);
>> +			oidcpy(&bases->parent_commit, &prerequisite_head->object.oid);
>> +			hashcpy(bases->parent_patch_id.hash, sha1);
>> +			return;
>
>What happens if you did this sequence?
>
>	$ git fetch origin
>        $ git checkout -b fork origin/master
>        $ git fetch origin
>        $ git format-patch --base=auto origin..
>
>You grab the updated origin/master as base and use it here, no?
>At that point the topology would look like:
>
>          1---2---3 updated upstream
>         /
>	0---X---Y---Z---A---B---C
>        ^
>        old upstream
>
>so you are basing your worn on "0" (old upstream) but setting base
>to "3"
>
>Wouldn't that trigger "base must be an ancestor of Z" check you had
>in [PATCH 2/4]?

Yes, this is flawed, I will follow your below suggestion to compute
the merge base as the base commit through upstream and specified range.

>
>I also do not see the point of showing "parent id" which as far as I
>can see is just a random commit object name and show different
>output that is not even described what it is.  It would be better to

Here is our consideration:
There is high chance that branch_get_upstream will retrun NULL(thus we
are not able to get exact base commit), since developers may checkout
branch from a local branch or a commit and haven't set "--set-upstream-to"
to track a remote branch, in this case, we want to provide likely useful
info(here is parent commit id and patch id), based on it, 0day robot still
have good chance to find the suitable base.
Otherwise, I'm afraid this annotation system won't work effectively in long run.

Thanks,
Xiaolong.
>
> * find the upstream (i.e. 3 in the picture) and then with our range
>   (i.e. A B and C) compute the merge base (i.e. you would find 0)
>   and use it as base;
>
> * if there is no upstream, error out and tell the user that there
>   is no upstream.  The user is intelligent enough and knows what
>   commit the base should be.
>
>I suspect, but I didn't think things through.
>
>
>--
>To unsubscribe from this list: send the line "unsubscribe git" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
