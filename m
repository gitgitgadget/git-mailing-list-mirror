From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2 2/2] config: support values longer than 1023 bytes
Date: Sun, 10 Apr 2011 22:54:18 +0200
Message-ID: <1302468858-7376-2-git-send-email-kusmabite@gmail.com>
References: <1302468858-7376-1-git-send-email-kusmabite@gmail.com>
Cc: jwa@urbancode.com, drew.northup@maine.edu, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 22:55:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q91ey-0002x0-Eh
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 22:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755221Ab1DJUzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 16:55:01 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41472 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149Ab1DJUy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 16:54:57 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so4018948bwz.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 13:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=V+NvQ4e3WDLXV3az3ZA21wmprZbD6HLVcfz2dkztH8o=;
        b=KLJk7FhtMOjU3IeL9lY+mnVBIwpFdI6+w8+20H456WwUisVXaVcCaPueHJe64TIvhj
         5pvKgx4a12T4eQBvkzqUsMEYbSSQW1KmJJyeusanW8E6wIUNSChYqzlaRbhdVuZEXWqn
         PL69EiSnq7YInnni++F5CpUEIefu9+zmhFdhs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=L3uWpiG6hF+gHjN2feap/zJL1BHQTc1fwbF/MkmGxJE6mM/5ls4aKHpM8f7XfqLUFW
         fmkKJWsxFuPo5Cr8LBWvnW2Cobux0xxHTX/xK0rYF0aP0baodZ24MVf5yslk3XTm2wbC
         MRG50xopLcMMn/yor2v5l88SJ4baR9cW2RgXA=
Received: by 10.204.20.139 with SMTP id f11mr2145314bkb.177.1302468896768;
        Sun, 10 Apr 2011 13:54:56 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id c11sm2836104bkc.14.2011.04.10.13.54.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 13:54:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0.916.ga2194
In-Reply-To: <1302468858-7376-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171287>

parse_value in config.c has a static buffer of 1024 bytes that it
parse the value into. This can sometimes be a problem when a
config file contains very long values.

It's particularly amusing that git-config already is able to write
such files, so it should probably be able to read them as well.

Fix this by using a strbuf instead of a fixed-size buffer.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

Updated as suggested by Peff.

 config.c                |   18 ++++++++----------
 t/t1303-wacky-config.sh |    2 +-
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/config.c b/config.c
index 0abcada..b7fc2c5 100644
--- a/config.c
+++ b/config.c
@@ -133,23 +133,21 @@ static int get_next_char(void)
 
 static char *parse_value(void)
 {
-	static char value[1024];
-	int quote = 0, comment = 0, len = 0, space = 0;
+	static struct strbuf value = STRBUF_INIT;
+	int quote = 0, comment = 0, space = 0;
 
+	strbuf_reset(&value);
 	for (;;) {
 		int c = get_next_char();
-		if (len >= sizeof(value) - 1)
-			return NULL;
 		if (c == '\n') {
 			if (quote)
 				return NULL;
-			value[len] = 0;
-			return value;
+			return value.buf;
 		}
 		if (comment)
 			continue;
 		if (isspace(c) && !quote) {
-			if (len)
+			if (value.len)
 				space++;
 			continue;
 		}
@@ -160,7 +158,7 @@ static char *parse_value(void)
 			}
 		}
 		for (; space; space--)
-			value[len++] = ' ';
+			strbuf_addch(&value, ' ');
 		if (c == '\\') {
 			c = get_next_char();
 			switch (c) {
@@ -182,14 +180,14 @@ static char *parse_value(void)
 			default:
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
1.7.4.msysgit.0.916.ga2194
