From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 00/40] MinGW port
Date: Sun, 2 Mar 2008 22:20:59 +0100
Message-ID: <200803022220.59711.johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 22:21:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVvcu-0006R5-VV
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 22:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756929AbYCBVVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 16:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756870AbYCBVVG
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 16:21:06 -0500
Received: from smtp1.srv.eunet.at ([193.154.160.119]:35932 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756835AbYCBVVE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 16:21:04 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id BF39E34253;
	Sun,  2 Mar 2008 22:21:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 81E91609B6;
	Sun,  2 Mar 2008 22:21:00 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75844>

On Wednesday 27 February 2008 19:54, Johannes Sixt wrote:
> So here it is, the MinGW port of git.
> This series is also available from
>
> git://repo.or.cz/git/mingw/j6t.git upstream
> http://repo.or.cz/w/git/mingw/j6t.git?a=shortlog;h=upstream

I've integrated the feedback that I received in this series. Thanks to 
has_dos_drive_prefix() as suggested by Dscho quite a number of #ifdef's could 
be removed. Below is the interdiff between the old and the new state. 
However, I have not yet moved stuff out of git-compat-util.h into 
compat/mingw.h to keep this message readable. I'll do that later after I have 
rebased the series on top of the latest git.git master.

BTW, the last hunk in the interdiff is a new bug-fix.

-- Hannes

diff --git a/Makefile b/Makefile
index 53a4e2a..2ea53c0 100644
--- a/Makefile
+++ b/Makefile
@@ -265,6 +265,7 @@ PROGRAMS = \
 	git-pack-redundant$X git-var$X \
 	git-merge-tree$X \
 	git-merge-recursive$X \
+	$(POSIX_ONLY_PROGRAMS) \
 	$(EXTRA_PROGRAMS)
 
 # Empty...
@@ -541,9 +542,11 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_MKDTEMP = YesPlease
 	NO_SVN_TESTS = YesPlease
 	NO_PERL_MAKEMAKER = YesPlease
-	NO_EXTRA_PROGRAMS = YesPlease
+	NO_POSIX_ONLY_PROGRAMS = YesPlease
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat
+	COMPAT_CFLAGS += -DPATH_SEP="';'"
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
+	COMPAT_CFLAGS += -DPRIuMAX=\"I64u\"
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch.o compat/regex.o
 	EXTLIBS += -lws2_32
 	X = .exe
@@ -611,8 +614,8 @@ ifdef ZLIB_PATH
 endif
 EXTLIBS += -lz
 
-ifndef NO_EXTRA_PROGRAMS
-	EXTRA_PROGRAMS += \
+ifndef NO_POSIX_ONLY_PROGRAMS
+	POSIX_ONLY_PROGRAMS = \
 		git-daemon$X \
 		git-imap-send$X
 endif
diff --git a/cache.h b/cache.h
index 3e4e10a..781fa40 100644
--- a/cache.h
+++ b/cache.h
@@ -441,11 +441,7 @@ int safe_create_leading_directories(char *path);
 char *enter_repo(char *path, int strict);
 static inline int is_absolute_path(const char *path)
 {
-#ifndef __MINGW32__
-	return path[0] == '/';
-#else
-	return path[0] == '/' || (path[0] && path[1] == ':');
-#endif
+	return path[0] == '/' || has_dos_drive_prefix(path);
 }
 const char *make_absolute_path(const char *path);
 
diff --git a/compat/mingw.c b/compat/mingw.c
index 0888288..6733727 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -330,16 +330,13 @@ struct tm *localtime_r(const time_t *timep, struct tm 
*result)
 #undef getcwd
 char *mingw_getcwd(char *pointer, int len)
 {
+	int i;
 	char *ret = getcwd(pointer, len);
 	if (!ret)
 		return ret;
-	if (pointer[0] != 0 && pointer[1] == ':') {
-		int i;
-		for (i = 2; pointer[i]; i++)
-			/* Thanks, Bill. You'll burn in hell for that. */
-			if (pointer[i] == '\\')
-				pointer[i] = '/';
-	}
+	for (i = 0; pointer[i]; i++)
+		if (pointer[i] == '\\')
+			pointer[i] = '/';
 	return ret;
 }
 
diff --git a/connect.c b/connect.c
index 7e18ac8..cb81b8c 100644
--- a/connect.c
+++ b/connect.c
@@ -529,13 +529,7 @@ struct child_process *git_connect(int fd[2], const char 
*url_orig,
 		end = host;
 
 	path = strchr(end, c);
-#ifdef __MINGW32__
-	/* host must have at least 2 chars to catch DOS C:/path */
-	if (path && path - end > 1)
-#else
-	if (path)
-#endif
-	{
+	if (path && !has_dos_drive_prefix(end)) {
 		if (c == ':') {
 			protocol = PROTO_SSH;
 			*path++ = '\0';
diff --git a/exec_cmd.c b/exec_cmd.c
index 6d2f740..84db7ee 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -70,11 +70,7 @@ static void add_path(struct strbuf *out, const char *path)
 		else
 			strbuf_addstr(out, make_absolute_path(path));
 
-#ifdef __MINGW32__
-		strbuf_addch(out, ';');
-#else
-		strbuf_addch(out, ':');
-#endif
+		strbuf_addch(out, PATH_SEP);
 	}
 }
 
diff --git a/git-compat-util.h b/git-compat-util.h
index 4a8df8e..3ea0d91 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -103,11 +103,11 @@
 #endif
 
 #ifndef PRIuMAX
-#ifndef __MINGW32__
 #define PRIuMAX "llu"
-#else
-#define PRIuMAX "I64u"
 #endif
+
+#ifndef PATH_SEP
+#define PATH_SEP ':'
 #endif
 
 #ifdef __GNUC__
@@ -168,9 +168,11 @@ extern int git_munmap(void *start, size_t length);
 #define pread git_pread
 extern ssize_t git_pread(int fd, void *buf, size_t count, off_t offset);
 #endif
-/* Forward decl that will remind us if its twin in cache.h changes.
-   This function in used in compat/pread.c.  But we can't include
-   cache.h there. */
+/*
+ * Forward decl that will remind us if its twin in cache.h changes.
+ * This function is used in compat/pread.c.  But we can't include
+ * cache.h there.
+ */
 extern int read_in_full(int fd, void *buf, size_t count);
 
 #ifdef NO_SETENV
@@ -650,6 +652,18 @@ char **copy_environ(void);
 void free_environ(char **env);
 char **env_setenv(char **env, const char *name);
 
+static inline int has_dos_drive_prefix(const char *path)
+{
+	return isalpha(*path) && path[1] == ':';
+}
+
+#else /* __MINGW32__ */
+
+static inline int has_dos_drive_prefix(const char *path)
+{
+	return 0;
+}
+
 #endif /* __MINGW32__ */
 
 #endif
diff --git a/help.c b/help.c
index 0248c76..b53c6d7 100644
--- a/help.c
+++ b/help.c
@@ -231,11 +231,6 @@ static void list_commands(void)
 	const char *env_path = getenv("PATH");
 	char *paths, *path, *colon;
 	const char *exec_path = git_exec_path();
-#ifdef __MINGW32__
-	char sep = ';';
-#else
-	char sep = ':';
-#endif
 
 	if (exec_path)
 		longest = list_commands_in_dir(&main_cmds, exec_path);
@@ -247,7 +242,7 @@ static void list_commands(void)
 
 	path = paths = xstrdup(env_path);
 	while (1) {
-		if ((colon = strchr(path, sep)))
+		if ((colon = strchr(path, PATH_SEP)))
 			*colon = 0;
 
 		len = list_commands_in_dir(&other_cmds, path);
diff --git a/setup.c b/setup.c
index 77cc461..212763f 100644
--- a/setup.c
+++ b/setup.c
@@ -12,15 +12,14 @@ static inline int is_dir_sep(char c) { return c == '/'; }
 
 static int sanitary_path_copy(char *dst, const char *src)
 {
-	char *dst0 = dst;
+	char *dst0;
 
-#ifdef __MINGW32__
-	if (isalpha(*src) && src[1] == ':') {
+	if (has_dos_drive_prefix(src)) {
 		*dst++ = *src++;
 		*dst++ = *src++;
-		dst0 = dst;
 	}
-#endif
+	dst0 = dst;
+
 	if (is_dir_sep(*src)) {
 		*dst++ = '/';
 		while (is_dir_sep(*src))
@@ -39,30 +38,22 @@ static int sanitary_path_copy(char *dst, const char *src)
 		 * (4) "../"          -- strip one, eat slash and continue.
 		 */
 		if (c == '.') {
-			switch (src[1]) {
-			case '\0':
+			if (!src[1]) {
 				/* (1) */
 				src++;
 				break;
-			case '/':
-#ifdef __MINGW32__
-			case '\\':
-#endif
+			} else if (is_dir_sep(src[1])) {
 				/* (2) */
 				src += 2;
 				while (is_dir_sep(*src))
 					src++;
 				continue;
-			case '.':
-				switch (src[2]) {
-				case '\0':
+			} else if (src[1] == '.') {
+				if (!src[2]) {
 					/* (3) */
 					src += 2;
 					goto up_one;
-				case '/':
-#ifdef __MINGW32__
-				case '\\':
-#endif
+				} else if (is_dir_sep(src[2])) {
 					/* (4) */
 					src += 3;
 					while (is_dir_sep(*src))
@@ -397,10 +388,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 
 	if (!getcwd(cwd, sizeof(cwd)-1))
 		die("Unable to read current working directory");
-#ifdef __MINGW32__
-	if (cwd[1] == ':')
+	if (has_dos_drive_prefix(cwd))
 		minoffset = 2;
-#endif
 
 	/*
 	 * Test in the following order (relative to the cwd):
diff --git a/sha1_file.c b/sha1_file.c
index 0c60849..fa34c75 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -85,10 +85,8 @@ int get_sha1_hex(const char *hex, unsigned char *sha1)
 
 static inline int offset_1st_component(const char *path)
 {
-#ifdef __MINGW32__
-	if (isalpha(path[0]) && path[1] == ':')
+	if (has_dos_drive_prefix(path))
 		return 2 + (path[2] == '/');
-#endif
 	return *path == '/';
 }
 
@@ -395,11 +393,7 @@ void prepare_alt_odb(void)
 	if (!alt) alt = "";
 
 	alt_odb_tail = &alt_odb_list;
-#ifdef __MINGW32__
-	link_alt_odb_entries(alt, alt + strlen(alt), ';', NULL, 0);
-#else
-	link_alt_odb_entries(alt, alt + strlen(alt), ':', NULL, 0);
-#endif
+	link_alt_odb_entries(alt, alt + strlen(alt), PATH_SEP, NULL, 0);
 
 	read_info_alternates(get_object_directory(), 0);
 }
diff --git a/templates/Makefile b/templates/Makefile
index eb08702..6c0da7a 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -34,11 +34,8 @@ boilerplates.made : $(bpsrc)
 		mkdir -p blt/$$dir && \
 		case "$$boilerplate" in \
 		*--) ;; \
-		*) if test -n "$$(sed -ne '/^#!\//p' -e '1q' < "$$boilerplate")"; then \
-			cp "$$boilerplate" "blt/$${dst}$(NOEXECTEMPL)"; \
-		   else \
-			cp "$$boilerplate" "blt/$$dst"; \
-		   fi ;; \
+		hooks--*) cp $$boilerplate blt/$${dst}$(NOEXECTEMPL) ;; \
+		*) cp $$boilerplate blt/$$dst ;; \
 		esac || exit; \
 	done && \
 	date >$@
diff --git a/transport.c b/transport.c
index 397983d..266a6cc 100644
--- a/transport.c
+++ b/transport.c
@@ -692,7 +692,8 @@ static int is_local(const char *url)
 {
 	const char *colon = strchr(url, ':');
 	const char *slash = strchr(url, '/');
-	return !colon || (slash && slash < colon);
+	return !colon || (slash && slash < colon) ||
+		has_dos_drive_prefix(url);
 }
 
 static int is_file(const char *url)
