From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v5 04/16] Add argv_array_detach and argv_array_free_detached
Date: Mon, 20 Aug 2012 23:52:10 +0200
Message-ID: <1345499542-15536-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345499542-15536-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 23:53:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3Zua-0008Es-Ur
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 23:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755931Ab2HTVxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 17:53:25 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:43593 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755843Ab2HTVxK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 17:53:10 -0400
Received: by weyx8 with SMTP id x8so4177354wey.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 14:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=iE8g7Iixx3s6n12vMMasO9d5lxokH8IhGjUS4l7wMEE=;
        b=WsBXMRG+Vuh2nAMryMnfyTSyh18Ra8YvuSFw1nFBoadTktns7pv0F9/6kAfz4C/5/Y
         Fo9suAJjhhv03ZIwgi0FkTEXYWyvUT/+6SlNG4N53xcel/4VlGix185dlmjG2953RKfw
         aPIXB+F2sZ3XDB1RGkVN6nItnFrWT9JWhYSJ5KUZ9az1+4oBKPryzXSFPJbTkybRTtrf
         94AylaSgMF628dKp6I5J0Sd42swj5WM7tb0F8oGZFx4OlRlpQqtXJSoZxF0yzyX7xks6
         whEo+fyddSc4H/mXBPJxfLoC7lPPsADk+o1PMig5b+WttPRnwRjqRgmnO4eZ7MvP/3YA
         +TaQ==
Received: by 10.180.84.1 with SMTP id u1mr32325947wiy.15.1345499589815;
        Mon, 20 Aug 2012 14:53:09 -0700 (PDT)
Received: from flomedio.lan (91-115-90-54.adsl.highway.telekom.at. [91.115.90.54])
        by mx.google.com with ESMTPS id w7sm30196654wiz.0.2012.08.20.14.53.08
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 14:53:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345499542-15536-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203882>

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
