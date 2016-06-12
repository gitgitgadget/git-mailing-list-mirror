From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] lib-httpd.sh: print error.log on error
Date: Sun, 12 Jun 2016 08:59:21 -0400
Message-ID: <20160612125921.GA15289@sigill.intra.peff.net>
References: <20160612104154.31446-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 12 14:59:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bC4zC-0003ZL-CJ
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 14:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbcFLM7Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2016 08:59:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:53453 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750965AbcFLM7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 08:59:25 -0400
Received: (qmail 15957 invoked by uid 102); 12 Jun 2016 12:59:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Jun 2016 08:59:24 -0400
Received: (qmail 6509 invoked by uid 107); 12 Jun 2016 12:59:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Jun 2016 08:59:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Jun 2016 08:59:21 -0400
Content-Disposition: inline
In-Reply-To: <20160612104154.31446-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297135>

On Sun, Jun 12, 2016 at 05:41:54PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> Failure to bring up httpd for testing is not considered an error, so =
the
> trash directory, which contains this error.log file, is removed and w=
e
> don't know what made httpd fail to start. Improve the situation a bit=
=2E
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  t/lib-httpd.sh | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
> index f9f3e5f..5b8de38 100644
> --- a/t/lib-httpd.sh
> +++ b/t/lib-httpd.sh
> @@ -180,6 +180,7 @@ start_httpd() {
>  	if test $? -ne 0
>  	then
>  		trap 'die' EXIT
> +		cat "$HTTPD_ROOT_PATH"/error.log 2>/dev/null
>  		test_skip_or_die $GIT_TEST_HTTPD "web server setup failed"
>  	fi

I like the idea of giving more data on error, but I think this will
break the TAP output and confuse anything parsing the output of the
tests, like prove (I think arbitrary output should have "#" prepended).

Also (or alternatively), it should probably only happen when we are in
verbose mode (it's not taken care of for us as usual because tests call
start_httpd outside of a test_expect_ block). I think this eliminates
the need to deal with the TAP thing (because our usual "-v" output is
not TAP-compliant).

-Peff
