From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@dwim.me>
Subject: Re: [RFC PATCH] gpg: add support for gpgsm
Date: Thu, 31 Mar 2016 18:08:06 +0200
Message-ID: <1459440486.2124.18.camel@dwim.me>
References: <1459432304-35779-1-git-send-email-cmn@dwim.me>
	 <xmqqa8ler6pu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 18:08:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alf8p-0000OW-Of
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 18:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755989AbcCaQIL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2016 12:08:11 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:47092 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755379AbcCaQIJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2016 12:08:09 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id C15B721B8B
	for <git@vger.kernel.org>; Thu, 31 Mar 2016 12:08:08 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Thu, 31 Mar 2016 12:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=dwim.me; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=yI4+IDZVufHyoYKCFsjZjZfSjks=; b=we7t+U
	BwEmJc819aSG38jifW5jdAp6jj8zbwYnpkdm02cy6PoZVuTNGhZvsYLzCzh2bthj
	6H46Ih/d22I/2fWoqtcLIUp0JKj/R9uhAn/iP1NxPulQ6ir0vbqPRzrpdow1y5iB
	lLGjlNXgPzYpGjgglaXGl3MygJ7eE7fOBoumc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=yI4+IDZVufHyoYK
	CFsjZjZfSjks=; b=HOAYVgyq665JbWityx8ZVxcZmXNbrK1A4Fdg9BuZBK7B/ar
	pugJ2l7iflSCbaTLR4a9xWq/HA4xW9iK+aRdpfixtsN7gl8ex+CsTIBuPRLCiIFR
	eqfyj6JP1aKs41KAEP0yMC1BW+KMI2xAIjbJRvJ/kUqXgPakP7yPSOru0tpI=
X-Sasl-enc: di7dCUfnzRBjQ3sggbJue4cfbN8FhIqsXuxMulwYzS6g 1459440488
Received: from ip5b40609c.dynamic.kabel-deutschland.de (ip5b40609c.dynamic.kabel-deutschland.de [91.64.96.156])
	by mail.messagingengine.com (Postfix) with ESMTPA id 18EBE680184;
	Thu, 31 Mar 2016 12:08:07 -0400 (EDT)
In-Reply-To: <xmqqa8ler6pu.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.18.5.1-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290407>

On Thu, 2016-03-31 at 08:46 -0700, Junio C Hamano wrote:
> Carlos Mart=C3=ADn Nieto <cmn@dwim.me> writes:
>=20
> >=20
> > Detect the gpgsm block header and run this command instead of gpg.
> > On the signing side, ask gpgsm if it knows the signing key we're
> > trying
> > to use and fall back to gpg if it does not.
> >=20
> > This lets the user more easily combine signing and verifying X509
> > and
> > PGP signatures without having to choose a default for a particular
> > repository that may need to be occasionally overridden.
> >=20
> > Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@dwim.me>
> >=20
> > ---
> >=20
> > Out there in the so-called "real world", companies like using X509
> > to
> > sign things. Currently you can set 'gpg.program' to gpgsm to get
> > gpg-compatible verification,...
> I notice that you had to add GPGSM_MESSAGE string constant; does the
> current code without any change really work correctly if you set
> 'gpg.program' to gpgsm and do nothing else?

It does work for verify-commit which is what I've been playing around
with since it just sends the contents of the 'gpgsig' header field to
the verification function.

I don't recall testing with verify-tag but there we might indeed have
issues, since we parse the contents to see if we have the signature.

>=20
> >=20
> > ... but if you're changing it to swap between
> > PGP and X509, it's an extra variable to keep in mind when working
> > with
> > signed commits and tags.
> >=20
> > +gpgsm.program::
> > +	Use this custom program instead of "gpgsm" found on $PATH
> > when
> > +	making or verifying a gpsm signature. The program must
> > support the
> gpsm signature, or gpgsm signature?


Nice catch. Thanks.

=C2=A0 cmn
