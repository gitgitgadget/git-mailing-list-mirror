From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v7 09/16] Allow reading svn dumps from files via file:// urls
Date: Tue, 28 Aug 2012 10:49:43 +0200
Message-ID: <1346143790-23491-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1346143790-23491-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 28 10:51:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6HWL-00022f-64
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 10:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983Ab2H1IvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 04:51:21 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42001 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807Ab2H1IvS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 04:51:18 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1532823bkw.19
        for <git@vger.kernel.org>; Tue, 28 Aug 2012 01:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=tk68sWbxM+rQIUPXrJq8ZkXhzlIfZoxb5tkyfyzulBM=;
        b=nU0n1fNufNECgioviZ1lMjggbAE+2pD201H9bBdizJeE2a1hWahB86R3JfjkMkaQu0
         piTxNwa0RPd5WTyRDXhnFGCi68OyekhMRVqNzUZXUwNhy511/l7AxUzjx6qBpkhKGZ4m
         7xeMl2b9nDTZBQ2Pwg1k3WcKGLHgYoK5vLDSjoE0W/ZKAaYjivmOf49hUgoZ5RldLQmo
         qujUWsAy8tmeAfsTC4UuLrAFyDVX3Fp+pUpVQLn71HyAVtBAdxmcOnDPsnBH+uPrErZI
         k8G8DCSB88X1TQWSwYcr7Br2yTT6IPNaYt1YCdaV5iqPoDxep6d6O5bGg4jIxb8YyYvT
         xvwA==
Received: by 10.204.129.23 with SMTP id m23mr4717492bks.28.1346143877660;
        Tue, 28 Aug 2012 01:51:17 -0700 (PDT)
Received: from flobuntu.lan (91-115-85-203.adsl.highway.telekom.at. [91.115.85.203])
        by mx.google.com with ESMTPS id m9sm12047800bkm.10.2012.08.28.01.51.15
        (version=SSLv3 cipher=OTHER);
        Tue, 28 Aug 2012 01:51:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1346143790-23491-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204408>

For testing as well as for importing large, already available dumps,
it's useful to bypass svnrdump and replay the svndump from a file
directly.

Add support for file:// urls in the remote url, e.g.

  svn::file:///path/to/dump

When the remote helper finds an url starting with file:// it tries to
open that file instead of invoking svnrdump.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote-testsvn.c |   55 +++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/remote-testsvn.c b/remote-testsvn.c
index ebe803b..2b9d151 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -9,6 +9,7 @@
 #include "argv-array.h"
 
 static const char *url;
+static int dump_from_file;
 static const char *private_ref;
 static const char *remote_ref = "refs/heads/master";
 
@@ -53,29 +54,38 @@ static int cmd_import(const char *line)
 	struct argv_array svndump_argv = ARGV_ARRAY_INIT;
 	struct child_process svndump_proc;
 
-	memset(&svndump_proc, 0, sizeof(struct child_process));
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
+	if (dump_from_file) {
+		dumpin_fd = open(url, O_RDONLY);
+		if(dumpin_fd < 0) {
+			die_errno("Couldn't open svn dump file %s.", url);
+		}
+	}
+	else {
+		memset(&svndump_proc, 0, sizeof(struct child_process));
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
@@ -149,8 +159,15 @@ int main(int argc, const char **argv)
 	remote = remote_get(argv[1]);
 	url_in = (argc == 3) ? argv[2] : remote->url[0];
 
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
