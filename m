From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v6 09/16] Allow reading svn dumps from files via file:// urls
Date: Wed, 22 Aug 2012 21:15:54 +0200
Message-ID: <1345662961-9587-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345662961-9587-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 21:17:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4GQK-0001jV-Oh
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 21:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059Ab2HVTQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 15:16:55 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46610 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964997Ab2HVTQr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 15:16:47 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so449679bkw.19
        for <git@vger.kernel.org>; Wed, 22 Aug 2012 12:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=tk68sWbxM+rQIUPXrJq8ZkXhzlIfZoxb5tkyfyzulBM=;
        b=Ie/+uNB/WfAmV36fwlIpfuaSoQ2k/c4TSKxj2hw8LZz7Ytt0fs6WA/q0V7ALrt6Q4u
         hO4K+iZsKAQS8WKxIag9p86+TA5v7QseRofWfIRQx2GBasMgc3FLmvuxNIJ/kEmlwdWU
         kRWhhB2JhqdJ08Mcx6Vb1n2Gr8rEh7mY4OlyILIsmHANrjaYkc9stRm97+tkg8Dz/R2o
         SdgDiYpxVDyDco1RkcKTCVB+2RlwlXIkiR6G1Em1yozAwZZJe6XwGC+RAzDFwUYN+dqF
         AS3h4TUsMeBLTguI8KMTHrYQM1pb5FnP7aUS+eMtDRq7r+byFxQxQK/TpfklrY6TW1wq
         Ne1A==
Received: by 10.204.129.14 with SMTP id m14mr6856221bks.7.1345663006362;
        Wed, 22 Aug 2012 12:16:46 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id ht18sm3346763bkc.16.2012.08.22.12.16.44
        (version=SSLv3 cipher=OTHER);
        Wed, 22 Aug 2012 12:16:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345662961-9587-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204075>

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
