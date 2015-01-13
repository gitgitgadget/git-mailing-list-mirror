From: Jeff King <peff@peff.net>
Subject: [PATCH 3/5] builtin/commit.c: use xstrdup_or_null instead of envdup
Date: Mon, 12 Jan 2015 20:58:33 -0500
Message-ID: <20150113015832.GC18986@peff.net>
References: <20150113015427.GA5497@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lukas Fleischer <git@cryptocrack.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 02:58:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAqkg-0005Go-Og
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 02:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbbAMB6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 20:58:34 -0500
Received: from cloud.peff.net ([50.56.180.127]:33605 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752346AbbAMB6d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 20:58:33 -0500
Received: (qmail 19209 invoked by uid 102); 13 Jan 2015 01:58:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jan 2015 19:58:33 -0600
Received: (qmail 22706 invoked by uid 107); 13 Jan 2015 01:58:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jan 2015 20:58:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Jan 2015 20:58:33 -0500
Content-Disposition: inline
In-Reply-To: <20150113015427.GA5497@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262318>

The only reason for envdup to be its own function is that we
have to save the result in a temporary string. With
xstrdup_or_null, we can feed the result of getenv()
directly.

Signed-off-by: Jeff King <peff@peff.net>
---
These ones need the temporary. Is the result more readable, or less?

 builtin/commit.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 7d90c35..5cd1478 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -559,20 +559,14 @@ static void set_ident_var(char **buf, char *val)
 	*buf = val;
 }
 
-static char *envdup(const char *var)
-{
-	const char *val = getenv(var);
-	return val ? xstrdup(val) : NULL;
-}
-
 static void determine_author_info(struct strbuf *author_ident)
 {
 	char *name, *email, *date;
 	struct ident_split author;
 
-	name = envdup("GIT_AUTHOR_NAME");
-	email = envdup("GIT_AUTHOR_EMAIL");
-	date = envdup("GIT_AUTHOR_DATE");
+	name = xstrdup_or_null(getenv("GIT_AUTHOR_NAME"));
+	email = xstrdup_or_null(getenv("GIT_AUTHOR_EMAIL"));
+	date = xstrdup_or_null(getenv("GIT_AUTHOR_DATE"));
 
 	if (author_message) {
 		struct ident_split ident;
-- 
2.2.1.425.g441bb3c
