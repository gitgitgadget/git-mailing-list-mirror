From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] abspath.c: use PATH_MAX in real_path_internal()
Date: Sun, 20 Jul 2014 22:25:01 -0400
Message-ID: <20140721022501.GB22750@peff.net>
References: <1405601143-31354-1-git-send-email-pclouds@gmail.com>
 <53C80265.5030903@web.de>
 <53C8562C.4000304@gmail.com>
 <CACsJy8D5X5svApB9edHK+1EaGi+q2ZRSOvyDYaDieVV2psgZPg@mail.gmail.com>
 <53CB0D81.1070404@gmail.com>
 <53CB7729.40101@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Jul 21 04:25:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X93Hs-0006JE-63
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 04:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbaGUCZF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jul 2014 22:25:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:37251 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751483AbaGUCZE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2014 22:25:04 -0400
Received: (qmail 21460 invoked by uid 102); 21 Jul 2014 02:25:03 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 20 Jul 2014 21:25:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Jul 2014 22:25:01 -0400
Content-Disposition: inline
In-Reply-To: <53CB7729.40101@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253939>

On Sun, Jul 20, 2014 at 10:00:41AM +0200, Ren=C3=A9 Scharfe wrote:

> -- >8 --
> Subject: [PATCH] unix-socket: remove stale socket before calling chdi=
r()
>=20
> unix_stream_listen() is given a path.  It calls unix_sockaddr_init(),
> which in turn can call chdir().  After that a relative path doesn't
> mean the same as before.  Any use of the original path should thus
> happen before that call.  For that reason, unlink the given path
> (to get rid of a possibly existing stale socket) right at the
> beginning of the function.

Thanks, I think this ordering problem was just missed in 1eb10f4
(unix-socket: handle long socket pathnames, 2012-01-09).

Your solution looks OK, though I think also just using:

  unlink(sa.sun_path);

would work, too (that is the path we are feeding to bind(), whether we
have chdir'd or not, so perhaps it is a little more obviously correct?)=
=2E
I'm OK with either.

> diff --git a/unix-socket.c b/unix-socket.c
> index 01f119f..91bd6b8 100644
> --- a/unix-socket.c
> +++ b/unix-socket.c
> @@ -99,11 +99,12 @@ int unix_stream_listen(const char *path)
>  	struct sockaddr_un sa;
>  	struct unix_sockaddr_context ctx;
> =20
> +	unlink(path);
> +
>  	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
>  		return -1;
>  	fd =3D unix_stream_socket();
> =20
> -	unlink(path);

I briefly wondered if this should be unlinking only when we get EEXIST,
but I don't think it is worth caring about. The only caller is
credential-cache, and it always wants to unconditionally replace
whatever is there (it will already have tried to contact any existing
socket).

-Peff
