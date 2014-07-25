From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v2 1/6] config.c: fix accuracy of line number in errors
Date: Fri, 25 Jul 2014 05:58:10 -0700
Message-ID: <1406293095-15920-2-git-send-email-tanayabh@gmail.com>
References: <1406293095-15920-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 14:59:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAf5e-00032Q-Pg
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 14:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760408AbaGYM7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 08:59:10 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:44861 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760404AbaGYM7I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 08:59:08 -0400
Received: by mail-pa0-f44.google.com with SMTP id eu11so6111783pac.3
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 05:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rDaQTDNOWXxHdVOb9SSDzGu/CvkrdD66VPVf3Z21E6o=;
        b=te0hGkY749OJs43jHjPrLoKa1jCPrIJ5avlsOaPCgeNUIyJyLghiHLLOBmDjt/oLtf
         0E+27N9elWi7e8jiBrrckLjEYY5Me6NAWg3d/xIKyVGNbVhAfQ/hles28nOygtVseCSL
         lYEPOgIFZNhGENja/3UIsMAyZYrPjI+u/ZRJNd5vN+flKpgg1pDDMhoRxO9UXECCvQ9a
         jKnvJEnrTb1+azEEaF4yqRuic7+82K2jVK17aytrvSfg2ywoeFk21aVOgKookF8Aovdf
         gXcxHv4CUaf9rAxar/2vH9SVTbRoK7tNfVoNGyw72WssALrFt9umcqrGa+YbBpp38+Of
         ttNA==
X-Received: by 10.70.128.227 with SMTP id nr3mr2312734pdb.156.1406293148256;
        Fri, 25 Jul 2014 05:59:08 -0700 (PDT)
Received: from localhost.localdomain ([223.176.246.45])
        by mx.google.com with ESMTPSA id tg9sm8798900pbc.29.2014.07.25.05.58.56
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 25 Jul 2014 05:58:59 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406293095-15920-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254212>

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
index 0d799e0..06257d9 100644
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
