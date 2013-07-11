From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v5 2/5] config: drop cf validity check in get_next_char()
Date: Fri, 12 Jul 2013 00:43:02 +0200
Message-ID: <20130711224302.GC26477@book-mint>
References: <20130711223614.GA26477@book-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 00:43:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxPZz-0000Qz-BG
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 00:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756376Ab3GKWnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 18:43:11 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.35]:57742 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755234Ab3GKWnK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 18:43:10 -0400
Received: from [85.16.23.209] (helo=book-mint)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UxPZo-0007hT-Aq; Fri, 12 Jul 2013 00:43:04 +0200
Content-Disposition: inline
In-Reply-To: <20130711223614.GA26477@book-mint>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230145>

The global variable cf is set with an initialized value in all codepaths before
calling this function.

The complete call graph looks like this:

  git_config_from_file
    -> do_config_from
      -> git_parse_file
        -> get_next_char
        -> get_value
            -> get_next_char
            -> parse_value
                -> get_next_char
        -> get_base_var
            -> get_next_char
            -> get_extended_base_var
                -> get_next_char

The variable is initialized in do_config_from.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 config.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/config.c b/config.c
index c165c85..1ec73ad 100644
--- a/config.c
+++ b/config.c
@@ -169,26 +169,23 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 static int get_next_char(void)
 {
 	int c;
-	FILE *f;
+	FILE *f = cf->f;
 
-	c = '\n';
-	if (cf && ((f = cf->f) != NULL)) {
+	c = fgetc(f);
+	if (c == '\r') {
+		/* DOS like systems */
 		c = fgetc(f);
-		if (c == '\r') {
-			/* DOS like systems */
-			c = fgetc(f);
-			if (c != '\n') {
-				ungetc(c, f);
-				c = '\r';
-			}
-		}
-		if (c == '\n')
-			cf->linenr++;
-		if (c == EOF) {
-			cf->eof = 1;
-			c = '\n';
+		if (c != '\n') {
+			ungetc(c, f);
+			c = '\r';
 		}
 	}
+	if (c == '\n')
+		cf->linenr++;
+	if (c == EOF) {
+		cf->eof = 1;
+		c = '\n';
+	}
 	return c;
 }
 
-- 
1.8.3.2.773.gcfaae5b
