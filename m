From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v6 04/16] Add argv_array_detach and argv_array_free_detached
Date: Wed, 22 Aug 2012 21:15:49 +0200
Message-ID: <1345662961-9587-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345662961-9587-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 21:17:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4GQn-0002J7-Jq
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 21:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079Ab2HVTR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 15:17:27 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46610 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965024Ab2HVTQh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 15:16:37 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so449679bkw.19
        for <git@vger.kernel.org>; Wed, 22 Aug 2012 12:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=iE8g7Iixx3s6n12vMMasO9d5lxokH8IhGjUS4l7wMEE=;
        b=dWlRbL2IGRKWPuWtQRgv0jAr4nW5fGKet6BGESSPfdtbwGxUEzTkvLw6xVldgVd+Ee
         CmTCsmHKXKRyBizBptE32or+QlajBCo5ruQXAz0j0Qyl3SQkPd5pbDMOy5wYizCAGZZs
         S4fnEusoXUK2wYj05YPdED/rBnAouihIRtrBAc/Qyn5jkcP5I8Yg3WESgHdPLngjOE7s
         FZK3eIvBOs9We+m7HQP/+uSy66xJ5U4VxW0tHGdF+0jip7tfS3tE6K9s+hYexrPre44T
         AEx/n8Hm7HFnMXbITkueVt3Jq540ozzfyQO6nqSMeonfk4logYih5wQRSVqQ5N4+9s6r
         ZClA==
Received: by 10.204.129.76 with SMTP id n12mr6851453bks.18.1345662996349;
        Wed, 22 Aug 2012 12:16:36 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id ht18sm3346763bkc.16.2012.08.22.12.16.34
        (version=SSLv3 cipher=OTHER);
        Wed, 22 Aug 2012 12:16:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345662961-9587-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204084>

Allow detaching of ownership of the argv_array's contents and add a
function to free those detached argv_arrays later.

This makes it possible to use argv_array efficiently with the exiting
struct child_process which only contains a member char **argv.

Add to documentation.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/api-argv-array.txt |    8 ++++++++
 argv-array.c                               |   20 ++++++++++++++++++++
 argv-array.h                               |    2 ++
 3 files changed, 30 insertions(+)

diff --git a/Documentation/technical/api-argv-array.txt b/Documentation/technical/api-argv-array.txt
index 1b7d8f1..6b97d6d 100644
--- a/Documentation/technical/api-argv-array.txt
+++ b/Documentation/technical/api-argv-array.txt
@@ -49,3 +49,11 @@ Functions
 `argv_array_clear`::
 	Free all memory associated with the array and return it to the
 	initial, empty state.
+
+`argv_array_detach`::
+	Detach the argv array from the `struct argv_array`, transfering
+	ownership of the allocated array and strings.
+
+`argv_array_free_detached`::
+	Free the memory allocated by a `struct argv_array` that was later
+	detached and is now no longer needed.
diff --git a/argv-array.c b/argv-array.c
index 0b5f889..aab50d6 100644
--- a/argv-array.c
+++ b/argv-array.c
@@ -59,3 +59,23 @@ void argv_array_clear(struct argv_array *array)
 	}
 	argv_array_init(array);
 }
+
+const char **argv_array_detach(struct argv_array *array, int *argc)
+{
+	const char **argv =
+		array->argv == empty_argv || array->argc == 0 ? NULL : array->argv;
+	if (argc)
+		*argc = array->argc;
+	argv_array_init(array);
+	return argv;
+}
+
+void argv_array_free_detached(const char **argv)
+{
+	if (argv) {
+		int i;
+		for (i = 0; argv[i]; i++)
+			free((char **)argv[i]);
+		free(argv);
+	}
+}
diff --git a/argv-array.h b/argv-array.h
index b93a69c..b3ef351 100644
--- a/argv-array.h
+++ b/argv-array.h
@@ -17,5 +17,7 @@ __attribute__((format (printf,2,3)))
 void argv_array_pushf(struct argv_array *, const char *fmt, ...);
 void argv_array_pushl(struct argv_array *, ...);
 void argv_array_clear(struct argv_array *);
+const char **argv_array_detach(struct argv_array *array, int *argc);
+void argv_array_free_detached(const char **argv);
 
 #endif /* ARGV_ARRAY_H */
-- 
1.7.9.5
