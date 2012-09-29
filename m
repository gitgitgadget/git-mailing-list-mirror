From: Ben Walton <bdwalton@gmail.com>
Subject: [PATCH] Remove the hard coded length limit on variable names in config files
Date: Sat, 29 Sep 2012 11:19:39 +0100
Message-ID: <1348913979-27431-1-git-send-email-bdwalton@gmail.com>
References: <7vpq5yzkf3.fsf@alter.siamese.dyndns.org>
Cc: Ben Walton <bdwalton@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 29 12:20:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THu9n-0007zH-DN
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 12:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060Ab2I2KUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 06:20:10 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:45910 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573Ab2I2KUI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2012 06:20:08 -0400
Received: by wibhr7 with SMTP id hr7so774468wib.1
        for <git@vger.kernel.org>; Sat, 29 Sep 2012 03:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ndjZnAnDLYCEI7TurPzUHMIDT/KUTRdL6eBCp8s90jA=;
        b=cNW7rvOKky2rKqHnpXEoBTKUPDq9d41jwfYa8N3o6/r2yX066JPRj+AKN7XTtC9lk0
         NoB1K3dB3PtgDoHBt4RYB8UwC2jazeM3LIM6KJIVGTxvhb/vaTh1rdnzqUPNDK+fM7or
         hVuq562s6aOQarxvZGuLe5G8qu99MgarggQl1Gdtjgy7UjNjkIFC28QpQOGuUKmvuh6/
         DKqhFR5axTdCwkS3kCWR6zyY8HjSflVr3IecRJeLBK1qBCKe9iJcZ2Vm8AI7O0Pc7oo0
         ysGVz9Puu8GSRDHk66mJrRHIAm3e6ifjK8Z3NBljOUfH9tIArPOcp2RpFJu/+pfaH1H+
         ny1g==
Received: by 10.216.212.66 with SMTP id x44mr601312weo.123.1348914006625;
        Sat, 29 Sep 2012 03:20:06 -0700 (PDT)
Received: from gilmour.chass.utoronto.ca ([89.100.144.161])
        by mx.google.com with ESMTPS id dm3sm4805131wib.3.2012.09.29.03.20.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 29 Sep 2012 03:20:06 -0700 (PDT)
Received: from bwalton by gilmour.chass.utoronto.ca with local (Exim 4.76)
	(envelope-from <bdwalton@gmail.com>)
	id 1THu9U-000790-OK; Sat, 29 Sep 2012 11:20:04 +0100
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <7vpq5yzkf3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206645>

Previously while reading the variable names in config files, there was
a 256 character limit with at most 128 of those characters being used
by the section header portion of the variable name.  This limitation
was only enforced while reading the config files.  It was possible to
write a config file that was not subsequently readable.

Instead of enforcing this limitation for both reading and writing,
remove it entirely by changing the var member of the config_file
struct to a strbuf instead of a fixed length buffer.  Update all of
the parsing functions in config.c to use the strbuf instead of the
static buffer.  Send the buf member of the strbuf to external callback
functions to preserve the external api.

Signed-off-by: Ben Walton <bdwalton@gmail.com>
---
Hi Junio,

(Sorry that this patch took so long to submit.  I've been busy moving.)

I think this should remove the length limitations enforced while reading
configuration file variable names.

Thanks
-Ben

 config.c |   50 +++++++++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/config.c b/config.c
index 40f9c6d..ee860a7 100644
--- a/config.c
+++ b/config.c
@@ -10,8 +10,6 @@
 #include "strbuf.h"
 #include "quote.h"
 
-#define MAXNAME (256)
-
 typedef struct config_file {
 	struct config_file *prev;
 	FILE *f;
@@ -19,7 +17,7 @@ typedef struct config_file {
 	int linenr;
 	int eof;
 	struct strbuf value;
-	char var[MAXNAME];
+	struct strbuf var;
 } config_file;
 
 static config_file *cf;
@@ -191,7 +189,7 @@ static inline int iskeychar(int c)
 	return isalnum(c) || c == '-';
 }
 
-static int get_value(config_fn_t fn, void *data, char *name, unsigned int len)
+static int get_value(config_fn_t fn, void *data, struct strbuf *name)
 {
 	int c;
 	char *value;
@@ -203,11 +201,9 @@ static int get_value(config_fn_t fn, void *data, char *name, unsigned int len)
 			break;
 		if (!iskeychar(c))
 			break;
-		name[len++] = tolower(c);
-		if (len >= MAXNAME)
-			return -1;
+		strbuf_addch(name, tolower(c));
 	}
-	name[len] = 0;
+
 	while (c == ' ' || c == '\t')
 		c = get_next_char();
 
@@ -219,10 +215,10 @@ static int get_value(config_fn_t fn, void *data, char *name, unsigned int len)
 		if (!value)
 			return -1;
 	}
