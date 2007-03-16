From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: cleaner/better zlib sources?
Date: Thu, 15 Mar 2007 20:16:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703151955150.4998@alien.or.mcafeemobile.com>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <45F9EED5.3070706@garzik.org> <Pine.LNX.4.64.0703151822490.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151848090.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151941090.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703151955440.3816@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>, mpm@selenic.com,
	bcrl@kvack.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 04:20:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS2zR-0002ET-MO
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 04:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581AbXCPDUI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 23:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752878AbXCPDUI
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 23:20:08 -0400
Received: from x35.xmailserver.org ([64.71.152.41]:48329 "EHLO
	x35.xmailserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581AbXCPDUG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 23:20:06 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.xmailserver.org with [XMail 1.25 ESMTP Server]
	id <S21C684> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Thu, 15 Mar 2007 23:20:05 -0400
X-X-Sender: davide@alien.or.mcafeemobile.com
In-Reply-To: <Pine.LNX.4.64.0703151955440.3816@woody.linux-foundation.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42318>

On Thu, 15 Mar 2007, Linus Torvalds wrote:

> 
> 
> On Thu, 15 Mar 2007, Davide Libenzi wrote:
> > 
> > That's the diff against 1.2.3, but it does not seem to make an substantial 
> > difference in my Opteron ...
> 
> But the "goto" stuff you did is 5-6%? 
> 
> Is that 5-6% of total git costs, or just of inflate() itself?

Didn't do proper cache warmup and test time was fairly short. Now I'm not 
able to notice substantial differences.
Hacked up test case below ...




- Davide



/* example.c -- usage example of the zlib compression library
 * Copyright (C) 1995-2004 Jean-loup Gailly.
 * For conditions of distribution and use, see copyright notice in zlib.h
 */

/* @(#) $Id$ */

#include <sys/time.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include "zlib.h"



#define CHECK_ERR(err, msg) do { \
	if (err != Z_OK) { \
		fprintf(stderr, "%s error: %d\n", msg, err); \
		exit(1); \
	} \
} while (0)




unsigned long long getustime(void) {
	struct timeval tm;

	gettimeofday(&tm, NULL);
	return tm.tv_sec * 1000000ULL + tm.tv_usec;
}


/* ===========================================================================
 * Test deflate() with large buffers and dynamic change of compression level
 */
void do_defl(Byte *compr, uLong *comprLen,
	     Byte *uncompr, uLong uncomprLen) {
	z_stream c_stream; /* compression stream */
	int err;

	c_stream.zalloc = (alloc_func)0;
	c_stream.zfree = (free_func)0;
	c_stream.opaque = (voidpf)0;

	err = deflateInit(&c_stream, Z_BEST_SPEED);
	CHECK_ERR(err, "deflateInit");

	c_stream.next_out = compr;
	c_stream.avail_out = (uInt) *comprLen;

	/* At this point, uncompr is still mostly zeroes, so it should compress
	 * very well:
	 */
	c_stream.next_in = uncompr;
	c_stream.avail_in = (uInt) uncomprLen;
	err = deflate(&c_stream, Z_FINISH);
	if (err != Z_STREAM_END) {
		fprintf(stderr, "whoops, got %d instead of Z_STREAM_END\n", err);
		exit(1);
	}

	err = deflateEnd(&c_stream);
	CHECK_ERR(err, "deflateEnd");

	*comprLen = c_stream.next_out - compr;
}

/* ===========================================================================
 * Test inflate() with large buffers
 */
void do_infl(Byte *compr, uLong comprLen,
	     Byte *uncompr, uLong *uncomprLen) {
	int err;
	z_stream d_stream; /* decompression stream */

	d_stream.zalloc = (alloc_func)0;
	d_stream.zfree = (free_func)0;
	d_stream.opaque = (voidpf)0;

	d_stream.next_in  = compr;
	d_stream.avail_in = (uInt)comprLen;

	err = inflateInit(&d_stream);
	CHECK_ERR(err, "inflateInit");

	d_stream.next_out = uncompr;            /* discard the output */
	d_stream.avail_out = (uInt) *uncomprLen;
	err = inflate(&d_stream, Z_FULL_FLUSH);
	if (err != Z_STREAM_END) {
		fprintf(stderr, "deflate should report Z_STREAM_END\n");
		exit(1);
	}

	err = inflateEnd(&d_stream);
	CHECK_ERR(err, "inflateEnd");

	*uncomprLen = d_stream.next_out - uncompr;
}


int main(int ac, char **av) {
	uLong i, n, clen, ulen, size = 8 * 1024 * 1024, range = 256;
	Byte *ubuf, *cbuf, *tbuf;
	unsigned long long ts, te;

	srand(1);
	ulen = size;
	clen = 2 * ulen;
	ubuf = malloc(ulen);
	tbuf = malloc(ulen);
	cbuf = malloc(clen);
	for (i = 0; i < ulen; i++)
		ubuf[i] = (Byte) (rand() % range);

	/* Warming up ... */
	do_defl(cbuf, &clen, ubuf, ulen);
	do_infl(cbuf, clen, tbuf, &ulen);
	if (ulen != size) {
		fprintf(stderr, "size mismatch %lu instead of %lu\n",
			(unsigned long) ulen, (unsigned long) size);
		return 1;
	}
	if (memcmp(tbuf, ubuf, size)) {
		fprintf(stderr, "whoops! we did not get back the same data\n");
		return 2;
	}
	/* Test ... */
	ts = getustime();
	n = 0;
	do {
		for (i = 0; i < 16; i++) {
			ulen = size;
			do_infl(cbuf, clen, ubuf, &ulen);
		}
		n += i;
		te = getustime();
	} while (te - ts < 2 * 1000000);

	fprintf(stdout, "us time / cycle = %llu\n", (te - ts) / n);

	return 0;
}
