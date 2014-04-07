From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 18/25] lockfile: avoid transitory invalid states
Date: Mon, 07 Apr 2014 14:12:26 +0200
Message-ID: <5342962A.8020608@viscovery.net>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu> <1396827247-28465-19-git-send-email-mhagger@alum.mit.edu> <534242AC.7030908@viscovery.net> <53428846.7060104@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 07 14:12:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX8Po-0001tN-TD
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 14:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792AbaDGMMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 08:12:36 -0400
Received: from so.liwest.at ([212.33.55.13]:35257 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753408AbaDGMMf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 08:12:35 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WX8Pb-0008KH-I3; Mon, 07 Apr 2014 14:12:27 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 452E316613;
	Mon,  7 Apr 2014 14:12:27 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <53428846.7060104@alum.mit.edu>
X-Enigmail-Version: 1.6
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245831>

Am 4/7/2014 13:13, schrieb Michael Haggerty:
> On 04/07/2014 08:16 AM, Johannes Sixt wrote:
>> Am 4/7/2014 1:34, schrieb Michael Haggerty:
>>> So, instead of encoding part of the lock_file state in the filename
>>> field, add a new bit "LOCK_FLAGS_LOCKFILE_ACTIVE" to flags, and use
>>> this bit to distinguish between a lock_file object that is active
>>> vs. one that is inactive.  Be careful to set this bit only when
>>> filename really contains the name of a file that should be deleted on
>>> cleanup.
>>
>> Since this flag is primarily for communication between the main code and a
>> signal handler, the only safe way is to define the flag as volatile
>> sig_atomic_t, not to make it a bit of a larger type!
> 
> Thanks for the feedback.  You are obviously right, and I will fix it.
> 
> But I have a feeling that this line of thought is going to lead to the
> signal handler's not being able to do anything.  How far can we afford
> to pursue strict correctness?  ...
> 
> The signal handler currently reads
> 
>     lock_file_list
>     lock_file::next
>     lock_file::fd
>     lock_file::owner
>     lock_file::filename
>     *lock_file::filename
> 
> and writes lock_file_list.  Among other things it calls close(),
> unlink(), vsnprintf(), and fprintf() (the last two via warning()).
> 
> But most of these actions are undefined under the C99 standard:

Good point. But not all is lost because some of the functions are
well-defined under POSIX, particularly close() and unlink(). (*printf are
not, though.)

> I don't have time to rewrite *all* of Git right now, so how can we get
> reasonable safety and portability within a feasible amount of work?

It shouldn't be *that* bad. We can make all members volatile, except
filename (because we wouldn't be able to strcpy(lk->filename, ...) without
a type cast).

How far *do* you want to go? I'm certainly not opposed to field-test your
current changeset (plus and adjustment to use sig_atomic_t) -- overall it
is an improvement. And then we will see how it works.

Just as food for thought: A compiler barrier should be sufficient to
inhibit that the compiler reorders code across accesses of the volatile
flag. Like in the main code:

	strcpy(lk->filename, ...);
	BARRIER();
	lk->is_active = 1;	/* volatile sig_atomic_t */

and in the signal handler:

	if (!lk->is_active)
		return;
	BARRIER();
	unlink(lk->filename);

with some suitable definition of BARRIER(). I don't think that we need an
explicit memory barrier (in practice) because that should be implied by
the context switch leading to the signal handler.

-- Hannes