-	return fn(name, value, data);
+	return fn(name->buf, value, data);
 }
 
-static int get_extended_base_var(char *name, int baselen, int c)
+static int get_extended_base_var(struct strbuf *name, int c)
 {
 	do {
 		if (c == '\n')
@@ -233,7 +229,7 @@ static int get_extended_base_var(char *name, int baselen, int c)
 	/* We require the format to be '[base "extension"]' */
 	if (c != '"')
 		return -1;
-	name[baselen++] = '.';
+	strbuf_addch(name, '.');
 
 	for (;;) {
 		int c = get_next_char();
@@ -246,34 +242,30 @@ static int get_extended_base_var(char *name, int baselen, int c)
 			if (c == '\n')
 				return -1;
 		}
-		name[baselen++] = c;
-		if (baselen > MAXNAME / 2)
-			return -1;
+		strbuf_addch(name, c);
 	}
 
 	/* Final ']' */
 	if (get_next_char() != ']')
 		return -1;
-	return baselen;
+	return name->len;
 }
 
-static int get_base_var(char *name)
+static int get_base_var(struct strbuf *name)
 {
-	int baselen = 0;
+	strbuf_reset(name);
 
 	for (;;) {
 		int c = get_next_char();
 		if (cf->eof)
 			return -1;
 		if (c == ']')
-			return baselen;
+			return name->len;
 		if (isspace(c))
-			return get_extended_base_var(name, baselen, c);
+			return get_extended_base_var(name, c);
 		if (!iskeychar(c) && c != '.')
 			return -1;
-		if (baselen > MAXNAME / 2)
-			return -1;
-		name[baselen++] = tolower(c);
+		strbuf_addch(name, tolower(c));
 	}
 }
 
@@ -281,7 +273,7 @@ static int git_parse_file(config_fn_t fn, void *data)
 {
 	int comment = 0;
 	int baselen = 0;
-	char *var = cf->var;
+	struct strbuf *var = &cf->var;
 
 	/* U+FEFF Byte Order Mark in UTF8 */
 	static const unsigned char *utf8_bom = (unsigned char *) "\xef\xbb\xbf";
@@ -320,14 +312,16 @@ static int git_parse_file(config_fn_t fn, void *data)
 			baselen = get_base_var(var);
 			if (baselen <= 0)
 				break;
-			var[baselen++] = '.';
-			var[baselen] = 0;
+			strbuf_addch(var, '.');
 			continue;
 		}
 		if (!isalpha(c))
 			break;
-		var[baselen] = tolower(c);
-		if (get_value(fn, data, var, baselen+1) < 0)
+		/* Truncate the var name back to the section header prior to
+		   grabbing the suffix part of the name and the value */
+		strbuf_setlen(var, baselen+1);
+		strbuf_addch(var, tolower(c));
+		if (get_value(fn, data, var) < 0)
 			break;
 	}
 	die("bad config file line %d in %s", cf->linenr, cf->name);
@@ -842,12 +836,14 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 		top.linenr = 1;
 		top.eof = 0;
 		strbuf_init(&top.value, 1024);
+		strbuf_init(&top.var, 1024);
 		cf = &top;
 
 		ret = git_parse_file(fn, data);
 
 		/* pop config-file parsing state stack */
 		strbuf_release(&top.value);
+		strbuf_release(&top.var);
 		cf = top.prev;
 
 		fclose(f);
-- 
1.7.9.5
