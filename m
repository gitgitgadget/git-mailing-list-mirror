From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 07/10] rev-list: call new "filter_skip" function
Date: Mon, 30 Mar 2009 05:26:12 +0200
Message-ID: <200903300526.12978.chriscool@tuxfamily.org>
References: <20090326055549.e1f244d9.chriscool@tuxfamily.org> <7v8wmssrrs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 05:28:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo8BB-0005aS-1T
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 05:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193AbZC3D1V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Mar 2009 23:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754084AbZC3D1V
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 23:27:21 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:40857 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753525AbZC3D1U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Mar 2009 23:27:20 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 0645D4B0024;
	Mon, 30 Mar 2009 05:27:11 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 708FD4B002A;
	Mon, 30 Mar 2009 05:27:06 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7v8wmssrrs.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115057>

Le jeudi 26 mars 2009, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > This patch implements a new "filter_skip" function in C in
> > "bisect.c" that will later replace the existing implementation in
> > shell in "git-bisect.sh".
> >
> > An array is used to store the skipped commits. But the array is
> > not yet fed anything.
> >
> > Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> > ---
> >  bisect.c           |   65
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++ bisect.h      =
   =20
> > |    6 ++++-
> >  builtin-rev-list.c |   30 ++++++++++++++++++++----
> >  3 files changed, 95 insertions(+), 6 deletions(-)
> >
> > diff --git a/bisect.c b/bisect.c
> > index 27def7d..39189f2 100644
> > --- a/bisect.c
> > +++ b/bisect.c
> > @@ -4,6 +4,11 @@
> >  #include "revision.h"
> >  #include "bisect.h"
> >
> > +
> > +static unsigned char (*skipped_sha1)[20];
> > +static int skipped_sha1_nr;
> > +static int skipped_sha1_alloc;
> > +
> >  /* bits #0-15 in revision.h */
> >
> >  #define COUNTED		(1u<<16)
> > @@ -386,3 +391,63 @@ struct commit_list *find_bisection(struct
> > commit_list *list, return best;
> >  }
> >
> > +static int skipcmp(const void *a, const void *b)
> > +{
> > +	return hashcmp(a, b);
> > +}
>
> I've learned to suspect without reading a qsort() callback that does =
not
> derefence its arguments.  Is this doing the right thing?

I think so.

Here is a gdb session that seems to show that it's ok:

---------------------------------------------------
=2E..
$ git bisect skip
There are only 'skip'ped commit left to test.
The first bad commit could be any of:
3de952f2416b6084f557ec417709eac740c6818c
7b7f204a749c3125d5224ed61ea2ae1187ad046f
32a594a3fdac2d57cf6d02987e30eec68511498c
We cannot bisect more!
$
$ gdb git
GNU gdb 6.6-debian
Copyright (C) 2006 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and yo=
u are
welcome to change it and/or distribute copies of it under certain=20
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for deta=
ils.
This GDB was configured as "x86_64-linux-gnu"...
Using host libthread_db library "/lib/libthread_db.so.1".
(gdb) b skipcmp
Breakpoint 1 at 0x46edfd: file bisect.c, line 457.
(gdb) run bisect--helper --next-vars
Starting program: /home/christian/git/bin/git bisect--helper --next-var=
s
[Thread debugging using libthread_db enabled]
[New Thread 47665987240336 (LWP 9703)]
[Switching to Thread 47665987240336 (LWP 9703)]

Breakpoint 1, skipcmp (a=3D0x77a800, b=3D0x77a814) at bisect.c:457
457             return hashcmp(a, b);
(gdb) p skipped_sha1
$1 =3D (unsigned char (*)[20]) 0x77a800
(gdb) p a - b
$2 =3D -20
(gdb) p sha1_to_hex(a)
$3 =3D 0x771256 "3de952f2416b6084f557ec417709eac740c6818c"
(gdb) p sha1_to_hex(b)
$4 =3D 0x7711c0 "7b7f204a749c3125d5224ed61ea2ae1187ad046f"
(gdb)   =20
---------------------------------------------------

Do you think I should add a comment and/or perhaps cast a and b into "c=
onst=20
unsigned char *"?

Thanks,
Christian.
