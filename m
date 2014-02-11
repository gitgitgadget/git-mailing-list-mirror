From: David Kastrup <dak@gnu.org>
Subject: Re: Profiling support?
Date: Tue, 11 Feb 2014 15:41:55 +0100
Message-ID: <878uthbtjg.fsf@fencepost.gnu.org>
References: <87d2itc2zv.fsf@fencepost.gnu.org>
	<CACsJy8BAD3cm2BLSapJ2fhkGiYjDKqW1TQ1yu0XPwTyEfL2oLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 11 15:42:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDEXE-0008DX-FP
	for gcvg-git-2@plane.gmane.org; Tue, 11 Feb 2014 15:42:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968AbaBKOl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Feb 2014 09:41:57 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:51921 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956AbaBKOl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Feb 2014 09:41:56 -0500
Received: from localhost ([127.0.0.1]:50963 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WDEX5-0002gP-UU; Tue, 11 Feb 2014 09:41:56 -0500
Received: by lola (Postfix, from userid 1000)
	id 818BEE0510; Tue, 11 Feb 2014 15:41:55 +0100 (CET)
In-Reply-To: <CACsJy8BAD3cm2BLSapJ2fhkGiYjDKqW1TQ1yu0XPwTyEfL2oLQ@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 11 Feb 2014 20:18:52 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241944>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Feb 11, 2014 at 6:17 PM, David Kastrup <dak@gnu.org> wrote:
>>
>> Looking in the Makefile, I just find support for coverage reports using
>> gcov.  Whatever is there with "profile" in it seems to be for
>> profile-based compilation rather than using gprof.
>>
>> Now since I've managed to push most of the runtime for basic git-blame
>> operation out of blame.c proper, it becomes important to figure out
>> where most of the remaining runtime (a sizable part of that being system
>> time) is being spent.  Loop counts like that provided by gcov (or am I
>> missing something here?) are not helpful for that, I think I rather need
>> the kind of per-function breakdown that gprof provides.
>>
>> Is there a reason there are no prewired recipes or advice for using
>> gprof on git?  Is there a way to get the work done, namely seeing the
>> actual distribution of call times (rather than iterations) using gcov so
>> that this is not necessary?
>
> Would perf help? No changes required, and almost no overhead, I think.

Not useful.  It would be probably nice for nailing down the performance
gains when the work is finished so that future regressions will be
noticeable.  It's reasonable easy to create a test case that will take
hours with the current git-blame and would finish in seconds with the
improved one.

But it's not useful at all for figuring out the hotspots within the
git-blame binary.

I made do with something like

make CFLAGS=-pg LDFLAGS=-pg

but it is sort of annoying that the required "make clean" apparently
also cleans out the coverage files: for sensible finding of bad stuff
one needs them as well.

At any rate, I'll probably figure out something eventually.  No idea
whether I'll get around to writing some useful instructions.  At the
current point of time, it would appear that a large part of the
remaining user time (about half) is spent in xdl_hash_record so x86_64
architectures already benefit from XDL_FAST_HASH (which seems to hurt
more than it would help with my i686).  So finding a good fast hash
function would likely help.  The current hash function _and_ the
XDL_FAST_HASH replacement used on x86_64 are a drag here because they
are not easily split into a word-unaligned, a (typically long and thus
most performance-relevant) word-aligned, and another word-unaligned part
in a manner that allows calculating the same hash for different
alignments.  Something like a CRC lends itself much better to that, but
since its basic operation is more complex on a general-purpose CPU, it's
not likely to result in a net win.

In assembly language, add-and-multiply operations modulo 2^32-1 are
pretty easy to do and lend themselves well to considering alignment at
the end, but in C, access to mixed precision multiplications and the
carry flag are rather awkward.

-- 
David Kastrup
