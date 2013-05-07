From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] clone: allow cloning local paths with colons in them
Date: Tue, 7 May 2013 12:47:27 -0400
Message-ID: <20130507164727.GA5078@sigill.intra.peff.net>
References: <1367033778-13923-1-git-send-email-pclouds@gmail.com>
 <1367633973-26214-1-git-send-email-pclouds@gmail.com>
 <7vehdils6c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	William Giokas <1007380@gmail.com>, fsckdaemon@gmail.com,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 07 18:47:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZl3A-0007TY-5i
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 18:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759154Ab3EGQrb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 May 2013 12:47:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:49272 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758587Ab3EGQrb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 12:47:31 -0400
Received: (qmail 22055 invoked by uid 102); 7 May 2013 16:47:51 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 May 2013 11:47:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 May 2013 12:47:27 -0400
Content-Disposition: inline
In-Reply-To: <7vehdils6c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223587>

On Tue, May 07, 2013 at 08:34:51AM -0700, Junio C Hamano wrote:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>=20
> > diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> > index 67869b4..0629149 100755
> > --- a/t/t5601-clone.sh
> > +++ b/t/t5601-clone.sh
> > @@ -280,4 +280,9 @@ test_expect_success 'clone checking out a tag' =
'
> >  	test_cmp fetch.expected fetch.actual
> >  '
> > =20
> > +test_expect_success NOT_MINGW,NOT_CYGWIN 'clone local path foo:bar=
' '
> > +	cp -R src "foo:bar" &&
> > +	git clone "./foo:bar" foobar
> > +'
>=20
> Hmph, why not
>=20
> 	git clone --mirror src foo:bar &&
>         git clone ./foo:bar foobar

Yeah, not only does that avoid "cp -R", but it is a nice check that we
do not do anything stupid with colons on the dst argument (which we
should obviously not, but it cannot hurt to exercise it).

> or something?  Also do we have a easy negative case we want to test,
> i.e. a case where we do not want the new codepath to trigger by
> mistake?

Yeah, checking "git clone host:path" would be nice, but such a case
would want to go through ssh. I suspect we could point GIT_SSH at a
script like:

  #!/bin/sh
  echo "ssh: $*" >ssh-log &&
  host=3D$1; shift
  cd "pretend-hosts/$host" && exec "$@"

It looks like t5602 does something similar already.

-Peff
