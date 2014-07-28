From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 09/10] abspath: convert absolute_path() to strbuf
Date: Mon, 28 Jul 2014 15:15:00 -0400
Message-ID: <20140728191500.GD11265@peff.net>
References: <53D694A2.8030007@web.de>
 <53D69793.3010307@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Jul 28 21:15:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBqO7-0004mv-C9
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 21:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbaG1TPG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2014 15:15:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:41940 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750933AbaG1TPF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 15:15:05 -0400
Received: (qmail 28300 invoked by uid 102); 28 Jul 2014 19:15:05 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Jul 2014 14:15:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jul 2014 15:15:00 -0400
Content-Disposition: inline
In-Reply-To: <53D69793.3010307@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254349>

On Mon, Jul 28, 2014 at 08:33:55PM +0200, Ren=C3=A9 Scharfe wrote:

>  const char *absolute_path(const char *path)
>  {
> -	static char buf[PATH_MAX + 1];
> -
> -	if (!*path) {
> -		die("The empty string is not a valid path");
> -	} else if (is_absolute_path(path)) {
> -		if (strlcpy(buf, path, PATH_MAX) >=3D PATH_MAX)
> -			die("Too long path: %.*s", 60, path);
> -	} else {
> -		size_t len;
> -		const char *fmt;
> -		const char *cwd =3D get_pwd_cwd();
> -		if (!cwd)
> -			die_errno("Cannot determine the current working directory");
> -		len =3D strlen(cwd);
> -		fmt =3D (len > 0 && is_dir_sep(cwd[len - 1])) ? "%s%s" : "%s/%s";
> -		if (snprintf(buf, PATH_MAX, fmt, cwd, path) >=3D PATH_MAX)
> -			die("Too long path: %.*s", 60, path);
> -	}
> -	return buf;
> +	static struct strbuf sb;
> +	strbuf_init(&sb, 0);
> +	strbuf_add_absolute_path(&sb, path);
> +	return sb.buf;
>  }

Is it right to strbuf_init here? That means that we are throwing away
the old buffer for each call. I would think you want instead:

  static struct strbuf sb =3D STRBUF_INIT;
  strbuf_reset(&sb);
  ...

-Peff
