From: Ye Xiaolong <xiaolong.ye@intel.com>
Subject: Re: [PATCH v3 2/4] format-patch: add '--base' option to record base
 tree info
Date: Tue, 5 Apr 2016 13:52:03 +0800
Message-ID: <20160405055203.GA10110@yexl-desktop>
References: <1459388776-18066-1-git-send-email-xiaolong.ye@intel.com>
 <1459388776-18066-3-git-send-email-xiaolong.ye@intel.com>
 <xmqqy48yo8eb.fsf@gitster.mtv.corp.google.com>
 <20160401133801.GA2915@yexl-desktop>
 <xmqqpou9jp4b.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 07:52:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anJv6-0001nH-CX
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 07:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbcDEFww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 01:52:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:23931 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763AbcDEFwv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 01:52:51 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 04 Apr 2016 22:52:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,442,1455004800"; 
   d="scan'208";a="938394447"
Received: from yexl-desktop.sh.intel.com (HELO localhost) ([10.239.159.26])
  by fmsmga001.fm.intel.com with ESMTP; 04 Apr 2016 22:52:49 -0700
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com
Content-Disposition: inline
In-Reply-To: <xmqqpou9jp4b.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290760>

On Fri, Apr 01, 2016 at 09:00:20AM -0700, Junio C Hamano wrote:
>Ye Xiaolong <xiaolong.ye@intel.com> writes:
>
>> On Thu, Mar 31, 2016 at 10:38:04AM -0700, Junio C Hamano wrote:
>>
>>>The contents of this look OK, but does it format correctly via
>>>AsciiDoc?  I suspect that only the first paragraph up to "of this
>>>shape:" would appear correctly and all the rest would become funny.
>>
>> Sorry, just heard of AsciiDoc, I will try to use it to do the right format work.
>
>Please make sure "make -C Documentation" produces sensible output
>for *.1 (manpage) and *.html.
OK.

>
>>>> +	init_revisions(&revs, NULL);
>>>> +	revs.max_parents = 1;
>>>> +	base->object.flags |= UNINTERESTING;
>>>> +	add_pending_object(&revs, &base->object, "base");
>>>> +	for (i = 0; i < total; i++) {
>>>> +		list[i]->object.flags |= 0;
>>>
>>>What does this statement do, exactly?  Are you clearing some bits
>>>but not others, and if so which ones?
>>
>> My mistake, it's useless and should be removed.
>
>It probably make sense to do "&= ~UNINTERESTING" there, though.  You
>are adding one UNINTERESTING object (i.e. the base) and adding
>objects that are on the list[] as interesting.
Yeah, it does make sense, I'll do the change.

>
>>>This shows the patches in the order discovered by the revision
>>>traversal, which typically is newer to older.  Is that intended?
>>>Is it assumed that the order of the patches does not matter?
>>
>> The prerequisite patches should show in topological order, thus robot
>> could parse them one by one and apply the patches in reverse order.
>
>If you have history where base is B, with three prerequisites 1-2-3,
>before the patch series A-B-C, i.e.
>
>	B---1---2---3---A---B---C
>
>if you are showing "base-commit: B" as the first line in the base
>tree information block, it would be natural to expect that the
>prerequisite patch ids are listed for 1 and then 2 and then finally
>3, i.e.
>
>	base-commit: B
>        prerequisite-patch-id: 1
>        prerequisite-patch-id: 2
>        prerequisite-patch-id: 3
>
>no?
I think this sounds more sensible than what I had thought, I'll adjust 
the showing sequence accordingly.

>
>Also I know _you_ intend to consume this by robot, but it makes me
>wonder if with a minimum update you can make the output also more
>useful for bystander humans.  A mailing list participant may
>
> - see an early round of a series that interests her,
> - try to apply them to her tree,
> - find that the series does not apply, but
> - sees that a block to help identify to what tree the series is
>   meant to apply.
>
>With a list of 40-hex alone, she may not be able to figure out the
>prerequisites, but if there is some other clue that helps her to
>identify the base commit and these patches, she may be able to
>construct a tree that is close enough.  Maybe you can help her by
>appending the title of the commit and patches at the end of these
>lines?
>
>This is not a strong suggestion (yet); I am thinking aloud at this
>point, without knowing how much it would help in practice to do so.
Thanks for the suggestions, actually it is what we have planned for next
step to make the output info more friendly for human being, I'll
follow up on it.

Thanks,
Xiaolong.

>--
>To unsubscribe from this list: send the line "unsubscribe git" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
