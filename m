From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v7 2/8] config.c: fix accuracy of line number in errors
Date: Fri,  1 Aug 2014 10:05:50 -0700
Message-ID: <1406912756-15517-3-git-send-email-tanayabh@gmail.com>
References: <1406912756-15517-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 01 19:06:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDGI7-0001fR-4D
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 19:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755189AbaHARGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 13:06:48 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:58489 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562AbaHARGr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 13:06:47 -0400
Received: by mail-pa0-f48.google.com with SMTP id et14so6124850pad.7
        for <git@vger.kernel.org>; Fri, 01 Aug 2014 10:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VKPUm1QoK63Kjyf+++4ruWP64dbCIVZqIPtpj1Y3HUs=;
        b=SHXGpWqrz+zR7Mf7Zf6Al5B2VozvVmPbUvqN+H9gMw+h8LAqSBCf8RbHBnlj+4XLAH
         Xv3w72zZb4+wEN2Dl3QGxO/f6LXA4+HgX5CfQmzlZpXaLMc7QbYtlaHiS+2KCom/bsUi
         lbAQO8Qmei9ZO2ilDVuTIOQrtJrkI5wdpTwuUGEgQi2+kJkEr50Z5kVr4DUIQEo53qhS
         I14u15Eb/Rvxf9qO2r/CX+kVKFLl4o0dEWAQkIFLCGIT3jBBxTDT1SDhN/h+VMDv5yDn
         j37lTzM5OKbozgfXWviImQc04fS5CvZeXP3o8UUvnwKiDlVvG+gLdiZVxCbSDbSCDIpa
         3B+Q==
X-Received: by 10.66.248.199 with SMTP id yo7mr2642728pac.107.1406912806905;
        Fri, 01 Aug 2014 10:06:46 -0700 (PDT)
Received: from localhost.localdomain ([110.225.111.156])
        by mx.google.com with ESMTPSA id pz10sm9241121pbb.33.2014.08.01.10.06.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 01 Aug 2014 10:06:46 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406912756-15517-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254635>

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
