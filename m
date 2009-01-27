From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Valgrind updates
Date: Tue, 27 Jan 2009 22:52:39 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901272241250.14855@racer>
References: <alpine.DEB.1.00.0901210105470.19014@racer> <20090121001551.GB18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210119510.19014@racer> <20090121003739.GA18373@coredump.intra.peff.net> <alpine.DEB.1.00.0901210216440.19014@racer>
 <20090121190757.GB21686@coredump.intra.peff.net> <alpine.DEB.1.00.0901212259420.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901270327200.26199@intel-tinevez-2-302> <alpine.LFD.2.00.0901261934450.3123@localhost.localdomain> <alpine.DEB.1.00.0901270512171.14855@racer>
 <20090127131404.GA11870@sirena.org.uk> <alpine.DEB.1.00.0901271742430.3586@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901271006060.3123@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: zlib@gzip.org, valgrind-users@lists.sourceforge.net,
	Mark Brown <broonie@sirena.org.uk>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 27 22:54:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRvsK-0004oq-Ao
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 22:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480AbZA0VwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 16:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752229AbZA0VwN
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 16:52:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:38989 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751799AbZA0VwM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 16:52:12 -0500
Received: (qmail invoked by alias); 27 Jan 2009 21:52:10 -0000
Received: from pD9EB30BF.dip0.t-ipconnect.de (EHLO noname) [217.235.48.191]
  by mail.gmx.net (mp067) with SMTP; 27 Jan 2009 22:52:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+M2F4q8XCMwHM7b9G3qV8Q4HcWEa7s1hn+43WRk0
	EkQWdvUKtqrMep
X-X-Sender: gene099@racer
In-Reply-To: <alpine.LFD.2.00.0901271006060.3123@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107391>

Hi,

[Cc'ed the valgrind-users list, maybe the valgrind Gods can see that our 
 case is pretty strange, and tell us what we do wrong.]

Note to valgrind experts: this is _not_ about the Conditional thing in 
zlib, but about an uninitialized byte _in the middle_ of the zlib output 
buffer.

 On Tue, 27 Jan 2009, Linus Torvalds wrote:

