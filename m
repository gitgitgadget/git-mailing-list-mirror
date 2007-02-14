From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] config: read system-wide defaults from /etc/gitconfig
Date: Wed, 14 Feb 2007 12:48:14 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702141246160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702140909.28369.andyparkins@gmail.com> <slrnet5p5h.s9h.siprbaum@xp.machine.xx>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-282141465-1171453694=:22628"
Cc: git@vger.kernel.org
To: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>,
	Andy Parkins <andyparkins@gmail.com>, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Feb 14 12:48:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHIcY-0005xV-9u
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 12:48:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbXBNLsQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 06:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbXBNLsQ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 06:48:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:54640 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751306AbXBNLsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 06:48:16 -0500
Received: (qmail invoked by alias); 14 Feb 2007 11:48:14 -0000
X-Provags-ID: V01U2FsdGVkX1+V0IIIdVGVjGtJ9SeI+L9aH8EiXseN+xaQmJDzd0
	J4tA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <slrnet5p5h.s9h.siprbaum@xp.machine.xx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39639>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-282141465-1171453694=:22628
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT


The settings in /etc/gitconfig can be overridden in ~/.gitconfig,
which in turn can be overridden in .git/config.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	On Wed, 14 Feb 2007, Peter Baumann wrote:

	> Andy Parkins <andyparkins@gmail.com> schrieb:
	> >
	> > With the release of 1.5.0 I added legacyheaders=false and
	> > usedelatbaseoffset=true to my repositories.
	> >
	> > While doing that though, it felt wrong to be editing every 
	> > single config.  Is there a justification for having three 
	> > config files?
	> >
	> >  /etc/gitconfig
	> >  $HOME/.gitconfig
	> >  $GIT_DIR/config
	> >
	> > With /etc/gitconfig coming in at lowest priority?
	> 
	> I would like this, too. This would allow me to set e.g.
	> "diff.color = auto" for everyone one a machine. We use git there 
	> to only manage some config files and several simple perl 
	> scripts. As it is mostly myself who does the editing, 
	> ~/.gitconfig works for *ME*.
	> 
	> But I'd like to set this globally so that my colluagues which 
	> don't have much clue about git don't need to bother about config 
	> settings. And yes, editing every single repo doesn't seem like 
	> an elegant solution.

	Voilà.

 Documentation/config.txt |    3 ++-
 cache.h                  |    1 +
 config.c                 |    2 ++
 3 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3865535..1dd90d8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -5,7 +5,8 @@ The git configuration file contains a number of variables that affect
 the git command's behavior. `.git/config` file for each repository
 is used to store the information for that repository, and
 `$HOME/.gitconfig` is used to store per user information to give
-fallback values for `.git/config` file.
+fallback values for `.git/config` file. The file `/etc/gitconfig`
+can be used to store system-wide defaults.
 
 They can be used by both the git plumbing
 and the porcelains. The variables are divided into sections, where
diff --git a/cache.h b/cache.h
index 44941c0..e316f66 100644
--- a/cache.h
+++ b/cache.h
@@ -123,6 +123,7 @@ extern int cache_errno;
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
 #define GRAFT_ENVIRONMENT "GIT_GRAFT_FILE"
 #define TEMPLATE_DIR_ENVIRONMENT "GIT_TEMPLATE_DIR"
+#define ETC_GITCONFIG "/etc/gitconfig"
 #define CONFIG_ENVIRONMENT "GIT_CONFIG"
 #define CONFIG_LOCAL_ENVIRONMENT "GIT_CONFIG_LOCAL"
 #define EXEC_PATH_ENVIRONMENT "GIT_EXEC_PATH"
diff --git a/config.c b/config.c
index d821071..b0c0948 100644
--- a/config.c
+++ b/config.c
@@ -383,6 +383,8 @@ int git_config(config_fn_t fn)
 	 * config file otherwise. */
 	filename = getenv(CONFIG_ENVIRONMENT);
 	if (!filename) {
+		if (!access(ETC_GITCONFIG, R_OK))
+			ret += git_config_from_file(fn, ETC_GITCONFIG);
 		home = getenv("HOME");
 		filename = getenv(CONFIG_LOCAL_ENVIRONMENT);
 		if (!filename)
-- 
1.5.0.rc4.2447.g06287-dirty

---1148973799-282141465-1171453694=:22628--
