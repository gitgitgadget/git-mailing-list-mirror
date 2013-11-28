From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Pack transfer negotiation to tree and blob level?
Date: Thu, 28 Nov 2013 08:40:09 -0000
Organization: OPDS
Message-ID: <4A4C52E5034347EF80B0D63DF71AE4C9@PhilipOakley>
References: <1E0A3B7F917445C7A968C81C35892FD4@PhilipOakley> <CACsJy8C5om91ObOHvSjDyDtHfCB9Y2gSbgF8Dsi2oXCbO55Czw@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Duy Nguyen" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 28 09:39:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vlx8C-0008Sv-Tl
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 09:39:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069Ab3K1IjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Nov 2013 03:39:25 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:31543 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750884Ab3K1IjY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Nov 2013 03:39:24 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AogXALwAl1JZ8YjW/2dsb2JhbABZgweEBYU+sAIFAQIBAYEeF3SCIAUBAQQBCAEBGRUeAQEhBQYCAwUCAQMOBwECAgIFIQICFAEECBIGBxcGCgkIAgECAwGHXgMJCq81iFwNiAIXgSmLTYE6V4JyNYETA48chw2ORYU5gyk8gS0
X-IPAS-Result: AogXALwAl1JZ8YjW/2dsb2JhbABZgweEBYU+sAIFAQIBAYEeF3SCIAUBAQQBCAEBGRUeAQEhBQYCAwUCAQMOBwECAgIFIQICFAEECBIGBxcGCgkIAgECAwGHXgMJCq81iFwNiAIXgSmLTYE6V4JyNYETA48chw2ORYU5gyk8gS0
X-IronPort-AV: E=Sophos;i="4.93,789,1378854000"; 
   d="scan'208";a="443511766"
Received: from host-89-241-136-214.as13285.net (HELO PhilipOakley) ([89.241.136.214])
  by out1.ip03ir2.opaltelecom.net with SMTP; 28 Nov 2013 08:39:22 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238480>

From: "Duy Nguyen" <pclouds@gmail.com>
Sent: Wednesday, November 27, 2013 11:50 PM
> On Thu, Nov 28, 2013 at 5:52 AM, Philip Oakley <philipoakley@iee.org> 
> wrote:
>> In the pack transfer protocol 
>> (Documentation\technical\pack-protocol.txt)
>> the negotiation for refs is discussed, but its unclear to me if the
>> negotiation explicitly navigates down into the trees and blobs of 
>> each
>> commit that need to go into the pack.
>>
>> From one perspective I can see that, in the main, it's only commit 
>> objects
>> that are being negotiated, and the DAG is used to imply which commit 
>> objects
>> are to be sent between the wants and haves end points, without need 
>> to
>> descend into their trees and blobs. The tags and the objects they 
>> point to
>> are explicitly given so are negotiated easily.
>>
>> The other view is that the negotiation should be listing every object 
>> of any
>> type between the wants and haves as part of the negotiation. I just 
>> couldn't
>> tell from the docs which assumption is appropriate. Is there any 
>> extra
>> clarifications on this?
>
> other object negotiation is inferred from commits because sending full
> listing is too much. If you say you have commit A, you imply you have
> everything from commit A down to the bottom. With this knowledge, when
> you want commit B, the sender only needs to send trees and objects
> that do not exist in commit A or any of its predecessors.

I presume that in the case of a tag that points to a tree, the pack will 
contain not only the specific tree that was tagged, but also its 
sub-trees and blobs that it references.

Plus I'm wondering if the commit(s) that contain that tagged tree are 
also sent (given that such a tree could be repeated/reused in other 
commits this may be expensive, and hence not done)

> Although to
> cut cost at the sender, we do something less than optimized (check out
> the edge concept in documents, or else in pack-objects.c). Pack
> bitmaps are supposed to provide cheap object traversal and make the
> transfered pack even smaller.
>
>> I ask as I was cogitating on options for a 'narrow' clone  (to 
>> complement
>> shallow clones ;-) that could, say, in some way limit the size of 
>> blobs
>> downloaded, or the number of tree levels downloaded, or even path 
>> limiting.
>
> size limiting is easy because you don't need to traverse object dag at
> all. Inside pack-objects it calls rev-list to collect objects to be
> sent. You just filter by size at that phase. Support for raising or
> lowering size limit is also workable, just like how shallow
> deepen/shorten is done: you let the sender know you have size limit A,
> now you want to raise to B and the sender just collects extra objects
> in A..B range for all "have" refs.
>
> The problem is how to let the client know what objects are not sent
> due to the size limit, so it could set up refs/replace to stop the
> user from running into missing objects. If there are too many excluded
> objects, sending all those SHA-1 with pkt-line is inefficient. (path
> limit does not have problem, it can infer from the command line
> arguments most of the time). Maybe you could send this listing in
> binary format just before sending the pack.

This was part of the problem I was thinking about ;-)

>
> BTW another way to deal with large blobs in clone is git-annex. I was
> thinking the other day if we could sort of integrate it to git to
> provide smooth UI (the user does not have to type "git annex
> something", or at least not often). Of course git-annex is still
> optional and the UI integration is only activated via config key,
> after git-annex is installed.

I'll have a look.
> --
> Duy
> --

Philip 
