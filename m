From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 03/19] argv-array: implement argv_array_pushv()
Date: Thu, 18 Jun 2015 18:53:56 +0800
Message-ID: <1434624852-6869-4-git-send-email-pyokagan@gmail.com>
References: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 12:55:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5XTS-0001Zx-Sd
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 12:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035AbbFRKyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 06:54:53 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33735 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753768AbbFRKyu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 06:54:50 -0400
Received: by padev16 with SMTP id ev16so59036711pad.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 03:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5PUexBDNd5Zl/ULTlrp3CoIuddO6NPJ599gY0uhQpIE=;
        b=PU/HOTU9yhYsIGLykC80PwQPCBxgj+XyK7NCagpAyuFXHVqph5PWvVYnMbodU2H9vl
         VRTFElLvvgY+AZq/3igBSjGr5Om6SmfVRYzoaBqf8rhGsrhVgvTZ7CGvU8rQalurc3pJ
         0BqcXsj+a7ajrkqHi/VyAfzSZuVimRWH/xdSiQTnKHdXKmcg7vEeeNO3bZ0QeMeIKaKk
         uFFda09+WztWTsMoLBRZ7gXRpjE0dcFDRhUvY/HJVMVGsyi5OHRWurLQrpBCKDb2uL4D
         75zJX1Kb7O2nZdUgXBv9UGPWMIWDRUb9jNONtOOf4/1OvJpauV+V867QDAfzzgBo4svC
         /3iQ==
X-Received: by 10.66.242.79 with SMTP id wo15mr20496165pac.6.1434624889644;
        Thu, 18 Jun 2015 03:54:49 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id eu5sm7735063pac.37.2015.06.18.03.54.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 03:54:48 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271946>

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
