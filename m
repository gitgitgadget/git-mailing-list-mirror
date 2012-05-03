From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Index format v5
Date: Thu, 3 May 2012 20:16:59 +0200
Message-ID: <87obq5p1t0.fsf@thomas.inf.ethz.ch>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, <trast@student.ethz.ch>,
	<gitster@pobox.com>, <mhagger@alum.mit.edu>, <peff@peff.net>,
	<spearce@spearce.org>, <davidbarr@google.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 03 20:17:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ0aT-0002Cm-49
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 20:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185Ab2ECSRD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 14:17:03 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:26389 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753637Ab2ECSRC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 14:17:02 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.283.3; Thu, 3 May
 2012 20:17:00 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 3 May
 2012 20:16:59 +0200
In-Reply-To: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
	(Thomas Gummerer's message of "Thu, 3 May 2012 19:25:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196927>

Thomas Gummerer <t.gummerer@gmail.com> writes:

>   32-bit crc32 checksum over ctime seconds, ctime nanoseconds,
>     ino, file size, dev, uid, gid (All stat(2) data except mtime) [7]
[...]
> [7] Since all stat data (except mtime and ctime) is just used for
>     checking if a file has changed a checksum of the data is enough.
>     In addition to that Thomas Rast suggested ctime could be ditched
>     completely (core.trustctime=false) and thus included in the
>     checksum. This would save 24 bytes per index entry, which would
>     be about 4 MB on the Webkit index.
>     (Thanks for the suggestion to Michael Haggerty)

This is the part I'm most curious about.  Are we missing anything?
Michael brought it up on IRC: the stat() results are only used to test
whether they are still the same, with the exception of the mtime (which
also undergoes raciness checks).

As far as I can see, none of st_{ino,dev,uid,gid} are useful for
anything.  st_size might conceivably be used as a hint for a buffer
size, but nobody actually does that.  The ctime undergoes stricter
checks, but AFAICS it's also all about whether it has changed, and
besides that can be turned off.  We think all of those fields can be
replaced by an arbitrary hash/CRC and only tested for equality.  32 bits
should be plenty, probably even if we just xor the values together.

So what's wrong in this thinking?

[The one flaw I found so far is that this makes it impossible to convert
back to v2-4 without at the very least refreshing the index.  Do we
care?]

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
