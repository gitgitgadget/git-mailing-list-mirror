From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] remote.c: don't leak the base branch name in
 format_tracking_info
Date: Sun, 10 Aug 2014 15:32:42 -0400
Message-ID: <20140810193242.GA9886@peff.net>
References: <1407679076-20300-1-git-send-email-stefanbeller@gmail.com>
 <53E78C59.2010704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 21:32:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGYrQ-0006ap-9g
	for gcvg-git-2@plane.gmane.org; Sun, 10 Aug 2014 21:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbaHJTcw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Aug 2014 15:32:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:49817 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751122AbaHJTcv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2014 15:32:51 -0400
Received: (qmail 32542 invoked by uid 102); 10 Aug 2014 19:32:51 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (204.237.18.137)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 10 Aug 2014 14:32:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Aug 2014 15:32:42 -0400
Content-Disposition: inline
In-Reply-To: <53E78C59.2010704@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255100>

On Sun, Aug 10, 2014 at 05:14:33PM +0200, Stefan Beller wrote:

> On 10.08.2014 15:57, Stefan Beller wrote:
> > Found by scan.coverity.com (Id: 1127809)
> >=20
> > Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
> > ---
> >  remote.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/remote.c b/remote.c
> > index 3d6c86a..2c1458f 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -1983,6 +1983,7 @@ int format_tracking_info(struct branch *branc=
h, struct strbuf *sb)
> >  			strbuf_addf(sb,
> >  				_("  (use \"git pull\" to merge the remote branch into yours)\=
n"));
> >  	}
> > +	free(base);
> >  	return 1;
> >  }
> > =20
> >=20
>=20
> Upon testing this one again, I get a warning
> remote.c: In function =E2=80=98format_tracking_info=E2=80=99:
> remote.c:1986:2: warning: passing argument 1 of =E2=80=98free=E2=80=99=
 discards =E2=80=98const=E2=80=99 qualifier from pointer target type [e=
nabled by default]
>   free(base);
>   ^
> In file included from git-compat-util.h:103:0,
>                  from cache.h:4,
>                  from remote.c:1:
> /usr/include/stdlib.h:483:13: note: expected =E2=80=98void *=E2=80=99=
 but argument is of type =E2=80=98const char *=E2=80=99
>  extern void free (void *__ptr) __THROW;
>              ^
>=20
> Please ignore this patch.

I think your patch is definitely fixing a leak; it's just that the
existing code is a little sloppy. It does:

  const char *base;
  ...
  base =3D branch->merge[0]->dst;
  base =3D shorten_unambiguous_ref(base, 0);

In the first assignment, "base" should be const, as we are pointing to
somebody else's memory. But in the second, we use the same pointer to
store newly allocated memory from shorten_unambiguous_ref.

In the general case, you need two pointers to do this right. However, w=
e
don't actually look at "base" between the two assignments, so I think
you could just do it as:

  char *base;
  ...
  base =3D shorten_unambiguous_ref(branch->merge[0]->dst, 0);

-Peff
