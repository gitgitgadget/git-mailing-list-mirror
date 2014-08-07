From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v9 2/8] config.c: fix accuracy of line number in errors
Date: Thu,  7 Aug 2014 04:59:13 -0700
Message-ID: <1407412759-13833-3-git-send-email-tanayabh@gmail.com>
References: <1407412759-13833-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 14:00:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFMMm-0004lL-99
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 14:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757411AbaHGMAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 08:00:14 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:53955 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597AbaHGMAL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 08:00:11 -0400
Received: by mail-pa0-f53.google.com with SMTP id rd3so5320895pab.12
        for <git@vger.kernel.org>; Thu, 07 Aug 2014 05:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LsohJTDAaPGKKkuB+MZIjhMrxU8brQ6m74sDy/UtuSM=;
        b=TwncHP4Aec7FXa48emHaLP2S4S4EYx5QLJ1qWXbh//n9AJz569bAS+uUnlT2sO96qM
         Yh2tvPWhaxoAxT9/YusUGAFmX7bI5gfttW1uvovnNdNe1fxxr11flDwMzWF34PZUcRh5
         O8oYx6+3wc0OZ1ogDDg3OulPJAOhXOjxIIMlZrxWAzZ6NjQ5KEoh2BHYUOHraYCJR2A9
         WE+daY1ul9caZ9a5TmeFpc48+Rr5K/283z5HlCJWrIxCuXm2tXPgQSMVR6icLjIx6UZm
         I20AzUxLoyCn/4pTYsq773XDMekVaooLAELGu7rpQjn4heQLHzJztOTJGDQmCnViIfhH
         Kivg==
X-Received: by 10.69.31.234 with SMTP id kp10mr2051257pbd.138.1407412811311;
        Thu, 07 Aug 2014 05:00:11 -0700 (PDT)
Received: from localhost.localdomain ([223.176.226.83])
        by mx.google.com with ESMTPSA id cb8sm13997212pad.8.2014.08.07.05.00.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Aug 2014 05:00:10 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407412759-13833-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254950>

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
