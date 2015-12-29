From: Jeff King <peff@peff.net>
Subject: [PATCH 04/14] shortlog: use skip_prefix_icase to parse "Author" lines
Date: Tue, 29 Dec 2015 02:27:46 -0500
Message-ID: <20151229072746.GD8842@sigill.intra.peff.net>
References: <20151229071847.GA8726@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 08:28:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDoho-0005st-5e
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 08:28:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464AbbL2H1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 02:27:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:46619 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752074AbbL2H1t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 02:27:49 -0500
Received: (qmail 18027 invoked by uid 102); 29 Dec 2015 07:27:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 01:27:49 -0600
Received: (qmail 19850 invoked by uid 107); 29 Dec 2015 07:28:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 02:28:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 02:27:46 -0500
Content-Disposition: inline
In-Reply-To: <20151229071847.GA8726@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283095>

Because we must match both "Author" and "author" here, we
could not use skip_prefix, and had to hand-code a partial
case-insensitive match. Now that we have skip_prefix_case,
we can use it. This is technically more liberal in what it
matches (e.g., it will match AUTHOR), but in this particular
case that that's OK (we are matching git-log output, so we
expect arbitrary data like commit headers to be indented).

In addition to being easier to read, this will make the code
easier to adapt for matching other lines.

Signed-off-by: Jeff King <peff@peff.net>
---
To be honest, I'm not sure what the original was trying for. I assumed
it was to match "log --raw" output, but because we always expect the
colon, it doesn't. I think this may actually have broken in b8ec592
(Build in shortlog, 2006-10-22); the original perl script looked for:

  /^[Aa]uthor:?\s*/

We could re-fix that, I guess, but it seems clear that nobody actually
cares (and anybody sane uses the builtin traversal these days anyway).

We could similarly drop the case-insensitivity, as I don't think it is
helping anyone in practice (though that is less easy to know).

 builtin/shortlog.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 35ebd17..86e277a 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -94,8 +94,8 @@ static void read_from_stdin(struct shortlog *log)
 	char author[1024], oneline[1024];
 
 	while (fgets(author, sizeof(author), stdin) != NULL) {
-		if (!(author[0] == 'A' || author[0] == 'a') ||
-		    !starts_with(author + 1, "uthor: "))
+		const char *v;
+		if (!skip_prefix_icase(author, "Author: ", &v))
 			continue;
 		while (fgets(oneline, sizeof(oneline), stdin) &&
 		       oneline[0] != '\n')
@@ -103,7 +103,7 @@ static void read_from_stdin(struct shortlog *log)
 		while (fgets(oneline, sizeof(oneline), stdin) &&
 		       oneline[0] == '\n')
 			; /* discard blanks */
-		insert_one_record(log, author + 8, oneline);
+		insert_one_record(log, v, oneline);
 	}
 }
 
-- 
2.7.0.rc3.367.g09631da
