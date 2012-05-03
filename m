From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Index format v5
Date: Thu, 3 May 2012 21:31:04 +0200
Message-ID: <87pqalgiyv.fsf@thomas.inf.ethz.ch>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
	<7vd36lf634.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Gummerer <t.gummerer@gmail.com>, <git@vger.kernel.org>,
	<trast@student.ethz.ch>, <mhagger@alum.mit.edu>, <peff@peff.net>,
	<spearce@spearce.org>, <davidbarr@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 03 21:31:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ1kA-0006zi-Tf
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 21:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758114Ab2ECTbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 15:31:09 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:29789 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755395Ab2ECTbI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 15:31:08 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.283.3; Thu, 3 May
 2012 21:31:05 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 3 May
 2012 21:31:04 +0200
In-Reply-To: <7vd36lf634.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 03 May 2012 11:54:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196947>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
>> I have been drafting the Version 5 of the index format over the past
>> few days with the help of Thomas Rast, Michael Haggerty, cmn and
>> barrbrain on IRC.
>
> Hrm, so if there is anything glaringly wrong below, should I reduce the
> "trustable reviewer karma point" from these people?  Or did you forget to
> say "but remaining errors are mine" ;-)?

Heh.

Partly it's my fault, I told Thomas to get this out tonight for a single
reason: Michael's CRC-over-stat idea is so radical that I wanted to know
whether there's anything wrong with it.  So the misunderstanding is
really that this is not anywhere near the final result.

But yeah:

> >   32-bit crc32 checksum over ctime seconds, ctime nanoseconds,
> >     ino, file size, dev, uid, gid (All stat(2) data except mtime) [7]
> 
> Giving occassional false positive to "did this change?" is acceptable, but
> any false negative is absolutely unacceptable.  How does this work with
> something like "racy git" situation (i.e. coming from "mtime happens to be
> the same as before") but due to crc32 collisions?
> 
> If there is no good answer to the above question, I would have to say that
> anybody who suggested or passed this through review loses all the
> accumulated reviewer karma points (if s/he has accumulated any, that is).

If this is a problem, then the fault is with me (and I do hope I have
some karma to lose...).

Note that the scenario you outlined is not an issue.  The entries other
than mtime and ctime are really only compared for equality, see
e.g. ce_match_stat_basic().  Comparisons for equality never have false
negatives with any hash function.  Collisions are false positives.

Upon closer reading I noticed that the ie_match_stat and ce_match_stat_*
family actually to distinguish between basically all the fields that can
change.  But this knowledge is never actually put to use, except that
there's an optimized code path where

* mode/type difference implies changed entry
* size difference implies changed entry

So that does constitute an argument to not put the size in the
stat-hash.  Mode and type aren't part of it in the proposed format
anyway.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
