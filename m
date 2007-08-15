From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: performance on repack
Date: Wed, 15 Aug 2007 19:11:52 +0200
Message-ID: <20070815171152.GA15155@auto.tuwien.ac.at>
References: <9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com> <20070812103338.GA7763@auto.tuwien.ac.at> <9e4733910708120649g5a5e0f48pa71bd983f2bc2945@mail.gmail.com> <20070814031236.GC27913@spearce.org> <alpine.LFD.0.999.0708141634160.5415@xanadu.home> <20070815053231.GJ27913@spearce.org> <9e4733910708150808x39241071j1a4012f16cd26ef8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 19:12:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILMPY-00030v-2X
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 19:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329AbXHORL4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 15 Aug 2007 13:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752133AbXHORL4
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 13:11:56 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:50934 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbXHORLz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 13:11:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 31261744025D;
	Wed, 15 Aug 2007 19:11:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HtNoQ-JvkWNC; Wed, 15 Aug 2007 19:11:52 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id A9888744025C; Wed, 15 Aug 2007 19:11:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910708150808x39241071j1a4012f16cd26ef8@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55926>

On Wed, Aug 15, 2007 at 11:08:38AM -0400, Jon Smirl wrote:
> On 8/15/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> > > Also... read_sha1_file() is currently not thread safe, and thread=
ed
> > > delta searching would requires that its usage be serialized with =
a
> > > global mutex (not done in this patch which is a bug), or ideally =
be made
> > > thread aware.
>=20
> You can avoid making all the low level calls thread safe by using the
> main thread to get everything into RAM before starting to search for
> the deltas. The worker threads would only deal with things completely
> in memory. You may need to ref count these in-memory objects if they
> are shared between worker threads. For simplicity the in-memory input
> objects should be read only by the threads. The worker threads create
> new structures to hand their results back to the main thread for
> writing to disk.

git-pack-objects knows the order, in which it will use the objects.  A
seperate thread could pre-read the next object and wait until the main
thread starts processing it. After the read is complete, another
thread could start computing the delta index.

git-pack-objects currently reads an object (and computes the delta
index), if it is really necessary. With the pre-read, unnecessary
operations would happen.

> Initially I would just ignore very large objects while getting the
> basic code to work. After the basic code is working if a very large
> object is encountered when the main thread is faulting objects in, th=
e
> main thread should just process this object on the spot using the
> existing low memory code.

I expect that the biggest gain will be for big objects, as they
require more time to read+unpack the source objects and compute the
delta index as well as the delta.

> > @@ -1862,10 +1863,12 @@ int pretend_sha1_file(void *buf, unsigned l=
ong len, enum object_type type,
> >  void *read_sha1_file(const unsigned char *sha1, enum object_type *=
type,
> >                      unsigned long *size)
> >  {
> > +       static pthread_mutex_t locky =3D PTHREAD_MUTEX_INITIALIZER;
> >         unsigned long mapsize;
> >         void *map, *buf;
> >         struct cached_object *co;
> >
> > +       pthread_mutex_lock(&locky);
> >         co =3D find_cached_object(sha1);
> >         if (co) {
> >                 buf =3D xmalloc(co->size + 1);
> > @@ -1873,20 +1876,26 @@ void *read_sha1_file(const unsigned char *s=
ha1, enum object_type *type,
> >                 ((char*)buf)[co->size] =3D 0;
> >                 *type =3D co->type;
> >                 *size =3D co->size;
> > +               pthread_mutex_unlock(&locky);
> >                 return buf;
> >         }
> >
> >         buf =3D read_packed_sha1(sha1, type, size);

Couldn't we release the mutex at this point?

Why do we need to protect from concurrent access, when we are reading
a loose object?

> > -       if (buf)
> > +       if (buf) {
> > +               pthread_mutex_unlock(&locky);
> >                 return buf;
> > +       }
> >         map =3D map_sha1_file(sha1, &mapsize);
> >         if (map) {
> >                 buf =3D unpack_sha1_file(map, mapsize, type, size, =
sha1);
> >                 munmap(map, mapsize);
> > +               pthread_mutex_unlock(&locky);
> >                 return buf;
> >         }
> >         reprepare_packed_git();
> > -       return read_packed_sha1(sha1, type, size);
> > +       buf =3D read_packed_sha1(sha1, type, size);
> > +       pthread_mutex_unlock(&locky);
> > +       return buf;
> >  }

mfg Martin K=F6gler
