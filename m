From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Reproducible, corrupt packfile after fresh git-svn checkout message
Date: Wed, 14 Aug 2013 11:09:41 +0200
Message-ID: <877gfok59m.fsf@linux-k42r.v.cablecom.net>
References: <52037F47.5010302@exxcellent.de> <52037F84.9060006@exxcellent.de>
	<f1d8f80d6fa3678ac043bfdb19bebf6bf4261273@localhost>
	<877gfw4byx.fsf@linux-k42r.v.cablecom.net>
	<262a9f8309a3812970f47ac9f4e4b49bb972ca49@localhost>
	<87fvuk2wl0.fsf@linux-k42r.v.cablecom.net>
	<9aa1672d5c04994f416dccd84b5983c960c0fdf9@localhost>
	<vpqli4cfhhe.fsf@anie.imag.fr>
	<813506281f7a4d3a8af650c5f8ee33dd7224f193@localhost>
	<vpqfvukfgr5.fsf@anie.imag.fr>
	<edc9f41b4ffca9ce36dc50e749de7a86e4618a0e@localhost>
	<87fvuk1cyl.fsf@linux-k42r.v.cablecom.net> <5203B100.30008@gmail.com>
	<87txj0i4mc.fsf@inf.ethz.ch> <7vsiyk9j6a.fsf@alter.siamese.dyndns.org>
	<5204E018.4000808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <stefanbeller@googlemail.com>
To: Ben Tebulin <tebulin@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 11:09:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9X5Q-0007xF-6K
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 11:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759579Ab3HNJJo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Aug 2013 05:09:44 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:45111 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759533Ab3HNJJn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Aug 2013 05:09:43 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 14 Aug
 2013 11:09:36 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 14 Aug 2013 11:09:41 +0200
In-Reply-To: <5204E018.4000808@gmail.com> (Ben Tebulin's message of "Fri, 09
	Aug 2013 14:27:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232275>

Ben Tebulin <tebulin@googlemail.com> writes:

> Hello everybody!
>
> I have some _very interesting_ news regarding this issue!
> Here is the deal:
>
>   1. I was able to *reproduce the error on a machine of a coworker!*
>
>   2. I was able to rule out
>       - HDD: It's reproducible from /dev/shm
>       - Memory: Memory tests works fine
>
> now the interesting part:
>
>   3. Occurs on Linux kernels 3.7.10, 3.8.x, 3.9.11, 3.10.5
>      _but not on:_ 3.6.11, 3.5.7 and 2.6.32
>
> Both machines showing this problem are =C2=BBDell Latitude E6330=C2=AB=
 with an
> =C2=BBi5-3340M @ 2.70GHz=C2=AB CPU. Mine running stock kernels, cowor=
ker using
> plain Ubuntu 13.04.
>
> Furthermore I need to stress, that we never had any issues with our
> devices during daily _at all_.
>
> So what to do best now?

If you're still interested...

What did memcheck86 say about these machines?


My best theory so far:

malloc()/free() actually use mmap()/munmap() for large allocations.
mallopt(3) tells me that "large" here means a dynamic limit on modern
glibc, but with an upper limit of 32MB on 64-bit.  So your 39MB blob
would always result in an mmap() type allocation.

And it should be easy for glibc to check mmap() type allocations agains=
t
double free(), at least if the address has not been mapped again in the
same process.  So it probably does that, which aborts the program.

You could try to gather some data on this by looking at

  strace -o fsck.trace -f git fsck

for a crash case.  If the theory is correct, you should see an munmap()
for an address similar to the one pointed out by the glibc error
message, as follows: if you get

  *** glibc detected *** <unknown>: free(): invalid pointer: 0x00007fe1=
29669010 ***

check for the address 0x7fe129669000 (the start of the page that the
address is in).

Note that this is a pretty weak theory, because double free() detection
is squarely up valgrind's alley.  So valgrind's lack of complaints is a
strong argument against it.  But it's the best I've got so far.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
