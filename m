From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 13/22] documentation: add documentation of the index-v5
 file format
Date: Thu, 11 Jul 2013 19:50:38 +0700
Message-ID: <CACsJy8B+y1pcnfNy_kuMXBZ5J72SR71TxE0RtV3a41HgnuDGaA@mail.gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
 <1373184720-29767-14-git-send-email-t.gummerer@gmail.com> <CACsJy8ALSBPq1+TP_YxJ=ecUwpKRY-i2O=+q8qMjtXbjShg3mA@mail.gmail.com>
 <87mwptcom9.fsf@gmail.com> <CACsJy8BT56_DvQ5Y2newJWn4EZjHZnTquypXpO2qDtN1Qh0zRg@mail.gmail.com>
 <87k3kxcmfs.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 14:51:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxGL5-0001oe-Me
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 14:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756009Ab3GKMvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 08:51:11 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:39445 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755834Ab3GKMvK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 08:51:10 -0400
Received: by mail-ob0-f182.google.com with SMTP id va7so9722104obc.41
        for <git@vger.kernel.org>; Thu, 11 Jul 2013 05:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rzcRa1nwIQP4LJjoOOJc99OAaQB0bhDj4gej3bz7BsI=;
        b=t3deKO28J3I3R8vHs6Ir7uemlsure7clpfJT6OLrmWwsddBwHGrS08fQvus+I1qXWz
         aykO2BIQVs77V7sTsNswCxASpyEdvOwOXzKPNwqKZvE9NZ6Sz8ToVTsjtcv+tRRoJdm9
         PPt6XsK98keN89l2or78Ewj9IYavvXty3zT2kc+rkDykgG14tdxnSFs1Dd4evwGs0UgR
         +5pHf2YVzCYgLxHZD+ic2g6LdvvI/PV8nSmJWz8KRBOAHhpJTunol50uElw6zv2nPu5F
         VGL/Sp5D5utOIHZeyD2czN7Q0DvsFkqAgmgqvEt+1v9qrH3APMOP1ilBbgFJzM6j0YId
         sMsQ==
X-Received: by 10.60.137.225 with SMTP id ql1mr31710555oeb.48.1373547069434;
 Thu, 11 Jul 2013 05:51:09 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Thu, 11 Jul 2013 05:50:38 -0700 (PDT)
In-Reply-To: <87k3kxcmfs.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230099>

On Thu, Jul 11, 2013 at 7:26 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Thu, Jul 11, 2013 at 6:39 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>>>> Question about the possibility of updating index file directly. If git
>>>> updates a few fields of an entry (but not entrycrc yet) and crashes,
>>>> the entry would become corrupt because its entrycrc does not match the
>>>> content. What do we do? Do we need to save a copy of the entry
>>>> somewhere in the index file (maybe in the conflict data section), so
>>>> that the reader can recover the index? Losing the index because of
>>>> bugs is big deal in my opinion. pre-v5 never faces this because we
>>>> keep the original copy til the end.
>>>>
>>>> Maybe entrycrc should not cover stat fields and statcrc. It would make
>>>> refreshing safer. If the above happens during refresh, only statcrc is
>>>> corrupt and we can just refresh the entry. entrycrc still says the
>>>> other fields are good (and they are).
>>>
>>> The original idea was to change the lock-file for partial writing to
>>> make it work for this case.  The exact structure of the file still has
>>> to be defined, but generally it would be done in the following steps:
>>>
>>>   1. Write the changed entry to the lock-file
>>>   2. Change the entry in the index
>>>   3. If we succeed delete the lock-file (commit the transaction)
>>>
>>> If git crashes, and leaves the index corrupted, we can recover the
>>> information from the lock-file and write the new information to the
>>> index file and then delete the lock-file.
>>
>> Ah makes sense. Still concerned about refreshing though. Updated files
>> are usually few while refreshed files could be a lot more, increasing
>> the cost at #1.
>
> Any idea how common refreshing a big part of the cache is?

No, probably not common. Anyone who does "find|xargs touch" deserves
to be punished. Files can be edited, then reverted by an editor, but
there should not be many of those. The only sensible case is "git
checkout <path>" with lots of modified files. But that can't happen
often.

> If it's not to common, I'd prefer to leave the stat data and stat crc in the
> entrycrc, as we can inform the user if something is wrong with the
> index, be it from git failing, or from disk corruption.
>
> On the other hand if refresh_cache is relatively common and usually
> changes a big part of the index we should leave them out, as git can
> still run correctly with incorrect stat data, but takes a little longer,
> because it may have to check the file contents.  That will be trade-off
> to make here.



--
Duy
