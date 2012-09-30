From: Ben Walton <bdwalton@gmail.com>
Subject: [PATCH] Remove the hard coded length limit on variable names in config files
Date: Sun, 30 Sep 2012 20:44:36 +0100
Message-ID: <1349034276-10690-1-git-send-email-bdwalton@gmail.com>
References: <CAP30j15wKa7wbLyaLo8omHcAh5u7O=Yt8Tjy4bD3V_0nT1zJPQ@mail.gmail.com>
Cc: Ben Walton <bdwalton@gmail.com>
To: hagger@alum.mit.edu, gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 30 21:45:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIPRj-00033f-3B
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 21:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509Ab2I3Tot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 15:44:49 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:46413 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab2I3Tos (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 15:44:48 -0400
Received: by wibhr7 with SMTP id hr7so1791896wib.1
        for <git@vger.kernel.org>; Sun, 30 Sep 2012 12:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9RmmQTAI/DABQiXkYKp2WidWUl+RMowkw2FwBTyP5KI=;
        b=HDEbcOjLQsrr1ffIjzJcp6omSZb37AdIwnj9ioCBFXoa1z/iqjKRb55661ULOFTwDG
         Gb/Q1+Mv1eAbwmJ/OFrpeYPw9Qnlix00JEI6jPyblLT4DDlVWsCagEWeyiEl8odwWCsG
         0ObQqtPTPYrzefZ4AFZuxXxA/443DSPbqaffeBu3kGgdh2c9PCuOYpxMpnPmmI01NueI
         c0knB1OpIgWBPImbghoJbFZ22SHiTukt3e1/Fd4q0LnPAzmoaK+T08nDJAT2wTMggf9M
         YYoW98lqoVwry932LU+n8bLs4Fy8Agi9oG32SDlSeS2D6g4HJ4+cjLdpbx2cDfxiz/Pe
         PVcQ==
Received: by 10.180.94.102 with SMTP id db6mr4376215wib.20.1349034287232;
        Sun, 30 Sep 2012 12:44:47 -0700 (PDT)
Received: from gilmour.chass.utoronto.ca ([89.100.144.161])
        by mx.google.com with ESMTPS id w7sm12593532wiz.0.2012.09.30.12.44.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 30 Sep 2012 12:44:46 -0700 (PDT)
Received: from bwalton by gilmour.chass.utoronto.ca with local (Exim 4.76)
	(envelope-from <bdwalton@gmail.com>)
	id 1TIPRU-0002nJ-Vt; Sun, 30 Sep 2012 20:44:45 +0100
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <CAP30j15wKa7wbLyaLo8omHcAh5u7O=Yt8Tjy4bD3V_0nT1zJPQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206695>

Previously while reading the variable names in config files, there was
a 256 character limit with at most 128 of those characters being used
by the section header portion of the variable name.  This limitation
was only enforced while reading the config files.  It was possible to
write a config file that was not subsequently readable.

Instead of enforcing this limitation for both reading and writing,
remove it entirely by changing the var member of the config_file
struct to a strbuf instead of a fixed length buffer.  Update all of
the parsing functions in config.c to use the strbuf instead of the
static buffer.

The parsing functions that returned the base length of the variable
name now return simply 0 for success and -1 for failure.  The base
length information is obtained through the strbuf's len member.

We now send the buf member of the strbuf to external callback
functions to preserve the external api.  None of the external callers
rely on the old size limitation for sizing their own buffers so
removing the limit should have no externally visible effect.

Signed-off-by: Ben Walton <bdwalton@gmail.com>
---
 config.c |   59 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/config.c b/config.c
index 08e47e2..24fb2d2 100644
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
@@ -260,7 +258,7 @@ static inline int iskeychar(int c)
 	return isalnum(c) || c == '-';
 }
 
-static int get_value(config_fn_t fn, void *data, char *name, unsigned int len)
+static int get_value(config_fn_t fn, void *data, struct strbuf *name)
 {
 	int c;
 	char *value;
@@ -272,11 +270,9 @@ static int get_value(config_fn_t fn, void *data, char *name, unsigned int len)
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
 
@@ -288,10 +284,10 @@ static int get_value(config_fn_t fn, void *data, char *name, unsigned int len)
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
@@ -302,7 +298,7 @@ static int get_extended_base_var(char *name, int baselen, int c)
 	/* We require the format to be '[base "extension"]' */
 	if (c != '"')
 		return -1;
-	name[baselen++] = '.';
+	strbuf_addch(name, '.');
 
 	for (;;) {
 		int c = get_next_char();
@@ -315,37 +311,31 @@ static int get_extended_base_var(char *name, int baselen, int c)
 			if (c == '\n')
 				goto error_incomplete_line;
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
+	return 0;
 error_incomplete_line:
 	cf->linenr--;
 	return -1;
 }
 
-static int get_base_var(char *name)
+static int get_base_var(struct strbuf *name)
 {
-	int baselen = 0;
-
 	for (;;) {
 		int c = get_next_char();
 		if (cf->eof)
 			return -1;
 		if (c == ']')
-			return baselen;
+			return 0;
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
 
@@ -353,7 +343,7 @@ static int git_parse_file(config_fn_t fn, void *data)
 {
 	int comment = 0;
 	int baselen = 0;
-	char *var = cf->var;
+	struct strbuf *var = &cf->var;
 
 	/* U+FEFF Byte Order Mark in UTF8 */
 	static const unsigned char *utf8_bom = (unsigned char *) "\xef\xbb\xbf";
@@ -389,17 +379,24 @@ static int git_parse_file(config_fn_t fn, void *data)
 			continue;
 		}
 		if (c == '[') {
-			baselen = get_base_var(var);
-			if (baselen <= 0)
+			/* Reset prior to determining a new stem */
+			strbuf_reset(var);
+			if (get_base_var(var) < 0 || var->len < 1)
 				break;
-			var[baselen++] = '.';
-			var[baselen] = 0;
+			strbuf_addch(var, '.');
+			baselen = var -> len;
 			continue;
 		}
 		if (!isalpha(c))
 			break;
-		var[baselen] = tolower(c);
-		if (get_value(fn, data, var, baselen+1) < 0)
+		/*
+		 * Truncate the var name back to the section header
+		 * stem prior to grabbing the suffix part of the name
+		 * and the value.
+		 */
+		strbuf_setlen(var, baselen);
+		strbuf_addch(var, tolower(c));
+		if (get_value(fn, data, var) < 0)
 			break;
 	}
 	die("bad config file line %d in %s", cf->linenr, cf->name);
@@ -899,12 +896,14 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
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
