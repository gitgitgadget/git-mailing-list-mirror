From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v8 2/8] config.c: fix accuracy of line number in errors
Date: Wed,  6 Aug 2014 07:53:06 -0700
Message-ID: <1407336792-16962-3-git-send-email-tanayabh@gmail.com>
References: <1407336792-16962-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 06 17:00:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF2i0-0008S1-26
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 17:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102AbaHFPAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 11:00:48 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:53881 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754004AbaHFPAr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 11:00:47 -0400
Received: by mail-pd0-f170.google.com with SMTP id g10so3466127pdj.1
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 08:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LsohJTDAaPGKKkuB+MZIjhMrxU8brQ6m74sDy/UtuSM=;
        b=kZTXnVWvkLfOU3vLpOXjeUMPRlG7MHms1wen0it4iQEY09lyATW55duK0gUvRqWSYb
         s8osGiSiyt8eiJKxoYEijxOKlOqhoaSiyp39NnQ87c+l/2our170Ff8xCNIXhCi0bXIJ
         dd/hmMrei2LVtIMfO7vf2pqg6mb4zNCn6BzuVP3qd/+oZQOKsvF5sjD0Pc6BTNiaQJmk
         BEJyyQ7PTDPodPh0wd/sffmrmo26P1ZfDg9LYGHart2HPOjhoQhIC3w5V0cXGqfSZyQr
         5It2akGLxRFlg8zokqGzd3uJ1VZn6LqtnnuKz98XHgFhsOAOIVuoSj7fPjmlS3XfwruH
         8UIQ==
X-Received: by 10.69.18.234 with SMTP id gp10mr11771638pbd.11.1407337247001;
        Wed, 06 Aug 2014 08:00:47 -0700 (PDT)
Received: from localhost.localdomain ([223.176.214.188])
        by mx.google.com with ESMTPSA id u2sm1547305pbs.42.2014.08.06.08.00.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 06 Aug 2014 08:00:46 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407336792-16962-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254855>

From: Matthieu Moy <Matthieu.Moy@imag.fr>

If a callback returns a negative value to `git_config*()` family,
they call `die()` while printing the line number and the file name.
Currently the printed line number is off by one, thus printing the
wrong line number.

Make `linenr` point to the line we just parsed during the call
to callback to get accurate line number in error messages.

Commit-message-by: Tanay Abhra <tanayabh@gmail.com>
Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 config.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 34940fd..bb4629e 100644
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
