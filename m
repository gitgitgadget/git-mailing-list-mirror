From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v4 1/6] config.c: fix accuracy of line number in errors
Date: Tue, 29 Jul 2014 04:28:17 -0700
Message-ID: <1406633302-23144-2-git-send-email-tanayabh@gmail.com>
References: <1406633302-23144-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 13:29:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC5bM-00039p-R2
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 13:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753278AbaG2L3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 07:29:36 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:61860 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227AbaG2L3f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 07:29:35 -0400
Received: by mail-pd0-f173.google.com with SMTP id w10so11534570pde.32
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 04:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CoDTocvGrhcz0CWymGlMXUPSQNRbnI9tjVEvyNjEhi0=;
        b=Gf/qy4dFSHQcEfKhMWNzLbiciaoOz062EGX3BiLI8cyBwCIG+WNQJU2wR96bx7cTFf
         HI7O+qc7CVThCGtGF0Yh5vDX+UZYdnByxZ31AppPKwKaE5x/wUaCZpZCKN4hA6z7i1op
         sej5UhGykRQpo2zqcj/I3ae6ivDpnixI/Uv9DtROpAzd80nttjNChYoeX/w7Jx2KZbmS
         5pJV+37uBzisZMvgSPFJu7Tx1vQ1gWTYByiIyD6DxKYH3n3ozcBzxE2l4cjDFBWYWdbA
         BjuG62m6SwJHNoDBvQPscBsAYiOnY/E2BIca6hxwujhX70s9YeKgN9m1c6BfYcrTj2gY
         qKHg==
X-Received: by 10.68.94.34 with SMTP id cz2mr1385800pbb.7.1406633374722;
        Tue, 29 Jul 2014 04:29:34 -0700 (PDT)
Received: from localhost.localdomain ([223.184.138.24])
        by mx.google.com with ESMTPSA id z2sm28554774pdj.16.2014.07.29.04.29.25
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 29 Jul 2014 04:29:34 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406633302-23144-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254414>

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