> Hmm. The zlib faq has a note about zlib doing a conditional on 
> uninitialized memory that doesn't matter, and that is what the 
> suppression should be about (to avoid a warning about "Conditional jump 
> or move depends on uninitialised value").
> 
> But that one is documented to not matter for the actual output (zlib 
> FAQ#36).
> 
> It's possible that zlib really does leave padding bytes around that 
> literally don't matter, and that don't get initialized. That really 
> would be bad, because it means that the output of git wouldn't be 
> repeatable. But I doubt this is the case - original git used to actually 
> do the SHA1 over the _compressed_ data, which was admittedly a totally 
> and utterly broken design (and we fixed it), but it did work. Maybe it 
> worked by luck, but I somehow doubt it.
> 
> Some googling did find this:
> 
> 	http://mailman.few.vu.nl/pipermail/sysprog/2008-October/000298.html
> 
> which looks very similar: an uninitialized byte in the middle of a 
> deflate() packet.
> 
> Anyway, I'm just going to Cc 'zlib@gzip.org', since this definitely is 
> _not_ the same issue as in the FAQ, and we're not the only ones seeing it.
>
> [...]
>
> Dscho wrote:
>
> > Yet, the buffer in question is 195 bytes, stream.total_count (which 
> > totally agrees with size - stream.avail_out) says it is 58 bytes, and 
> > valgrind says that the byte with offset 51 is uninitialized.
> 
> The thing to note here is that what we are passing in to "write_buffer()" 
> is _exactly_ what zlib deflated for us:
> 
>  - 'compressed' is the allocation, and is what we used to initialize 
>    'stream.next_out' with (at the top of the code sequence above)
> 
>  - 'size' is gotten from 'stream.total_out' at the end of the compression.
> 
> Oh Gods of zlib, please hear our plea for clarification..

To help ye Gods, I put together this almost minimal C program:

-- snip --
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <zlib.h>

int main(int argc, char **argv)
{
	const char hdr[] = {
		0x74, 0x72, 0x65, 0x65, 0x20, 0x31, 0x36, 0x35,
		0x00,
	};
	int hdrlen = sizeof(hdr);
	const char buf[] = {
		0x31, 0x30, 0x30, 0x36, 0x34, 0x34, 0x20, 0x66,
		0x69, 0x6c, 0x65, 0x31, 0x00, 0x10, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x31, 0x30, 0x30, 0x36, 0x34, 0x34, 0x20,
		0x66, 0x69, 0x6c, 0x65, 0x32, 0x00, 0x20, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x31, 0x30, 0x30, 0x36, 0x34, 0x34,
		0x20, 0x66, 0x69, 0x6c, 0x65, 0x33, 0x00, 0x30,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x31, 0x30, 0x30, 0x36, 0x34,
		0x34, 0x20, 0x66, 0x69, 0x6c, 0x65, 0x34, 0x00,
		0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x31, 0x30, 0x30, 0x36,
		0x34, 0x34, 0x20, 0x66, 0x69, 0x6c, 0x65, 0x35,
		0x00, 0x50, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00,
	};
	int len = sizeof(buf);
	z_stream stream;
	unsigned char *compressed;
	int size, ret, i;
	FILE *out;

	memset(&stream, 0, sizeof(stream));
	deflateInit(&stream, Z_BEST_SPEED);
	size = 8 + deflateBound(&stream, len+hdrlen);
	compressed = malloc(size);
	if (!compressed)
		return 1;

	stream.next_out = compressed;
	stream.avail_out = size;

	stream.next_in = (unsigned char *)hdr;
	stream.avail_in = hdrlen;
	while ((ret = deflate(&stream, 0)) == Z_OK)
		/* nothing */;
	/* deflate() returns Z_BUF_ERROR at this point */

	stream.next_in = (unsigned char *)buf;
	stream.avail_in = len;
	ret = deflate(&stream, Z_FINISH);
	if (ret != Z_STREAM_END)
		return 1;

	if (deflateEnd(&stream) != Z_OK)
		return 1;

	out = fopen("/dev/null", "w");
	fwrite(compressed + 51, 51, 1, out);
	fwrite(compressed + 51, 1, 1, stderr);
	fflush(out);
	fclose(out);

	free(compressed);
	return 0;
}
-- snap --

... which produces this output...

-- snip --
==6348== Memcheck, a memory error detector.
==6348== Copyright (C) 2002-2008, and GNU GPL'd, by Julian Seward et al.
==6348== Using LibVEX rev exported, a library for dynamic binary translation.
==6348== Copyright (C) 2004-2008, and GNU GPL'd, by OpenWorks LLP.
==6348== Using valgrind-3.5.0.SVN, a dynamic binary instrumentation framework.
==6348== Copyright (C) 2000-2008, and GNU GPL'd, by Julian Seward et al.
==6348== For more details, rerun with: -v
==6348== 
==6348== Use of uninitialised value of size 8
==6348==    at 0x4E2FC5B: (within /usr/lib/libz.so.1.2.3.3)
==6348==    by 0x4E317B6: (within /usr/lib/libz.so.1.2.3.3)
==6348==    by 0x4E2DF9C: (within /usr/lib/libz.so.1.2.3.3)
==6348==    by 0x4E2E654: deflate (in /usr/lib/libz.so.1.2.3.3)
==6348==    by 0x400957: main (valgrind-testcase.c:60)
==6348== 
==6348== Syscall param write(buf) points to uninitialised byte(s)
==6348==    at 0x5103D50: write (in /lib/libc-2.6.1.so)
==6348==    by 0x50A9AE2: _IO_file_write (in /lib/libc-2.6.1.so)
==6348==    by 0x50A9748: (within /lib/libc-2.6.1.so)
==6348==    by 0x50A9A4B: _IO_file_xsputn (in /lib/libc-2.6.1.so)
==6348==    by 0x509FDBA: fwrite (in /lib/libc-2.6.1.so)
==6348==    by 0x4009D7: main (valgrind-testcase.c:69)
==6348==  Address 0x53da87b is 51 bytes inside a block of size 195 alloc'd
==6348==    at 0x4C222CB: malloc (in /usr/local/lib/valgrind/amd64-linux/vgpreload_memcheck.so)
==6348==    by 0x4008D7: main (valgrind-testcase.c:45)
,==6348== 
==6348== Syscall param write(buf) points to uninitialised byte(s)
==6348==    at 0x5103D50: write (in /lib/libc-2.6.1.so)
==6348==    by 0x50A9AE2: _IO_file_write (in /lib/libc-2.6.1.so)
==6348==    by 0x50A9748: (within /lib/libc-2.6.1.so)
==6348==    by 0x50A9A83: _IO_do_write (in /lib/libc-2.6.1.so)
==6348==    by 0x50AA048: _IO_file_sync (in /lib/libc-2.6.1.so)
==6348==    by 0x509EDB9: fflush (in /lib/libc-2.6.1.so)
==6348==    by 0x4009E0: main (valgrind-testcase.c:70)
==6348==  Address 0x4020000 is not stack'd, malloc'd or (recently) free'd
==6348== 
==6348== ERROR SUMMARY: 3 errors from 3 contexts (suppressed: 15 from 4)
==6348== malloc/free: in use at exit: 0 bytes in 0 blocks.
==6348== malloc/free: 7 allocs, 7 frees, 268,835 bytes allocated.
==6348== For counts of detected errors, rerun with: -v
==6348== Use --track-origins=yes to see where uninitialised values come from
==6348== All heap blocks were freed -- no leaks are possible.
-- snap --

Note that the error only occurs when fwrite()ing to stderr, not 
any other file.

This is with valgrind compiled from a git-svn mirror updated today, i.e. 
valgrind-3.5.0.SVN.


Ciao,
Dscho
