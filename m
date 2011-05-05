From: "Kibler, Bill" <bill.kibler@hp.com>
Subject: RE: git failure on HP-UX
Date: Thu, 5 May 2011 20:51:52 +0000
Message-ID: <88C5107F36BD7E4BBFDFDB140E3D81077FA78CF26B@GVW1362EXC.americas.hpqcorp.net>
References: <88C5107F36BD7E4BBFDFDB140E3D81077FA78CF12C@GVW1362EXC.americas.hpqcorp.net>
 <7vfwot6k7a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Richard Lloyd <richard.lloyd@connectinternetsolutions.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 23:04:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI5iN-0006Wq-3U
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 23:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947Ab1EEVD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 17:03:58 -0400
Received: from g4t0014.houston.hp.com ([15.201.24.17]:45115 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550Ab1EEVD5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 17:03:57 -0400
X-Greylist: delayed 617 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 May 2011 17:03:57 EDT
Received: from G2W1953G.americas.hpqcorp.net (gvt0525.austin.hp.com [16.238.8.185])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by g4t0014.houston.hp.com (Postfix) with ESMTPS id 8E47D2424D;
	Thu,  5 May 2011 20:53:39 +0000 (UTC)
Received: from G5W0326.americas.hpqcorp.net (16.228.8.70) by
 G2W1953G.americas.hpqcorp.net (16.238.8.185) with Microsoft SMTP Server (TLS)
 id 14.1.270.1; Thu, 5 May 2011 20:51:55 +0000
Received: from GVW1362EXC.americas.hpqcorp.net ([16.230.34.143]) by
 G5W0326.americas.hpqcorp.net ([16.228.8.70]) with mapi; Thu, 5 May 2011
 20:51:55 +0000
Thread-Topic: git failure on HP-UX
Thread-Index: AcwLV5LX8gfa/uHdSi27g4QBxZpblQACxelQ
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172914>

Let me say first off that my change seems to work, but clearly I feel it
was more a lucky guess on my part than hunting down the actual cause since
I feel it is a combination of git actions and HP-UX libraries. I can't really
debug all of HP-UX libc, so I have to make an educated guess as to what might
be happening. For me, I felt that some mechanism inside of git should be
possible to set on the client side to limit transfer buffer sizes without
a recompile.

Now having said that and had a chance to consider my explanation as stated,
it might be more accurate to say that what I think is happening is closer to
this - as I understand the SIGBUS and other messages around the action,
I think the library call is setting up the pipe buffer as 8k of memory,
while git is assuming(?) a 64K space and returns a pointer to the libc
function that is well beyond - 48K beyond - the size of the buffer.
As I take what is happing, one of these processes is returning a pointer
that points outside approved space and causing the system to fault.
The debug steps all showed the values from git as being reasonable or
what I thought them to be, yet HP-UX faulted when entering the called
function. 

Since I was unable to date to clearly understand all the coding associated with
the fetch-pack process, just running out of time on the project, I was hoping
to get more data from the git email group, that might highlight something I missed
debugging the problem. I clearly was unable to find enough text to explain both
sides of the side-band handshake and how sideband values are used - maybe if
I had more time to understand the code fully, but I don't.

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
