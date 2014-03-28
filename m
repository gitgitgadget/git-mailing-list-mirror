From: Andrew Keller <andrew@kellerfarm.com>
Subject: Re: Borrowing objects from nearby repositories
Date: Fri, 28 Mar 2014 10:52:20 -0400
Message-ID: <8030ADEA-B11F-47E8-AFE7-8F46E861F560@kellerfarm.com>
References: <BFF5FBC7-8F53-4958-8D56-90EADD3AD626@kellerfarm.com> <CACBZZX5teZuqtNkPT4PdXJn=g34cOhRH2oNehROT8kJ_M2cgfg@mail.gmail.com> <xmqqtxammctc.fsf@gitster.dls.corp.google.com> <xmqqvbv1kjoc.fsf@gitster.dls.corp.google.com> <3533946C-DE97-4214-9B55-F5B788DDD952@kellerfarm.com> <xmqqbnwskgwd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 15:52:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTY90-0007Dy-79
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 15:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbaC1Ow0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 10:52:26 -0400
Received: from atl4mhob03.myregisteredsite.com ([209.17.115.41]:45447 "EHLO
	atl4mhob03.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751437AbaC1OwY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 10:52:24 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.209])
	by atl4mhob03.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s2SEqKKW013998
	for <git@vger.kernel.org>; Fri, 28 Mar 2014 10:52:20 -0400
Received: (qmail 31195 invoked by uid 0); 28 Mar 2014 14:52:20 -0000
X-TCPREMOTEIP: 69.41.14.217
X-Authenticated-UID: andrew@kellerfarm.com
Received: from unknown (HELO devnet.ces.cvnt.net) (andrew@kellerfarm.com@69.41.14.217)
  by 0 with ESMTPA; 28 Mar 2014 14:52:20 -0000
In-Reply-To: <xmqqbnwskgwd.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245391>

On Mar 26, 2014, at 1:29 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Andrew Keller <andrew@kellerfarm.com> writes:
> 
>> On Mar 25, 2014, at 6:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>>>> I think that the standard practice with the existing toolset is to
>>>> clone with reference and then repack.  That is:
>>>> 
>>>>   $ git clone --reference <borrowee> git://over/there mine
>>>>   $ cd mine
>>>>   $ git repack -a -d
>>>> 
>>>> And then you can try this:
>>>> 
>>>>   $ mv .git/objects/info/alternates .git/objects/info/alternates.disabled
>>>>   $ git fsck
>>>> 
>>>> to make sure that you are no longer borrowing anything from the
>>>> borrowee.  Once you are satisfied, you can remove the saved-away
>>>> alternates.disabled file.
>>> 
>>> Oh, I forgot to say that I am not opposed if somebody wants to teach
>>> "git clone" a new option to copy its objects from two places,
>>> (hopefully) the majority from near-by reference repository and the
>>> remainder over the network, without permanently relying on the
>>> former via the alternates mechanism.  The implementation of such a
>>> feature could even literally be "clone with reference first and then
>>> repack" at least initially but even in the final version.
> 
> [Administrivia: please wrap your lines to a reasonable length]
> 
>> That was actually one of my first ideas - adding some sort of
>> '--auto-repack' option to git-clone.  It's a relatively small
>> change, and would work.  However, keeping in mind my end goal of
>> automating the feature to the point where you could run simply
>> 'git clone <url>', an '--auto-repack' option is more difficult to
>> undo.  You would need a new parameter to disable the automatic
>> adding of reference repositories, and a new parameter to undo
>> '--auto-repack', and you'd have to remember to actually undo both
>> of those settings.
>> 
>> In contrast, if the new feature was '--borrow', and the evolution
>> of the feature was a global configuration 'fetch.autoBorrow', then
>> to turn it off temporarily, one only needs a single new parameter
>> '--no-auto-borrow'.  I think this is a cleaner approach than the
>> former, although much more work.
> 
> I think you may have misread me.  With the "new option", I was
> hinting that the "clone --reference && repack && rm alternates"
> will be an acceptable internal implementation of the "--borrow"
> option that was mentioned in the thread.  I am not sure where you
> got the "auto-repack" from.

Ah, yes - that is better than what I was thinking.  I was thinking a bit
too low-level, and using two arguments in the place of your one.

> One of the reasons you may have misread me may be because I made it
> sound as if "this may work and when it works you will be happy, but
> if it does not work you did not lose very much" by mentioning "mv &&
> fsck".  That wasn't what I meant.
> 
> The "repack -a" procedure is to make the borrower repository no
> longer dependent on the borrowee, and it is supposed to always work.
> In fact, this behaviour was the whole reason why "repack" later
> learned its "-l" option to disable it, because people who cloned
> with "--reference" in order to reduce the disk footprint by sharing
> older and more common objects [*1*] were rightfully surprised to see
> that the borrowed objects were copied over to their borrower
> repository when they ran "repack" [*2*].
> 
> Because this is "clone", there is nothing complex to "undo".  Either
> it succeeds, or you remove the whole new directory if anything
> fails.
> 
> I said "even in the final version" for a simple reason: you cannot
> cannot do realistically any better than the "clone --reference &&
> repack -a d && rm alternates" sequence.

Wow, that's very insightful - thanks!  So, it sounds like I was right about
the general areas of concern when trying to do this during a fetch, but
I underestimated just how complicated it would be.

Okay, so to re-frame my idea, like you said, the goal is to find a user-
friendly way for the user to tell git-clone to set up the alternates file
(or perhaps just use the --alternates parameter), and run a repack,
and disconnect the alternate.  And yet, we still want to be able to use
--reference on its own, because there are existing use cases for that.

Thanks!
 - Andrew Keller
