From: linux@horizon.com
Subject: Re: A look at some alternative PACK file encodings
Date: 7 Sep 2006 04:41:58 -0400
Message-ID: <20060907084158.25725.qmail@science.horizon.com>
Cc: git@vger.kernel.org, linux@horizon.com
X-From: git-owner@vger.kernel.org Thu Sep 07 10:42:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLFSY-0002zP-6W
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 10:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbWIGImB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 04:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWIGImB
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 04:42:01 -0400
Received: from science.horizon.com ([192.35.100.1]:62258 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751039AbWIGImA
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Sep 2006 04:42:00 -0400
Received: (qmail 25726 invoked by uid 1000); 7 Sep 2006 04:41:58 -0400
To: gitzilla@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26617>

A few notes:


Re: base-128 encodings, it's a pet peeve of mine that meny people, even
while trying to save space, waste it by allowing redundant encodings.
The optimal way, assming msbit=1 means "more", is

	0x00 -> 0		0x01 -> 1
	0x7f -> 127		0x80 0x00 -> 128
	0x80 0x7f -> 255	0x81 0x00 -> 256
	0xfe 0x7f -> 16383	0xff 0x00 -> 16384
	0xff 0x7f -> 16511	0x80 0x00 0x00 -> 16512

The decoding code can be written several ways, but try:

	c = *p++;
	x = c & 127;
	while (c & 128) {
		c = *p++;
		x = ((x + 1) << 7) + (c & 127);
	}

encoding is most easily done in reverse:

	char buf[9];
	char *p = buf+8;

	*p = x & 127;
	while (x >>= 7)
		*--p = 0x80 | (--x & 127);

	write_out(p, buf + 9 - p);


If you want to do signed offsets, the easiest way to write the code
is to convert to an unsigned with the sign bit as lsbit:

	u = (s << 1) ^ -(s < 0);

And then feed the resulting unsigned number to the functions above.
Handling the sign bit specially in the encoding is messier.


And finally, regarding qsort(), stability is not guaranteed, but glibc
actually uses a stable merge sort if it can allocate the memory.  See
http://sourceware.org/cgi-bin/cvsweb.cgi/libc/stdlib/msort.c?rev=1.21&cvsroot=glibc

This leads to the slightly annoying question of whether it's worth
writing a stable sort just to make git work a little bit better
on non-glibc platforms, when it doesn't affect most current users
personally and it still works correctly with an unstable qsort.

It might be simplest to simply lift the glibc mergesort implementation,
possibly inlining the compares for efficiency.  If you touch the code,
please (my eyes!  it hurts us!) consider fixing the brace style.
