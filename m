From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH] config: support values longer than 1024 bytes
Date: Wed,  6 Apr 2011 01:30:03 +0200
Message-ID: <1302046203-4408-1-git-send-email-kusmabite@gmail.com>
Cc: jwa@urbancode.com, drew.northup@maine.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 06 01:30:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7FhU-0000Sv-BQ
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 01:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996Ab1DEXaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 19:30:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49374 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984Ab1DEXaO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 19:30:14 -0400
Received: by fxm17 with SMTP id 17so627915fxm.19
        for <git@vger.kernel.org>; Tue, 05 Apr 2011 16:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=XUn9wwlrP3mgkFK9LQhHwCWVTcJjjpABYP+ZPhGxvDw=;
        b=w60y7YWqW7RUs/ckmdr3ofcyy7GuWnS9qXMTpIKfOwrV8ANAt0Ug7CGzqocHklOJcJ
         VWRKk5nEwW+cYu5/CRkY2ErnPhZYg2oY4Ej5mb7fN3DFT8UewoK/eg6oOic+R045e/2w
         It7c2+daOwuVe+O1el1X0PI3bSUp/VI57+JZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=QxhF7byJ74UknPDtcKhWDuZmacvDyylKtYSymaXPNoMRv9b0nGWIqfrcJY1cjEeb6/
         fC8afAeXweZEUusaV545UTmEyY6OU2GR6x2ZbAa6A6N/OC+D/04VwEN7lW4JHzAIhxHr
         rYi6yx8noENi4f/8GaAdsVMza21MTyimXyano=
Received: by 10.223.35.147 with SMTP id p19mr336006fad.13.1302046212429;
        Tue, 05 Apr 2011 16:30:12 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id n9sm2245115fax.3.2011.04.05.16.30.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Apr 2011 16:30:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0.168.g33778
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170941>

parse_value in config.c has a static buffer of 1024 bytes that it
parse the value into. This can sometimes be a problem when a
config file contains very long values.

It's particularly amusing that git-config already is able to write
such files, so it should probably be able to read them as well.

Fix this by using a strbuf instead of a static buffer.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

Here's a proper-ish submission with a commit message and all.

The rather awkward return statement with strdup("") is because
strbuf_detach returns NULL when there's nothing allocated. Even
worse, it returns an uninitialized string if the string has been
initialized with a non-zero 'hint'.

Perhaps I should change it to return a heap-allocated, empty
string in those cases instead of working around it here?

 config.c                |   26 ++++++++++++++------------
 t/t1303-wacky-config.sh |    2 +-
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/config.c b/config.c
index 0abcada..f882f7c 100644
--- a/config.c
+++ b/config.c
@@ -133,23 +133,22 @@ static int get_next_char(void)
 
 static char *parse_value(void)
 {
-	static char value[1024];
-	int quote = 0, comment = 0, len = 0, space = 0;
+	struct strbuf value = STRBUF_INIT;
+	int quote = 0, comment = 0, space = 0;
 
 	for (;;) {
 		int c = get_next_char();
-		if (len >= sizeof(value) - 1)
-			return NULL;
 		if (c == '\n') {
 			if (quote)
 				return NULL;
-			value[len] = 0;
-			return value;
+			return value.len ?
+			    strbuf_detach(&value, NULL) :
+			    strdup("");
 		}
 		if (comment)
 			continue;
 		if (isspace(c) && !quote) {
-			if (len)
+			if (value.len)
 				space++;
 			continue;
 		}
@@ -160,7 +159,7 @@ static char *parse_value(void)
 			}
 		}
 		for (; space; space--)
-			value[len++] = ' ';
+			strbuf_addch(&value, ' ');
 		if (c == '\\') {
 			c = get_next_char();
 			switch (c) {
@@ -180,16 +179,17 @@ static char *parse_value(void)
 				break;
 			/* Reject unknown escape sequences */
 			default:
+				strbuf_release(&value);
 				return NULL;
 			}
-			value[len++] = c;
+			strbuf_addch(&value, c);
 			continue;
 		}
 		if (c == '"') {
 			quote = 1-quote;
 			continue;
 		}
-		value[len++] = c;
+		strbuf_addch(&value, c);
 	}
 }
 
@@ -200,7 +200,7 @@ static inline int iskeychar(int c)
 
 static int get_value(config_fn_t fn, void *data, char *name, unsigned int len)
 {
-	int c;
+	int c, ret;
 	char *value;
 
 	/* Get the full name */
@@ -226,7 +226,9 @@ static int get_value(config_fn_t fn, void *data, char *name, unsigned int len)
 		if (!value)
 			return -1;
 	}
-	return fn(name, value, data);
+	ret = fn(name, value, data);
+	free(value);
+	return ret;
 }
 
 static int get_extended_base_var(char *name, int baselen, int c)
diff --git a/t/t1303-wacky-config.sh b/t/t1303-wacky-config.sh
index 080117c..46103a1 100755
--- a/t/t1303-wacky-config.sh
+++ b/t/t1303-wacky-config.sh
@@ -44,7 +44,7 @@ LONG_VALUE=$(printf "x%01021dx a" 7)
 test_expect_success 'do not crash on special long config line' '
 	setup &&
 	git config section.key "$LONG_VALUE" &&
-	check section.key "fatal: bad config file line 2 in .git/config"
+	check section.key "$LONG_VALUE"
 '
 
 test_done
-- 
1.7.4.msysgit.0.168.g33778
