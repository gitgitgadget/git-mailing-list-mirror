From: Jeff King <peff@peff.net>
Subject: Re: compile error in Git v2.7.0-rc0
Date: Mon, 14 Dec 2015 15:52:41 -0500
Message-ID: <20151214205241.GB14788@sigill.intra.peff.net>
References: <CALibRqFajuBuv9ooaBWL1kUzaVps2WfodqucyHni2ggv6JpwDg@mail.gmail.com>
 <xmqqvb80ix9u.fsf@gitster.mtv.corp.google.com>
 <20151214204624.GA14788@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: johan defries <johandefries@gmail.com>, git@vger.kernel.org,
	gitter.spiros@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 21:52:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8a73-0001xk-On
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 21:52:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753566AbbLNUwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 15:52:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:41471 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753285AbbLNUwo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 15:52:44 -0500
Received: (qmail 17194 invoked by uid 102); 14 Dec 2015 20:52:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Dec 2015 14:52:44 -0600
Received: (qmail 31341 invoked by uid 107); 14 Dec 2015 20:52:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Dec 2015 15:52:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Dec 2015 15:52:41 -0500
Content-Disposition: inline
In-Reply-To: <20151214204624.GA14788@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282409>

On Mon, Dec 14, 2015 at 03:46:25PM -0500, Jeff King wrote:

> I don't think that fix is right, though. We should be passing "host" to
> gethostbyname.

Here it is in patch form. It can go on top of ep/ident-with-getaddrinfo.

-- >8 --
Subject: [PATCH] ident: fix undefined variable when NO_IPV6 is set

Commit 00bce77 (ident.c: add support for IPv6, 2015-11-27)
moved the "gethostbyname" call out of "add_domainname" and
into the helper function "canonical_name". But when moving
the code, it forgot that the "buf" variable is passed as
"host" in the helper.

Reported-by: johan defries <johandefries@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 ident.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ident.c b/ident.c
index 4e7f99d..00a62e0 100644
--- a/ident.c
+++ b/ident.c
@@ -86,7 +86,7 @@ static int canonical_name(const char *host, struct strbuf *out)
 		freeaddrinfo(ai);
 	}
 #else
-	struct hostent *he = gethostbyname(buf);
+	struct hostent *he = gethostbyname(host);
 	if (he && strchr(he->h_name, '.')) {
 		strbuf_addstr(out, he->h_name);
 		status = 0;
-- 
2.7.0.rc0.348.g8e7037f
