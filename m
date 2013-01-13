From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] archive-tar: fix sanity check in config parsing
Date: Sun, 13 Jan 2013 15:00:49 -0500
Message-ID: <20130113200044.GA3979@sigill.intra.peff.net>
References: <50F2F1E9.1040700@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jan 13 21:01:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuTk0-0003Xu-Qy
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 21:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756060Ab3AMUAw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 15:00:52 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60267 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755452Ab3AMUAw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 15:00:52 -0500
Received: (qmail 11521 invoked by uid 107); 13 Jan 2013 20:02:07 -0000
Received: from mb92836d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.40.185)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 13 Jan 2013 15:02:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Jan 2013 15:00:49 -0500
Content-Disposition: inline
In-Reply-To: <50F2F1E9.1040700@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213398>

On Sun, Jan 13, 2013 at 06:42:01PM +0100, Ren=C3=A9 Scharfe wrote:

> When parsing these config variable names, we currently check that
> the second dot is found nine characters into the name, disallowing
> filter names with a length of five characters.  Additionally,
> git archive crashes when the second dot is omitted:
>=20
> 	$ ./git -c tar.foo=3Dbar archive HEAD >/dev/null
> 	fatal: Data too large to fit into virtual memory space.
>=20
> Instead we should check if the second dot exists at all, or if
> we only found the first one.

Eek. Thanks for finding it. Your fix is obviously correct.

> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -335,7 +335,7 @@ static int tar_filter_config(const char *var, con=
st char *value, void *data)
>  	if (prefixcmp(var, "tar."))
>  		return 0;
>  	dot =3D strrchr(var, '.');
> -	if (dot =3D=3D var + 9)
> +	if (dot =3D=3D var + 3)
>  		return 0;

=46or the curious, the original version of the patch[1] read:

+       if (prefixcmp(var, "tarfilter."))
+               return 0;
+       dot =3D strrchr(var, '.');
+       if (dot =3D=3D var + 9)
+               return 0;

and when I shortened the config section to "tar" in a re-roll of the
series, I missed the corresponding change to the offset.

-Peff

[1] http://thread.gmane.org/gmane.comp.version-control.git/175785/focus=
=3D175858
