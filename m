From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v5 5/5] do not die when error in config parsing of buf occurs
Date: Fri, 12 Jul 2013 00:48:30 +0200
Message-ID: <20130711224830.GF26477@book-mint>
References: <20130711223614.GA26477@book-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 00:48:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxPfB-00057a-RH
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 00:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756009Ab3GKWse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 18:48:34 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.40]:39954 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048Ab3GKWsd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 18:48:33 -0400
Received: from [85.16.23.209] (helo=book-mint)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UxPf6-0003Xf-3n; Fri, 12 Jul 2013 00:48:32 +0200
Content-Disposition: inline
In-Reply-To: <20130711223614.GA26477@book-mint>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230148>

If a config parsing error in a file occurs we can die and let the user
fix the issue. This is different for the buf parsing function since it
can be used to parse blobs of .gitmodules files. If a parsing error
occurs here we should proceed since otherwise a database containing such
an error in a single revision could be rendered unusable.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 config.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 75f6ad9..e13a7b6 100644
--- a/config.c
+++ b/config.c
@@ -21,6 +21,7 @@ struct config_source {
 		} buf;
 	} u;
 	const char *name;
+	int die_on_error;
 	int linenr;
 	int eof;
 	struct strbuf value;
@@ -442,7 +443,10 @@ static int git_parse_source(config_fn_t fn, void *data)
 		if (get_value(fn, data, var) < 0)
 			break;
 	}
-	die("bad config file line %d in %s", cf->linenr, cf->name);
+	if (cf->die_on_error)
+		die("bad config file line %d in %s", cf->linenr, cf->name);
+	else
+		return error("bad config file line %d in %s", cf->linenr, cf->name);
 }
 
 static int parse_unit_factor(const char *end, uintmax_t *val)
@@ -950,7 +954,7 @@ int git_default_config(const char *var, const char *value, void *dummy)
 }
 
 /*
- * All source specific fields in the union, name and the callbacks
+ * All source specific fields in the union, die_on_error, name and the callbacks
  * fgetc, ungetc, ftell of top need to be initialized before calling
  * this function.
  */
@@ -987,6 +991,7 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 
 		top.u.file = f;
 		top.name = filename;
+		top.die_on_error = 1;
 		top.fgetc = config_file_fgetc;
 		top.ungetc = config_file_ungetc;
 		top.ftell = config_file_ftell;
@@ -1007,6 +1012,7 @@ int git_config_from_buf(config_fn_t fn, const char *name, const char *buf,
 	top.u.buf.len = len;
 	top.u.buf.pos = 0;
 	top.name = name;
+	top.die_on_error = 0;
 	top.fgetc = config_buf_fgetc;
 	top.ungetc = config_buf_ungetc;
 	top.ftell = config_buf_ftell;
-- 
1.8.3.2.773.gcfaae5b
