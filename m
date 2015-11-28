From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3] ident.c: add support for IPv6
Date: Sat, 28 Nov 2015 12:23:41 -0500
Message-ID: <20151128172341.GE27264@sigill.intra.peff.net>
References: <1448633307-43339-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 28 18:24:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a2jER-00079f-4b
	for gcvg-git-2@plane.gmane.org; Sat, 28 Nov 2015 18:24:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbbK1RXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2015 12:23:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:34700 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752459AbbK1RXo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2015 12:23:44 -0500
Received: (qmail 20201 invoked by uid 102); 28 Nov 2015 17:23:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 28 Nov 2015 11:23:44 -0600
Received: (qmail 23631 invoked by uid 107); 28 Nov 2015 17:23:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 28 Nov 2015 12:23:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Nov 2015 12:23:41 -0500
Content-Disposition: inline
In-Reply-To: <1448633307-43339-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281793>

On Fri, Nov 27, 2015 at 02:08:27PM +0000, Elia Pinto wrote:

> This is the third version of the patch ($gmane/280488)
> Changes from previous:
> 
> - Simplified the implementation, adding the new
> function canonical_name (Jeff King) ($gmane/281479).
> Fixed a new typo introduced in the second version.

Thanks, I think this keeps add_domainname() a lot cleaner. There are a
few problems:

> +static int canonical_name(const char *host, struct strbuf *out)
> +{
> +       int status=-1;

Our style is to put whitespace between operators (so "int status = -1;",
and other places below).

This line (and the others) was also indented with spaces, not tabs.

> +#ifndef NO_IPV6
> +       struct addrinfo hints, *ai;
> +       memset (&hints, '\0', sizeof (hints));
> +       hints.ai_flags = AI_CANONNAME;
> +       int gai = getaddrinfo(host, NULL, &hints, &ai);

We do C89-style no-decl-after-statement. But this "gai" is only
used once, so we can just lump it into the next conditional.

> +       if (!gai) {
> +               if (ai && strchr(ai->ai_canonname, '.')) {
> +                       strbuf_addstr(out, ai->ai_canonname);
> +                       status=0;
> +               }
> +               freeaddrinfo(ai);
> +       }
> +#else
> +       struct hostent *he = gethostbyname(buf);
> +       if (he && strchr(he->h_name, '.')) {
> +                       strbuf_addstr(out, he->h_name);
> +                       status=0;
> +       }
> +#endif /* NO_IPV6 */
> +}

I think you are missing a "return status" here.

> @@ -82,10 +105,9 @@ static void add_domainname(struct strbuf *out)
>  	}
>  	if (strchr(buf, '.'))
>  		strbuf_addstr(out, buf);
> -	else if ((he = gethostbyname(buf)) && strchr(he->h_name, '.'))
> -		strbuf_addstr(out, he->h_name);
> -	else
> -		strbuf_addf(out, "%s.(none)", buf);
> +	else {
> +		 if (canonical_name(buf,out) != 0) strbuf_addf(out, "%s.(none)", buf);
> +	}

We always put conditional bodies on the next line, even if they are
one-liners.

Here's what I've queued, addressing those. No need to re-send if you're
happy with it:

-- >8 --
From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] ident.c: add support for IPv6

Add IPv6 support by implementing name resolution with the
protocol agnostic getaddrinfo(3) API. The old gethostbyname(3)
code is still available when git is compiled with NO_IPV6.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 ident.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/ident.c b/ident.c
index 5ff1aad..4e7f99d 100644
--- a/ident.c
+++ b/ident.c
@@ -70,10 +70,35 @@ static int add_mailname_host(struct strbuf *buf)
 	return 0;
 }
 
+static int canonical_name(const char *host, struct strbuf *out)
+{
+	int status = -1;
+
+#ifndef NO_IPV6
+	struct addrinfo hints, *ai;
+	memset (&hints, '\0', sizeof (hints));
+	hints.ai_flags = AI_CANONNAME;
+	if (!getaddrinfo(host, NULL, &hints, &ai)) {
+		if (ai && strchr(ai->ai_canonname, '.')) {
+			strbuf_addstr(out, ai->ai_canonname);
+			status = 0;
+		}
+		freeaddrinfo(ai);
+	}
+#else
+	struct hostent *he = gethostbyname(buf);
+	if (he && strchr(he->h_name, '.')) {
+		strbuf_addstr(out, he->h_name);
+		status = 0;
+	}
+#endif /* NO_IPV6 */
+
+	return status;
+}
+
 static void add_domainname(struct strbuf *out)
 {
 	char buf[1024];
-	struct hostent *he;
 
 	if (gethostname(buf, sizeof(buf))) {
 		warning("cannot get host name: %s", strerror(errno));
@@ -82,9 +107,7 @@ static void add_domainname(struct strbuf *out)
 	}
 	if (strchr(buf, '.'))
 		strbuf_addstr(out, buf);
-	else if ((he = gethostbyname(buf)) && strchr(he->h_name, '.'))
-		strbuf_addstr(out, he->h_name);
-	else
+	else if (canonical_name(buf, out) < 0)
 		strbuf_addf(out, "%s.(none)", buf);
 }
 
-- 
2.6.3.636.g1460207
