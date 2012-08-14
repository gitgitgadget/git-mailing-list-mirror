From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH/RFC v3 08/16] Allow reading svn dumps from files via file:// urls.
Date: Tue, 14 Aug 2012 21:13:10 +0200
Message-ID: <1344971598-8213-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1344971598-8213-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 21:17:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1McL-0003cZ-2W
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 21:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756648Ab2HNTRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 15:17:21 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44490 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756588Ab2HNTRS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 15:17:18 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so265503bkw.19
        for <git@vger.kernel.org>; Tue, 14 Aug 2012 12:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=H5q2g4FLC4PSs3P192dtbQ/pwI65G4yHcTObB01e6Zk=;
        b=fH02Lg+V060w7WdUzCDB79zVeZKjDx6fTa6IOtFkqmj6QUBq4Op7VfyWDrDgT/bnXq
         6Zp0HxMJyBY0+vTTLU/LX1E0px+BgB2t2Ez4TVg3YhidComS+Duf7K0lCfKxrYMiVJ3L
         tPGzpGvGcOFY1rDqP/TnSOqImT0nU4RmBjxcqfPkPrm4hpDvoJZAejJIYnIk/1nDd74l
         IBbPvLgyZuXaVxkhdp/vaXYZz3cr8oUARjbonMf74KJqTCpOV37JUqvkef9HgU8TRjhY
         mz66pf4FuK+GMFYvJ+Hb/oL6GJdJtsYSZKsuDFU+xB79/8PrQVh7ZYlhuYH1YWdbJRdc
         EEWQ==
Received: by 10.205.122.147 with SMTP id gg19mr6707557bkc.73.1344971837759;
        Tue, 14 Aug 2012 12:17:17 -0700 (PDT)
Received: from localhost.localdomain (089144206125.atnat0015.highway.a1.net. [89.144.206.125])
        by mx.google.com with ESMTPS id fu8sm1681583bkc.5.2012.08.14.12.17.13
        (version=SSLv3 cipher=OTHER);
        Tue, 14 Aug 2012 12:17:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1344971598-8213-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203432>

For testing as well as for importing large, already
available dumps, it's useful to bypass svnrdump and
replay the svndump from a file directly.

Add support for file:// urls in the remote url.
e.g. svn::file:///path/to/dump
When the remote helper finds an url starting with
file:// it tries to open that file instead of invoking svnrdump.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 contrib/svn-fe/remote-svn.c |   59 ++++++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 23 deletions(-)

diff --git a/contrib/svn-fe/remote-svn.c b/contrib/svn-fe/remote-svn.c
index ce59344..df1babc 100644
--- a/contrib/svn-fe/remote-svn.c
+++ b/contrib/svn-fe/remote-svn.c
@@ -10,6 +10,7 @@
 #include "argv-array.h"
 
 static const char *url;
+static int dump_from_file;
 static const char *private_ref;
 static const char *remote_ref = "refs/heads/master";
 
@@ -54,34 +55,39 @@ static int cmd_import(const char *line)
 	struct argv_array svndump_argv = ARGV_ARRAY_INIT;
 	struct child_process svndump_proc;
 
-	memset(&svndump_proc, 0, sizeof (struct child_process));
-	svndump_proc.out = -1;
-	argv_array_push(&svndump_argv, "svnrdump");
-	argv_array_push(&svndump_argv, "dump");
-	argv_array_push(&svndump_argv, url);
-	argv_array_pushf(&svndump_argv, "-r%u:HEAD", startrev);
-	svndump_proc.argv = svndump_argv.argv;
-
-	code = start_command(&svndump_proc);
-	if (code)
-		die("Unable to start %s, code %d", svndump_proc.argv[0], code);
-	dumpin_fd = svndump_proc.out;
-
-	code = start_command(&svndump_proc);
-	if (code)
-		die("Unable to start %s, code %d", svndump_proc.argv[0], code);
-	dumpin_fd = svndump_proc.out;
+	if(dump_from_file) {
+		dumpin_fd = open(url, O_RDONLY);
+		if(dumpin_fd < 0) {
+			die_errno("Couldn't open svn dump file %s.", url);
+		}
+	}
+	else {
+		memset(&svndump_proc, 0, sizeof (struct child_process));
+		svndump_proc.out = -1;
+		argv_array_push(&svndump_argv, "svnrdump");
+		argv_array_push(&svndump_argv, "dump");
+		argv_array_push(&svndump_argv, url);
+		argv_array_pushf(&svndump_argv, "-r%u:HEAD", startrev);
+		svndump_proc.argv = svndump_argv.argv;
+
+		code = start_command(&svndump_proc);
+		if (code)
+			die("Unable to start %s, code %d", svndump_proc.argv[0], code);
+		dumpin_fd = svndump_proc.out;
 
+	}
 	svndump_init_fd(dumpin_fd, STDIN_FILENO);
 	svndump_read(url, private_ref);
 	svndump_deinit();
 	svndump_reset();
 
 	close(dumpin_fd);
-	code = finish_command(&svndump_proc);
-	if (code)
-		warning("%s, returned %d", svndump_proc.argv[0], code);
-	argv_array_clear(&svndump_argv);
+	if(!dump_from_file) {
+		code = finish_command(&svndump_proc);
+		if (code)
+			warning("%s, returned %d", svndump_proc.argv[0], code);
+		argv_array_clear(&svndump_argv);
+	}
 
 	return 0;
 }
@@ -158,8 +164,15 @@ int main(int argc, const char **argv)
 	if (argc == 3)
 		url_in = argv[2];
 
-	end_url_with_slash(&buf, url_in);
-	url = strbuf_detach(&buf, NULL);
+	if (!prefixcmp(url_in, "file://")) {
+		dump_from_file = 1;
+		url = url_decode(url_in + sizeof("file://")-1);
+	}
+	else {
+		dump_from_file = 0;
+		end_url_with_slash(&buf, url_in);
+		url = strbuf_detach(&buf, NULL);
+	}
 
 	strbuf_addf(&buf, "refs/svn/%s/master", remote->name);
 	private_ref = strbuf_detach(&buf, NULL);
-- 
1.7.9.5
