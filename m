From: Jeff King <peff@github.com>
Subject: Re: [PATCHv2 7/9] archive: implement configurable tar filters
Date: Wed, 22 Jun 2011 10:59:17 -0400
Message-ID: <20110622145916.GA9266@sigill.intra.peff.net>
References: <20110622011923.GA30370@sigill.intra.peff.net>
 <20110622012631.GG30604@sigill.intra.peff.net>
 <4E01872F.8070503@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Jun 22 16:59:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZOtt-0001dJ-Jl
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 16:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758097Ab1FVO7Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jun 2011 10:59:24 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44295
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757988Ab1FVO7X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 10:59:23 -0400
Received: (qmail 13743 invoked by uid 107); 22 Jun 2011 14:59:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 22 Jun 2011 10:59:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Jun 2011 10:59:17 -0400
Content-Disposition: inline
In-Reply-To: <4E01872F.8070503@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176238>

On Wed, Jun 22, 2011 at 08:09:51AM +0200, Ren=C3=A9 Scharfe wrote:

> just a quick comment before I drop off the net for a few days.  I lik=
e
> the series a lot, especially the refactorings in patches 1 to 6.

Thanks. I didn't know if I was going overboard, but the result looked
cleaner to me, so it is good to have a second opinion.

> > +tar.<format>.command::
>=20
> Would switching around format and "command" be better?
>=20
> 	[tar "command"]
> 		tar.gz =3D gzip -cn
> 		tar.xz =3D xz -c

That violates our usual convention that the first and final components
are static, and the middle part can contain everything. So doing:

  git config tar.command.tar.gz "gzip -cn"

is going to end up as:

  [tar "command.tar"]
    gz =3D gzip -cn

Plus it doesn't leave room for any additional per-command config keys i=
f
we want to add them in the future.

> > +	ar =3D find_tar_filter(name, namelen);
> > +	if (!ar) {
> > +		ar =3D xcalloc(1, sizeof(*ar));
> > +		ar->name =3D xmemdupz(name, namelen);
> > +		ar->write_archive =3D write_tar_filter_archive;
> > +		ar->flags =3D ARCHIVER_WANT_COMPRESSION_LEVELS;
> > +		ALLOC_GROW(tar_filters, nr_tar_filters + 1, alloc_tar_filters);
> > +		tar_filters[nr_tar_filters++] =3D ar;
> > +	}
> > +
> > +	if (!strcmp(type, "command")) {
> > +		if (!value)
> > +			return config_error_nonbool(var);
> > +		free(ar->data);
> > +		ar->data =3D xstrdup(value);
> > +		return 0;
> > +	}
>=20
> Why not register it right here instead of adding it to the intermedia=
te
> list?

If it were just this patch, you could do that. But as soon as you add
more keys (e.g., a later patch adds tar.*.remote), then you run into th=
e
situation of getting only part of the config at a time, and maybe not
getting the full config for a command at all. For example:

  [tar "tar.gz"]
    remote =3D true

would make an archiver with no "command" set. We would need to
special-case it everywhere to ignore it when we looked at the list, or
later just remove it.  This patch takes the approach of having a
secondary list of all of the configured bits, and then only registering
those that are actually valid.

It also keeps the configured and builtin lists separate. Otherwise I
have to special-case:

  [tar "zip"]
    command =3D ...

to ignore the builtin zip archiver, which I think is not something we
want to be able to override in this way.

> And are duplicates handled properly, e.g. system has "gzip -cn"
> and local wants "gzip -c"?

Yes. We look up the archiver in the list of configured ones and
overwrite its command field (that's why the .tar.gz patch actually call=
s
the config parser as if you had those lines in your config file, instea=
d
of registering static archiver structs).

I should probably include a test for that, though.

-Peff
