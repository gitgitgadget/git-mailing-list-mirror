From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH 1/7] config.c: fix accuracy of line number in errors
Date: Wed, 23 Jul 2014 11:42:52 -0700
Message-ID: <1406140978-9472-2-git-send-email-tanayabh@gmail.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 20:44:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA1WB-0006U1-NH
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 20:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933173AbaGWSnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 14:43:53 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:41168 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932584AbaGWSnv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 14:43:51 -0400
Received: by mail-pa0-f53.google.com with SMTP id kq14so2251926pab.40
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 11:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lTu0MSKpxpqHL/so+SRtVR3pIdea9a9aZYTd9GIz7ko=;
        b=Gsitfvz5kpkeQhKqNUh3yM9QrXzGRBgHRUv7RFDfaavpv5PfQVMb0I2f2W06C0u15R
         lKujb7h8TXVMTKKUjVsODs3SXChL9Gc/Mtn/RbNwyHusWkmHHL81wCcOzLUad3OeQReI
         cmM0CmenLymLv4uBiIgkKNpKa6GjyB7yYOGYj9Fc7P25Ur32uNNI0oqi2OnS54Ge6t+X
         tTvSgLnubGkFFcVUIZoSciKhDKKqQNyU1d8Cl0B3xcnf/xs9RAF8rIPDcg+jETbwjvJj
         iFPoK5Fkw1w5nL0HNsSCU+XtxJ18n5KCULQp/AiHnzlVJbeqxHd5SF45/4Y4k0MQFq2B
         2cbg==
X-Received: by 10.68.94.130 with SMTP id dc2mr4235238pbb.113.1406141031395;
        Wed, 23 Jul 2014 11:43:51 -0700 (PDT)
Received: from localhost.localdomain ([27.56.89.40])
        by mx.google.com with ESMTPSA id z10sm1067820pdo.14.2014.07.23.11.43.48
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Jul 2014 11:43:50 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254102>

If a callback returns a negative value to `git_config*()` family,
they call `die()` while printing the line number and the file name.
Currently the printed line number is off by one, thus printing the
wrong line number.

Make `linenr` point to the line we just parsed during the call
to callback to get accurate line number in error messages.

Discovered-by: Tanay Abhra <tanayabh@gmail.com>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
 config.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 22971e9..6db8f97 100644
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
