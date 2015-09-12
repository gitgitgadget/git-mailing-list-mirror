From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [Feature Request] git blame showing only revisions from git rev-list --first-parent
Date: Sat, 12 Sep 2015 23:09:18 +0100
Organization: OPDS
Message-ID: <6EB617480AFE4F7898553BCE6A91D946@PhilipOakley>
References: <CA+nPnMx1tkwTRckUjhg6LD055n-jzYDTKsH2sz-0PXPfJiy_tA@mail.gmail.com><20150911140133.GA14311@sigill.intra.peff.net><xmqqa8ss29tq.fsf@gitster.mtv.corp.google.com><xmqqsi6kzsgc.fsf@gitster.mtv.corp.google.com><20150912033054.GA30431@sigill.intra.peff.net> <xmqqy4gcxcp4.fsf@gitster.mtv.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Stephen Connolly" <stephen.alan.connolly@gmail.com>,
	<git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 13 00:08:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zasyc-0000Rx-GR
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 00:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbbILWIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2015 18:08:30 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:34284 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750848AbbILWI3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Sep 2015 18:08:29 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2BjLQBXofRVPJiZLFBdGQEBgwiBPYZZbb1dBAQCgSA8EQEBAQEBAQEGAQEBAUABJBtBAQICg1gFAQEBAQIBCAEBHREeAQEhCwIDBQIBAxUBCyUUAQQaBgcDFAYBEggCAQIDAYgVDL0IjQEBAQEBBgEBAQEehnOEfYQ1WIMfgRQFjTCIJgGBFYZilBuLYzeCPRwWgT89M4NQhCyBOoFHAQEB
X-IPAS-Result: A2BjLQBXofRVPJiZLFBdGQEBgwiBPYZZbb1dBAQCgSA8EQEBAQEBAQEGAQEBAUABJBtBAQICg1gFAQEBAQIBCAEBHREeAQEhCwIDBQIBAxUBCyUUAQQaBgcDFAYBEggCAQIDAYgVDL0IjQEBAQEBBgEBAQEehnOEfYQ1WIMfgRQFjTCIJgGBFYZilBuLYzeCPRwWgT89M4NQhCyBOoFHAQEB
X-IronPort-AV: E=Sophos;i="5.17,519,1437433200"; 
   d="scan'208";a="42539194"
Received: from 80-44-153-152.dynamic.dsl.as9105.com (HELO PhilipOakley) ([80.44.153.152])
  by out1.ip02ir2.opaltelecom.net with SMTP; 12 Sep 2015 23:08:26 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277737>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Saturday, September 12, 2015 9:29 AM
> Jeff King <peff@peff.net> writes:
>
>> Yeah, I think what is happening in this first hunk:
>> ...
>> is doing the right thing. It did feel a little weird to me to be 
>> munging
>> the global commit objects themselves, but I guess it is fairly normal
>> for git code.
>
> Yeah, the above may be brilliant, but ...
>
>>> diff --git a/revision.c b/revision.c
>>> index af2a18e..a020a42 100644
>>> --- a/revision.c
>>> +++ b/revision.c
>>> @@ -2765,7 +2765,9 @@ static void set_children(struct rev_info 
>>> *revs)
>>>  struct commit *commit = l->item;
>>>  struct commit_list *p;
>>>
>>> - for (p = commit->parents; p; p = p->next)
>>> + for (p = commit->parents;
>>> +      p && !revs->first_parent_only;
>>> +      p = p->next)
>>>  add_child(revs, p->item, commit);
>>>  }
>>>  }
>
> ... this is a total crap and shows that I am doubly an idiot.
>
> The loop is a no-op when first-parent-only (the intent is to call
> add-child for just the first parent), so the code is stupid and
> wrong in the first place, but more importantly, the logic is utterly
> confused.
>
> The thing is, traversing first-parent chain in reverse fundamentally
> is undefined.  You can fork multiple topics at the tip of 'master'
> and each of the topics may be single strand of pearls, but which one
> of the topics is the first-child-chain---there is no answer to that
> question.

I don't understand why this would be so. If we just have a base commit 
from which to seek a --reversed chain then it would be true.

But if I understood the man page correctly: --reverse "This requires a 
range of revision like START..END where the path to blame exists in 
START." which when combined with --first-parent, would define a single 
string of pearls which could then be reversed. Or is it that the code 
doesn't do it in that order?

>
> The add_child() call above is exactly that.  It is saying "record
> the fact that commit is child of p->item for these p on that parents
> list".  We may limit the call to record that commit C is a child of
> its first parent P (and nobody else), but that does not make us
> record that that P has only one child (which is C).  This loop will
> be entered with another commit C' whose first parent is the same P
> and when we return from the set_children() function, we will find
> that P has more than one children (C and C', at least); the only
> thing we ensured is that all of these recorded children have P as
> their first parent.  It does not tell us which one of C's we would
> want to pick when digging in reverse from P.
--
Philip 
