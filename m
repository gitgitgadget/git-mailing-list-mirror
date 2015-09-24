From: Jeff King <peff@peff.net>
Subject: [PATCH 34/68] read_remotes_file: simplify string handling
Date: Thu, 24 Sep 2015 17:07:20 -0400
Message-ID: <20150924210720.GE30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:10:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDm7-0004AY-MI
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601AbbIXVJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:09:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:35978 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753076AbbIXVHX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:07:23 -0400
Received: (qmail 12032 invoked by uid 102); 24 Sep 2015 21:07:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:07:22 -0500
Received: (qmail 29263 invoked by uid 107); 24 Sep 2015 21:07:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:07:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:07:20 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278623>

The main motivation for this cleanup is to switch our
line-reading to a strbuf, which removes the use of a
fixed-size buffer (which limited the size of remote URLs).
Since we have the strbuf, we can make use of strbuf_rtrim().

While we're here, we can also simplify the parsing of each
line.  First, we can use skip_prefix() to avoid some magic
numbers.

But second, we can avoid splitting the parsing and actions
for each line into two stages. Right now we figure out which
type of line we have, set an int to a magic number,
skip any intermediate whitespace, and then act on
the resulting value based on the magic number.

Instead, let's factor the whitespace skipping into a
function. That lets us avoid the magic numbers and keep the
actions close to the parsing.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c | 55 ++++++++++++++++++-------------------------------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/remote.c b/remote.c
index 22a60fc..a01f13a 100644
--- a/remote.c
+++ b/remote.c
@@ -54,9 +54,6 @@ static const char *pushremote_name;
 static struct rewrites rewrites;
 static struct rewrites rewrites_push;
 
-#define BUF_SIZE (2048)
-static char buffer[BUF_SIZE];
-
 static int valid_remote(const struct remote *remote)
 {
 	return (!!remote->url) || (!!remote->foreign_vcs);
@@ -243,50 +240,34 @@ static void add_instead_of(struct rewrite *rewrite, const char *instead_of)
 	rewrite->instead_of_nr++;
 }
 
+static const char *skip_spaces(const char *s)
+{
+	while (isspace(*s))
+		s++;
+	return s;
+}
+
 static void read_remotes_file(struct remote *remote)
 {
+	struct strbuf buf = STRBUF_INIT;
 	FILE *f = fopen(git_path("remotes/%s", remote->name), "r");
 
 	if (!f)
 		return;
 	remote->origin = REMOTE_REMOTES;
-	while (fgets(buffer, BUF_SIZE, f)) {
-		int value_list;
-		char *s, *p;
-
-		if (starts_with(buffer, "URL:")) {
-			value_list = 0;
-			s = buffer + 4;
-		} else if (starts_with(buffer, "Push:")) {
-			value_list = 1;
-			s = buffer + 5;
-		} else if (starts_with(buffer, "Pull:")) {
-			value_list = 2;
-			s = buffer + 5;
-		} else
-			continue;
-
-		while (isspace(*s))
-			s++;
-		if (!*s)
-			continue;
+	while (strbuf_getline(&buf, f, '\n') != EOF) {
+		const char *v;
 
-		p = s + strlen(s);
-		while (isspace(p[-1]))
-			*--p = 0;
+		strbuf_rtrim(&buf);
 
-		switch (value_list) {
-		case 0:
-			add_url_alias(remote, xstrdup(s));
-			break;
-		case 1:
-			add_push_refspec(remote, xstrdup(s));
-			break;
-		case 2:
-			add_fetch_refspec(remote, xstrdup(s));
-			break;
-		}
+		if (skip_prefix(buf.buf, "URL:", &v))
+			add_url_alias(remote, xstrdup(skip_spaces(v)));
+		else if (skip_prefix(buf.buf, "Push:", &v))
+			add_push_refspec(remote, xstrdup(skip_spaces(v)));
+		else if (skip_prefix(buf.buf, "Pull:", &v))
+			add_fetch_refspec(remote, xstrdup(skip_spaces(v)));
 	}
+	strbuf_release(&buf);
 	fclose(f);
 }
 
-- 
2.6.0.rc3.454.g204ad51
