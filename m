From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/3] pretty: make %H/%h dependent on
 --abbrev[-commit]
Date: Sun, 25 Apr 2010 23:31:47 -0400
Message-ID: <20100426033147.GB14421@coredump.intra.peff.net>
References: <1272232579-18895-1-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-2-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-3-git-send-email-wmpalmer@gmail.com>
 <20100426031012.GA29953@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Will Palmer <wmpalmer@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 05:31:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6F34-00073n-Pi
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 05:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754363Ab0DZDbu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Apr 2010 23:31:50 -0400
Received: from peff.net ([208.65.91.99]:52900 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752159Ab0DZDbt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 23:31:49 -0400
Received: (qmail 2738 invoked by uid 107); 26 Apr 2010 03:31:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 25 Apr 2010 23:31:58 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Apr 2010 23:31:47 -0400
Content-Disposition: inline
In-Reply-To: <20100426031012.GA29953@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145782>

On Sun, Apr 25, 2010 at 10:11:37PM -0500, Jonathan Nieder wrote:

> Here=E2=80=99s an alternative implementation of the more controversia=
l half of
> your patch, for your amusement.  The big downside is that it requires
> one to specify --abbrev-commit before the --format option.

That is not insurmountable, as we could just check after the parsing
stage. But there is a worse problem:

> +static void abbreviate_commit_hashes(char *fmt)
> +{
> +	char *p;
> +	for (p =3D fmt; p !=3D NULL; p =3D strchr(p + 1, '%')) {
> +		p++;
> +		switch (*p) {
> +		case 'H':
> +			*p =3D 'h';
> +			break;
> +		case 'P':
> +			*p =3D 'p';
> +			break;
> +		case 'T':
> +		default:
> +			break;
> +		}
> +	}
> +}

You parse '%%H' incorrectly. I would really rather not see ad-hoc
parsers for the format like this, but rather use or extend strbuf_expan=
d
as appropriate. That would make things less painful if and when we
decide to tweak the syntax.

I think a lot of this might be more pleasant if we had some extensible
and backwards compatible syntax like %(placeholder, arg, ...) and could
do "%(H, abbrev=3Dalways)" or "%(H, abbrev=3Dconfig)". Yeah, it's long,=
 but
it is readable and explicit.

-Peff
