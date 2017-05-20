Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59377201A7
	for <e@80x24.org>; Sat, 20 May 2017 15:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755178AbdETP32 (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 11:29:28 -0400
Received: from mout.web.de ([212.227.15.4]:54872 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752261AbdETP31 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 11:29:27 -0400
Received: from [192.168.178.36] ([79.213.117.211]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M8zdd-1d6r8P29bZ-00CUuV; Sat, 20
 May 2017 17:29:20 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] mingw: simplify PATH handling
Message-ID: <c5b7292f-6367-e4a9-2ee0-96b93b1b587f@web.de>
Date:   Sat, 20 May 2017 17:29:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:j/TG+MRHXzIfEEFctEkkEGIqtnAtnQXgsQ/FW1tdrtALFvS7ZW9
 vkqKcUVt4dfiO8/48YlmFiQMifyTsiTlDdtm0hYWXb1fjdtdL4po9kf5FJ2f6gq0A0AifZu
 nbLEXaL/ZHyibf6GsoWHcFTo+zNKnZ08Oe4XOydg4DqKgwcBCQr1qMcPr3S3BSSVr9ygUB0
 7LZ3xZRg8UJ7Tr11rUgIg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9Zz7RYtCPjQ=:qTJ+6a9r5tdle8zm75gIln
 JfUQh+H1L9Ca9iEjTNKItA9KSnfIszmfOqoiKn2mYcT1jDbmyy50j8TwUQ1Rmx+4uc1zvdlAZ
 yD2KIOVJZmjPvMHW4YumM/PWNJ3y/bjNRHPgjBnuX3CzHF+xsQYzuXpO5lbh6se/4gxDAuYlY
 xzEl3culIgz8F2M+ghn4N7U16Qt9biYtUusaNF9fbVwT//BlPJ03PaHrMtHLDyOZXdTOuAYLA
 0wuQPDmXtXr4cETRrKA0Y/otZUwNlgqlQOKZnVsInU+mUA0JlM2gyymxcKn1EluveM6d4Xbcg
 bQhEjSSD7GKU+yc8txDVEAU4N2EeSyukzgMtrAu0N9y1VmQVHyLk0VzP29ZEnCtgdjZEvgJnl
 LhEFeAQNpwf9Ywgll7Y5JQYqISVuJLZDTOlWBnBOYncfFSFh/Od2VNo5Dq6duQdfWzetYN+Nu
 W+nnbIx873RS5NA7knzYDVeeK5zi/XHclEjLFEQ0xmqr2bkmeIPUjezpZpEpBCrMr4mLlUaLJ
 6LKPRQ2o23D73Lty4qG7usrYFyr/DBMk6yKUVYqvGcAQuzafAoVkA8fU9szHN77O7LrBeUB03
 J75D3+Ujc8gZAiNSAkruxcNuCMx0pwtePuM7swP2IxWQpFuN+P5Ptgtir46yChMbcXC939CoJ
 LPq7uBCKXG6btigDynanC995h6poW24SQrtgv37avWQVPyERPNLjo6Q6ViZ6aqBcmNFbsbHxd
 jqn1HaEZdLqXOVAsPWl3lLHr5A3mHYJxhqzuKUxieCYzsPdl/URGWQED8Kz24BWgibxpwm2/k
 RlcI6Zu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Windows the environment variable PATH contains a semicolon-separated
list of directories to search for, in order, when looking for the
location of a binary to run.  get_path_split() parses it and returns an
array of string copies, which is iterated by path_lookup(), which in
turn passes each entry to lookup_prog().

Change lookup_prog() to take the directory name as a length-limited
string instead of as a NUL-terminated one and parse PATH directly in
path_lookup().  This avoids memory allocations, simplifying the code.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 compat/mingw.c | 96 ++++++++++++++--------------------------------------------
 1 file changed, 22 insertions(+), 74 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 5113071bc7..7bc61d4066 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1154,67 +1154,15 @@ static const char *parse_interpreter(const char *cmd)
 }
 
 /*
- * Splits the PATH into parts.
- */
-static char **get_path_split(void)
-{
-	char *p, **path, *envpath = mingw_getenv("PATH");
-	int i, n = 0;
-
-	if (!envpath || !*envpath)
-		return NULL;
-
-	envpath = xstrdup(envpath);
-	p = envpath;
-	while (p) {
-		char *dir = p;
-		p = strchr(p, ';');
-		if (p) *p++ = '\0';
-		if (*dir) {	/* not earlier, catches series of ; */
-			++n;
-		}
-	}
-	if (!n) {
-		free(envpath);
-		return NULL;
-	}
-
-	ALLOC_ARRAY(path, n + 1);
-	p = envpath;
-	i = 0;
-	do {
-		if (*p)
-			path[i++] = xstrdup(p);
-		p = p+strlen(p)+1;
-	} while (i < n);
-	path[i] = NULL;
-
-	free(envpath);
-
-	return path;
-}
-
-static void free_path_split(char **path)
-{
-	char **p = path;
-
-	if (!path)
-		return;
-
-	while (*p)
-		free(*p++);
-	free(path);
-}
-
-/*
  * exe_only means that we only want to detect .exe files, but not scripts
  * (which do not have an extension)
  */
-static char *lookup_prog(const char *dir, const char *cmd, int isexe, int exe_only)
+static char *lookup_prog(const char *dir, int dirlen, const char *cmd,
+			 int isexe, int exe_only)
 {
 	char path[MAX_PATH];
 	wchar_t wpath[MAX_PATH];
-	snprintf(path, sizeof(path), "%s\\%s.exe", dir, cmd);
+	snprintf(path, sizeof(path), "%.*s\\%s.exe", dirlen, dir, cmd);
 
 	if (xutftowcs_path(wpath, path) < 0)
 		return NULL;
@@ -1235,17 +1183,27 @@ static char *lookup_prog(const char *dir, const char *cmd, int isexe, int exe_on
  * Determines the absolute path of cmd using the split path in path.
  * If cmd contains a slash or backslash, no lookup is performed.
  */
-static char *path_lookup(const char *cmd, char **path, int exe_only)
+static char *path_lookup(const char *cmd, int exe_only)
 {
+	const char *path;
 	char *prog = NULL;
 	int len = strlen(cmd);
 	int isexe = len >= 4 && !strcasecmp(cmd+len-4, ".exe");
 
 	if (strchr(cmd, '/') || strchr(cmd, '\\'))
-		prog = xstrdup(cmd);
+		return xstrdup(cmd);
 
-	while (!prog && *path)
-		prog = lookup_prog(*path++, cmd, isexe, exe_only);
+	path = mingw_getenv("PATH");
+	if (!path)
+		return NULL;
+
+	for (; !prog && *path; path++) {
+		const char *sep = strchrnul(path, ';');
+		if (sep == path)
+			continue;
+		prog = lookup_prog(path, sep - path, cmd, isexe, exe_only);
+		path = sep;
+	}
 
 	return prog;
 }
@@ -1569,13 +1527,10 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **deltaen
 	}
 
 	if (getenv("GIT_STRACE_COMMANDS")) {
-		char **path = get_path_split();
-		char *p = path_lookup("strace.exe", path, 1);
+		char *p = path_lookup("strace.exe", 1);
 		if (!p) {
-			free_path_split(path);
 			return error("strace not found!");
 		}
-		free_path_split(path);
 		if (xutftowcs_path(wcmd, p) < 0) {
 			free(p);
 			return -1;
@@ -1634,8 +1589,7 @@ pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **deltaenv,
 		     int fhin, int fhout, int fherr)
 {
 	pid_t pid;
-	char **path = get_path_split();
-	char *prog = path_lookup(cmd, path, 0);
+	char *prog = path_lookup(cmd, 0);
 
 	if (!prog) {
 		errno = ENOENT;
@@ -1646,7 +1600,7 @@ pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **deltaenv,
 
 		if (interpr) {
 			const char *argv0 = argv[0];
-			char *iprog = path_lookup(interpr, path, 1);
+			char *iprog = path_lookup(interpr, 1);
 			argv[0] = prog;
 			if (!iprog) {
 				errno = ENOENT;
@@ -1664,21 +1618,18 @@ pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **deltaenv,
 					       fhin, fhout, fherr);
 		free(prog);
 	}
-	free_path_split(path);
 	return pid;
 }
 
 static int try_shell_exec(const char *cmd, char *const *argv)
 {
 	const char *interpr = parse_interpreter(cmd);
-	char **path;
 	char *prog;
 	int pid = 0;
 
 	if (!interpr)
 		return 0;
-	path = get_path_split();
-	prog = path_lookup(interpr, path, 1);
+	prog = path_lookup(interpr, 1);
 	if (prog) {
 		int argc = 0;
 #ifndef _MSC_VER
@@ -1700,7 +1651,6 @@ static int try_shell_exec(const char *cmd, char *const *argv)
 		free(prog);
 		free(argv2);
 	}
-	free_path_split(path);
 	return pid;
 }
 
@@ -1722,8 +1672,7 @@ int mingw_execv(const char *cmd, char *const *argv)
 
 int mingw_execvp(const char *cmd, char *const *argv)
 {
-	char **path = get_path_split();
-	char *prog = path_lookup(cmd, path, 0);
+	char *prog = path_lookup(cmd, 0);
 
 	if (prog) {
 		mingw_execv(prog, argv);
@@ -1731,7 +1680,6 @@ int mingw_execvp(const char *cmd, char *const *argv)
 	} else
 		errno = ENOENT;
 
-	free_path_split(path);
 	return -1;
 }
 
-- 
2.12.1.windows.1

