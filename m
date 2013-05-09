From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v3 2/5] config: drop cf validity check in get_next_char()
Date: Thu, 9 May 2013 18:18:42 +0200
Message-ID: <20130509161841.GD3526@book-mint>
References: <20130509154020.GA26423@book-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 09 18:24:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaTdq-0001IQ-MT
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 18:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190Ab3EIQYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 12:24:22 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.38]:35820 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784Ab3EIQYU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 12:24:20 -0400
Received: from [213.221.117.228] (helo=book-mint)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UaTYN-0000tL-0x; Thu, 09 May 2013 18:18:47 +0200
Content-Disposition: inline
In-Reply-To: <20130509154020.GA26423@book-mint>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223740>

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
1.8.3.rc1.40.gba374ae
