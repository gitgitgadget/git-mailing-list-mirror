From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] Fix Solaris Workshop Compiler issues
Date: Thu, 15 Nov 2007 01:44:04 +0100
Message-ID: <20071115004404.GB25021@atjola.homenet>
References: <Pine.LNX.4.64.0711142125460.17530@bianca.dialin.t-online.de> <20071114204732.GE3973@steel.home> <7vprycfrk6.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711150011020.4135@bianca.dialin.t-online.de> <20071114232809.GH3973@steel.home> <20071115001756.GA25021@atjola.homenet> <7v3av89wq7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Guido Ostkamp <git@ostkamp.fastmail.fm>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 01:44:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsSqH-0005hf-EQ
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 01:44:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756826AbXKOAoJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Nov 2007 19:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756734AbXKOAoJ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 19:44:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:59555 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754888AbXKOAoH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 19:44:07 -0500
Received: (qmail invoked by alias); 15 Nov 2007 00:44:05 -0000
Received: from i577BBF04.versanet.de (EHLO localhost) [87.123.191.4]
  by mail.gmx.net (mp018) with SMTP; 15 Nov 2007 01:44:05 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18MFr5u+N0Mrn/4SCGRCfg7e8Z/UATt5o783yDy00
	PvK9TgpHEHdMUL
Content-Disposition: inline
In-Reply-To: <7v3av89wq7.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65032>

On 2007.11.14 16:30:08 -0800, Junio C Hamano wrote:
> Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:
>=20
> > No, just tried with cc: Sun C 5.7 Patch 117837-06 2005/10/05
> >
> > It's the "struct hack", ie. the incomplete array at the end of
> > delta_index. Still looking for a fix/workaround.
>=20
> Do you mean the "FLEX_ARRAY" thing?
>=20
> You can ask for FLEX_ARRAY from the command line of your "make"
> process.
>=20
> There is this thing in git-compat-util.h
>=20
>         #ifndef FLEX_ARRAY
>         #if defined(__GNUC__) && (__GNUC__ < 3)
>         #define FLEX_ARRAY 0
>         #else
>         #define FLEX_ARRAY /* empty */
>         #endif
>         #endif
>=20
> The sources are written this way:
>=20
> 	struct foo {
>         	... other members ...
>                 char last_member_that_is_flexible[FLEX_ARRAY];
> 	};
>=20
> For older gcc, because we know about its lack of support, the
> above turns into:
>=20
> 	struct foo {
>         	... other members ...
>                 char last_member_that_is_flexible[0];
>         }
>=20
> But for recent enough compilers that grok the "flexible array
> members", the above expands to:
>=20
> 	struct foo {
>         	... other members ...
>                 char last_member_that_is_flexible[];
>         }
>=20
> Maybe your compiler needs -DFLEX_ARRAY=3D0 in CFLAGS?

Actually, I just created a test-case remotely on a Solaris box in my
university (see below) and didn't compile the actual git code. With the
=46AM, cc complains about a redeclared identifier, with a zero-sized
array, it complains that an array cannot be zero-sized...

Seems to be a known bug in Sun Studio 10:
http://forum.java.sun.com/thread.jspa?threadID=3D5071896&messageID=3D92=
63771

Bj=F6rn


#include <stdio.h>

struct foo;
void bar(const struct foo *, unsigned long);

struct bla {
	unsigned long foo;
};

struct foo {
	unsigned long val;
	struct bla *blas[];
};

void bar(const struct foo *foo, unsigned long val)
{
	printf("%lu %lu\n", foo->val, val);
}

int main()
{
	struct foo foo;
	foo.val =3D 10;
	bar(&foo, 20);

	return 0;
}
