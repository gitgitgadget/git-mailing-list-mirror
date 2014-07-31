From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v5 1/7] config.c: fix accuracy of line number in errors
Date: Thu, 31 Jul 2014 02:44:11 -0700
Message-ID: <1406799857-28048-2-git-send-email-tanayabh@gmail.com>
References: <1406799857-28048-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 11:45:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCmvf-0004eE-Ce
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 11:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbaGaJpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 05:45:38 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:59784 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932265AbaGaJph (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 05:45:37 -0400
Received: by mail-pa0-f54.google.com with SMTP id fa1so3325383pad.13
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 02:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/dSqeTkvkbPyDFz7gMi9RfJRQKWcmSOcmHnYR1yvCsI=;
        b=cJ8jLjn2dcQE/tUoLL2aTOxAnC43ueo7EjFRBijfCUjPF5qnXbFJu6iuWHMKAPlN8e
         6CTv+2Y6BDsqfEx9lqXIoWBb6vA1sTc8LVoGYDadrvcjp/sTxzrW3TYGAhBAVQqt+jNy
         79FBOR/wehE346bhC6Yz5X6vNKJZU+JkejnvTJzFQjOiCWgOyLgLnnZvnVcDpOkE76JJ
         zpj/3BmjA4mfaiUhUKhuxpJ5XPS9NWooQGPYbRYzBN8jjgdgHAkV45jlyPBcEuqW0FGv
         PL7xWn5ttPLYRDC6STnCcquYwxk0J6wkjUSEutGr9GHxtHFh2S0HGK8nYV3uaa3Spvjq
         ZL3A==
X-Received: by 10.70.43.37 with SMTP id t5mr10922176pdl.98.1406799936860;
        Thu, 31 Jul 2014 02:45:36 -0700 (PDT)
Received: from localhost.localdomain ([106.201.156.106])
        by mx.google.com with ESMTPSA id zq5sm4933551pbb.37.2014.07.31.02.45.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Jul 2014 02:45:36 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406799857-28048-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254542>

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
