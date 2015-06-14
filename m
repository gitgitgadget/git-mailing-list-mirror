From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 03/19] argv-array: implement argv_array_pushv()
Date: Sun, 14 Jun 2015 16:41:50 +0800
Message-ID: <1434271326-11349-4-git-send-email-pyokagan@gmail.com>
References: <1434271326-11349-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 10:42:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z43V5-00067n-A0
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 10:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbbFNImk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 04:42:40 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34683 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147AbbFNIme (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 04:42:34 -0400
Received: by pacgb13 with SMTP id gb13so16496254pac.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 01:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5PUexBDNd5Zl/ULTlrp3CoIuddO6NPJ599gY0uhQpIE=;
        b=Z2WCGSDKdhZ/uDc//JuGkQFRaIafX7P1aJ8Y2BNxJtkwNzyDB5VwVCZjfZQzAuftL+
         QCHa7EpSZsUWT0MpbLE7RC/id0J5lTvF3l8NUH14z4x7YpAO2jilYCJmzsX755/qI429
         2MsbIHWEWO5uWSjdw241KsqxyOyuQxr1fWP685zMQNCef/ingRzp7OHXhM08rFe+wRaY
         Abtgv2QleyRzlriH7TPWrBs/JSYXiqE4bWPHlFmQU9QoMUfWjnzZOCnUhhbYAoLKWzAX
         niIAMIuO8Zt1M7rkZTk/JsuiovSvsPfCnOSnJ7iuF2gliN7PjFjJpXy0EnNzqGtKs4vk
         Hwrw==
X-Received: by 10.68.136.169 with SMTP id qb9mr37738390pbb.47.1434271353997;
        Sun, 14 Jun 2015 01:42:33 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id kk6sm8622549pdb.94.2015.06.14.01.42.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Jun 2015 01:42:32 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434271326-11349-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271617>

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
