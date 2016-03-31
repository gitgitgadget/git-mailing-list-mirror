From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@dwim.me>
Subject: Re: [RFC PATCH] gpg: add support for gpgsm
Date: Thu, 31 Mar 2016 16:44:50 +0200
Message-ID: <1459435490.2124.15.camel@dwim.me>
References: <1459432304-35779-1-git-send-email-cmn@dwim.me>
	 <20160331142200.GB31116@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 31 16:45:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aldqI-0004RC-Et
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 16:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757122AbcCaOo6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2016 10:44:58 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:45621 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757103AbcCaOo6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2016 10:44:58 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 380FA21DB2
	for <git@vger.kernel.org>; Thu, 31 Mar 2016 10:44:52 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Thu, 31 Mar 2016 10:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=dwim.me; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=2xfjKhbAOqu0tGwhtTU46RJfXT0=; b=WnITHP
	yr3g3TvjF6yYvr0yc/TatnubHyR7d7YxfulnYu2xHvgnFL6kavwl7Udxl2UoMGgE
	JijpfXiyKwB8j1YCZn+taujaC/ShJUwvd3Q7YIuQnx0rkX7R0hR0eAqXGELgPTNK
	L3/ISFkIC6nPgUX5C9OHVPRXWW6EsE3i1VI3E=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=2xfjKhbAOqu0tGw
	htTU46RJfXT0=; b=B/kIbCIvqLQR/FvfArpaIlIcrLnt81JHXJH9Bz3jD95ZAno
	hWs3xFrXzTMGEEzG99ZjXdkB+XuqKwwUVwFUFOPOv03x1JetzxHeToz/FaRboXxl
	cEz4Wn6nD8WKWH39tWxxC7tzAC3S4kXPMws2lyJXM45+7GWAdPwYYs7eTP6I=
X-Sasl-enc: KpyZwYre3QoRRQlUGFVxKMszX5uvt7gXh8CRTVHrn8Ls 1459435491
Received: from ip5b40609c.dynamic.kabel-deutschland.de (ip5b40609c.dynamic.kabel-deutschland.de [91.64.96.156])
	by mail.messagingengine.com (Postfix) with ESMTPA id 89640C00023;
	Thu, 31 Mar 2016 10:44:51 -0400 (EDT)
In-Reply-To: <20160331142200.GB31116@sigill.intra.peff.net>
X-Mailer: Evolution 3.18.5.1-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290393>

On Thu, 2016-03-31 at 10:22 -0400, Jeff King wrote:
> On Thu, Mar 31, 2016 at 03:51:44PM +0200, Carlos Mart=C3=ADn Nieto wr=
ote:
>=20
> >=20
> > Detect the gpgsm block header and run this command instead of gpg.
> This part makes sense to me, and is a strict improvement (though
> offhand, I wonder if any other systems use the generic "BEGIN SIGNED
> MESSAGE" header. The obvious option would be PEM from "openssl
> smime",
> but it is "BEGIN PKCS7").

Yep. It's useful when you can tell what generated the signatures.

>=20
> >=20
> > On the signing side, ask gpgsm if it knows the signing key we're
> > trying
> > to use and fall back to gpg if it does not.
> This part looks like we incur an extra fork/exec each time we sign
> with
> gpg, even if the user doesn't ever want to use gpgsm, or even have it
> installed.

Yes, this is unfortunate as I don't know any other way to tell whether
gpgsm (or whatever else) knows about a key. We could try to find gpgsm
in PATH but I suspect this would be expensive as well.

>=20
> I wonder if there are any hints we can use from the key ident, but I
> suppose not. In the default config, it comes straight from
> $GIT_COMMITTER_*, and is just a name/email.

Both gpg and gpgsm accept any string and try to match it against the
information in the keys. So even though gpgsm keys are shown by the
program itself with the "0x" prefix, 'gpgsm -k DigiCert' does show me
the public key I have for them.

>=20
> But maybe we could pull this out to a separate config option, like
> "commit.defaultSignatureType", which could be either "gpg", "gpgsm",
> or
> "auto" to enable the behavior you have here.=C2=A0=C2=A0Then savvy us=
ers can
> pick
> the type they plan to use.=C2=A0=C2=A0We can have a discussion then a=
bout
> whether
> to flip the default from "gpg" to "auto", but I'd vote to leave it at
> gpg unless gpgsm gets a huge amount of traction, and it really is
> 50/50
> what people would want.
>=20
> And regardless of the default type for creating signatures, we'd
> still
> automatically verify signatures from either type.

This makes sense. It allows for the automatic detection if that's
wanted but it would stop us running gpgsm on each invocation.



> > =C2=A0/*
> > + * Try to figure out if the given program contains given the key.
> > Both
> > + * gpg and gpgsm have keys in hex format, so we don't necessarily
> > know
> > + * which one to use.
> > + */
> > +static int program_knows_key(const char *program, const char
> > *signing_key)
> > +{
> > +	struct child_process gpg =3D CHILD_PROCESS_INIT;
> > +	struct strbuf output =3D STRBUF_INIT;
> > +	const char *args[4];
> > +	size_t len;
> > +
> > +	gpg.argv =3D args;
> > +	gpg.in =3D -1;
> > +	gpg.out =3D -1;
> > +	args[0] =3D program;
> > +	args[1] =3D "-K";
> > +	args[2] =3D signing_key;
> > +	args[3] =3D NULL;
> I think you'd want to send stderr to /dev/null here, as this is for
> speculatively seeing "does the user even have gpgsm set up?".
>=20
> >=20
> > +
> > +	if (start_command(&gpg))
> > +		return error(_("could not run '%s'"), program);
> Likewise, most users would start seeing "could not run 'gpgsm'" if
> they
> do not even have it installed.

Ah yes, I completely forgot to take that into account.

=C2=A0 =C2=A0cmn
