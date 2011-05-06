From: "Kibler, Bill" <bill.kibler@hp.com>
Subject: RE: git failure on HP-UX - more data
Date: Fri, 6 May 2011 21:34:16 +0000
Message-ID: <88C5107F36BD7E4BBFDFDB140E3D81077FA78CF78C@GVW1362EXC.americas.hpqcorp.net>
References: <88C5107F36BD7E4BBFDFDB140E3D81077FA78CF12C@GVW1362EXC.americas.hpqcorp.net>
 <7vfwot6k7a.fsf@alter.siamese.dyndns.org>
 <88C5107F36BD7E4BBFDFDB140E3D81077FA78CF67E@GVW1362EXC.americas.hpqcorp.net>
 <7vliyjzj0n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Richard Lloyd <richard.lloyd@connectinternetsolutions.com>,
	"kibler@psyber.com" <kibler@psyber.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 23:35:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QISfu-0001if-6c
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 23:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932888Ab1EFVe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 17:34:57 -0400
Received: from g6t0184.atlanta.hp.com ([15.193.32.61]:30810 "EHLO
	g6t0184.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932843Ab1EFVe5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2011 17:34:57 -0400
Received: from G3W0631.americas.hpqcorp.net (g3w0631.americas.hpqcorp.net [16.233.59.15])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by g6t0184.atlanta.hp.com (Postfix) with ESMTPS id 794FCC45C;
	Fri,  6 May 2011 21:34:55 +0000 (UTC)
Received: from G6W0173.americas.hpqcorp.net (16.230.33.182) by
 G3W0631.americas.hpqcorp.net (16.233.59.15) with Microsoft SMTP Server (TLS)
 id 8.2.176.0; Fri, 6 May 2011 21:34:17 +0000
Received: from GVW1362EXC.americas.hpqcorp.net ([16.230.34.143]) by
 G6W0173.americas.hpqcorp.net ([16.230.33.182]) with mapi; Fri, 6 May 2011
 21:34:17 +0000
Thread-Topic: git failure on HP-UX - more data
Thread-Index: AcwMKdU4mxqqL9SsQWae4ctnjjzqvQACR7Og
In-Reply-To: <7vliyjzj0n.fsf@alter.siamese.dyndns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173013>

Thanks for the response, it was very informative. I understand now
that the "side-band" values really are more of "what version" of
the protocol can you run, than an actual "use this size" handshake.

I think it might help to say again, that on HP-UX I ran several tests
of cloning using other processes, and they always worked correctly.
I even did some tusc/traces which showed multiple pipe transfers of
8K much as you would expected for your analysis of what is suppose
to happen. It is only when doing this under the ssh pipe process
that the problem occurs.

I did look, but not closely at the code, to see what might be handled
differently between the ssh and say a http transfer as it related to
pack or sideband routines. I feel if we can just determine what really 
is different using ssh we would be pretty close to the problem.

I am making it clear in my notes, that this fix is hopefully only a
temporary fix for what is still really an unknown problem.


-----Original Message-----
From: Junio C Hamano [mailto:gitster@pobox.com] 
Sent: Friday, May 06, 2011 1:12 PM
To: Kibler, Bill
Cc: git@vger.kernel.org; Richard Lloyd; kibler@psyber.com
Subject: Re: git failure on HP-UX - more data

"Kibler, Bill" <bill.kibler@hp.com> writes:

> I just ran several tests on hp-UX using various values for the
> "LARGE_PACKET_MAX", ...

The original sideband protocol had a fixed receiver side buffer that was
only 1000 bytes long.  When we updated the protocol so that we can carry
more payload with a single logical pkt-line format, which has the maximum
packet length of a bit less than 64k (it has a fixed 4 hexadecimal digits
field at the front that indicates its size, so the maximum payload size is
64k minus 4 or something like that), we added a protocol extension that is
negotiated between the server and the client for both sides to make sure
that they have the updated implementation in which the receiver is
prepared to accept a 64k packet, not just a small 1000-byte static buffer.

But all of that is at the logical protocol level.

Even if the transfer goes over the Ethernet, this size is in no way
limited by its MTU of 1500 bytes, because the kernel will take care of
buffering and reassembling for us.

It is the same deal for the pkt-line protocol, where we issue a write(2)
and expect that the system may write less than what we asked it to write,
and return us how many bytes it has actually written. As long as write(2)
correctly returns the number of bytes it wrote, and our code that calls
write(2) correctly expects a short-write and loops until writing
everything out, there is no need to worry about LARGE_PACKET_MAX.

At least, that is the theory.

I think already said this in my previous message to you, but it is
possible that we have a bug in our code that fails to expect write(2) to
result in short-write and loop until we write everything out.  My gut
feeling is that it is slightly more plausible that we have such a bug than
that your libc has a buggy implementation of write(2) that returns a bogus
value (say 64k) when in fact it wrote only what would fit in your pipe
buffer (you said 8k, I think) when asked to write 64k.

And the right thing to do is to find and fix such a bug. I am afraid you
are wasting your time by futzing LARGE_PACKET_MAX. Even if you find a good
small value that happens to work on _your_ machine, it would not be a real
fix for the problem.
