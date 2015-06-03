From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 03/19] argv-array: implement argv_array_pushv()
Date: Wed,  3 Jun 2015 14:48:47 +0800
Message-ID: <1433314143-4478-4-git-send-email-pyokagan@gmail.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 08:50:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z02Uy-0004Nv-Vg
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 08:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270AbbFCGt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 02:49:57 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:34911 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236AbbFCGty (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 02:49:54 -0400
Received: by pdbnf5 with SMTP id nf5so736729pdb.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 23:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5PUexBDNd5Zl/ULTlrp3CoIuddO6NPJ599gY0uhQpIE=;
        b=n+GcrYbHtS4mp24JGPIvpL21b5O0K77zrzE5nydqJeApTp1a2mylbd+X6qxzWz3mS8
         qRW+R2f9roF6k9hZFU/+xO5nnQFWbRQSnggYA5l08lF/AOYCD6g1IAZBWzrOxYC4hTR9
         PjccA+EHZ4ZODQQN7eHYiJWL5rwwJlpe4RxGMan2TM1UelbN+w1TXGlW/769qF+TzWLT
         a+AHoN+g9J9Doi3Kh+etPF01doYIjMmZlmaA+i48iAPimzG2DsFD2GuqHI91HsupyO2t
         xZZbQa6pn/hQkHnYsLL8cRh7rC6TJEOOcXPo+7lBjckfWQ1s/oPqX23aZHFZDEd+BXDh
         8woA==
X-Received: by 10.66.146.100 with SMTP id tb4mr10350409pab.70.1433314193910;
        Tue, 02 Jun 2015 23:49:53 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qt4sm19474130pbc.86.2015.06.02.23.49.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 23:49:52 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270640>

When we have a null-terminated array, it would be useful to convert it
or append it to an argv_array for further manipulation.

Implement argv_array_pushv() which will push a null-terminated array of
strings on to an argv_array.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 Documentation/technical/api-argv-array.txt | 3 +++
 argv-array.c                               | 6 ++++++
 argv-array.h                               | 1 +
 3 files changed, 10 insertions(+)

diff --git a/Documentation/technical/api-argv-array.txt b/Documentation/technical/api-argv-array.txt
index 1a79781..8076172 100644
--- a/Documentation/technical/api-argv-array.txt
+++ b/Documentation/technical/api-argv-array.txt
@@ -46,6 +46,9 @@ Functions
 	Format a string and push it onto the end of the array. This is a
 	convenience wrapper combining `strbuf_addf` and `argv_array_push`.
 
+`argv_array_pushv`::
+	Push a null-terminated array of strings onto the end of the array.
+
 `argv_array_pop`::
 	Remove the final element from the array. If there are no
 	elements in the array, do nothing.
diff --git a/argv-array.c b/argv-array.c
index 256741d..eaed477 100644
--- a/argv-array.c
+++ b/argv-array.c
@@ -49,6 +49,12 @@ void argv_array_pushl(struct argv_array *array, ...)
 	va_end(ap);
 }
 
+void argv_array_pushv(struct argv_array *array, const char **argv)
+{
+	for (; *argv; argv++)
+		argv_array_push(array, *argv);
+}
+
 void argv_array_pop(struct argv_array *array)
 {
 	if (!array->argc)
diff --git a/argv-array.h b/argv-array.h
index c65e6e8..a2fa0aa 100644
--- a/argv-array.h
+++ b/argv-array.h
@@ -17,6 +17,7 @@ __attribute__((format (printf,2,3)))
 void argv_array_pushf(struct argv_array *, const char *fmt, ...);
 LAST_ARG_MUST_BE_NULL
 void argv_array_pushl(struct argv_array *, ...);
+void argv_array_pushv(struct argv_array *, const char **);
 void argv_array_pop(struct argv_array *);
 void argv_array_clear(struct argv_array *);
 
-- 
2.1.4
