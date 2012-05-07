From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: Index format v5
Date: Tue, 08 May 2012 00:18:26 +0200
Message-ID: <4FA84A32.7070607@dewire.com>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com> <87obq5p1t0.fsf@thomas.inf.ethz.ch> <4FA3816E.8090005@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, peff@peff.net, spearce@spearce.org,
	davidbarr@google.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 08 00:19:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRWH4-00065G-QU
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 00:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756966Ab2EGWTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 18:19:18 -0400
Received: from mail.dewire.com ([83.140.172.130]:23416 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752760Ab2EGWTR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 18:19:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 528458FC76;
	Tue,  8 May 2012 00:19:17 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UmwaDmImdkTN; Tue,  8 May 2012 00:19:16 +0200 (CEST)
Received: from Robin-Rosenbergs-MacBook-Pro.local (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id A58DB8FC74;
	Tue,  8 May 2012 00:19:15 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:13.0) Gecko/20120425 Thunderbird/13.0
In-Reply-To: <4FA3816E.8090005@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197322>

Michael Haggerty skrev 2012-05-04 09.12:
> On 05/03/2012 08:16 PM, Thomas Rast wrote:
>> Thomas Gummerer<t.gummerer@gmail.com>  writes:
>>
>>>    32-bit crc32 checksum over ctime seconds, ctime nanoseconds,
>>>      ino, file size, dev, uid, gid (All stat(2) data except mtime) [7]
>> [...]
>>> [7] Since all stat data (except mtime and ctime) is just used for
>>>      checking if a file has changed a checksum of the data is enough.
>>>      In addition to that Thomas Rast suggested ctime could be ditched
>>>      completely (core.trustctime=false) and thus included in the
>>>      checksum. This would save 24 bytes per index entry, which would
>>>      be about 4 MB on the Webkit index.
>>>      (Thanks for the suggestion to Michael Haggerty)
>>
>> This is the part I'm most curious about.  Are we missing anything?
>> Michael brought it up on IRC: the stat() results are only used to test
>> whether they are still the same, with the exception of the mtime (which
>> also undergoes raciness checks).
>>
>> As far as I can see, none of st_{ino,dev,uid,gid} are useful for
>> anything.  st_size might conceivably be used as a hint for a buffer
>> size, but nobody actually does that.  The ctime undergoes stricter
>> checks, but AFAICS it's also all about whether it has changed, and
>> besides that can be turned off.  We think all of those fields can be
>> replaced by an arbitrary hash/CRC and only tested for equality.  32 bits
>> should be plenty, probably even if we just xor the values together.
>
> XOR is definitely *not* adequate; for example, changing uid=gid="you" to uid=gid="me"
 > would not affect the XOR of the values (assuming, as is often the case, that each user
> has his own uid/gid with the same numerical values).

If you change uid/gid, that has no relevance for the content that git tracks. If the CRC
is equal you have to check the content. Ideally a change that does not change the content
should not change the CRC either, so there is really no absolute need to see that change.

I assume the idea is that if you do "tar xvf" or something like that, then changes in file,
mtime etc could be picked up by looking at these attributes, but it seems that those that
mess with mtime such that it goes back in time are out of luck with git anyway.

> Which hash to use depends on some estimate of the likelihood that the hashes collide and
 > simultaneously that the other metadata coincide.  It seems to me that CRC-32 would
> be adequate.  But if not, a longer hash could be used (albeit with less space savings).
>
> Michael
>

JGit simply ignores ctime, ino, dev, uid and gid.  The real reason is of course that
standard Java does not have an API for these extra attributes. On the the other hand
nobody is going to fix this bug. The reason is that if you follow the rule that mtime
must always change to "now" if content change, then all changes will be found simply
by looking at mtime or performing a content check for the racy case.  Those that mess
with mtime tend to be unhappy anyway.

Then there is the issue of how often we can detect changes without checking content. Ino
usually changes, but when it changes mtime usually does too, so how often does it speed
up.

Has anyone instrumented git to see how much the different attributes actually
contribute to performance and accuracy?

I'd like to extend the size field to 64 bits. We rarely need the extra bits, but we
cannot differ between 3 bytes and 4294967299 bytes so avoiding the very expensive
content check there would be welcome, even it it's a rare event. I haven't thought
too much about this though. I just felt uncomfortable when looking at the code and
knowing that performing a content check of a 4 GB file could take a minute or two.

-- robin
