From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v3 1/5] config: factor out config file stack management
Date: Thu, 9 May 2013 18:17:53 +0200
Message-ID: <20130509161753.GC3526@book-mint>
References: <20130509154020.GA26423@book-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 09 18:24:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaTdq-0001IQ-6H
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 18:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753088Ab3EIQYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 12:24:12 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.38]:55235 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403Ab3EIQYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 12:24:09 -0400
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 May 2013 12:24:09 EDT
Received: from [213.221.117.228] (helo=book-mint)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UaTXa-00073i-TO; Thu, 09 May 2013 18:17:59 +0200
Content-Disposition: inline
In-Reply-To: <20130509154020.GA26423@book-mint>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223741>

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
index aefd80b..f0494f3 100644
--- a/config.c
+++ b/config.c
@@ -896,6 +896,32 @@ int git_default_config(const char *var, const char *value, void *dummy)
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
@@ -905,22 +931,10 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
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
1.8.3.rc1.40.gba374ae
