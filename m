From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: I'm a total push-over..
Date: Sun, 27 Jan 2008 14:07:25 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801271406130.23907@racer.site>
References: <e51f66da0801230601n6edd2639lff70415afa9f9026@mail.gmail.com> <4797518A.3040704@op5.se> <e51f66da0801240519u4c8e6ddfrb7af8df34552252a@mail.gmail.com> <4798B633.8040606@op5.se> <37fcd2780801240828vac82e6ds4da5aecde56e8d2f@mail.gmail.com>
 <alpine.LFD.1.00.0801240839590.2803@woody.linux-foundation.org> <e51f66da0801251252r1950c2d5g12caa5e71b9a37a@mail.gmail.com> <alpine.LFD.1.00.0801251407010.5056@hp.linux-foundation.org> <e51f66da0801260416p5f5ffb98w16fe832fe62dc7c9@mail.gmail.com>
 <alpine.LFD.1.00.0801262247140.3222@www.l.google.com> <20080127082128.GH26664@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Marko Kreen <markokr@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 15:08:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJ8BD-0001B8-OB
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 15:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022AbYA0OHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 09:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753968AbYA0OHp
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 09:07:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:58662 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753233AbYA0OHo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 09:07:44 -0500
Received: (qmail invoked by alias); 27 Jan 2008 14:07:41 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp007) with SMTP; 27 Jan 2008 15:07:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+QIFEWsCOQKF4NgkOp/nhPd8MKvMvgAPL7Al0t3e
	/tIpXd8hDwYGaJ
X-X-Sender: gene099@racer.site
In-Reply-To: <20080127082128.GH26664@dpotapov.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71815>

Hi,

On Sun, 27 Jan 2008, Dmitry Potapov wrote:

> #define rot(x,k) (((x)<<(k)) | ((x)>>(32-(k))))
> 
> #define mix(a,b,c) \
> { \
> 	a -= c;  a ^= rot(c, 4);  c += b; \
> 	b -= a;  b ^= rot(a, 6);  a += c; \
> 	c -= b;  c ^= rot(b, 8);  b += a; \
> 	a -= c;  a ^= rot(c,16);  c += b; \
> 	b -= a;  b ^= rot(a,19);  a += c; \
> 	c -= b;  c ^= rot(b, 4);  b += a; \
> }
> #define final(a,b,c) \
> { \
> 	c ^= b; c -= rot(b,14); \
> 	a ^= c; a -= rot(c,11); \
> 	b ^= a; b -= rot(a,25); \
> 	c ^= b; c -= rot(b,16); \
> 	a ^= c; a -= rot(c,4);  \
> 	b ^= a; b -= rot(a,14); \
> 	c ^= b; c -= rot(b,24); \
> }
> 
> #define hash_value(x) \
> 	hs[hp] += (x); \
> 	if (++hp == 3) { \
> 		mix (hs[0], hs[1], hs[2]); \
> 		hp = 0; \
> 	}
> unsigned int name_hash(const char *name, unsigned size)
> {
> 	unsigned hp = 0;
> 	unsigned hs[3];
> 	hs[0] = hs[1] = hs[2] = 0xdeadbeef + size;
> 
> 	do {
> 		unsigned char c;
> 		if (size >= sizeof(unsigned)) {
> 			unsigned val = get_unaligned_uint(name);
> 			if (!(val & 0x80808080)) {
> 				val &= ~0x20202020;
> 				hash_value(val);
> 				name += sizeof(val);
> 				size -= sizeof(val);
> 				continue;
> 			}
> 		}
> 
> 		while (!((c = *name) & 0x80)) {
> 			hash_value(c & ~0x20);
> 			name++;
> 			if (!--size)
> 				goto done:
> 		}
> 
> 		do {
> 			// TODO: add denormalization for Mac
> 			unsigned val = towupper (utf8_to_wchar(&name, &size));
> 			hash_value(val);
> 		} while (size && (*name & 0x80));
> 
> 	} while (size);
> done:
> 	if (hp)
> 		final(a,b,c);
> 	return hs[2];
> }

<irony>Oh yes, let's take this one, it is so much shorter, cleaner and 
overall more elegant than Linus' code.</irony>

Ciao,
Dscho
