From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v3 1/6] config.c: fix accuracy of line number in errors
Date: Mon, 28 Jul 2014 03:33:50 -0700
Message-ID: <1406543635-19281-2-git-send-email-tanayabh@gmail.com>
References: <1406543635-19281-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 12:34:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBiGP-0008H4-Gn
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 12:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbaG1Keg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 06:34:36 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:49287 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbaG1Kef (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 06:34:35 -0400
Received: by mail-pa0-f50.google.com with SMTP id et14so10364741pad.9
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 03:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CoDTocvGrhcz0CWymGlMXUPSQNRbnI9tjVEvyNjEhi0=;
        b=oquhGxHobKt0qxw3X7aVTpQGhhAAUKmbjUEnt/Spzbm4e2VYOKopXRbkGv+UrdhMj8
         66o/JlYNyskmiASvtYs0dzh/I++RhK8THgJN5XD7VcyHaTvfe7eCveiG6fG0pmRPl5Xu
         h/EYxatA+0/sSvQ+n2GqHvJN77l5dza1DSn0X+SOHpkIw9JUXFAuhnM32uQC/XnK+L/0
         y2mfhQbr89fJn/5UJJRetadk4wyCuvhDEvwY+VwWqBLiGpqYI4wLmdox2I4gZth0R3xB
         U17EA1D4kPpOD2nSpilE7eJOQR1iTQSIcyARJz6l2QANpaDNJzmZK2qiKHj56C/elwJN
         YkIA==
X-Received: by 10.70.129.81 with SMTP id nu17mr37931741pdb.56.1406543675107;
        Mon, 28 Jul 2014 03:34:35 -0700 (PDT)
Received: from localhost.localdomain ([106.211.56.253])
        by mx.google.com with ESMTPSA id v8sm23639483pdr.45.2014.07.28.03.34.31
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Jul 2014 03:34:34 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406543635-19281-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254291>

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
index d3ad661..e5b7f10 100644
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
