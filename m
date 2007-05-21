From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH] git-pack-objects: cache small deltas between big objects
Date: Mon, 21 May 2007 19:00:43 +0200
Message-ID: <20070521170043.GA27063@auto.tuwien.ac.at>
References: <11796954641778-git-send-email-mkoegler@auto.tuwien.ac.at> <7v646mixnm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 21 19:00:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqBFd-00037E-8G
	for gcvg-git@gmane.org; Mon, 21 May 2007 19:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756034AbXEURAr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 21 May 2007 13:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756193AbXEURAr
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 13:00:47 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:57983 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756034AbXEURAr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 13:00:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 198707037F42;
	Mon, 21 May 2007 19:00:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g4-mCWZXh0hi; Mon, 21 May 2007 19:00:43 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id B907E7037F40; Mon, 21 May 2007 19:00:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v646mixnm.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48029>

On Sun, May 20, 2007 at 09:54:53PM -0700, Junio C Hamano wrote:
> Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:
> > diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> > index d165f10..13429d0 100644
> > --- a/builtin-pack-objects.c
> > +++ b/builtin-pack-objects.c
> > ...
> > @@ -1294,10 +1302,17 @@ static int try_delta(struct unpacked *trg, =
struct unpacked *src,
> >  	if (!delta_buf)
> >  		return 0;
> > =20
> > +	if (trg_entry->delta_data)
> > +		free (trg_entry->delta_data);
> > +	trg_entry->delta_data =3D 0;
> >  	trg_entry->delta =3D src_entry;
> >  	trg_entry->delta_size =3D delta_size;
> >  	trg_entry->depth =3D src_entry->depth + 1;
> > -	free(delta_buf);
> > +	/* cache delta, if objects are large enough compared to delta siz=
e */
> > +	if ((src_size >> 20) + (trg_size >> 21) > (delta_size >> 10))
> > +		trg_entry->delta_data =3D delta_buf;
> > +	else
> > +		free(delta_buf);
> >  	return 1;
> >  }
>=20
> Care to justify this arithmetic?  Why isn't it for example like
> this?
>=20
> 	((src_size + trg_size) >> 10) > delta_size

I wanted to avoid a possible overflow in (src_size + trg_size), so
I shift both sides.

> I am puzzled by the shifts on both ends, and differences between
> 20 and 21.

I base the maximum allowed delta_size for caching on the required
memory for creating the delta. For the src entry, you need need a
delta index, which has (about) the same size of the src entry. So I
count the src entry double.

I divide the requried memory by 1024, so that the delta size is some
magnitudes smaller and will not cause a big increase of memory usage,
eg:

=46or two 100 MB (uncompressed) blobs, we need 300MB of memory to do th=
e
delta (with the default window size of 10 up to 1900MB for all delta
indexes in the worst case). The patch will limit the delta size for
the target blob to 150kB.

The caching policy does only cache really small deltas for really big
objects, as I wanted to avoid out of memory situations. Futurer patch
should probably replace it with a better strategy.

mfg Martin K=F6gler
