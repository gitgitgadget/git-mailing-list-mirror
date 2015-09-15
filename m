From: Jeff King <peff@peff.net>
Subject: [PATCH 58/67] help: clean up kfmclient munging
Date: Tue, 15 Sep 2015 12:11:13 -0400
Message-ID: <20150915161113.GF29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 18:11:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbspG-00054J-MY
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 18:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905AbbIOQLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 12:11:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:59459 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753485AbbIOQLP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 12:11:15 -0400
Received: (qmail 14439 invoked by uid 102); 15 Sep 2015 16:11:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:11:15 -0500
Received: (qmail 7925 invoked by uid 107); 15 Sep 2015 16:11:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 12:11:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 12:11:13 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277963>

When we are going to launch "/path/to/konqueror", we instead
rewrite this into "/path/to/kfmclient" by duplicating the
original string and writing over the ending bits. This can
be done more obviously with strip_suffix and xstrfmt.

Note that we also fix a subtle bug with the "filename"
parameter, which is passed as argv[0] to the child. If the
user has configured a program name with no directory
component, we always pass the string "kfmclient", even if
your program is called something else. But if you give a
full path, we give the basename of that path. But more
bizarrely, if we rewrite "konqueror" to "kfmclient", we
still pass "konqueror".

The history of this function doesn't reveal anything
interesting, so it looks like just an oversight from
combining the suffix-munging with the basename-finding.
Let's just call basename on the munged path, which produces
consistent results (if you gave a program, whether a full
path or not, we pass its basename).

Probably this doesn't matter at all in practice, but it
makes the code slightly less confusing to read.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/help.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index fba8c01..e1650ab 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -140,17 +140,10 @@ static void exec_man_konqueror(const char *path, const char *page)
 
 		/* It's simpler to launch konqueror using kfmclient. */
 		if (path) {
-			const char *file = strrchr(path, '/');
-			if (file && !strcmp(file + 1, "konqueror")) {
-				char *new = xstrdup(path);
-				char *dest = strrchr(new, '/');
-
-				/* strlen("konqueror") == strlen("kfmclient") */
-				strcpy(dest + 1, "kfmclient");
-				path = new;
-			}
-			if (file)
-				filename = file;
+			size_t len;
+			if (strip_suffix(path, "/konqueror", &len))
+				path = xstrfmt("%.*s/kfmclient", (int)len, path);
+			filename = basename((char *)path);
 		} else
 			path = "kfmclient";
 		strbuf_addf(&man_page, "man:%s(1)", page);
-- 
2.6.0.rc2.408.ga2926b9
