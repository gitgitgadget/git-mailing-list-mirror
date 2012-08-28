From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v7 04/16] Add argv_array_detach and argv_array_free_detached
Date: Tue, 28 Aug 2012 10:49:38 +0200
Message-ID: <1346143790-23491-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1346143790-23491-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 28 10:52:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6HWs-0002Rb-WF
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 10:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331Ab2H1Iv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 04:51:56 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42001 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621Ab2H1IvG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 04:51:06 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1532823bkw.19
        for <git@vger.kernel.org>; Tue, 28 Aug 2012 01:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=iE8g7Iixx3s6n12vMMasO9d5lxokH8IhGjUS4l7wMEE=;
        b=i531SVBk2EsgGozqNVZwSgMiyUZetXXVWyof1Ny99JKcgbV4q7oYU7trEuj5dSZr/E
         Je+iHEb/ps2N2wUUmD2N0OKdwokUFdg5b+EY6ixiLmw6OUaEciEX0j0kD5/9eEjae2nF
         vrLWVexqnHAKbbmTfCX87D2c4CsED15e0T6hTI1JtHLKE3/KxI6Xy/dsWO4Lnu8pF9Gy
         OklK2fgOu7cZ6osfdiQ8PdXxEY+NA4UookHq4j4njezXBk7U8uzOS5zC+GmJpCE7GrXU
         CjtAHlbLK7Pa8Baohew7wQQtBipHPc3KuXamMTf7sPf4M3KjnPpVgh2zYH7L1GqXC7vB
         o/AA==
Received: by 10.204.156.87 with SMTP id v23mr4718902bkw.0.1346143865675;
        Tue, 28 Aug 2012 01:51:05 -0700 (PDT)
Received: from flobuntu.lan (91-115-85-203.adsl.highway.telekom.at. [91.115.85.203])
        by mx.google.com with ESMTPS id m9sm12047800bkm.10.2012.08.28.01.51.03
        (version=SSLv3 cipher=OTHER);
        Tue, 28 Aug 2012 01:51:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1346143790-23491-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204415>

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
