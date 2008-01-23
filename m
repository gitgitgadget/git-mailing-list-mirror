From: Andreas Ericsson <ae@op5.se>
Subject: Re: I'm a total push-over..
Date: Wed, 23 Jan 2008 09:32:54 +0100
Message-ID: <4796FBB6.9080609@op5.se>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 09:34:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHb3W-0000iS-Sw
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 09:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbYAWIdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 03:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbYAWIdS
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 03:33:18 -0500
Received: from mail.op5.se ([193.201.96.20]:44504 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113AbYAWIdR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 03:33:17 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id BC6411F08037;
	Wed, 23 Jan 2008 09:33:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xIB5DrNZ091D; Wed, 23 Jan 2008 09:33:14 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 3867F1F0802C;
	Wed, 23 Jan 2008 09:33:11 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71520>

Linus Torvalds wrote:
> 
> NOTE NOTE NOTE! The current hash is a joke.


Insofar as hashes go, it's not that shabby for hashing filenames.
Here's the test output from a small hash-comparison program I've
got, which runs the test-input through a series of different hashes
to compare dispersion, collisions, lookup- and insert times and
other things that are interesting from a practical PoV.

Fowler/Noll/Vo cheap hash
Collisions: 1829, 7.91%. Depth max: 3, average: 0.09.
Time spent in lookups: 167.859ms. Per entry: 0.145us
Time spent inserting: 2.753ms. Per entry: 0.119us

PHP Zend cheap hash
Collisions: 1908, 8.25%. Depth max: 3, average: 0.09.
Time spent in lookups: 171.819ms. Per entry: 0.149us
Time spent inserting: 2.778ms. Per entry: 0.120us

Phong Vo's linear congruential hash
Collisions: 1996, 8.63%. Depth max: 3, average: 0.09.
Time spent in lookups: 168.276ms. Per entry: 0.146us
Time spent inserting: 2.840ms. Per entry: 0.123us

Phong Vo's second linear congruential hash
Collisions: 1933, 8.36%. Depth max: 3, average: 0.09.
Time spent in lookups: 170.416ms. Per entry: 0.147us
Time spent inserting: 2.774ms. Per entry: 0.120us

Glib string hash
Collisions: 1907, 8.24%. Depth max: 3, average: 0.09.
Time spent in lookups: 192.420ms. Per entry: 0.166us
Time spent inserting: 3.154ms. Per entry: 0.136us

sdbm hash
Collisions: 1899, 8.21%. Depth max: 3, average: 0.09.
Time spent in lookups: 170.797ms. Per entry: 0.148us
Time spent inserting: 2.724ms. Per entry: 0.118us

bfd hash
Collisions: 1949, 8.43%. Depth max: 3, average: 0.09.
Time spent in lookups: 206.504ms. Per entry: 0.179us
Time spent inserting: 3.241ms. Per entry: 0.140us

Linus' GIT hash
Collisions: 1946, 8.41%. Depth max: 4, average: 0.09.
Time spent in lookups: 179.336ms. Per entry: 0.155us
Time spent inserting: 2.781ms. Per entry: 0.120us

This is with 64K buckets, which (with my implementation) means
a total hash-table size of 256KiB. The test-input is a simple
file-listing from the linux kernel (although it has the .git
directory included too).

As you can see, it loses out on mathematical correctness, as it
has more collisions (but not that many). OTOH, the simplicity
of the implementation makes it a viable option anyway, since
the time spent in insertion (which is almost completely inside
the hash-function) is on average so much shorter.

For a temporary hash-table, it will work splendidly. It will
probably have issues scaling to, say, 30 or 40 million input
lines (fairly typical test-data for database hashes, fe).

Note that real-world timings will be shorter. My test-program
doesn't have the luxury of keeping hash-functions inline, so
some compiler optimizations become impossible.

This is on a Intel(R) Core(TM)2 Duo CPU T7700  @ 2.40GHz
(according to /proc/cpuinfo), with a cache size of 4meg. The
use of multiplication is sane though, as it means no arch
will suffer greatly.

The FNV hash would be better (pasted below), but I doubt
anyone will ever care, and there will be larger differences
between architectures with this one than the lt_git hash (well,
a function's gotta have a name).

/*
 * Fowler/Noll/Vo hash
 *
 * The basis of the hash algorithm was taken from an idea sent by email to the
 * IEEE Posix P1003.2 mailing list from Phong Vo (kpv@research.att.com) and
 * Glenn Fowler (gsf@research.att.com).  Landon Curt Noll (chongo@toad.com)
 * later improved on their algorithm.
 *
 * The magic is in the interesting relationship between the special prime
 * 16777619 (2^24 + 403) and 2^32 and 2^8.
 *
 * This hash produces the fewest collisions of any function that we've seen so
 * far, and works well on both numbers and strings.
 *
 * (Last comment from MySQL code)
 *
 */
u32 FNV1(u8 *k, u32 len)
{
	u8 *e;
	u32 h;

	e = k + len;
	for (h = 0; k < e; k++) {
		h *= 16777619;
		h ^= *k;
	}

	return (h);
}


I could provide figures for other table-sizes too, if anyone's
interested.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
