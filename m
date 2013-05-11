From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v4 2/5] config: drop cf validity check in get_next_char()
Date: Sat, 11 May 2013 15:19:29 +0200
Message-ID: <20130511131929.GC17991@book-mint>
References: <20130511131721.GA17991@book-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 11 15:19:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub9iA-0002wr-22
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 15:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238Ab3EKNTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 09:19:38 -0400
Received: from smtprelay01.ispgateway.de ([80.67.29.23]:47006 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab3EKNTi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 09:19:38 -0400
Received: from [213.221.117.228] (helo=book-mint)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Ub9i4-0005kn-Vp; Sat, 11 May 2013 15:19:37 +0200
Content-Disposition: inline
In-Reply-To: <20130511131721.GA17991@book-mint>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223966>

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
index f0494f3..046642b 100644
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
1.8.3.rc1.53.g0126843
