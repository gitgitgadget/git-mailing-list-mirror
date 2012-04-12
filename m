From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] fetch: Only call a new ref a "branch" if it's under refs/heads/.
Date: Thu, 12 Apr 2012 22:15:04 +0200
Message-ID: <4F8737C8.1020501@web.de>
References: <1334154569-26124-1-git-send-email-marcnarc@xiplink.com> <20120412055216.GC27369@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: marcnarc@xiplink.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 22:15:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIQQH-0002E3-Vu
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 22:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934539Ab2DLUPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 16:15:11 -0400
Received: from fmmailgate04.web.de ([217.72.192.242]:57789 "EHLO
	fmmailgate04.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757150Ab2DLUPK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 16:15:10 -0400
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate04.web.de (Postfix) with ESMTP id 825A875D4C60
	for <git@vger.kernel.org>; Thu, 12 Apr 2012 22:15:08 +0200 (CEST)
Received: from [192.168.178.48] ([91.3.165.27]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0LrKEG-1SAtvj2BO0-013ACW; Thu, 12 Apr 2012 22:15:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <20120412055216.GC27369@sigill.intra.peff.net>
X-Provags-ID: V02:K0:9FYZBgbo0LKxYVGeQ8XHt8FH2pYNFpYCQIEwzfWd8+6
 X6ND2GoQu1PP5JUNAtZE+a1bxiiwZdMtYETCw5gC8e+OapPd4F
 W1J82q1sBCbZ2Ss10oyqdvmYHx0v/3dAFNPK8UBGmbg0BBRFXL
 DlfT5RR5ReGT1mv8KtyO9R7iCHNewVu1+5mYkKmAwWZv073xMc
 BnaMS2U2efk1BTQ9LsSLQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195362>

Am 12.04.2012 07:52, schrieb Jeff King:
> On Wed, Apr 11, 2012 at 10:29:29AM -0400, marcnarc@xiplink.com wrote:
> 
>>  builtin/fetch.c |    9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index 65f5f9b..57be58a 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -298,8 +298,13 @@ static int update_local_ref(struct ref *ref,
>>  			what = _("[new tag]");
>>  		}
>>  		else {
>> -			msg = "storing head";
>> -			what = _("[new branch]");
>> +			if (!prefixcmp(ref->name, "refs/heads/")) {
>> +				msg = "storing head";
>> +				what = _("[new branch]");
>> +			} else {
>> +				msg = "storing ref";
>> +				what = _("[new ref]");
>> +			}
>>  			if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
>>  			    (recurse_submodules != RECURSE_SUBMODULES_ON))
>>  				check_for_new_submodule_commits(ref->new_sha1);
> 
> It looks like you kept the behavior the same with respect to
> recurse_submodules, which will continue to run for everything except
> tags. Which is probably a good choice, since your patch only wanted to
> deal with the status message, but I am left to wonder: if submodules
> were intended to be recursed for branches but not tags, what should
> happen for other types of refs? Was it intentional that they fell into
> the "branch" category here, or were they following the same failure to
> distinguish that the message-writing code had?
> 
> This code block handles only new refs.  If you look at the code below,
> updates of existing refs (forced or not) will happen for all refs,
> including tags.
> 
> Jens, can you double-check the intended logic?

Thanks for spotting this inconsistency. I think it makes sense to
check for new submodule commits no matter if we fetched a new tag,
branch or other ref. I can't remember a reason why I put that code
into the refs & branches part instead of doing that for every new
ref. Patch following ...
