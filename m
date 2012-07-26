From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 07/16] Allow reading svn dumps from files via file:// urls.
Date: Thu, 26 Jul 2012 09:32:28 +0200
Message-ID: <1343287957-22040-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 09:34:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuIao-0004t5-SZ
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 09:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813Ab2GZHej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 03:34:39 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58737 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547Ab2GZHee (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 03:34:34 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1067267bkw.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 00:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ruay5JCmE+5W/wY6/xpl58OZ1296LDKXFWVGGjIJxx0=;
        b=uT4cc7vaAf0YsUmGR8OqQg/09748IO6RZwINqsbdhqHMV6yV3E3Xo+Q0PSuArJqsQ+
         3m1ekKqhP3jUlaZJpqvhVxKUSIZAaK61N0sOMJJmGSuj1G6DkxT8tYk3PkAHVWImRTax
         ezsiK3l0qitwjmS9k8b0mgGhEP4ihIQVxGS0thALFSIMop6Nz9pgd6oyT8khxC8jKynS
         BYA3SSqRB04WQFiJX9wGJj6qLdfcU/BXoC7rczTvK8KTemDYCZx2ria6odwDyiCxCnKB
         obgz7x9E5dy56KlHcpmwlVnG/qYqThHJ/dvHcTAJTschP4F84KbZJwKQ/oQzzyss7xhV
         NVhA==
Received: by 10.204.153.10 with SMTP id i10mr13085612bkw.67.1343288073907;
        Thu, 26 Jul 2012 00:34:33 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id n5sm13880348bkv.14.2012.07.26.00.34.31
        (version=SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 00:34:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1343287957-22040-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202237>

For testing as well as for importing large, already
available dumps, it's useful to bypass svnrdump and
replay the svndump from a file directly.

Add support for file:// urls in the remote url.
e.g. svn::file:///path/to/dump
When the remote helper finds an url starting with
file:// it tries to open that file instead of invoking svnrdump.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 contrib/svn-fe/remote-svn.c |   56 +++++++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/contrib/svn-fe/remote-svn.c b/contrib/svn-fe/remote-svn.c
index 29fc371..862b739 100644
--- a/contrib/svn-fe/remote-svn.c
+++ b/contrib/svn-fe/remote-svn.c
@@ -23,6 +23,7 @@ static inline void printd(const char *fmt, ...)
 }
 
 static const char *url;
+static int dump_from_file;
 static const char *private_ref;
 static const char *remote_ref = "refs/heads/master";
 
@@ -105,18 +106,28 @@ enum cmd_result cmd_import(struct strbuf *line)
 	}
 	printd("Opened fast-import back-pipe %s for reading.", back_pipe_env);
 
-	memset(&svndump_proc, 0, sizeof (struct child_process));
-	svndump_proc.out = -1;
-	argv_array_push(&svndump_argv, "svnrdump");
-	argv_array_push(&svndump_argv, "dump");
-	argv_array_push(&svndump_argv, url);
-	argv_array_pushf(&svndump_argv, "-r%u:HEAD", startrev);
-	svndump_proc.argv = svndump_argv.argv;
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
+
+	}
 
-	code = start_command(&svndump_proc);
-	if (code)
-		die("Unable to start %s, code %d", svndump_proc.argv[0], code);
-	dumpin_fd = svndump_proc.out;
 
 	svndump_init_fd(dumpin_fd, report_fd);
 	svndump_read(url, private_ref);
@@ -125,10 +136,12 @@ enum cmd_result cmd_import(struct strbuf *line)
 
 	close(dumpin_fd);
 	close(report_fd);
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
 
 	return SUCCESS;
 }
@@ -191,9 +204,16 @@ int main(int argc, const char **argv)
 	else
 		warning("Excess arguments!");
 
-	end_url_with_slash(&buf, url);
-	url = strbuf_detach(&buf, NULL);
-
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
 
 	strbuf_init(&buf, 0);
-- 
1.7.9.5
