From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH 2/4] Allow reading svn dumps from files via file:// urls.
Date: Wed, 11 Jul 2012 15:38:51 +0200
Message-ID: <1342013933-14381-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1342013933-14381-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1342013933-14381-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 15:40:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sox9H-0008Gl-BA
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 15:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757828Ab2GKNjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 09:39:52 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35780 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757822Ab2GKNjt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 09:39:49 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1074961bkw.19
        for <git@vger.kernel.org>; Wed, 11 Jul 2012 06:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mGmvOYuRxC7Wc2tQZnfQvSdq7CD12ZdsHWcRvAxz0v8=;
        b=qTRjFyP9wONYn2iffOh/mGIUAKo7a2WlGEibDJnAjo9e67DOzgEiNbFLp3nJcSJMdt
         uIYfK/Da7iBhaBed+gvRtU5HKeK/hNhJUsRxBVJV3B/Mrgi7Oa2Z8NXHeegf3TQbPOis
         6OQrFyw/de1m9q7QAmmSH25M8TKkp3OxGTdtTIj0EZBNh6k+yD1x4sK9sIt3xiHwiR+9
         zrpthnjK38lV71/8pxmiYrlnmFRZEuxx2pb+LYXlADqo5bIK5RO6tJ1YN2keSx6/btYp
         r1hbRyX6+tLDLBA9sRpSHVMUkXx3MkL7glSa8kou6sdLf0Yf9Z1sKnncmuhcDEardGsD
         DAGA==
Received: by 10.204.129.208 with SMTP id p16mr6077207bks.129.1342013988966;
        Wed, 11 Jul 2012 06:39:48 -0700 (PDT)
Received: from flobuntu.lan (91-115-86-162.adsl.highway.telekom.at. [91.115.86.162])
        by mx.google.com with ESMTPS id fu8sm1207082bkc.5.2012.07.11.06.39.47
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Jul 2012 06:39:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1342013933-14381-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201296>

Especially for testing and development it's useful
to bypass svnrdump and replay the svndump from a file
without connecting to an svn server.

Add support for file:// urls in the remote url.
e.g. svn::file:///path/to/dump
When the remote helper finds an url starting with
file:// it tries to open that file instead of invoking svnrdump.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 contrib/svn-fe/remote-svn.c |   53 +++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/contrib/svn-fe/remote-svn.c b/contrib/svn-fe/remote-svn.c
index 5ec7fbb..a248166 100644
--- a/contrib/svn-fe/remote-svn.c
+++ b/contrib/svn-fe/remote-svn.c
@@ -26,6 +26,7 @@ static inline void printd(const char* fmt, ...)
 
 static struct remote* remote;
 static const char* url;
+static int dump_from_file;
 const char* private_refs = "refs/remote-svn/";		/* + remote->name. */
 const char* remote_ref = "refs/heads/master";
 
@@ -56,6 +57,7 @@ enum cmd_result cmd_import(struct strbuf* line)
 	const char* revs = "-r0:HEAD";
 	int code, report_fd;
 	char* back_pipe_env;
+	int dumpin_fd;
 	struct child_process svndump_proc = {
 			.argv = NULL,		/* comes later .. */
 			/* we want a pipe to the child's stdout, but stdin, stderr inherited.
@@ -90,27 +92,35 @@ enum cmd_result cmd_import(struct strbuf* line)
 
 	printd("Opened fast-import back-pipe %s for reading.", back_pipe_env);
 
-	svndump_proc.argv = xcalloc(5, sizeof(char*));
-	svndump_proc.argv[0] = "svnrdump";
-	svndump_proc.argv[1] = "dump";
-	svndump_proc.argv[2] = url;
-	svndump_proc.argv[3] = revs;
-
-	code = start_command(&svndump_proc);
-	if(code)
-		die("Unable to start %s, code %d", svndump_proc.argv[0], code);
-
+	if(dump_from_file) {
+		dumpin_fd = open(url, O_RDONLY);
+		if(dumpin_fd < 0) {
+			die_errno("Couldn't open svn dump file %s.", url);
+		}
+	}
+	else {
+		svndump_proc.argv = xcalloc(5, sizeof(char*));
+		svndump_proc.argv[0] = "svnrdump";
+		svndump_proc.argv[1] = "dump";
+		svndump_proc.argv[2] = url;
+		svndump_proc.argv[3] = revs;
+
+		code = start_command(&svndump_proc);
+		if(code)
+			die("Unable to start %s, code %d", svndump_proc.argv[0], code);
+		dumpin_fd = svndump_proc.out;
+	}
 
 
-	svndump_init_fd(svndump_proc.out, report_fd);
+	svndump_init_fd(dumpin_fd, report_fd);
 	svndump_read(url);
 	svndump_deinit();
 	svndump_reset();
 
-	close(svndump_proc.out);
+	close(dumpin_fd);
 	close(report_fd);
-
-	code = finish_command(&svndump_proc);
+	if(!dump_from_file)
+		code = finish_command(&svndump_proc);
 	if(code)
 		warning("Something went wrong with termination of %s, code %d", svndump_proc.argv[0], code);
 	free(svndump_proc.argv);
@@ -166,14 +176,23 @@ int main(int argc, const char **argv)
 
 	remote = remote_get(argv[1]);
 	if (argc == 3) {
-		end_url_with_slash(&buf, argv[2]);
+		url = argv[2];
 	} else if (argc == 2) {
-		end_url_with_slash(&buf, remote->url[0]);
+		url = remote->url[0];
 	} else {
 		warning("Excess arguments!");
 	}
 
-	url = strbuf_detach(&buf, NULL);
+	if (!prefixcmp(url, "file://")) {
+		dump_from_file = 1;
+		url = url_decode(url + sizeof("file://")-1);
+		printd("remote-svn uses a file as dump input.");
+	}
+	else {
+		dump_from_file = 0;
+		end_url_with_slash(&buf, url);
+		url = strbuf_detach(&buf, NULL);
+	}
 
 	printd("remote-svn starting with url %s", url);
 
-- 
1.7.9.5
