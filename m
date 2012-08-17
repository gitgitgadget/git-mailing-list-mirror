From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH/RFC v4 09/16] Allow reading svn dumps from files via file:// urls.
Date: Fri, 17 Aug 2012 22:25:50 +0200
Message-ID: <1345235157-702-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345235157-702-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 22:27:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2T8f-00061V-Pt
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 22:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758910Ab2HQU1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 16:27:15 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:46891 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758891Ab2HQU1A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 16:27:00 -0400
Received: by weyx8 with SMTP id x8so2687303wey.19
        for <git@vger.kernel.org>; Fri, 17 Aug 2012 13:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=FYO0c9RGxtt005k8KBaTjqySKTMgzDh49+ehRCRH5qI=;
        b=Fzu/L1icAHhqVvpd27i6xkCbcwS2QwUuHt8I6326YRvmPwjgzlc25xUGw0VLQKDlqJ
         RWnb58VAIZqcRXNtbjfl76xXovbLe4RkU2JevOR11HFncr61S+/HcyOzZARE6T707b9F
         aotRdqwIsLbi/5DlmeYDqE859wR4YyjVtqwjAqnONqRj2HRB/tWqfJotb2jfD6a3Qlus
         jR2LYSycuxnErAcoER3CZDE7PO0gKk4lVDZJqD9+JfnqmTbGyMUasCHkfcvJPSxBJKnN
         +OlQewu8Bf5nOpwLhRUWXrYeSKrBX6+DHBzyasq9bfD7AG4yOVbss/lvD3eg/IS8BjYj
         OvyA==
Received: by 10.180.75.209 with SMTP id e17mr10984059wiw.0.1345235218950;
        Fri, 17 Aug 2012 13:26:58 -0700 (PDT)
Received: from flobuntu.lan (91-115-81-15.adsl.highway.telekom.at. [91.115.81.15])
        by mx.google.com with ESMTPS id k2sm17372232wiz.7.2012.08.17.13.26.56
        (version=SSLv3 cipher=OTHER);
        Fri, 17 Aug 2012 13:26:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345235157-702-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203651>

For testing as well as for importing large, already
available dumps, it's useful to bypass svnrdump and
replay the svndump from a file directly.

Add support for file:// urls in the remote url.
e.g. svn::file:///path/to/dump
When the remote helper finds an url starting with
file:// it tries to open that file instead of invoking svnrdump.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 contrib/svn-fe/remote-svn.c |   55 ++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/contrib/svn-fe/remote-svn.c b/contrib/svn-fe/remote-svn.c
index b853d54..80a089a 100644
--- a/contrib/svn-fe/remote-svn.c
+++ b/contrib/svn-fe/remote-svn.c
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
