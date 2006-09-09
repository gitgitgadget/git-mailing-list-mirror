From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] git-archive: make compression level of ZIP archives configurable
Date: Sat, 09 Sep 2006 17:02:38 +0200
Message-ID: <4502D78E.3050006@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 09 17:02:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GM4M1-0007Nf-HF
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 17:02:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWIIPCk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 11:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWIIPCk
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 11:02:40 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:35029
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S932249AbWIIPCh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Sep 2006 11:02:37 -0400
Received: from [10.0.1.3] (p508E5573.dip.t-dialin.net [80.142.85.115])
	by neapel230.server4you.de (Postfix) with ESMTP id B5DBE8006;
	Sat,  9 Sep 2006 17:02:36 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Junio C Hamano <junkio@cox.net>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26754>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

diff --git a/archive.h b/archive.h
index f3d344b..d8cca73 100644
--- a/archive.h
+++ b/archive.h
@@ -42,5 +42,6 @@ extern void parse_pathspec_arg(const cha
  */
 extern int write_tar_archive(struct archiver_args *);
 extern int write_zip_archive(struct archiver_args *);
+extern void *parse_extra_zip_args(int argc, const char **argv);
 
 #endif	/* ARCHIVE_H */
diff --git a/builtin-archive.c b/builtin-archive.c
index 6ef2c90..83e5589 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -15,8 +15,15 @@ static const char archive_usage[] =
 "git-archive --format=<fmt> [--prefix=<prefix>/] [<extra>] <tree-ish> [path...]";
 
 struct archiver archivers[] = {
-	{ .name = "tar", .write_archive = write_tar_archive },
-	{ .name = "zip", .write_archive = write_zip_archive },
+	{
+		.name		= "tar",
+		.write_archive	= write_tar_archive,
+	},
+	{
+		.name		= "zip",
+		.write_archive	= write_zip_archive,
+		.parse_extra	= parse_extra_zip_args,
+	},
 };
 
 static int run_remote_archiver(struct archiver *ar, int argc, const char **argv)
diff --git a/builtin-zip-tree.c b/builtin-zip-tree.c
index 23b4de5..fdac2bd 100644
--- a/builtin-zip-tree.c
+++ b/builtin-zip-tree.c
@@ -379,3 +379,16 @@ int write_zip_archive(struct archiver_ar
 
 	return 0;
 }
+
+void *parse_extra_zip_args(int argc, const char **argv)
+{
+	for (; argc > 0; argc--, argv++) {
+		const char *arg = argv[0];
+
+		if (arg[0] == '-' && isdigit(arg[1]) && arg[2] == '\0')
+			zlib_compression_level = arg[1] - '0';
+		else
+			die("Unknown argument for zip format: %s", arg);
+	}
+	return NULL;
+}
