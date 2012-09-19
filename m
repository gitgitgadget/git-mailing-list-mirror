From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v8 09/16] Allow reading svn dumps from files via file:// urls
Date: Wed, 19 Sep 2012 17:21:23 +0200
Message-ID: <1348068090-31988-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1348068090-31988-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 17:23:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEM7f-0006Jl-Qy
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 17:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096Ab2ISPWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 11:22:52 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:32832 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755979Ab2ISPWq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 11:22:46 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so597401bkw.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 08:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=BtCOwfo0+kPGaNOzpkbazYG/J7DRYv3uV4M2cAXgUPA=;
        b=Gj1i2/XkPnY5pV+34triWBywCGUv3+r57F7PSC8qh6ccyMR47oBWYYry77F+IrbX6i
         oTeMW9Zk+GGGEYScUkxq4Lv2MfLjSfyLHUvkv7s5catnWXHjBrQewrqr+TIIimwL/HNk
         Ju+GHz06Qy8NfGdVfPlCBuH2qgIbXKgj4/ut6Rh3kLRmCuotcUMinOewSfNH91r3a85c
         ewJgL592H4E1XOVTDJ0B4uBF3iYTYVEa8Y9SwqtPgnefxnebQJUdkkqxTjjsOTadVSHZ
         xNGpQfFJafUWQV9BFfOOo7vISP+lYVra3JF4PaRAR3cTAvIeqq4kFZY2g8C4P6PpYRho
         FV6w==
Received: by 10.204.149.217 with SMTP id u25mr1413243bkv.107.1348068165257;
        Wed, 19 Sep 2012 08:22:45 -0700 (PDT)
Received: from flobuntu.lan (91-115-94-56.adsl.highway.telekom.at. [91.115.94.56])
        by mx.google.com with ESMTPS id d13sm1570686bkw.12.2012.09.19.08.22.41
        (version=SSLv3 cipher=OTHER);
        Wed, 19 Sep 2012 08:22:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1348068090-31988-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205936>

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
diff:
- style
- seperate strbufs in main.

 remote-testsvn.c |   52 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/remote-testsvn.c b/remote-testsvn.c
index c30ffcd..67466a9 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -9,6 +9,7 @@
 #include "argv-array.h"
 
 static const char *url;
+static int dump_from_file;
 static const char *private_ref;
 static const char *remote_ref = "refs/heads/master";
 
@@ -54,29 +55,36 @@ static int cmd_import(const char *line)
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
+		if(dumpin_fd < 0)
+			die_errno("Couldn't open svn dump file %s.", url);
+	} else {
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
+	if (!dump_from_file) {
+		code = finish_command(&svndump_proc);
+		if (code)
+			warning("%s, returned %d", svndump_proc.argv[0], code);
+		argv_array_clear(&svndump_argv);
+	}
 
 	return 0;
 }
@@ -151,8 +159,14 @@ int main(int argc, const char **argv)
 	remote = remote_get(argv[1]);
 	url_in = (argc == 3) ? argv[2] : remote->url[0];
 
-	end_url_with_slash(&url_sb, url_in);
-	url = url_sb.buf;
+	if (!prefixcmp(url_in, "file://")) {
+		dump_from_file = 1;
+		url = url_decode(url_in + sizeof("file://")-1);
+	} else {
+		dump_from_file = 0;
+		end_url_with_slash(&url_sb, url_in);
+		url = url_sb.buf;
+	}
 
 	strbuf_addf(&private_ref_sb, "refs/svn/%s/master", remote->name);
 	private_ref = private_ref_sb.buf;
-- 
1.7.9.5
