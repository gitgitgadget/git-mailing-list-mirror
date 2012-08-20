From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v5 09/16] Allow reading svn dumps from files via file:// urls
Date: Mon, 20 Aug 2012 23:52:15 +0200
Message-ID: <1345499542-15536-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345499542-15536-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 23:53:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3Zua-0008Es-2m
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 23:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755909Ab2HTVxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 17:53:23 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:60643 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755883Ab2HTVxU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 17:53:20 -0400
Received: by mail-wi0-f170.google.com with SMTP id hq12so3844314wib.1
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 14:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=tk68sWbxM+rQIUPXrJq8ZkXhzlIfZoxb5tkyfyzulBM=;
        b=LestdI+SvNhzOpIPqPiJb3sKmyiCb7Fxvkk5mQCCiDaSYjmU95pc0XSWn7NfbYwzq+
         VknbyJ0gSX9LdFx9ugC6UjLjallabkioejrtR+jb2mWKkU3A/JnW7FIfVzXD63c+soT+
         Hhvtls5iupAfahelqZ487m918cqPVbvEb1GPBEHcGnKj4fnLSEi+y6yB+YwSlEfuer1d
         0DJNcplyzETK6V85aijn3RHrRu//DEZ04KwPtZqAFQPK9iXuJ2+ZS5OiyLM6Bae8xHzP
         TE8R571BS/RzHFARrtNM4oAsdawhyXgkojSR8dwUa9Fmwt0IusgFDB2xK3SjYgKfcWEx
         e0ZA==
Received: by 10.216.241.198 with SMTP id g48mr8466407wer.156.1345499599506;
        Mon, 20 Aug 2012 14:53:19 -0700 (PDT)
Received: from flomedio.lan (91-115-90-54.adsl.highway.telekom.at. [91.115.90.54])
        by mx.google.com with ESMTPS id w7sm30196654wiz.0.2012.08.20.14.53.17
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 14:53:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345499542-15536-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203879>

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
