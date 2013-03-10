From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v2 1/4] config: factor out config file stack management
Date: Sun, 10 Mar 2013 17:57:53 +0100
Message-ID: <20130310165752.GB1136@sandbox-ub.fritz.box>
References: <20130310165642.GA1136@sandbox-ub.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 10 17:58:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEjZs-0005ch-51
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 17:58:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711Ab3CJQ6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 12:58:01 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.29]:34873 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110Ab3CJQ6A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 12:58:00 -0400
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UEjZJ-0007Zz-IK; Sun, 10 Mar 2013 17:57:53 +0100
Content-Disposition: inline
In-Reply-To: <20130310165642.GA1136@sandbox-ub.fritz.box>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217812>

Because a config callback may start parsing a new file, the
global context regarding the current config file is stored
as a stack. Currently we only need to manage that stack from
git_config_from_file. Let's factor it out to allow new
sources of config data.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 config.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/config.c b/config.c
index aefd80b..2c299dc 100644
--- a/config.c
+++ b/config.c
@@ -896,6 +896,28 @@ int git_default_config(const char *var, const char *value, void *dummy)
 	return 0;
 }
 
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
@@ -905,22 +927,10 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
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
1.8.2.rc0.26.gf7384c5
