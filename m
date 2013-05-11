From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v4 5/5] do not die when error in config parsing of buf occurs
Date: Sat, 11 May 2013 15:21:55 +0200
Message-ID: <20130511132155.GF17991@book-mint>
References: <20130511131721.GA17991@book-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 11 15:22:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub9kY-0004pK-E3
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 15:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692Ab3EKNWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 09:22:06 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.97]:36609 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550Ab3EKNWF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 09:22:05 -0400
Received: from [213.221.117.228] (helo=book-mint)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Ub9kL-0003Jb-OL; Sat, 11 May 2013 15:21:57 +0200
Content-Disposition: inline
In-Reply-To: <20130511131721.GA17991@book-mint>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223969>

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
index 23b14f4..a8d3dcf 100644
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
@@ -940,7 +944,7 @@ int git_default_config(const char *var, const char *value, void *dummy)
 }
 
 /*
- * All source specific fields in the union, name and the callbacks
+ * All source specific fields in the union, die_on_error, name and the callbacks
  * fgetc, ungetc, ftell of top need to be initialized before calling
  * this function.
  */
@@ -977,6 +981,7 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 
 		top.u.file = f;
 		top.name = filename;
+		top.die_on_error = 1;
 		top.fgetc = config_file_fgetc;
 		top.ungetc = config_file_ungetc;
 		top.ftell = config_file_ftell;
@@ -997,6 +1002,7 @@ int git_config_from_buf(config_fn_t fn, const char *name, const char *buf,
 	top.u.buf.len = len;
 	top.u.buf.pos = 0;
 	top.name = name;
+	top.die_on_error = 0;
 	top.fgetc = config_buf_fgetc;
 	top.ungetc = config_buf_ungetc;
 	top.ftell = config_buf_ftell;
-- 
1.8.3.rc1.53.g0126843
