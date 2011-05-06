From: "Kibler, Bill" <bill.kibler@hp.com>
Subject: RE: git failure on HP-UX - more data
Date: Fri, 6 May 2011 19:02:50 +0000
Message-ID: <88C5107F36BD7E4BBFDFDB140E3D81077FA78CF67E@GVW1362EXC.americas.hpqcorp.net>
References: <88C5107F36BD7E4BBFDFDB140E3D81077FA78CF12C@GVW1362EXC.americas.hpqcorp.net>
 <7vfwot6k7a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Richard Lloyd <richard.lloyd@connectinternetsolutions.com>,
	"kibler@psyber.com" <kibler@psyber.com>,
	"Kibler, Bill" <bill.kibler@hp.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 21:04:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIQJp-0000sr-1D
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 21:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756602Ab1EFTD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 15:03:59 -0400
Received: from g4t0017.houston.hp.com ([15.201.24.20]:3987 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754622Ab1EFTD5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2011 15:03:57 -0400
Received: from G1W0401.americas.hpqcorp.net (g1w0401.americas.hpqcorp.net [16.236.31.6])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by g4t0017.houston.hp.com (Postfix) with ESMTPS id B5340388D8;
	Fri,  6 May 2011 19:03:56 +0000 (UTC)
Received: from G6W0644.americas.hpqcorp.net (16.230.34.80) by
 G1W0401.americas.hpqcorp.net (16.236.31.6) with Microsoft SMTP Server (TLS)
 id 8.2.176.0; Fri, 6 May 2011 19:02:53 +0000
Received: from GVW1362EXC.americas.hpqcorp.net ([16.230.34.143]) by
 G6W0644.americas.hpqcorp.net ([16.230.34.80]) with mapi; Fri, 6 May 2011
 19:02:53 +0000
Thread-Topic: git failure on HP-UX - more data
Thread-Index: AcwLV5LX8gfa/uHdSi27g4QBxZpblQAoAUyw
In-Reply-To: <7vfwot6k7a.fsf@alter.siamese.dyndns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173000>

I spent some time thinking about this problem and realized that guessing the
pipe size was the issue probably was wrong, when it is likely something more 
generic in nature. I did some more testing, and remembered a similar problem
when trying to do a git clone of the arm kernel for my $99 netbook article
(see www.kiblerelectronics./corner/ccii.shtml), where it failed much
the same as on HP-UX. My thinking is that this is a variable that is controlled
by the OS/Libc settings and not something that can be selected as a
good enough value. My real problem and reason for putting in a bug report,
is wanting to know how this value was intended to be used.

I just ran several tests on hp-UX using various values for the
"LARGE_PACKET_MAX", all trying to see what the actual failure value is.
I thought it might be related to ssize_t, which in HP-UX is 32K, but
values around 32K all worked fine. 65000 failed, while 48000 worked.
I went through the normal trial and error process and found the value
to vary over a number of tests - in short - not fixed. That suggested
it is partly controlled by some amount of free space(?).

I will test out my arm netbook and see if changing this value helps git
on my system, but for now I feel this value was selected somewhat
arbitrarily when it should be selected as the smallest value that can
work for your OS of choice. I thought of using 32K on HP-UX, but decided
that if I don't really know what the mechanism is controlling this value
then the smallest working value is the safest to use (8208).

Can anyone in this group explain what is going on for me? Why was 64K
selected in the first place?
Thanks.
Bill. 

-----Original Message-----
From: Junio C Hamano [mailto:gitster@pobox.com] 
Sent: Thursday, May 05, 2011 12:07 PM
To: Kibler, Bill
Cc: git@vger.kernel.org; Richard Lloyd
Subject: Re: git failure on HP-UX

"Kibler, Bill" <bill.kibler@hp.com> writes:

> In looking at the code, "sideband.h" defines "LARGE_PACKET_MAX 65520"
> and is related to the passed flag "side-band-64k" as discussed in git
> document pack-protocol.txt. The current default usage seems to be 64K
> transfers, yet if we check the "include/limits.h" of HP-UX we see a
> "PIPE_BUF" set to 8192. Along with the tusc indication of 8K pipe size,
> I suspect that HP-UX is coring due to git trying to use a 64K pipe when
> 8K is max.
>
> I solved the probem for now, by changing the file sideband.h to use
> "LARGE_PACKET_MAX 8208".

This does not make any sense.  We may make write(2) and read(2) system
calls with 64k (or maybe bit more) chunk, but that does not mean the
implementation of these system calls must take that as a whole.  Your
write(2) is allowed to write only whatever fits your pipe buffer, and tell
the caller "I wrote only 8192 bytes", and the code is supposed to loop,
advancing the write pointer by 8k and calling write(2) again, until you
write everything to whoever is reading the other end of the pipe.  The
same thing for the read(2).

If you can find a place where we make write(2)/read(2) and blindly assumes
that a non-negative return means everything was written/read successfully,
then you have found a bug.

If the symptom _were_ a deadlock where the writer of one pipe expected to
be able to send 64k to the other end of the pipe and then hear back from
the other side with a separate read, I would understand that could happen
(actually we know a local pipe transfer without ssh has that kind of
potential deadlock but I think the size we assume that can fit in the pipe
buffer is far smaller than 8k).  But I do not understand where a SIGBUS
can come from.
