From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] config: read system-wide defaults from /etc/gitconfig
Date: Wed, 14 Feb 2007 20:25:52 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702142015150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702140909.28369.andyparkins@gmail.com> <slrnet5p5h.s9h.siprbaum@xp.machine.xx>
 <Pine.LNX.4.63.0702141246160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45D35092.8040901@xs4all.nl> <7vr6sso8w8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: hanwen@xs4all.nl,
	Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 20:25:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHPlN-0003BA-Jn
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 20:25:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbXBNTZy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 14:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbXBNTZy
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 14:25:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:40313 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932468AbXBNTZx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 14:25:53 -0500
Received: (qmail invoked by alias); 14 Feb 2007 19:25:52 -0000
X-Provags-ID: V01U2FsdGVkX1/fpgQHH5/fOnaTe2T8otcfHe0VVXhpiAIrKoq5/W
	m57w==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vr6sso8w8.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39726>

Hi,

On Wed, 14 Feb 2007, Junio C Hamano wrote:

> Han-Wen Nienhuys <hanwen@xs4all.nl> writes:
> 
> > Johannes Schindelin escreveu:
> >> The settings in /etc/gitconfig can be overridden in ~/.gitconfig,
> >> which in turn can be overridden in .git/config.
> >
> >> +#define ETC_GITCONFIG "/etc/gitconfig"
> >
> >> +		if (!access(ETC_GITCONFIG, R_OK))
> >> +			ret += git_config_from_file(fn, ETC_GITCONFIG);
> >
> > this is a stupid idea.  
> 
> Stupid probably is too strong a word, but I think I'd agree we
> should default it to $(prefix)/etc and have distros override it
> in the Makefile.

Fair enough. And my patch was not really complete. Please amend to spare 
me eternal shame:
--
[BROWN PAPERBAG PATCH ON TOP OF OTHER PATCH] 

It is $prefix/etc/gitconfig now, and works also if you do not
`git config -l`. D'oh.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 Makefile         |    5 ++++-
 builtin-config.c |    7 ++++++-
 cache.h          |    1 -
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 6f05abb..617908c 100644
--- a/Makefile
+++ b/Makefile
@@ -128,6 +128,7 @@ prefix = $(HOME)
 bindir = $(prefix)/bin
 gitexecdir = $(bindir)
 template_dir = $(prefix)/share/git-core/templates/
+ETC_GITCONFIG = $(prefix)/etc/gitconfig
 # DESTDIR=
 
 # default configuration for gitweb
@@ -591,6 +592,7 @@ endif
 # Shell quote (do not use $(call) to accommodate ancient setups);
 
 SHA1_HEADER_SQ = $(subst ','\'',$(SHA1_HEADER))
+ETC_GITCONFIG_SQ = $(subst ','\'',$(ETC_GITCONFIG))
 
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 bindir_SQ = $(subst ','\'',$(bindir))
@@ -603,7 +605,8 @@ PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
 
 LIBS = $(GITLIBS) $(EXTLIBS)
 
-BASIC_CFLAGS += -DSHA1_HEADER='$(SHA1_HEADER_SQ)' $(COMPAT_CFLAGS)
+BASIC_CFLAGS += -DSHA1_HEADER='$(SHA1_HEADER_SQ)' \
+	-DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"' $(COMPAT_CFLAGS)
 LIB_OBJS += $(COMPAT_OBJS)
 
 ALL_CFLAGS += $(BASIC_CFLAGS)
diff --git a/builtin-config.c b/builtin-config.c
index 0f9051d..34470c4 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -64,7 +64,7 @@ static int get_value(const char* key_, const char* regex_)
 	int ret = -1;
 	char *tl;
 	char *global = NULL, *repo_config = NULL;
-	const char *local;
+	const char *system_wide = NULL, *local;
 
 	local = getenv(CONFIG_ENVIRONMENT);
 	if (!local) {
@@ -74,6 +74,7 @@ static int get_value(const char* key_, const char* regex_)
 			local = repo_config = xstrdup(git_path("config"));
 		if (home)
 			global = xstrdup(mkpath("%s/.gitconfig", home));
+		system_wide = ETC_GITCONFIG;
 	}
 
 	key = xstrdup(key_);
@@ -103,11 +104,15 @@ static int get_value(const char* key_, const char* regex_)
 		}
 	}
 
+	if (do_all && system_wide)
+		git_config_from_file(show_config, system_wide);
 	if (do_all && global)
 		git_config_from_file(show_config, global);
 	git_config_from_file(show_config, local);
 	if (!do_all && !seen && global)
 		git_config_from_file(show_config, global);
+	if (!do_all && !seen && system_wide)
+		git_config_from_file(show_config, system_wide);
 
 	free(key);
 	if (regexp) {
diff --git a/cache.h b/cache.h
index e316f66..44941c0 100644
--- a/cache.h
+++ b/cache.h
@@ -123,7 +123,6 @@ extern int cache_errno;
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
 #define GRAFT_ENVIRONMENT "GIT_GRAFT_FILE"
 #define TEMPLATE_DIR_ENVIRONMENT "GIT_TEMPLATE_DIR"
-#define ETC_GITCONFIG "/etc/gitconfig"
 #define CONFIG_ENVIRONMENT "GIT_CONFIG"
 #define CONFIG_LOCAL_ENVIRONMENT "GIT_CONFIG_LOCAL"
 #define EXEC_PATH_ENVIRONMENT "GIT_EXEC_PATH"
