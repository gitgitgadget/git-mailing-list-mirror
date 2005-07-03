From: linux@horizon.com
Subject: Re: kernel.org and GIT tree rebuilding
Date: 3 Jul 2005 02:51:12 -0000
Message-ID: <20050703025112.18758.qmail@science.horizon.com>
X-From: git-owner@vger.kernel.org Sun Jul 03 04:51:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DouZt-0001hR-UT
	for gcvg-git@gmane.org; Sun, 03 Jul 2005 04:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVGCCvS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 22:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVGCCvS
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 22:51:18 -0400
Received: from science.horizon.com ([192.35.100.1]:8519 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261346AbVGCCvM
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Jul 2005 22:51:12 -0400
Received: (qmail 18759 invoked by uid 1000); 3 Jul 2005 02:51:12 -0000
To: git@vger.kernel.org, torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> 	unsigned long size;
> 	unsigned char c;
> 
> 	c = *pack++;
> 	size = c & 15;
> 	type = (c >> 4) & 7;
> 	while (c & 0x80) {
> 		c = *pack++;
> 		size = (size << 7) + (c & 0x7f);
> 	}
> 
> or something. That's even denser.

If you're going for density, you missed something.  Try:

 	c = *pack++;
 	size = c & 15;
 	type = (c >> 4) & 7;
 	while (c & 0x80) {
 		c = *pack++;
 		size = (size << 7) + (c & 0x7f) + 16;
 	}

Encoding is most easily done in little-endian order, such as:

static unsigned
encode(unsigned char *p, unsigned long x)
{
        unsigned char *q = p;
        unsigned char buf[5];
        unsigned char *b = buf;

        while (x > 15) {
                assert(b < buf+5);
                x -= 16;
                *b++ = x & 0x7f;
                x >>= 7;
        }
        *b = x;

        while (b != buf)
                *q++ = *b-- | 0x80;
        *q++ = *b;
        return (unsigned)(q - p);
}

(You'll probably want to rewrite the above, but it's abandoned to the
public domain in any case.  Go nuts.)
