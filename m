From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/9] Rewrite launch_editor, create_tag and stripspace to
 use strbufs.
Date: Thu, 6 Sep 2007 17:38:35 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709061732480.28586@racer.site>
References: <11890382183913-git-send-email-krh@redhat.com>
 <11890382242333-git-send-email-krh@redhat.com> <11890382243290-git-send-email-krh@redhat.com>
 <11890382253220-git-send-email-krh@redhat.com> <11890382252522-git-send-email-krh@redhat.com>
 <1189038225525-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-89205257-1189096715=:28586"
Cc: git@vger.kernel.org
To: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 18:39:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITKOF-0006Ae-7k
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 18:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754739AbXIFQix (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 12:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbXIFQiw
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 12:38:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:42454 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752519AbXIFQiu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 12:38:50 -0400
Received: (qmail invoked by alias); 06 Sep 2007 16:38:49 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp050) with SMTP; 06 Sep 2007 18:38:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/XBXNYjGbX6aep5HEamhg58qKu+Mvc/uZt+OWZdg
	rXnUBbXUVxN0Xm
X-X-Sender: gene099@racer.site
In-Reply-To: <1189038225525-git-send-email-krh@redhat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57903>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-89205257-1189096715=:28586
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 5 Sep 2007, Kristian Høgsberg wrote:

> diff --git a/strbuf.c b/strbuf.c
> index fcfc05e..ed2afea 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -73,43 +74,15 @@ void strbuf_printf(struct strbuf *sb, const char *fmt, ...)
>  {
>  	char buffer[2048];
>  	va_list args;
> -	int len, size = 2 * sizeof buffer;
> +	int len;
>  
>  	va_start(args, fmt);
>  	len = vsnprintf(buffer, sizeof(buffer), fmt, args);
>  	va_end(args);
>  
> -	if (len > sizeof(buffer)) {
> -		/*
> -		 * Didn't fit in the buffer, but this vsnprintf at
> -		 * least gives us the required length back.  Grow the
> -		 * buffer acccordingly and try again.
> -		 */
> -		strbuf_grow(sb, len);
> -		va_start(args, fmt);
> -		len = vsnprintf(sb->buf + sb->len,
> -				sb->alloc - sb->len, fmt, args);
> -		va_end(args);
> -	} else if (len >= 0) {
> -		/*
> -		 * The initial vsnprintf fit in the temp buffer, just
> -		 * copy it to the strbuf.
> -		 */
> -		strbuf_add(sb, buffer, len);
> -	} else {
> -		/*
> -		 * This vnsprintf sucks and just returns -1 when the
> -		 * buffer is too small.  Keep doubling the size until
> -		 * it fits.
> -		 */
> -		while (len < 0) {
> -			strbuf_grow(sb, size);
> -			va_start(args, fmt);
> -			len = vsnprintf(sb->buf + sb->len,
> -					sb->alloc - sb->len, fmt, args);
> -			va_end(args);
> -			size *= 2;
> -		}
> -	}
> +	if (len > sizeof(buffer) || len < 0)
> +		die("out of buffer space\n");
> +
> +	strbuf_add(sb, buffer, len);
>  }

Really?

(If you find the time, it would be really nice to rebase that patch series 
on top of Pierre's strbuf work...)

Ciao,
Dscho

--8323584-89205257-1189096715=:28586--
