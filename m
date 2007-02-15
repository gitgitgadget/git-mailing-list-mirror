From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] config: read system-wide defaults from /etc/gitconfig
Date: Wed, 14 Feb 2007 21:27:23 -0800
Message-ID: <7v1wkshtxg.fsf@assigned-by-dhcp.cox.net>
References: <200702140909.28369.andyparkins@gmail.com>
	<slrnet5p5h.s9h.siprbaum@xp.machine.xx>
	<Pine.LNX.4.63.0702141246160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45D35092.8040901@xs4all.nl> <7vr6sso8w8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702142015150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vfy98o78i.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702142049430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: hanwen@xs4all.nl,
	Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 15 06:28:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHZA8-0001el-Gw
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 06:28:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbXBOF10 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 00:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932688AbXBOF10
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 00:27:26 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:54490 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932269AbXBOF1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 00:27:25 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070215052724.ICXC1306.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 15 Feb 2007 00:27:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PhTP1W00t1kojtg0000000; Thu, 15 Feb 2007 00:27:24 -0500
In-Reply-To: <Pine.LNX.4.63.0702142049430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 14 Feb 2007 20:54:41 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39796>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I think we need to have a way to disable this setting, perhaps
>> via an environment variable.
>
> Yes. Just set GIT_CONFIG=/what/ever, and it no longer reads from 
> ~/.gitconfig or $prefix/etc/gitconfig.

I think GIT_CONFIG and GIT_LOCAL_CONFIG environment variables
are seriously misdesigned.  At least, I do not think of a sane
way to make use of them.  For one thing, when they are set,
truly per-repository variables such as repositoryformatversion,
legacyheaders and sharedrepository are all ignored.

What I would think is sensible would be simply to:

 - $GIT_CONFIG_SYSTEM environment, if set, names a file to be
   read first.  It defaults to /etc/gitconfig.  You can set it
   to /dev/null to avoid using /etc/gitconfig if you have
   specific need.

 - Then $HOME/.gitconfig is read.

 - Then $GIT_DIR/config is read.

Information read from later files overrides the earlier ones, as
before.

I am not quite sure how $GIT_CONFIG and $GIT_CONFIG_LOCAL were
meant to be used.  Are there any *real* users?  With lack of
information on the intended uses of these two environment
variables, I hacked up the following tweaks on top of the above
defined semantics, to imitate what I _think_ was the original
intention.  The hacked one goes like this:

 - $GIT_CONFIG environment, if set, names a file to be read
   first.  We read it first.

 - If $GIT_CONFIG is unset, then $GIT_CONFIG_SYSTEM (or
   /etc/gitconfig) and $HOME/.gitconfig are read, as above.

 - Next file to be read is $GIT_CONFIG_LOCAL (if set) or
   $GIT_DIR/config.  When reading this file, if we read from
   $GIT_CONFIG earlier, we read only "core.*" section from it.

The difference from the original, aside from the additional
business with /etc/gitconfig, is that this updated one does read
from $GIT_DIR/config (or $GIT_CONFIG_LOCAL) to avoid missing
more important per-repo variables.  Since I did not understand
why $GIT_CONFIG makes the remaining configuration files to be
totally skipped in the original, I added hacks to make the last
step to read only minimally.

I'd rather not to have the hacks to deal with GIT_CONFIG and
GIT_CONFIG_LOCAL I did in this patch, but I do not know enough
to tell if they are meaningless hacks to imitate ill-defined
original semantics, or if they still cover useful use cases
these two environment variables were originally invented to
satisfy.

---

 Makefile |   10 +++++--
 cache.h  |    4 +++
 config.c |   84 +++++++++++++++++++++++++++++++++++++++----------------------
 3 files changed, 65 insertions(+), 33 deletions(-)

diff --git a/Makefile b/Makefile
index ebecbbd..4232465 100644
--- a/Makefile
+++ b/Makefile
@@ -122,6 +122,7 @@ STRIP ?= strip
 
 prefix = $(HOME)
 bindir = $(prefix)/bin
+etcdir = $(prefix)/etc
 gitexecdir = $(bindir)
 template_dir = $(prefix)/share/git-core/templates/
 # DESTDIR=
@@ -142,7 +143,7 @@ GITWEB_FAVICON = git-favicon.png
 GITWEB_SITE_HEADER =
 GITWEB_SITE_FOOTER =
 
-export prefix bindir gitexecdir template_dir
+export prefix bindir etcdir gitexecdir template_dir
 
 CC = gcc
 AR = ar
@@ -587,6 +588,7 @@ SHA1_HEADER_SQ = $(subst ','\'',$(SHA1_HEADER))
 
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 bindir_SQ = $(subst ','\'',$(bindir))
+etcdir_SQ = $(subst ','\'',$(etcdir))
 gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
 template_dir_SQ = $(subst ','\'',$(template_dir))
 prefix_SQ = $(subst ','\'',$(prefix))
@@ -596,7 +598,9 @@ PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
 
 LIBS = $(GITLIBS) $(EXTLIBS)
 
-BASIC_CFLAGS += -DSHA1_HEADER='$(SHA1_HEADER_SQ)' $(COMPAT_CFLAGS)
+BASIC_CFLAGS += -DSHA1_HEADER='$(SHA1_HEADER_SQ)'
+BASIC_CFLAGS += -DGIT_CONFIG_SYSTEM='"$(etcdir_SQ)/gitconfig"'
+BASIC_CFLAGS += $(COMPAT_CFLAGS)
 LIB_OBJS += $(COMPAT_OBJS)
 
 ALL_CFLAGS += $(BASIC_CFLAGS)
