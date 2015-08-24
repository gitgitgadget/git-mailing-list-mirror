From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/6] write_file_v(): do not leave incomplete line at the end
Date: Mon, 24 Aug 2015 13:58:08 -0700
Message-ID: <1440449890-29490-5-git-send-email-gitster@pobox.com>
References: <xmqqzj1g31e5.fsf@gitster.dls.corp.google.com>
 <1440449890-29490-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 24 22:58:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTyp1-0006xJ-7j
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 22:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754361AbbHXU6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 16:58:17 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34759 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754249AbbHXU6P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 16:58:15 -0400
Received: by pabzx8 with SMTP id zx8so14632629pab.1
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 13:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=6+9O7vNf9Gu3ipo/xFkB4yElxKK58B1+6dl3tqhgImE=;
        b=gwKxXiIvyRfJWXfzQivLSfBz/mQ5o7QXAsLoSD40pNe/6z8h3iOBYA/470OkheE215
         jfzUBF4gdYCGZaF+v74TkJXLE/cd6/7uGeOm1j6V3oj+crzY2+3R0IhcqHdNRRqlefmM
         cEEZQwcijOKlXs35V7Jk7yGslBy13DDvYjH1FIiRq6KbyCpRd9eBND0InS+rY6+/aWLC
         nnjh/W2/bmthwrvRjFoecHuScg1moKfpnq2RNzXXxs122/zJgooFl9fLkuBccN0XdVdp
         AOk0iUk5aygITYgvXVIMR/HYLM6qH1a5I7XFpcmIjnIt50GiCN9rEzaCo3JrcXKhhnZz
         Czjg==
X-Received: by 10.66.150.66 with SMTP id ug2mr10205300pab.4.1440449895324;
        Mon, 24 Aug 2015 13:58:15 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:813d:881a:159:a8e7])
        by smtp.gmail.com with ESMTPSA id v5sm18433784pdo.87.2015.08.24.13.58.14
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 24 Aug 2015 13:58:14 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-568-g53a3e28
In-Reply-To: <1440449890-29490-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276484>

All existing callers to this function use it to produce a text file
or an empty file, and a new callsite that mimick them must end their
payload with a LF.  If they forget to do so, the resulting file will
end with an incomplete line.

Introduce WRITE_FILE_BINARY flag bit, which no existing callers
pass, and unless that bit is set, make sure that write_file_v() adds
an extra LF at the end of an incomplete line as necessary.

With this, the caller-side fix in builtin/am.c becomes unnecessary.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/am.c | 10 ++--------
 wrapper.c    | 14 +++++++++++---
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 9c57677..486ff59 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -199,19 +199,13 @@ static inline const char *am_path(const struct am_state *state, const char *path
 static int write_state_text(const struct am_state *state,
 			    const char *name, const char *string)
 {
-	const char *fmt;
-
-	if (*string && string[strlen(string) - 1] != '\n')
-		fmt = "%s\n";
-	else
-		fmt = "%s";
-	return write_file(am_path(state, name), fmt, string);
+	return write_file(am_path(state, name), "%s", string);
 }
 
 static int write_state_count(const struct am_state *state,
 			     const char *name, int value)
 {
-	return write_file(am_path(state, name), "%d\n", value);
+	return write_file(am_path(state, name), "%d", value);
 }
 
 static int write_state_bool(const struct am_state *state,
diff --git a/wrapper.c b/wrapper.c
index 8c8925b..db39e1b 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -621,17 +621,25 @@ char *xgetcwd(void)
 	return strbuf_detach(&sb, NULL);
 }
 
-static int write_file_v(const char *path, int fatal,
+
+#define WRITE_FILE_GENTLY (1 << 0)
+#define WRITE_FILE_BINARY (1 << 1)
+
+static int write_file_v(const char *path, unsigned flags,
 			const char *fmt, va_list params)
 {
+	int fatal = !(flags & WRITE_FILE_GENTLY);
 	struct strbuf sb = STRBUF_INIT;
 	int fd = open(path, O_RDWR | O_CREAT | O_TRUNC, 0666);
+
 	if (fd < 0) {
 		if (fatal)
 			die_errno(_("could not open %s for writing"), path);
 		return -1;
 	}
 	strbuf_vaddf(&sb, fmt, params);
+	if (!(flags & WRITE_FILE_BINARY))
+		strbuf_complete_line(&sb);
 	if (write_in_full(fd, sb.buf, sb.len) != sb.len) {
 		int err = errno;
 		close(fd);
@@ -656,7 +664,7 @@ int write_file(const char *path, const char *fmt, ...)
 	va_list params;
 
 	va_start(params, fmt);
-	status = write_file_v(path, 1, fmt, params);
+	status = write_file_v(path, 0, fmt, params);
 	va_end(params);
 	return status;
 }
@@ -667,7 +675,7 @@ int write_file_gently(const char *path, const char *fmt, ...)
 	va_list params;
 
 	va_start(params, fmt);
-	status = write_file_v(path, 0, fmt, params);
+	status = write_file_v(path, WRITE_FILE_GENTLY, fmt, params);
 	va_end(params);
 	return status;
 }
-- 
2.5.0-568-g53a3e28
