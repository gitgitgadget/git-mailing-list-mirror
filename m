X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: Minor documentation problems [RFC PATCH]
Date: Thu, 2 Nov 2006 07:39:43 -0500
Message-ID: <BAYC1-PASMTP018DA61B5F35F9603DF8A8AEFF0@CEZ.ICE>
References: <vpqmz7a1694.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 2 Nov 2006 12:40:02 +0000 (UTC)
Cc: git <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061102073943.a4ebaaaf.seanlkml@sympatico.ca>
In-Reply-To: <vpqmz7a1694.fsf@ecrins.imag.fr>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 02 Nov 2006 12:39:46.0266 (UTC) FILETIME=[FA6F2BA0:01C6FE7B]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfbrL-0002Cx-Pr for gcvg-git@gmane.org; Thu, 02 Nov
 2006 13:39:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752389AbWKBMjr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 07:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752813AbWKBMjr
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 07:39:47 -0500
Received: from bayc1-pasmtp01.bayc1.hotmail.com ([65.54.191.161]:20095 "EHLO
 bayc1-pasmtp01.bayc1.hotmail.com") by vger.kernel.org with ESMTP id
 S1752389AbWKBMjq (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006
 07:39:46 -0500
Received: from linux1.attic.local ([65.93.43.81]) by
 bayc1-pasmtp01.bayc1.hotmail.com over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Thu, 2 Nov 2006 04:39:45 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1Gfav9-0001VD-QH; Thu, 02 Nov 2006 06:39:43 -0500
To: Matthieu Moy <Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org

On Thu, 02 Nov 2006 11:40:23 +0100
Matthieu Moy <Matthieu.Moy@imag.fr> wrote:

> * http://www.kernel.org/pub/software/scm/cogito/docs/cg-commit.1.html
>   Mentions .git/config, but not ~/.gitconfig (which is indeed _the_
>   place where I think most people want to set their name and email).
> 
>   Side note: it can be interesting to have a command to do this.
>   For example, bzr has "bzr whoami 'me <myself@myisp.com>'", which
>   avoids having to learn the config file syntax.

This is the git version :

$ git repo-config user.email "myself@myisp.com"
$ git repo-config user.name "me"

Unfortunately repo-config doesn't update ~/.gitconfig only
the .git/config file.

The patch below adds a --global option to allow:

$ git repo-config --global user.email "myself@myisp.com"
$ git repo-config --global user.name "me"

Although the syntax is a bit depressing, it would seem to
be the path of least resistance.

The patch below always updates ~/.gitconfig but perhaps it
should respect GIT_CONFIG and/or GIT_CONFIG_LOCAL
environment variables.

Sean

diff --git a/builtin-repo-config.c b/builtin-repo-config.c
index f60cee1..8c2b58a 100644
--- a/builtin-repo-config.c
+++ b/builtin-repo-config.c
@@ -127,9 +127,20 @@ free_strings:
 	return ret;
 }
 
+static int set_config(int global, const char* key, const char* value,
+		const char* value_regex, int multi_replace)
+{
+	if (global)
+		return git_global_config_set_multivar(key, value,
+				value_regex, multi_replace);
+	else
+		return git_config_set_multivar(key, value,
+				value_regex, multi_replace);
+}
+
 int cmd_repo_config(int argc, const char **argv, const char *prefix)
 {
-	int nongit = 0;
+	int nongit = 0, global = 0;
 	setup_git_directory_gently(&nongit);
 
 	while (1 < argc) {
@@ -139,6 +150,8 @@ int cmd_repo_config(int argc, const char
 			type = T_BOOL;
 		else if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l"))
 			return git_config(show_all_config);
+		else if (!strcmp(argv[1], "--global"))
+			global = 1;
 		else
 			break;
 		argc--;
@@ -150,9 +163,9 @@ int cmd_repo_config(int argc, const char
 		return get_value(argv[1], NULL);
 	case 3:
 		if (!strcmp(argv[1], "--unset"))
-			return git_config_set(argv[2], NULL);
+			return set_config(global, argv[2], NULL, NULL, 0);
 		else if (!strcmp(argv[1], "--unset-all"))
-			return git_config_set_multivar(argv[2], NULL, NULL, 1);
+			return set_config(global, argv[2], NULL, NULL, 1);
 		else if (!strcmp(argv[1], "--get"))
 			return get_value(argv[2], NULL);
 		else if (!strcmp(argv[1], "--get-all")) {
@@ -165,12 +178,12 @@ int cmd_repo_config(int argc, const char
 			return get_value(argv[2], NULL);
 		} else
 
-			return git_config_set(argv[1], argv[2]);
+			return set_config(global, argv[1], argv[2], NULL, 0);
 	case 4:
 		if (!strcmp(argv[1], "--unset"))
-			return git_config_set_multivar(argv[2], NULL, argv[3], 0);
+			return set_config(global, argv[2], NULL, argv[3], 0);
 		else if (!strcmp(argv[1], "--unset-all"))
-			return git_config_set_multivar(argv[2], NULL, argv[3], 1);
+			return set_config(global, argv[2], NULL, argv[3], 1);
 		else if (!strcmp(argv[1], "--get"))
 			return get_value(argv[2], argv[3]);
 		else if (!strcmp(argv[1], "--get-all")) {
@@ -183,13 +196,13 @@ int cmd_repo_config(int argc, const char
 			return get_value(argv[2], argv[3]);
 		} else if (!strcmp(argv[1], "--replace-all"))
 
-			return git_config_set_multivar(argv[2], argv[3], NULL, 1);
+			return set_config(global, argv[2], argv[3], NULL, 1);
 		else
 
-			return git_config_set_multivar(argv[1], argv[2], argv[3], 0);
+			return set_config(global, argv[1], argv[2], argv[3], 0);
 	case 5:
 		if (!strcmp(argv[1], "--replace-all"))
-			return git_config_set_multivar(argv[2], argv[3], argv[4], 1);
+			return set_config(global, argv[2], argv[3], argv[4], 1);
 	case 1:
 	default:
 		usage(git_config_set_usage);
diff --git a/cache.h b/cache.h
index d0a1657..5f7c599 100644
--- a/cache.h
+++ b/cache.h
@@ -402,6 +402,8 @@ extern int git_config_int(const char *,
 extern int git_config_bool(const char *, const char *);
 extern int git_config_set(const char *, const char *);
 extern int git_config_set_multivar(const char *, const char *, const char *, int);
+extern int git_global_config_set(const char*, const char*);
+extern int git_global_config_set_multivar(const char*, const char*, const char*, int);
 extern int check_repository_format_version(const char *var, const char *value);
 
 #define MAX_GITNAME (1000)
diff --git a/config.c b/config.c
index e8f0caf..0393b65 100644
--- a/config.c
+++ b/config.c
@@ -529,22 +529,16 @@ int git_config_set(const char* key, cons
  * - the config file is removed and the lock file rename()d to it.
  *
  */
-int git_config_set_multivar(const char* key, const char* value,
+int git_config_file_set_multivar(char* config_filename,
+	const char* key, const char* value,
 	const char* value_regex, int multi_replace)
 {
 	int i, dot;
 	int fd = -1, in_fd;
 	int ret;
-	char* config_filename;
 	char* lock_file;
 	const char* last_dot = strrchr(key, '.');
 
-	config_filename = getenv("GIT_CONFIG");
-	if (!config_filename) {
-		config_filename = getenv("GIT_CONFIG_LOCAL");
-		if (!config_filename)
-			config_filename  = git_path("config");
-	}
 	config_filename = xstrdup(config_filename);
 	lock_file = xstrdup(mkpath("%s.lock", config_filename));
 
@@ -742,3 +736,36 @@ out_free:
 }
 
 
+int git_config_set_multivar(const char* key, const char* value,
+	const char* value_regex, int multi_replace)
+{
+	char* config_filename;
+	config_filename = getenv("GIT_CONFIG");
+	if (!config_filename) {
+		config_filename = getenv("GIT_CONFIG_LOCAL");
+		if (!config_filename)
+			config_filename  = git_path("config");
+	}
+	return git_config_file_set_multivar(config_filename, key, value,
+				value_regex, multi_replace);
+}
+
+int git_global_config_set_multivar(const char* key, const char* value,
+	const char* value_regex, int multi_replace)
+{
+	int ret = -1;
+	const char *home = getenv("HOME");
+	if (home) {
+		char * global = xstrdup(mkpath("%s/.gitconfig", home));
+		ret = git_config_file_set_multivar(global, key, value,
+				value_regex, multi_replace);
+		free(global);
+	}
+	return ret;
+}
+
+int git_global_config_set(const char* key, const char* value)
+{
+	return git_global_config_set_multivar(key, value, NULL, 0);
+}
