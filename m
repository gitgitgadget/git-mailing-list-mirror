From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 18/25] lockfile: avoid transitory invalid states
Date: Mon, 07 Apr 2014 13:13:10 +0200
Message-ID: <53428846.7060104@alum.mit.edu>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu> <1396827247-28465-19-git-send-email-mhagger@alum.mit.edu> <534242AC.7030908@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Apr 07 13:13:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX7UO-0001it-Pn
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 13:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754874AbaDGLNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 07:13:17 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:56783 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753510AbaDGLNP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 07:13:15 -0400
X-AuditID: 12074411-f79ab6d000002f0e-25-5342884acb14
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 49.EA.12046.A4882435; Mon,  7 Apr 2014 07:13:14 -0400 (EDT)
Received: from [192.168.69.148] (p5B156B1D.dip0.t-ipconnect.de [91.21.107.29])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s37BDAj4011906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 7 Apr 2014 07:13:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <534242AC.7030908@viscovery.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsUixO6iqOvV4RRs0PNdzKLrSjeTRUPvFWaL
	lT9rLH609DBbnHnTyGjR2fGV0YHN41nvHkaPi5eUPRY/8PL4vEnO4+7/nUwet59tYwlgi+K2
	SUosKQvOTM/Tt0vgzjiwej9TwTeRim8/JjM1MJ4X6GLk5JAQMJGYfuQaI4QtJnHh3nq2LkYu
	DiGBy4wSP9/9ZYdwzjJJPJq/nxWkildAW2LBu+UsIDaLgKrEzV87mEBsNgFdiUU9zUA2B4eo
	QJDEn7OKEOWCEidnPgErFxHQkNh9uhdsJrPAFUaJjVO/M4PUCwu4S2zfDrV4PqPEpGfzwHZx
	As1c/2w9C0iNhIC4RE9jEEiYGSj8o2klG4QtL7H97RzmCYyCs5Csm4WkbBaSsgWMzKsY5RJz
	SnN1cxMzc4pTk3WLkxPz8lKLdE31cjNL9FJTSjcxQmJBcAfjjJNyhxgFOBiVeHhXHHIMFmJN
	LCuuzD3EKMnBpCTKG9DqFCzEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhHc3O1CONyWxsiq1KB8m
	Jc3BoiTOy7dE3U9IID2xJDU7NbUgtQgmK8PBoSTBa9sO1ChYlJqeWpGWmVOCkGbi4AQZziUl
	Upyal5JalFhakhEPiuD4YmAMg6R4gPYeagPZW1yQmAsUhWg9xajLsWHbmkYmIZa8/LxUKXHe
	GyBFAiBFGaV5cCtgie8VozjQx8K8PiCX8ACTJtykV0BLmICWGLqCLSlJREhJNTDqrV563P3W
	Cp1DihIhOXrW+fbv/T9uDvg1+b/BVOWYgx+nzeL/vetzzAM3hjiBaVWLXLX3NM+3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245830>

On 04/07/2014 08:16 AM, Johannes Sixt wrote:
> Am 4/7/2014 1:34, schrieb Michael Haggerty:
>> Because remove_lock_file() can be called any time by the signal
>> handler, it is important that any lock_file objects that are in the
>> lock_file_list are always in a valid state.  And since lock_file
>> objects are often reused (but are never removed from lock_file_list),
>> that means we have to be careful whenever mutating a lock_file object
>> to always keep it in a well-defined state.
>> ...
>> So, instead of encoding part of the lock_file state in the filename
>> field, add a new bit "LOCK_FLAGS_LOCKFILE_ACTIVE" to flags, and use
>> this bit to distinguish between a lock_file object that is active
>> vs. one that is inactive.  Be careful to set this bit only when
>> filename really contains the name of a file that should be deleted on
>> cleanup.
> 
> Since this flag is primarily for communication between the main code and a
> signal handler, the only safe way is to define the flag as volatile
> sig_atomic_t, not to make it a bit of a larger type!

Thanks for the feedback.  You are obviously right, and I will fix it.

But I have a feeling that this line of thought is going to lead to the
signal handler's not being able to do anything.  How far can we afford
to pursue strict correctness?  We have

	struct lock_file {
		struct lock_file *next;
		int fd;
		pid_t owner;
		char on_list;
		char filename[PATH_MAX];
	};

	static struct lock_file *lock_file_list;

The signal handler currently reads

    lock_file_list
    lock_file::next
    lock_file::fd
    lock_file::owner
    lock_file::filename
    *lock_file::filename

and writes lock_file_list.  Among other things it calls close(),
unlink(), vsnprintf(), and fprintf() (the last two via warning()).

But most of these actions are undefined under the C99 standard:

> If the signal occurs other than as the result of calling the abort
> or raise function, the behavior is undefined if the signal handler
> refers to any object with static storage duration other than by
> assigning a value to an object declared as volatile sig_atomic_t, or
> the signal handler calls any function in the standard library other
> than the abort function, the _Exit function, or the signal function
> with the first argument equal to the signal number corresponding to
> the signal that caused the invocation of the handler.

I don't have time to rewrite *all* of Git right now, so how can we get
reasonable safety and portability within a feasible amount of work?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
