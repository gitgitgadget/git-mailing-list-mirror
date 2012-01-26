From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] config: factor out config file stack management
Date: Thu, 26 Jan 2012 02:38:22 -0500
Message-ID: <20120126073821.GB30474@sigill.intra.peff.net>
References: <20120126073547.GA28689@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 26 08:38:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqJuf-0006wG-R0
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 08:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009Ab2AZHiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 02:38:25 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45001
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751958Ab2AZHiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 02:38:25 -0500
Received: (qmail 23974 invoked by uid 107); 26 Jan 2012 07:45:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Jan 2012 02:45:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jan 2012 02:38:22 -0500
Content-Disposition: inline
In-Reply-To: <20120126073547.GA28689@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189142>

Because a config callback may start parsing a new file, the
global context regarding the current config file is stored
as a stack. Currently we only need to manage that stack from
git_config_from_file. Let's factor it out to allow new
sources of config data.

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c |   30 +++++++++++++++++++-----------
 1 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/config.c b/config.c
index a6966c1..b82f749 100644
--- a/config.c
+++ b/config.c
@@ -826,6 +826,23 @@ int git_default_config(const char *var, const char *value, void *dummy)
 	return 0;
 }
 
+static void config_file_push(config_file *top, const char *name)
+{
+	top->prev = cf;
+	top->f = NULL;
+	top->name = name;
+	top->linenr = 1;
+	top->eof = 0;
+	strbuf_init(&top->value, 1024);
+	cf = top;
+}
+
+static void config_file_pop(config_file *top)
+{
+	strbuf_release(&top->value);
+	cf = top->prev;
+}
+
 int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 {
 	int ret;
@@ -835,21 +852,12 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 	if (f) {
 		config_file top;
 
-		/* push config-file parsing state stack */
-		top.prev = cf;
+		config_file_push(&top, filename);
 		top.f = f;
-		top.name = filename;
-		top.linenr = 1;
-		top.eof = 0;
-		strbuf_init(&top.value, 1024);
-		cf = &top;
 
 		ret = git_parse_file(fn, data);
 
-		/* pop config-file parsing state stack */
-		strbuf_release(&top.value);
-		cf = top.prev;
-
+		config_file_pop(&top);
 		fclose(f);
 	}
 	return ret;
-- 
1.7.9.rc2.293.gaae2
