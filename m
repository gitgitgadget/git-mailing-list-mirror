From: Jeff King <peff@peff.net>
Subject: [PATCHv2 12/15] ident: use full dns names to generate email addresses
Date: Mon, 21 May 2012 19:10:23 -0400
Message-ID: <20120521231023.GL10981@sigill.intra.peff.net>
References: <20120521230917.GA474@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 22 01:11:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWbkq-0000r2-54
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 01:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385Ab2EUXK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 19:10:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51237
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753789Ab2EUXK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 19:10:26 -0400
Received: (qmail 7941 invoked by uid 107); 21 May 2012 23:10:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 May 2012 19:10:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 May 2012 19:10:23 -0400
Content-Disposition: inline
In-Reply-To: <20120521230917.GA474@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198158>

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
index 5aec073..b111e34 100644
--- a/ident.c
+++ b/ident.c
@@ -65,23 +65,18 @@ static void add_domainname(struct strbuf *out)
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
1.7.10.1.19.g711d603
