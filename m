From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v8 04/16] Add argv_array_detach and argv_array_free_detached
Date: Wed, 19 Sep 2012 17:21:18 +0200
Message-ID: <1348068090-31988-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1348068090-31988-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 17:22:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEM6v-0005ul-Bj
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 17:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755557Ab2ISPWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 11:22:35 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64575 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755552Ab2ISPWc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 11:22:32 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so596995bkw.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 08:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=8ap7qwxZ7g0reYLov+PYfh7KrxJlaaWLtaCaJdbFlpY=;
        b=lOlV8T/bSwmW/u1QpREMl+2rBIttk2h/jOJZB1z+WLCwzC8e/pvxgbhtKTC0QSeANA
         iNu8V51gQQMMSGgrvyVLemQgejf0sr7Qz35su10s03sbzMHXw6RIjjd6J+A1FbHZuSSD
         t7ktXsZFPCDYgYNTVjaQbzwIyOackLpSYCKFaJnKbajeLS74zH88G7DJekD3eO3A4KC3
         EMzIuIdlAXmIJWan51QJ4oUKaCSWJTOqEJCRq1W3QdcBDGhB72R9bSyDxl8yEQKM+EU7
         EOd0arH606MKM2wtYH7P6f7IeKmlDN397hTIUxxS0AnqHUlllJ9qCTGw9tmIqoc/31C1
         nnWQ==
Received: by 10.204.152.136 with SMTP id g8mr1431872bkw.44.1348068151796;
        Wed, 19 Sep 2012 08:22:31 -0700 (PDT)
Received: from flobuntu.lan (91-115-94-56.adsl.highway.telekom.at. [91.115.94.56])
        by mx.google.com with ESMTPS id d13sm1570686bkw.12.2012.09.19.08.22.29
        (version=SSLv3 cipher=OTHER);
        Wed, 19 Sep 2012 08:22:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1348068090-31988-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205931>

Allow detaching of ownership of the argv_array's contents and add a
function to free those detached argv_arrays later.

This makes it possible to use argv_array efficiently with the exiting
struct child_process which only contains a member char **argv.

Add to documentation.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
no diff

 Documentation/technical/api-argv-array.txt |    8 ++++++++
 argv-array.c                               |   20 ++++++++++++++++++++
 argv-array.h                               |    2 ++
 3 files changed, 30 insertions(+)

diff --git a/Documentation/technical/api-argv-array.txt b/Documentation/technical/api-argv-array.txt
index 1a79781..a959517 100644
--- a/Documentation/technical/api-argv-array.txt
+++ b/Documentation/technical/api-argv-array.txt
@@ -53,3 +53,11 @@ Functions
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
index 256741d..9e960d5 100644
--- a/argv-array.c
+++ b/argv-array.c
@@ -68,3 +68,23 @@ void argv_array_clear(struct argv_array *array)
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
index f4b9866..40248d4 100644
--- a/argv-array.h
+++ b/argv-array.h
@@ -18,5 +18,7 @@ void argv_array_pushf(struct argv_array *, const char *fmt, ...);
 void argv_array_pushl(struct argv_array *, ...);
 void argv_array_pop(struct argv_array *);
 void argv_array_clear(struct argv_array *);
+const char **argv_array_detach(struct argv_array *array, int *argc);
+void argv_array_free_detached(const char **argv);
 
 #endif /* ARGV_ARRAY_H */
-- 
1.7.9.5
