From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] git-upload-archive: add config option to allow only specified formats
Date: Sun, 10 Sep 2006 17:58:38 +0200
Message-ID: <20060910155837.GA15974@lsrfire.ath.cx>
References: <7vpse4tcyc.fsf@assigned-by-dhcp.cox.net> <7vk64ctctv.fsf@assigned-by-dhcp.cox.net> <7v1wqkt2v4.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 10 17:58:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMRhk-0000Tj-Ku
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 17:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWIJP6j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 11:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWIJP6j
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 11:58:39 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:5322
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S932267AbWIJP6j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 11:58:39 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 0B9A712279; Sun, 10 Sep 2006 17:58:38 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>
Content-Disposition: inline
In-Reply-To: <7v1wqkt2v4.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26798>

 Documentation/config.txt |    5 +++++
 builtin-upload-archive.c |   39 +++++++++++++++++++++++++++++++++++++++
 daemon.c                 |    2 ++
 3 files changed, 46 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ce722a2..5c3c6c7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -236,6 +236,11 @@ tar.umask::
 	the same permissions as gitlink:git-checkout[1] would use. The default
 	value remains 0, which means world read-write.
 
+uploadarchive.daemonformats::
+	A comma-separated list of the git-archive formats allowed for upload
+	via git-daemon.  If this parameter is missing all formats are allowed
+	for upload.
+
 user.email::
 	Your email address to be recorded in any newly created commits.
 	Can be overridden by the 'GIT_AUTHOR_EMAIL' and 'GIT_COMMITTER_EMAIL'
diff --git a/builtin-upload-archive.c b/builtin-upload-archive.c
index 96f96bd..6a5245a 100644
--- a/builtin-upload-archive.c
+++ b/builtin-upload-archive.c
@@ -16,6 +16,37 @@ static const char upload_archive_usage[]
 static const char deadchild[] =
 "git-upload-archive: archiver died with error";
 
+static char *daemon_formats;
+
+static int upload_format_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "uploadarchive.daemonformats"))
+		daemon_formats = xstrdup(value);
+	return 0;
+}
+
+static int is_in(const char *needle, const char *haystack, const char *delim)
+{
+	int len = strlen(needle);
+	const char *search = haystack;
+
+	for (;;) {
+		char *pos = strstr(search, needle);
+		if (!pos)
+			return 0;
+		search++;
+		if ((pos == haystack || strchr(delim, pos[-1])) &&
+		    (pos[len] == '\0' || strchr(delim, pos[len])))
+			return 1;
+	}
+}
+
+static int upload_format_allowed(const char *fmt)
+{
+	if (getenv("GIT_DAEMON"))
+		return daemon_formats ? is_in(fmt, daemon_formats, " \t,") : 1;
+	return 1;
+}
 
 static int run_upload_archive(int argc, const char **argv, const char *prefix)
 {
@@ -38,6 +69,8 @@ static int run_upload_archive(int argc, 
 	if (!enter_repo(buf, 0))
 		die("not a git archive");
 
+	git_config(upload_format_config);
+
 	/* put received options in sent_argv[] */
 	sent_argc = 1;
 	sent_argv[0] = "git-upload-archive";
@@ -67,6 +100,12 @@ static int run_upload_archive(int argc, 
 	/* parse all options sent by the client */
 	treeish_idx = parse_archive_args(sent_argc, sent_argv, &ar);
 
+	if (!upload_format_allowed(ar.name)) {
+		free(daemon_formats);
+		die("upload of %s format forbidden\n", ar.name);
+	}
+	free(daemon_formats);
+
 	parse_treeish_arg(sent_argv + treeish_idx, &ar.args, prefix);
 	parse_pathspec_arg(sent_argv + treeish_idx + 1, &ar.args);
 
diff --git a/daemon.c b/daemon.c
index a2954a0..2d58abe 100644
--- a/daemon.c
+++ b/daemon.c
@@ -304,6 +304,8 @@ static int run_service(char *dir, struct
 		return -1;
 	}
 
+	setenv("GIT_DAEMON", "I am your father.", 1);
+
 	/*
 	 * We'll ignore SIGTERM from now on, we have a
 	 * good client.
