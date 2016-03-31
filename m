From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] gpg: add support for gpgsm
Date: Thu, 31 Mar 2016 10:22:00 -0400
Message-ID: <20160331142200.GB31116@sigill.intra.peff.net>
References: <1459432304-35779-1-git-send-email-cmn@dwim.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@dwim.me>
X-From: git-owner@vger.kernel.org Thu Mar 31 16:22:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aldUA-0002o4-Tl
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 16:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757339AbcCaOWF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2016 10:22:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:41481 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757274AbcCaOWD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 10:22:03 -0400
Received: (qmail 19886 invoked by uid 102); 31 Mar 2016 14:22:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 10:22:02 -0400
Received: (qmail 12910 invoked by uid 107); 31 Mar 2016 14:22:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 10:22:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Mar 2016 10:22:00 -0400
Content-Disposition: inline
In-Reply-To: <1459432304-35779-1-git-send-email-cmn@dwim.me>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290386>

On Thu, Mar 31, 2016 at 03:51:44PM +0200, Carlos Mart=C3=ADn Nieto wrot=
e:

> Detect the gpgsm block header and run this command instead of gpg.

This part makes sense to me, and is a strict improvement (though
offhand, I wonder if any other systems use the generic "BEGIN SIGNED
MESSAGE" header. The obvious option would be PEM from "openssl smime",
but it is "BEGIN PKCS7").

> On the signing side, ask gpgsm if it knows the signing key we're tryi=
ng
> to use and fall back to gpg if it does not.

This part looks like we incur an extra fork/exec each time we sign with
gpg, even if the user doesn't ever want to use gpgsm, or even have it
installed.

I wonder if there are any hints we can use from the key ident, but I
suppose not. In the default config, it comes straight from
$GIT_COMMITTER_*, and is just a name/email.

But maybe we could pull this out to a separate config option, like
"commit.defaultSignatureType", which could be either "gpg", "gpgsm", or
"auto" to enable the behavior you have here.  Then savvy users can pick
the type they plan to use.  We can have a discussion then about whether
to flip the default from "gpg" to "auto", but I'd vote to leave it at
gpg unless gpgsm gets a huge amount of traction, and it really is 50/50
what people would want.

And regardless of the default type for creating signatures, we'd still
automatically verify signatures from either type.

>  /*
> + * Try to figure out if the given program contains given the key. Bo=
th
> + * gpg and gpgsm have keys in hex format, so we don't necessarily kn=
ow
> + * which one to use.
> + */
> +static int program_knows_key(const char *program, const char *signin=
g_key)
> +{
> +	struct child_process gpg =3D CHILD_PROCESS_INIT;
> +	struct strbuf output =3D STRBUF_INIT;
> +	const char *args[4];
> +	size_t len;
> +
> +	gpg.argv =3D args;
> +	gpg.in =3D -1;
> +	gpg.out =3D -1;
> +	args[0] =3D program;
> +	args[1] =3D "-K";
> +	args[2] =3D signing_key;
> +	args[3] =3D NULL;

I think you'd want to send stderr to /dev/null here, as this is for
speculatively seeing "does the user even have gpgsm set up?".

> +
> +	if (start_command(&gpg))
> +		return error(_("could not run '%s'"), program);

Likewise, most users would start seeing "could not run 'gpgsm'" if they
do not even have it installed.

-Peff
