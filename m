From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] fetch: Only call a new ref a "branch" if it's under refs/heads/.
Date: Thu, 12 Apr 2012 16:36:32 -0400
Message-ID: <4F873CD0.4050204@xiplink.com>
References: <1334154569-26124-1-git-send-email-marcnarc@xiplink.com> <20120412055216.GC27369@sigill.intra.peff.net> <4F8737C8.1020501@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 12 22:36:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIQl3-0006gP-88
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 22:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966002Ab2DLUgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 16:36:40 -0400
Received: from smtp172.dfw.emailsrvr.com ([67.192.241.172]:54123 "EHLO
	smtp172.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762724Ab2DLUgj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 16:36:39 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp17.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id E9290188C96
	for <git@vger.kernel.org>; Thu, 12 Apr 2012 16:36:38 -0400 (EDT)
X-Virus-Scanned: OK
Received: from smtp154.ord.emailsrvr.com (smtp154.ord.emailsrvr.com [173.203.6.154])
	by smtp17.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTPS id D03CF188C5D
	for <git@vger.kernel.org>; Thu, 12 Apr 2012 16:36:38 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp17.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 63D621900A1;
	Thu, 12 Apr 2012 16:36:06 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp17.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 1E2EE190096;
	Thu, 12 Apr 2012 16:36:05 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
In-Reply-To: <4F8737C8.1020501@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195365>

On 12-04-12 04:15 PM, Jens Lehmann wrote:
> Am 12.04.2012 07:52, schrieb Jeff King:
>> On Wed, Apr 11, 2012 at 10:29:29AM -0400, marcnarc@xiplink.com wrote:
>>
>>>  builtin/fetch.c |    9 +++++++--
>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>>> index 65f5f9b..57be58a 100644
>>> --- a/builtin/fetch.c
>>> +++ b/builtin/fetch.c
>>> @@ -298,8 +298,13 @@ static int update_local_ref(struct ref *ref,
>>>  			what = _("[new tag]");
>>>  		}
>>>  		else {
>>> -			msg = "storing head";
>>> -			what = _("[new branch]");
>>> +			if (!prefixcmp(ref->name, "refs/heads/")) {
>>> +				msg = "storing head";
>>> +				what = _("[new branch]");
>>> +			} else {
>>> +				msg = "storing ref";
>>> +				what = _("[new ref]");
>>> +			}
>>>  			if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
>>>  			    (recurse_submodules != RECURSE_SUBMODULES_ON))
>>>  				check_for_new_submodule_commits(ref->new_sha1);
>>
>> It looks like you kept the behavior the same with respect to
>> recurse_submodules, which will continue to run for everything except
>> tags. Which is probably a good choice, since your patch only wanted to
>> deal with the status message, but I am left to wonder: if submodules
>> were intended to be recursed for branches but not tags, what should
>> happen for other types of refs? Was it intentional that they fell into
>> the "branch" category here, or were they following the same failure to
>> distinguish that the message-writing code had?
>>
>> This code block handles only new refs.  If you look at the code below,
>> updates of existing refs (forced or not) will happen for all refs,
>> including tags.
>>
>> Jens, can you double-check the intended logic?
> 
> Thanks for spotting this inconsistency. I think it makes sense to
> check for new submodule commits no matter if we fetched a new tag,
> branch or other ref. I can't remember a reason why I put that code
> into the refs & branches part instead of doing that for every new
> ref. Patch following ...

I assumed it was an optimization of some sort -- that since tags are normally
only fetched when they're part of a requested branch's history (right?),
there was no point in doing submodule recursion on the fetched tags since
those tagged tree-ishes had already been submodule-recursed.

Or something like that.  :)

		M.
