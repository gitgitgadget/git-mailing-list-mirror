From: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 5/6] clone: fix hostname parsing when guessing dir
Date: Thu, 30 Jul 2015 14:18:11 +0200
Message-ID: <20150730121811.GA24635@pks-pc.localdomain>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
 <1438185076-28870-1-git-send-email-ps@pks.im>
 <1438185076-28870-6-git-send-email-ps@pks.im>
 <xmqq7fpiamiq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 14:18:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKmnB-0005pF-GX
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 14:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbbG3MSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 08:18:15 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42936 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750985AbbG3MSO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jul 2015 08:18:14 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 2DB49207BD
	for <git@vger.kernel.org>; Thu, 30 Jul 2015 08:18:13 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Thu, 30 Jul 2015 08:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=kFxjfwhFmQqz4WWXsyD2kEZTe68=; b=S4dOS
	iIXFX67G9vym06eqiDWWFfpZZLBCZ5HfAjYksSBa/Q3e2fw4HfbmtmqQ2LHXZPen
	Ir6e8e0PsZHVYBTdQHU7lh0aplj9ZIe7v2FZXgzmacGiWGEWH6WhT1fkW79SKjSG
	cCiHPgbWLmGwf50NIj92Rmn/xCanjzN1dhzH14=
X-Sasl-enc: b6qvhjrUy/aErNvcPmrWnBTTLzJfby9rY+D8gZ7NlDlF 1438258692
Received: from localhost (x5ce10d7e.dyn.telefonica.de [92.225.13.126])
	by mail.messagingengine.com (Postfix) with ESMTPA id B855A68019B;
	Thu, 30 Jul 2015 08:18:12 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <xmqq7fpiamiq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274985>


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2015 at 10:42:21AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > We fail to guess a sensible directory name for a newly cloned
> > repository when the path component of the URL is empty. E.g.
> > cloning a repository 'ssh://user:password@example.com/' we create
> > a directory 'password@example.com' for the clone.
> >
> > Fix this by ...
>=20
> It is clear that you do not want to have that password in the
> resulting directory name from the problem description, but you
> started saying "Fix this" without saying what the desired outcome
> is.  "We want to use only the hostname, e.g. 'example.com', in such
> a case instead." or something, perhaps, at the end of the first
> paragraph?  "Fix this by doing such and such" becomes understandable
> only after we know what end result you want to achieve by "doing
> such and such".

Agreed, will fix with the next iteration.

> > ... using parse_connect_url to split host and path
> > components and explicitly checking whether we need to fall back
> > to the hostname for guessing a directory name.
>=20
> I cannot help wonder why this much change (including patches 3 and
> 4) is needed.  Isn't it just the matter of making this part of the
> existing code be aware of '@' in addition to ':'?

Actually no, as host and path components need to be treated
differently. See below.

> > -	/*
> > -	 * Find last component, but be prepared that repo could have
> > -	 * the form  "remote.example.com:foo.git", i.e. no slash
> > -	 * in the directory part.
> > -	 */
> > -	start =3D end;
> > -	while (repo < start && !is_dir_sep(start[-1]) && start[-1] !=3D ':')
> > -		start--;
>=20
> Regardless of the issue you are trying to address, we may want to
> limit that "be prepared for and careful with ':'" logic in the
> existing code to the case where the "last component" does not have
> any other component before it.  That is:
>=20
> 	http://example.com/foo:bar.git/
>=20
> would be stripped to
>=20
> 	http://example.com/foo:bar
>=20
> and then we scan backwards for ':' or '/' and declare that "bar" is
> the name of the repository, but we would probably want "foo:bar"
> instead (or we may not, as some filesystems do not want to have a
> colon in its path components).

This case is exactly why I did include patches 3 and 4. We've got
two cases that need to be distinguished:

1. we've got a non-empty path component (that is it contains more
   than just a '/'). In this case we want to take its last part
   and strip it of things like '.git'. We should only honor ':'
   as a path separator if it is the first character in the path
   component, otherwise only honor '/'.

2. we've got an empty path component. In this case we want to
   inspect the host part. If it is empty we have to error out,
   otherwise we want to strip it of authentication information
   (everythin up to and including '@') and port information
   (everything following the ':').

So both cases are treated entirely different. For your example
we'd first split up 'http://example.com/foo:bar.git' into the
host 'example.com' and the path '/foo:bar.git'. As
'parse_connect_url()' does exactly what we need, e.g. split up
host and path, I think it is only natural to reuse it.

But actually you are right, currently I still have the old logic
in place that splits on colons in the path component. In my case
it would be 'parse_connect_url()'s responsibility to detect if
host and path are not separated by '/' but by ':' and thus we'd
not run into the problem with 'foo:bar.git'. I'll verify that
behavior though and write some tests.

Patrick

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVuhYDAAoJEBF8Z7aeq/Es7wgP/2MJ1qElpWCCsDyHX/RJwBno
ftAjKrsB2Rn3Lh6oUTiCmR4GQ83n0D28RbCBE0sykF48cQO6779OB8PskNym5Wgo
oXrTF/8oz5DJ5eCIyRRUaXv1rE4FBox2X/qtECMY8JlqgoCky8m3BEPLp8pqiiHh
ZP/dLBAAPgTEG4ac01dRrNMj9woBRkl0ONG7ub4WuS4tRkrP7WMxsJFdywegcyDR
kDTP+w93Dr6ROBW39K5qbwCxR6aF88qDG43BrPjvV8TODINkmGd6CKo1AGPBqaxu
fXncQsRb5t37i96BOSpR6RzGb1p/jS+m7Tx4bCAVt9HeJebQYCJzjYpSsY27TJwz
+fFSQNxQWUTYzRFBjyawmsSlZ9aHZl+oAYyq+S5WFiPfAG7TKL0AcrfL+rQAWwgy
neru9fkw2HIP/Vl6eo45707WoeunYxfzr7zgWk7HG0FIpFw+2r6qINuI+k8vm81N
Z0s59RJLRRHkeHIDrCf+kwHaq95rrs1cPApJLWA21tD/TSx0JV3p2SuXC9Jt34dQ
yFiMdX6eUuWOsLYHvSFixctqhJ0RgaEelPZsjvAmayNOBHovbKdg2bUrenON58md
U2aRJplSGrwhWUWPDnqfk2UFTbQ6MpCBXjzvfg8rQR6+rtSWo4LRz/rs0Roiuqfe
BsBlCmyAYLm3BEU39R0s
=Ybt9
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
