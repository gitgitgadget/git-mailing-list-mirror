From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v6 1/7] config.c: fix accuracy of line number in errors
Date: Thu, 31 Jul 2014 08:47:36 -0700
Message-ID: <1406821662-1570-2-git-send-email-tanayabh@gmail.com>
References: <1406821662-1570-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 17:48:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCsaw-00085u-Un
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 17:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbaGaPsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 11:48:37 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:41279 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbaGaPsh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 11:48:37 -0400
Received: by mail-pa0-f41.google.com with SMTP id rd3so3872664pab.14
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 08:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/dSqeTkvkbPyDFz7gMi9RfJRQKWcmSOcmHnYR1yvCsI=;
        b=XtsJnsoTojqQMRmZTs12ZaH091vTGW8FFBA22/aXlQ/KtD9yYcks6ZVlxqbvJBHjdr
         +sB9LifqdrsUa70rC/VxcwfXNhWMIXEOhvTgdJQnkdU6TluqQ6FcUcbXcuvH0eVcgh+D
         TX01lXieSX0ZPuBTViSJiMvX31cdtQ3I30zO3kAc0cao3HMzFyEfqqOgpt2HHKB3Ac6d
         8ANKZ7Of/88uh8ZS4DiQKuv3Q0qikwomVSPdwyrnSkVTu5f4kOoWsO5tJMUrmE0wQU3n
         O9ngbSsiLeV4e1kvCbouFEWSLjfm8wH8grfBvVqQCssjdsEvZDeAAOugx8q1P9fWmLOY
         BkKg==
X-Received: by 10.70.94.100 with SMTP id db4mr13447934pdb.122.1406821716708;
        Thu, 31 Jul 2014 08:48:36 -0700 (PDT)
Received: from localhost.localdomain ([223.229.21.143])
        by mx.google.com with ESMTPSA id n16sm8837555pdj.41.2014.07.31.08.48.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Jul 2014 08:48:36 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406821662-1570-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254579>

From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>

If a callback returns a negative value to `git_config*()` family,
they call `die()` while printing the line number and the file name.
Currently the printed line number is off by one, thus printing the
wrong line number.

Make `linenr` point to the line we just parsed during the call
to callback to get accurate line number in error messages.

Commit-message-by: Tanay Abhra <tanayabh@gmail.com>
Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 config.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index a191328..ed5fc8e 100644
--- a/config.c
+++ b/config.c
@@ -244,6 +244,7 @@ static int get_next_char(void)
 		cf->linenr++;
 	if (c == EOF) {
 		cf->eof = 1;
+		cf->linenr++;
 		c = '\n';
 	}
 	return c;
@@ -319,6 +320,7 @@ static int get_value(config_fn_t fn, void *data, struct strbuf *name)
 {
 	int c;
 	char *value;
+	int ret;
 
 	/* Get the full name */
 	for (;;) {
@@ -341,7 +343,15 @@ static int get_value(config_fn_t fn, void *data, struct strbuf *name)
 		if (!value)
 			return -1;
 	}
-	return fn(name->buf, value, data);
+	/*
+	 * We already consumed the \n, but we need linenr to point to
+	 * the line we just parsed during the call to fn to get
+	 * accurate line number in error messages.
+	 */
+	cf->linenr--;
+	ret = fn(name->buf, value, data);
+	cf->linenr++;
+	return ret;
 }
 
 static int get_extended_base_var(struct strbuf *name, int c)
-- 
1.9.0.GIT
