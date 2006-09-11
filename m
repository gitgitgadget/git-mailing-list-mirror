From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] git-upload-archive: add config option to allow only specified
 formats
Date: Mon, 11 Sep 2006 23:41:08 +0200
Message-ID: <4505D7F4.8050207@lsrfire.ath.cx>
References: <7vpse4tcyc.fsf@assigned-by-dhcp.cox.net>	<7vk64ctctv.fsf@assigned-by-dhcp.cox.net>	<7v1wqkt2v4.fsf_-_@assigned-by-dhcp.cox.net>	<20060910155837.GA15974@lsrfire.ath.cx> <7vpse3sitc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Franck Bui-Huu <vagabon.xyz@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 11 23:41:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMtWm-0001qX-Dv
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 23:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWIKVlN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 17:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbWIKVlN
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 17:41:13 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:28136
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751009AbWIKVlM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Sep 2006 17:41:12 -0400
Received: from [10.0.1.3] (p508E65FD.dip.t-dialin.net [80.142.101.253])
	by neapel230.server4you.de (Postfix) with ESMTP id 70539B43A;
	Mon, 11 Sep 2006 23:41:10 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpse3sitc.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26859>

Add a config options, uploadarchive.daemonformats, which can be used to
specify the archive formats that are OK to be uploaded using the
upload-archive service of git-daemon.  The list can be restricted
further using the environment variable GIT_DAEMON_ARCHIVE_FORMATS.

These settings are properly taken into account for --list output, so a
user can run git-archive --remote=<url> --list to inquire the allowed
and supported archive formats on the remote end.

git-daemon is changed to always set the environment variable GIT_DAEMON
before it spawns children.  This variable can thus be used to detect
the presence of the (more restrictive) daemon environment.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---

Junio C Hamano schrieb:
> Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>> +uploadarchive.daemonformats::
>> +	A comma-separated list of the git-archive formats allowed for upload
>> +	via git-daemon.  If this parameter is missing all formats are allowed
>> +	for upload.
>> +
> 
> Fine -- do we have any other "list-ish" configuration variable,
> by the way?  I am just wondering if we earlier established a
> convention to use some delimiter to list out things and if we do
> have such a convention if delimiter is a comma or not.

I didn't find any.  The code would accept whitespace as a separator, too
(in order to recognize lists like "one, two").  I found myself abusing
this during my testing: I always left out the comma.  So I dropped the
comma from the list of delimiters in this patch, going with shell-like
lists now.

> So we could enhance "--remote --list" to show what are supported
> (both codewise and policywise) on the remote end, with a bit of
> code restructuring?

Yes, of course.  D'oh!

>> diff --git a/daemon.c b/daemon.c
>> index a2954a0..2d58abe 100644
>> --- a/daemon.c
>> +++ b/daemon.c
>> @@ -304,6 +304,8 @@ static int run_service(char *dir, struct
>>  		return -1;
>>  	}
>>  
>> +	setenv("GIT_DAEMON", "I am your father.", 1);
> 
> I suspect "upload_format_allowed()" can be taught to see what is
> in this environment variable and sometimes take that as
> daemon_format without letting the repository to override it, so
> that the site administrator can limit the formats that can be
> used further, just like daemon service mechanism lets them be in
> control.

GIT_DAEMON is meant to indicate one thing, only: that git-daemon started
the process and that it thus has to obey stricter rules.  We can add
another variable which can override the archive config, though.

This patch applies to the 'next' branch (61af0aa).

 Documentation/config.txt |    5 +++++
 archive.h                |    2 ++
 builtin-archive.c        |   27 +++++++++++++++++++++++++--
 builtin-upload-archive.c |    6 ++++++
 cache.h                  |    4 ++++
 config.c                 |   22 ++++++++++++++++++++++
 daemon.c                 |    2 ++
 environment.c            |    1 +
 8 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ce722a2..e4123f1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -236,6 +236,11 @@ tar.umask::
 	the same permissions as gitlink:git-checkout[1] would use. The default
 	value remains 0, which means world read-write.
 
+uploadarchive.daemonformats::
+	A whitespace-separated list of the git-archive formats allowed for
+	upload via git-daemon.  If this parameter is missing or is equal to
+	"*" then all formats are allowed for upload.
+
 user.email::
 	Your email address to be recorded in any newly created commits.
 	Can be overridden by the 'GIT_AUTHOR_EMAIL' and 'GIT_COMMITTER_EMAIL'
