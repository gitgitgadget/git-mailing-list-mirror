From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC v2 07/16] Allow reading svn dumps from files via file:// urls.
Date: Mon, 30 Jul 2012 16:31:14 +0200
Message-ID: <1343658683-10713-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 16:40:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svr8m-0008J8-Pu
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 16:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754742Ab2G3Oj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 10:39:26 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39226 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754734Ab2G3OjX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 10:39:23 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so2859087bkw.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 07:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=fvGnwyHpX2d24mWQD+HUzNMBYU4LVElcX/VcdiZQQhM=;
        b=CxAvzIgEizzbvbQMhshww62CKEaB2aL99RcUrDoQhjIq5R2lMUbuiqgN42/y3DtisF
         +CyMoNaayu5PbkAqSinyAguMYZYRLRL99IzKIGCMlvTPsdxJ8JmciD/3Y6iy+L3L5Ulf
         lvZIFEjAOFuXk9rX7fhjUJVZPujmnUul2AhloWz65k3NG9HMjasfxk9EOgRZOmP21AmJ
         U8LU/VbTRz12Bprw0z+w22SQ1JKCaKr4SE8cnaNWYmn9WTcme8epcq3vkk/c2wu74Wtj
         MEkCEpUz8eTh2ZTQI2TJSziMREYXohJIoZGc+PVW5EUxHaAdxhnuwgjWVnsD+9lt+0/l
         TSfQ==
Received: by 10.204.157.144 with SMTP id b16mr3916524bkx.122.1343659162846;
        Mon, 30 Jul 2012 07:39:22 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id fu8sm3945866bkc.5.2012.07.30.07.39.21
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jul 2012 07:39:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1343658683-10713-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202560>

For testing as well as for importing large, already
available dumps, it's useful to bypass svnrdump and
replay the svndump from a file directly.

Add support for file:// urls in the remote url.
e.g. svn::file:///path/to/dump
When the remote helper finds an url starting with
file:// it tries to open that file instead of invoking svnrdump.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 contrib/svn-fe/remote-svn.c |   54 +++++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/contrib/svn-fe/remote-svn.c b/contrib/svn-fe/remote-svn.c
index d5c2df8..9dcf78b 100644
--- a/contrib/svn-fe/remote-svn.c
+++ b/contrib/svn-fe/remote-svn.c
@@ -9,6 +9,7 @@
 #include "argv-array.h"
 
 static const char *url;
+static int dump_from_file;
 static const char *private_ref;
 static const char *remote_ref = "refs/heads/master";
 
@@ -74,18 +75,28 @@ int cmd_import(struct strbuf *line)
 		die("Unable to open fast-import back-pipe! %s", strerror(errno));
 	}
 
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
@@ -94,10 +105,12 @@ int cmd_import(struct strbuf *line)
 
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
 
 	return 0;
 }
@@ -164,8 +177,15 @@ int main(int argc, const char **argv)
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
 
 	strbuf_init(&buf, 0);
 	strbuf_addf(&buf, "refs/svn/%s/master", remote->name);
-- 
1.7.9.5