diff --git a/cache.h b/cache.h
index c62b0b0..2b4e26d 100644
--- a/cache.h
+++ b/cache.h
@@ -125,6 +125,10 @@ extern int cache_errno;
 #define TEMPLATE_DIR_ENVIRONMENT "GIT_TEMPLATE_DIR"
 #define CONFIG_ENVIRONMENT "GIT_CONFIG"
 #define CONFIG_LOCAL_ENVIRONMENT "GIT_CONFIG_LOCAL"
+#define CONFIG_SYSTEM_ENVIRONMENT "GIT_CONFIG_SYSTEM"
+#ifndef GIT_CONFIG_SYSTEM
+#define GIT_CONFIG_SYSTEM "/etc/gitconfig"
+#endif
 #define EXEC_PATH_ENVIRONMENT "GIT_EXEC_PATH"
 
 extern int is_bare_repository_cfg;
diff --git a/config.c b/config.c
index c938aa0..7ec0d9a 100644
--- a/config.c
+++ b/config.c
@@ -107,7 +107,7 @@ static inline int iskeychar(int c)
 	return isalnum(c) || c == '-';
 }
 
-static int get_value(config_fn_t fn, char *name, unsigned int len)
+static int get_value(config_fn_t fn, char *name, unsigned int len, int core_only)
 {
 	int c;
 	char *value;
@@ -135,6 +135,8 @@ static int get_value(config_fn_t fn, char *name, unsigned int len)
 		if (!value)
 			return -1;
 	}
+	if (core_only && strncmp(name, "core.", 5))
+		return 0;
 	return fn(name, value);
 }
 
@@ -193,7 +195,7 @@ static int get_base_var(char *name)
 	}
 }
 
-static int git_parse_file(config_fn_t fn)
+static int git_parse_file(config_fn_t fn, int core_only)
 {
 	int comment = 0;
 	int baselen = 0;
@@ -225,7 +227,8 @@ static int git_parse_file(config_fn_t fn)
 		if (!isalpha(c))
 			break;
 		var[baselen] = tolower(c);
-		if (get_value(fn, var, baselen+1) < 0)
+
+		if (get_value(fn, var, baselen+1, core_only) < 0)
 			break;
 	}
 	die("bad config file line %d in %s", config_linenr, config_file_name);
@@ -356,50 +359,71 @@ int git_default_config(const char *var, const char *value)
 	return 0;
 }
 
-int git_config_from_file(config_fn_t fn, const char *filename)
+static int git_config_from_file_1(config_fn_t fn, const char *filename, int core_only, int missing_ok)
 {
 	int ret;
 	FILE *f = fopen(filename, "r");
 
-	ret = -1;
+	ret = missing_ok ? 0 : -1;
 	if (f) {
 		config_file = f;
 		config_file_name = filename;
 		config_linenr = 1;
-		ret = git_parse_file(fn);
+		ret = git_parse_file(fn, core_only);
 		fclose(f);
 		config_file_name = NULL;
 	}
 	return ret;
 }
 
+int git_config_from_file(config_fn_t fn, const char *filename)
+{
+	return git_config_from_file_1(fn, filename, 0, 0);
+}
+
 int git_config(config_fn_t fn)
 {
+	/*
+	 * If GIT_CONFIG environment is set, then it is read first.
+	 * If GIT_CONFIG environment is not set,
+	 *    GIT_CONFIG_SYSTEM (default /etc/gitconfig) is read next.
+	 *    Then $HOME/.gitconfig is read.
+	 *
+	 * Then, if GIT_CONFIG_LOCAL is set, it is read.
+	 * Otherwise "$GIT_DIR/config" is read.
+	 * 
+	 * However, if we read from GIT_CONFIG environment earlier, we
+	 * only read "core.*" section in the last step.
+	 */
 	int ret = 0;
-	char *repo_config = NULL;
-	const char *home = NULL, *filename;
-
-	/* $GIT_CONFIG makes git read _only_ the given config file,
-	 * $GIT_CONFIG_LOCAL will make it process it in addition to the
-	 * global config file, the same way it would the per-repository
-	 * config file otherwise. */
-	filename = getenv(CONFIG_ENVIRONMENT);
-	if (!filename) {
-		home = getenv("HOME");
-		filename = getenv(CONFIG_LOCAL_ENVIRONMENT);
-		if (!filename)
-			filename = repo_config = xstrdup(git_path("config"));
-	}
-
-	if (home) {
-		char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
-		if (!access(user_config, R_OK))
-			ret = git_config_from_file(fn, user_config);
-		free(user_config);
-	}
-
-	ret += git_config_from_file(fn, filename);
-	free(repo_config);
+	int core_only;
+	char *cfg;
+	char path[PATH_MAX];
+
+	cfg = getenv(CONFIG_ENVIRONMENT);
+	if (cfg) {
+		ret += git_config_from_file_1(fn, cfg, 0, 1);
+		core_only = 1;
+	}
+	else {
+		core_only = 0;
+		cfg = getenv(CONFIG_SYSTEM_ENVIRONMENT);
+		if (!cfg)
+			cfg = GIT_CONFIG_SYSTEM;
+		ret += git_config_from_file_1(fn, cfg, 0, 1);
+
+		cfg = getenv("HOME");
+		if (cfg) {
+			snprintf(path, sizeof(path), "%s/.gitconfig", cfg);
+			ret += git_config_from_file_1(fn, path, 0, 1);
+		}
+	}
+	cfg = getenv(CONFIG_LOCAL_ENVIRONMENT);
+	if (!cfg) {
+		strcpy(path, git_path("config"));
+		cfg = path;
+	}
+	ret += git_config_from_file_1(fn, cfg, core_only, 1);
 	return ret;
 }
 
