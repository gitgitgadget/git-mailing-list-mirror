From: "George Spelvin" <linux@horizon.com>
Subject: Re: [PATCH] block-sha1: more good unaligned memory access candidates
Date: 13 Aug 2009 16:15:42 -0400
Message-ID: <20090813201542.25431.qmail@science.horizon.com>
Cc: linux@horizon.com, nico@cam.org, torvalds@linux-foundation.org
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 13 22:24:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbgqE-00081p-G1
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 22:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755916AbZHMUPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 16:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755905AbZHMUPt
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 16:15:49 -0400
Received: from science.horizon.com ([71.41.210.146]:65360 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755790AbZHMUPr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 16:15:47 -0400
Received: (qmail 25432 invoked by uid 1000); 13 Aug 2009 16:15:42 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125867>

> Wow.  Is it now faster than the arm/ and ppc/ hand-tweaked assembly?

It's probably faster than the ARM, which was tuned for size rather
than speed, but if you want to rework the assembly for speed, the ARM's
rotate-and-add operations allow tricks which I doubt GCC can pick up on.
(You have to notice that the F(b,c,d) function is bitwise, so you can
do it on rotated data and do the rotate when you add the result to e.)

I'd be surprised if it were faster than PPC code, especially on the
in-order G3 and G4 cores where careful scheduling really pays off.
But maybe I just get to be surprised...

For automatic assembly tuning, I was thinking of having a .c file that
has a bunch of #ifdef __PPC__ statements that gets run through $(CC) -E.
That should be a fairly portable way to 


The other question about unaligned access is whether it's beneficial
to make the fetch loop work like this:

	char const *in;
	uint32_t *out
	unsigned lsb = (unsigned)p & 3;
	uint32_t const *p32 = (uint32_t const *)(in - lsb);
	uint32_t t = ntohl(*p32);

	switch (lsb) {

	case 0:
		*out++ = t;
		for (i = 1; i < 16; i++)
			*out++ = ntohl(*++p32);
		break;
	case 1:
		for (i = 0; i < 16; i++) {
			uint32_t s = t << 8;
			t = ntohl(*++p32);
			*out++ = s | t >> 24;
		}
		break;
	case 1:
		for (i = 0; i < 16; i++) {
			uint32_t s = t << 16;
			t = ntohl(*++p32);
			*out++ = s | t >> 16;
		}
		break;
	case 1:
		for (i = 0; i < 16; i++) {
			uint32_t s = t << 24;
			t = ntohl(*++p32);
			*out++ = s | t >> 8;
		}
		break;
	}

On the ARM, at least, ntohl() isn't particularly cheap, so loading 4
bytes and assembling them turns out to be cheaper.  But it's a thought.
