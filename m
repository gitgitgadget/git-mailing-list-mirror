From: Jeff King <peff@peff.net>
Subject: [PATCH 12/14] trailer: factor out config reading
Date: Tue, 29 Dec 2015 02:35:37 -0500
Message-ID: <20151229073536.GL8842@sigill.intra.peff.net>
References: <20151229071847.GA8726@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 08:35:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDoop-0004Dg-O8
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 08:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125AbbL2Hfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 02:35:40 -0500
Received: from cloud.peff.net ([50.56.180.127]:46643 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752519AbbL2Hfj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 02:35:39 -0500
Received: (qmail 18399 invoked by uid 102); 29 Dec 2015 07:35:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 01:35:39 -0600
Received: (qmail 20016 invoked by uid 107); 29 Dec 2015 07:35:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 02:35:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 02:35:37 -0500
Content-Disposition: inline
In-Reply-To: <20151229071847.GA8726@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283103>

The only entry point into the trailer.c code is
process_trailers, which initializes itself by reading the
trailer config. Let's pull that out into a separate function
and protect it with a lazy-initialization flag. That will
let us easily add new entry points in future patches.

Signed-off-by: Jeff King <peff@peff.net>
---
 trailer.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/trailer.c b/trailer.c
index 6f3416f..18bf209 100644
--- a/trailer.c
+++ b/trailer.c
@@ -842,6 +842,19 @@ static void free_all(struct trailer_item **first)
 	}
 }
 
+static void init_trailer_config(void)
+{
+	static int initialized;
+
+	if (initialized)
+		return;
+
+	git_config(git_trailer_default_config, NULL);
+	git_config(git_trailer_config, NULL);
+
+	initialized = 1;
+}
+
 void process_trailers(const char *file, int trim_empty, struct string_list *trailers)
 {
 	struct trailer_item *in_tok_first = NULL;
@@ -850,10 +863,7 @@ void process_trailers(const char *file, int trim_empty, struct string_list *trai
 	struct strbuf **lines;
 	int trailer_end;
 
-	/* Default config must be setup first */
-	git_config(git_trailer_default_config, NULL);
-	git_config(git_trailer_config, NULL);
-
+	init_trailer_config();
 	lines = read_input_file(file);
 
 	/* Print the lines before the trailers */
-- 
2.7.0.rc3.367.g09631da
