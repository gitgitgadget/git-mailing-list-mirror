From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v5 1/5] config: factor out config file stack management
Date: Fri, 12 Jul 2013 00:40:32 +0200
Message-ID: <20130711224032.GB26477@book-mint>
References: <20130711223614.GA26477@book-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 00:40:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxPXY-0006is-Ek
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 00:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756357Ab3GKWkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 18:40:40 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.102]:46038 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976Ab3GKWkk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 18:40:40 -0400
Received: from [85.16.23.209] (helo=book-mint)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UxPXO-0006Zu-5K; Fri, 12 Jul 2013 00:40:34 +0200
Content-Disposition: inline
In-Reply-To: <20130711223614.GA26477@book-mint>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230144>

Because a config callback may start parsing a new file, the
global context regarding the current config file is stored
as a stack. Currently we only need to manage that stack from
git_config_from_file. Let's factor it out to allow new
sources of config data.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 config.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/config.c b/config.c
index d04e815..c165c85 100644
--- a/config.c
+++ b/config.c
@@ -906,6 +906,32 @@ int git_default_config(const char *var, const char *value, void *dummy)
 	return 0;
 }
 
+/*
+ * The fields f and name of top need to be initialized before calling
+ * this function.
+ */
+static int do_config_from(struct config_file *top, config_fn_t fn, void *data)
+{
+	int ret;
+
+	/* push config-file parsing state stack */
+	top->prev = cf;
+	top->linenr = 1;
+	top->eof = 0;
+	strbuf_init(&top->value, 1024);
+	strbuf_init(&top->var, 1024);
+	cf = top;
+
+	ret = git_parse_file(fn, data);
+
+	/* pop config-file parsing state stack */
+	strbuf_release(&top->value);
+	strbuf_release(&top->var);
+	cf = top->prev;
+
+	return ret;
+}
+
 int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 {
 	int ret;
@@ -915,22 +941,10 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 	if (f) {
 		config_file top;
 
-		/* push config-file parsing state stack */
-		top.prev = cf;
 		top.f = f;
 		top.name = filename;
-		top.linenr = 1;
-		top.eof = 0;
-		strbuf_init(&top.value, 1024);
-		strbuf_init(&top.var, 1024);
-		cf = &top;
-
-		ret = git_parse_file(fn, data);
-
-		/* pop config-file parsing state stack */
-		strbuf_release(&top.value);
-		strbuf_release(&top.var);
-		cf = top.prev;
+
+		ret = do_config_from(&top, fn, data);
 
 		fclose(f);
 	}
-- 
1.8.3.2.773.gcfaae5b