diff --git a/archive.h b/archive.h
index 16dcdb8..9ffd300 100644
--- a/archive.h
+++ b/archive.h
@@ -27,6 +27,8 @@ struct archiver {
 
 extern struct archiver archivers[];
 
+extern int is_allowed_archive_format(const char *format);
+
 extern int parse_archive_args(int argc,
 			      const char **argv,
 			      struct archiver *ar);
diff --git a/builtin-archive.c b/builtin-archive.c
index cb883df..5060811 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -169,8 +169,10 @@ int parse_archive_args(int argc, const c
 		const char *arg = argv[i];
 
 		if (!strcmp(arg, "--list") || !strcmp(arg, "-l")) {
-			for (i = 0; i < ARRAY_SIZE(archivers); i++)
-				printf("%s\n", archivers[i].name);
+			for (i = 0; i < ARRAY_SIZE(archivers); i++) {
+				if (is_allowed_archive_format(archivers[i].name))
+					printf("%s\n", archivers[i].name);
+			}
 			exit(0);
 		}
 		if (!strcmp(arg, "--verbose") || !strcmp(arg, "-v")) {
@@ -217,6 +219,25 @@ int parse_archive_args(int argc, const c
 	return i;
 }
 
+int is_allowed_archive_format(const char *format)
+{
+	char *formats;
+
+	if (!getenv("GIT_DAEMON"))
+		return 1;
+
+	formats = getenv("GIT_DAEMON_ARCHIVE_FORMATS");
+	if (formats && !git_config_list_contains(formats, format))
+		return 0;
+
+	if (git_config_list_contains(daemon_archive_formats, "*"))
+		return 1;
+	if (!git_config_list_contains(daemon_archive_formats, format))
+		return 0;
+
+	return 1;
+}
+
 static const char *remote_request(int *ac, const char **av)
 {
 	int ix, iy, cnt = *ac;
@@ -260,6 +281,8 @@ int cmd_archive(int argc, const char **a
 
 	setlinebuf(stderr);
 
+	git_config(git_default_config);
+
 	memset(&ar, 0, sizeof(ar));
 	tree_idx = parse_archive_args(argc, argv, &ar);
 	if (prefix == NULL)
diff --git a/builtin-upload-archive.c b/builtin-upload-archive.c
index 42cb9f8..ff31c04 100644
--- a/builtin-upload-archive.c
+++ b/builtin-upload-archive.c
@@ -67,6 +67,9 @@ static int run_upload_archive(int argc, 
 	/* parse all options sent by the client */
 	treeish_idx = parse_archive_args(sent_argc, sent_argv, &ar);
 
+	if (!is_allowed_archive_format(ar.name))
+		die("upload of %s format forbidden\n", ar.name);
+
 	parse_treeish_arg(sent_argv + treeish_idx, &ar.args, prefix);
 	parse_pathspec_arg(sent_argv + treeish_idx + 1, &ar.args);
 
@@ -77,6 +80,9 @@ int cmd_upload_archive(int argc, const c
 {
 	pid_t writer;
 	int fd1[2], fd2[2];
+
+	git_config(git_default_config);
+
 	/*
 	 * Set up sideband subprocess.
 	 *
diff --git a/cache.h b/cache.h
index ac51ed1..9f8d58b 100644
--- a/cache.h
+++ b/cache.h
@@ -399,6 +399,7 @@ extern int git_config_int(const char *, 
 extern int git_config_bool(const char *, const char *);
 extern int git_config_set(const char *, const char *);
 extern int git_config_set_multivar(const char *, const char *, const char *, int);
+extern int git_config_list_contains(const char *haystack, const char *needle);
 extern int check_repository_format_version(const char *var, const char *value);
 
 #define MAX_GITNAME (1000)
@@ -408,6 +409,9 @@ extern char git_default_name[MAX_GITNAME
 #define MAX_ENCODING_LENGTH 64
 extern char git_commit_encoding[MAX_ENCODING_LENGTH];
 
+#define MAX_FORMATS_LENGTH 256
+extern char daemon_archive_formats[MAX_FORMATS_LENGTH];
+
 extern int copy_fd(int ifd, int ofd);
 extern void write_or_die(int fd, const void *buf, size_t count);
 extern int write_or_whine(int fd, const void *buf, size_t count, const char *msg);
diff --git a/config.c b/config.c
index e8f0caf..0f111ab 100644
--- a/config.c
+++ b/config.c
@@ -251,6 +251,23 @@ int git_config_bool(const char *name, co
 	return git_config_int(name, value) != 0;
 }
 
+int git_config_list_contains(const char *haystack, const char *needle)
+{
+	const char delim[] = " \t";
+	int len = strlen(needle);
+	const char *begin = haystack;
+
+	for (;;) {
+		char *pos = strstr(haystack, needle);
+		if (!pos)
+			return 0;
+		haystack++;
+		if ((pos == begin || strchr(delim, pos[-1])) &&
+		    (pos[len] == '\0' || strchr(delim, pos[len])))
+			return 1;
+	}
+}
+
 int git_default_config(const char *var, const char *value)
 {
 	/* This needs a better name */
@@ -314,6 +331,11 @@ int git_default_config(const char *var, 
 		return 0;
 	}
 
+	if (!strcmp(var, "uploadarchive.daemonformats")) {
+		strlcpy(daemon_archive_formats, value, sizeof(daemon_archive_formats));
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
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
diff --git a/environment.c b/environment.c
index 84d870c..1796937 100644
--- a/environment.c
+++ b/environment.c
@@ -24,6 +24,7 @@ const char *apply_default_whitespace;
 int zlib_compression_level = Z_DEFAULT_COMPRESSION;
 int pager_in_use;
 int pager_use_color = 1;
+char daemon_archive_formats[MAX_FORMATS_LENGTH] = "*";
 
 static const char *git_dir;
 static char *git_object_dir, *git_index_file, *git_refs_dir, *git_graft_file;
