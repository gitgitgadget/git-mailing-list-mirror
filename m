From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: avoid duplicate patches from git log ?
Date: Tue, 3 May 2016 23:36:32 +0100
Organization: OPDS
Message-ID: <E735FEEE2908434F874CAD1874307E38@PhilipOakley>
References: <712E44CFAD1A41A982AEF1540C1F9F80@PhilipOakley><20160503220039.GB25133@sigill.intra.peff.net> <xmqqbn4mlrk2.fsf@gitster.mtv.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 04 00:36:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axivm-0001Z6-Gq
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 00:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756745AbcECWgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 18:36:35 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:8661 "EHLO
	smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756436AbcECWge (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 18:36:34 -0400
Received: from PhilipOakley ([92.16.246.238])
	by smtp.talktalk.net with SMTP
	id xivfau7UKm8hQxivfa0K6t; Tue, 03 May 2016 23:36:31 +0100
X-Originating-IP: [92.16.246.238]
X-Spam: 0
X-OAuthority: v=2.2 cv=EbSKe7uC c=1 sm=1 tr=0 a=6h1yBlRVFNKLyN041wWm2Q==:117
 a=6h1yBlRVFNKLyN041wWm2Q==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=PKzvZo6CAAAA:8 a=NEAV23lmAAAA:8 a=sJ1kJ_e0VwgmzTykt2UA:9
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfGh4gdAU0U9WxKcjq+kD2dt9cugk7f6S+YZ3AnuaWrtmMnC/DERmzO2/iTagdKBpVHGsvtC56P1rawH52L9zPdduRp+SKMUcZNv9zKIg4dVZCxzxdVl/
 6YuC6ag0sA9b1avyw9yDOJk9Nc7GNQ2jutDDawv/BFQKKnokSqs1bUmJ7y+YqYw71j79RZMT6zXgJQENTvWkWPGKxG+SYGSSvK6cNAYlNl3VMBFh5dSRW0Y7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293470>

From: "Junio C Hamano" <gitster@pobox.com>
> Jeff King <peff@peff.net> writes:
>
>> On Tue, May 03, 2016 at 09:11:55PM +0100, Philip Oakley wrote:
>>
>>> However, as the G4W project (https://github.com/git-for-windows/git/)
>>> follows the main git repo and its releases, it needs to rebase it's 
>>> fixup
>>> patches, while retaining their original series, so has repeated copies 
>>> of
>>> those fix patches on the second parent path (a technique Dscho called
>>> rebasing merges).
>>>
>>> for example:
>>> > bf1a7ff (MinGW: disable CRT command line globbing, 2011-01-07)
>>> > a05e9a8 (MinGW: disable CRT command line globbing, 2011-01-07)
>>> > 45cfa35 (MinGW: disable CRT command line globbing, 2011-01-07)
>>> > 1d35390 (MinGW: disable CRT command line globbing, 2011-01-07)
>>> > 022e029 (MinGW: disable CRT command line globbing, 2011-01-07)
>>>
>>>
>>> How can I filter out all the duplicate patches which are identical other
>>> than the commit date?
>>>
>>> The --left --right and --cherry don't appear to do what I'd expect/hope. 
>>> Any
>>> suggestions?
>>
>> I don't think there's a good way right now. The option that suppresses
>> commits is --cherry-pick, but it wants there to be a "left" and "right"
>> from a symmetric difference, and to cull duplicates from the various
>> sides.
>>
>> I think you really just want to keep a running list of all of the
>> commits you've seen and cull any duplicates. I guess you'd want this as
>> part of the history simplification step, so that whole uninteresting
>> side-branches are culled.
>>
>> The obvious choice for matching two commits is patch-id, though it can
>> be expensive to generate. There have been patches playing around with
>> caching in the past, but nothing merged. For your purposes, I suspect
>> matching an "(author, authordate, subject)" tuple would be sufficient
>> and fast.
>
> What would be really interesting is what should happen when the side
> "rebase merge" branch that is supposed to be irrelevant for the
> purpose of explaining the overall history does not become empty
> after such filtering operation.  The merge commit itself may claim
> that both branches are equivalent, but in reality it may turn out
> that the merge failed to reflect the effect of some other changes in
> the history of the side branch in the result--which would be a
> ticking time-bomb for future mismerges waiting to happen.

I think that's a misunderstanding of the development process for an "on top 
of" project, where the upstream would not be expected to take all the fixups 
for that project's customers.

The releases of the project do need to be retained in the history, but 
because of the "on top of" policy, the prior release becomes a second parent 
to a "theirs" merge commit of the upstream (and subsequent rebase on top of 
that).

Thus when seaching history the first parent route would have the fastest 
transition to the upstream, but the full history would still have all the 
releases on it.

It may be that Peff's suggestion is a workable heuristic for a rebase flow 
where one could eliminate those duplicates quite easily. I just had a 
feeling that there was already something that did the patch-id thing for 
duplicate removals, but obviously I had that wrong.

--
Philip 
