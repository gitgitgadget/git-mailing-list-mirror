From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make strbuf_cmp inline, constify its arguments and  optimize it a bit
Date: Mon, 8 Oct 2007 00:31:40 +0200
Message-ID: <20071007223140.GG2765@steel.home>
References: <1190625904-22808-1-git-send-email-madcoder@debian.org> <1190625904-22808-2-git-send-email-madcoder@debian.org> <20071007140052.GA3260@steel.home> <20071007172425.bb691da9.tihirvon@gmail.com> <20071007143912.GB10024@artemis.corp> <87sl4nlyg0.fsf@catnip.gol.com> <857ilylxhm.fsf@lola.goethe.zz> <20071007215432.GC2765@steel.home> <EF81F7DD-73C7-4B6F-92D2-4A143CA05365@wincent.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Kastrup <dak@gnu.org>, Miles Bader <miles@gnu.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Timo Hirvonen <tihirvon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 00:31:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeefE-0005aC-5k
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 00:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307AbXJGWbp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Oct 2007 18:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754480AbXJGWbp
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 18:31:45 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:58485 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbXJGWbo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 18:31:44 -0400
Received: from tigra.home (Fc872.f.strato-dslnet.de [195.4.200.114])
	by post.webmailer.de (fruni mo34) (RZmta 13.4)
	with ESMTP id j02db7j97M594U ; Mon, 8 Oct 2007 00:31:41 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id CFDA5277AE;
	Mon,  8 Oct 2007 00:31:40 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id A0FD9C502; Mon,  8 Oct 2007 00:31:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <EF81F7DD-73C7-4B6F-92D2-4A143CA05365@wincent.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+ecrQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60234>

Wincent Colaiuta, Mon, Oct 08, 2007 00:12:17 +0200:
> El 7/10/2007, a las 23:54, Alex Riesen escribi=F3:
>=20
> >>... All the rest pretty much
> >>was worse than what we started from in that it needed to reevaluate
> >>more conditions and turned out more complicated and obfuscate even =
to
> >>the human reader.
> >
> >it _is_ smaller. And it is _measurably_ faster on that thing I have =
at
> >home (and old p4).
>=20
> Can we see the numbers and the steps used to obtain them? I'm also a =
=20
> little bit confused about how an inlined function can lead to a =20
> smaller executable... or did you just mean lines-of-code?

I did mean the bytes of object code. I never said it produces a
smaller executable.

I compiled with gcc -O2 and -O4, gcc 4.1.2 (Ubuntu 4.1.2-0ubuntu4).
Cut the functions out into their own files and compile them to get the
object code. Compile with -S (assembly) to examine the generated code.
Compare.

#include <stdint.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/time.h>
#include <stdio.h>
#include <string.h>

struct strbuf {
	size_t alloc;
	size_t len;
	char *buf;
};

int strbuf_cmp2(struct strbuf *a, struct strbuf *b)
{
	int len =3D a->len < b->len ? a->len: b->len;
	int cmp =3D memcmp(a->buf, b->buf, len);
	if (cmp)
		return cmp;
	return a->len < b->len ? -1: a->len !=3D b->len;
}

int strbuf_cmp1(struct strbuf *a, struct strbuf *b)
{
	int cmp;
	if (a->len < b->len) {
		cmp =3D memcmp(a->buf, b->buf, a->len);
		return cmp ? cmp : -1;
	} else {
		cmp =3D memcmp(a->buf, b->buf, b->len);
		return cmp ? cmp : a->len !=3D b->len;
	}
}

int main(int argc, char *argv[], char *envp[])
{
	struct strbuf s1 =3D {
		.alloc =3D 0,
		.len =3D 50,
		.buf =3D "01234567890123456789012345678901234567890123456789",
	};
	struct strbuf s2 =3D {
		.alloc =3D 0,
		.len =3D 50,
		.buf =3D "0123456789012345678901234567890123456789",
	};
	struct strbuf s3 =3D {
		.alloc =3D 0,
		.len =3D 50,
		.buf =3D "0123456789012345678901234567890123456789012345678x",
	};
	struct timeval tv1, tv2, diff;
	unsigned n;
	int result;
#define CYCLES 0xffffffffu

	strbuf_cmp1(&s1, &s2);
	strbuf_cmp1(&s2, &s3);
	result =3D 0;
	gettimeofday(&tv1, NULL);
	for (n =3D CYCLES; n--; ) {
		result +=3D strbuf_cmp1(&s1, &s2);
		result +=3D strbuf_cmp1(&s2, &s3);
		result +=3D strbuf_cmp1(&s1, &s3);
		result +=3D strbuf_cmp1(&s1, &s1);
		result +=3D n;
	}
	gettimeofday(&tv2, NULL);
	timersub(&tv2, &tv1, &diff);
	printf("ph=3D%ld.%ld (%d)\n", diff.tv_sec, diff.tv_usec, result);

	strbuf_cmp2(&s1, &s2);
	strbuf_cmp2(&s2, &s3);
	result =3D 0;
	gettimeofday(&tv1, NULL);
	for (n =3D CYCLES; n--; ) {
		result +=3D strbuf_cmp2(&s1, &s2);
		result +=3D strbuf_cmp2(&s2, &s3);
		result +=3D strbuf_cmp2(&s1, &s3);
		result +=3D strbuf_cmp2(&s1, &s1);
		result +=3D n;
	}
	gettimeofday(&tv2, NULL);
	timersub(&tv2, &tv1, &diff);
	printf("ar=3D%ld.%ld (%d)\n", diff.tv_sec, diff.tv_usec, result);
	return 0;
}
