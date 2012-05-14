From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] drop length limitations on gecos-derived names and
 emails
Date: Mon, 14 May 2012 13:05:33 -0400
Message-ID: <20120514170533.GA29909@sigill.intra.peff.net>
References: <20120511231303.GA24611@sigill.intra.peff.net>
 <20120514162824.GA24457@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 14 19:05:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STyiL-0007Fd-7j
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 19:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757071Ab2ENRFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 13:05:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42880
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755826Ab2ENRFf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 13:05:35 -0400
Received: (qmail 22896 invoked by uid 107); 14 May 2012 17:05:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 May 2012 13:05:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 May 2012 13:05:33 -0400
Content-Disposition: inline
In-Reply-To: <20120514162824.GA24457@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197787>

On Mon, May 14, 2012 at 12:28:24PM -0400, Jeff King wrote:

> I noticed in add_domainname that we look up the host via gethostname,
> and then if it is not fully qualified, call gethostbyname and steal the
> domain portion of the result, tacking it onto the hostname we got.
> 
> That seems oddly complex to me, and like it could result in a bogus
> hostname if the unqualified name does not match the first part of the
> returned qualified name. E.g., if the /etc/hosts file contains something
> like:
> 
>   192.168.1.1 foo.example.com bar.example.com bar
> 
> (and your hostname is "bar"). I doubt it matters much in practice, and
> it is outside the scope of this patch, so I left it for now.

It looks like a bug in adc3dbc (Use sensible domain name (the DNS one)
when guessing ident information, 2005-10-21). Before that we used
getdomainname, where that procedure made more sense.

The patch below fixes it. I doubt it matters much in practice, but I
think the resulting code is way less confusing to read.

-- >8 --
Subject: [PATCH] ident: use full dns names to generate email addresses

When we construct an email address from the username and
hostname, we generate the host part of the email with this
procedure:

  1. add the result of gethostname

  2. if it has a dot, ok, it's fully qualified

  3. if not, then look up the unqualified hostname via
     gethostbyname; take the domain name of the result and
     append it to the hostname

Step 3 can actually produce a bogus result, as the name
returned by gethostbyname may not be related to the hostname
we fed it (e.g., consider a machine "foo" with names
"foo.one.example.com" and "bar.two.example.com"; we may have
the latter returned and generate the bogus name
"foo.two.example.com").

This patch simply uses the full hostname returned by
gethostbyname. In the common case that the first part is the
same as the unqualified hostname, the behavior is identical.
And in the case that it is not the same, we are much more
likely to be generating a valid name.

Signed-off-by: Jeff King <peff@peff.net>
---
 ident.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/ident.c b/ident.c
index 72944ba..e552e7f 100644
--- a/ident.c
+++ b/ident.c
@@ -62,23 +62,18 @@ static void add_domainname(struct strbuf *out)
 {
 	char buf[1024];
 	struct hostent *he;
-	const char *domainname;
 
 	if (gethostname(buf, sizeof(buf))) {
 		warning("cannot get host name: %s", strerror(errno));
 		strbuf_addstr(out, "(none)");
 		return;
 	}
-	strbuf_addstr(out, buf);
 	if (strchr(buf, '.'))
-		return;
-
-	he = gethostbyname(buf);
-	strbuf_addch(out, '.');
-	if (he && (domainname = strchr(he->h_name, '.')))
-		strbuf_addstr(out, domainname + 1);
+		strbuf_addstr(out, buf);
+	else if ((he = gethostbyname(buf)) && strchr(he->h_name, '.'))
+		strbuf_addstr(out, he->h_name);
 	else
-		strbuf_addstr(out, "(none)");
+		strbuf_addf(out, "%s.(none)", buf);
 }
 
 static void copy_email(const struct passwd *pw, struct strbuf *email)
-- 
1.7.10.2.8.g1101eed
