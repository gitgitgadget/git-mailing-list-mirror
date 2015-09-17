From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 33/67] read_branches_file: replace strcpy with xstrdup
Date: Thu, 17 Sep 2015 07:36:54 -0400
Message-ID: <20150917113654.GC22085@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915154950.GG29753@sigill.intra.peff.net>
 <xmqqlhc6p2f9.fsf@gitster.mtv.corp.google.com>
 <20150916204226.GE3915@sigill.intra.peff.net>
 <20150917112856.GA22085@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 13:37:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcXUr-0000YF-Rn
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 13:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbbIQLg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 07:36:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:60744 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751681AbbIQLg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 07:36:57 -0400
Received: (qmail 22859 invoked by uid 102); 17 Sep 2015 11:36:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Sep 2015 06:36:56 -0500
Received: (qmail 29506 invoked by uid 107); 17 Sep 2015 11:37:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Sep 2015 07:37:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Sep 2015 07:36:54 -0400
Content-Disposition: inline
In-Reply-To: <20150917112856.GA22085@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278110>

On Thu, Sep 17, 2015 at 07:28:56AM -0400, Jeff King wrote:

> Here is the patch I ended up with:
> 
> -- >8 --
> Subject: [PATCH] read_branches_file: simplify string handling

And here is the matching cleanup for read_remotes_file, which
lets us drop the static global "buffer" entirely.

-- >8 --
Subject: [PATCH] read_remotes_file: simplify string handling

The main motivation for this cleanup is to switch our
line-reading to a strbuf, which removes the use of a
static-sized buffer (which limited the size of remote URLs).
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
You could also take advantage of the fact that all of the actions have a
uniform function interface, and write this as:

  void (*action)(struct remote *, char *);

  if (skip_prefix(buf.buf, "URL:", &v))
	action = add_url_alias;
  else ...more parsing...

  while (isspace(*v))
	v++;

  action(remote, xstrdup(v));

That is more restrictive, but I doubt we would be adding new actions to
this deprecated format anytime soon. I'm not sure which people think is
more readable.

 remote.c | 55 ++++++++++++++++++-------------------------------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/remote.c b/remote.c
index 2bef5a4..a62b659 100644
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
2.6.0.rc2.408.ga2926b9
