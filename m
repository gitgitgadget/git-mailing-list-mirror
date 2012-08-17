From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH/RFC v4 04/16] Add argv_array_detach and argv_array_free_detached.
Date: Fri, 17 Aug 2012 22:25:45 +0200
Message-ID: <1345235157-702-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345235157-702-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 22:27:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2T8I-0005Xc-4a
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 22:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758886Ab2HQU0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 16:26:54 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:58829 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758881Ab2HQU0s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 16:26:48 -0400
Received: by mail-we0-f174.google.com with SMTP id x8so2687136wey.19
        for <git@vger.kernel.org>; Fri, 17 Aug 2012 13:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=KtNDEqVmliKWgmsHuF+sHHJ7i9W6B/u+9bRXsVgzCKs=;
        b=wjK2l/Z7lv25h3fx1oDRLWVubaaqarsqwozCQvyljc76FvFw1Z99N8unhODi9XvwU4
         nfLTEraiyzrOANZ4hZOA1eKCX3t8xASTqwKOcMHfd3LDHkUbSZEjd4vikIg44ly2aa1t
         aOBHwWEpZi8r0w135B0pZQYt85ggo5kMQLGYNqIPwSPiBheS/rtvGGiQWwL+4GMo5Iky
         0rzezfJc0sr3Ep9pfkdJVrhsilqYi4bvoSLS8RH977plGCOus4N9Jo5Q4JkFjfL8UtLc
         kHCzOvbnr9pGUBXI9UGsYpdqXde9sEQ4Dl5qHZav/zad4LOT+YmFdOVo5zRiWZ2Wjgwg
         07ig==
Received: by 10.216.85.149 with SMTP id u21mr2977603wee.147.1345235208006;
        Fri, 17 Aug 2012 13:26:48 -0700 (PDT)
Received: from flobuntu.lan (91-115-81-15.adsl.highway.telekom.at. [91.115.81.15])
        by mx.google.com with ESMTPS id k2sm17372232wiz.7.2012.08.17.13.26.46
        (version=SSLv3 cipher=OTHER);
        Fri, 17 Aug 2012 13:26:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345235157-702-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203647>

Allow detaching of ownership of the argv_array's contents and
add a function to free those detached argv_arrays later.

This makes it possible to use argv_array efficiently with the
exiting struct child_process which only contains a member
char **argv.

Add to documentation.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
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
