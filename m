From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] for-each-ref: add split message parts to %(contents:*).
Date: Fri, 2 Sep 2011 12:39:03 -0400
Message-ID: <20110902163903.GA21768@sigill.intra.peff.net>
References: <20110901184815.2cd8b472@pomiocik.lan>
 <1314895801-21147-1-git-send-email-mgorny@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
X-From: git-owner@vger.kernel.org Fri Sep 02 18:39:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzWlt-0000LZ-N8
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 18:39:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397Ab1IBQjI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Sep 2011 12:39:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49339
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753371Ab1IBQjG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 12:39:06 -0400
Received: (qmail 704 invoked by uid 107); 2 Sep 2011 16:39:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Sep 2011 12:39:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Sep 2011 12:39:03 -0400
Content-Disposition: inline
In-Reply-To: <1314895801-21147-1-git-send-email-mgorny@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180622>

On Thu, Sep 01, 2011 at 06:50:01PM +0200, Micha=C5=82 G=C3=B3rny wrote:

> -	buf =3D strchr(buf, '\n');
> -	if (!buf) {
> -		*body =3D "";
> -		return; /* no body */
> -	}
> -	while (*buf =3D=3D '\n')
> -		buf++; /* skip blank between subject and body */
> -	*body =3D buf;
> +	buf =3D format_subject(NULL, buf, NULL);
> +
> +	/* When having a signed tag without body, format_subject()
> +	 * will start to eat the signature. */
> +	if (buf > *signature)
> +		*body =3D *signature;
> +	else /* - 1 to get a trailing newline to strip */
> +		*body =3D buf - 1;

This last line is wrong if there is no trailing newline, no? Running
even the existing tests in t6300 against your new patch, I get:

expecting success:
  git for-each-ref --format=3D'%(subject)' refs/heads/master >actual &&
  test_cmp expected actual

--- expected    2011-09-02 16:36:38.306058729 +0000
+++ actual      2011-09-02 16:36:38.318058729 +0000
@@ -1 +1 @@
-Initial
+Initia
not ok - 28 basic atom: head subject

-Peff
