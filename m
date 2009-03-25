From: Johan Herland <johan@herland.net>
Subject: [PATCH/RFC 4/7] git-init: Introduce --restricted for restricting
 repository access
Date: Wed, 25 Mar 2009 22:39:53 +0100
Message-ID: <200903252239.53864.johan@herland.net>
References: <200903250105.05808.johan@herland.net>
 <7v63hybaqd.fsf@gitster.siamese.dyndns.org>
 <200903252236.03010.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 22:41:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmaqj-0006pn-Dz
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 22:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754497AbZCYVj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 17:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753716AbZCYVj7
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 17:39:59 -0400
Received: from mx.getmail.no ([84.208.15.66]:41351 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753550AbZCYVj6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 17:39:58 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH300M8E06JMZ00@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 25 Mar 2009 22:39:55 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH300BSO06HR300@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 25 Mar 2009 22:39:55 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.3.25.212528
User-Agent: KMail/1.11.1 (Linux/2.6.28-ARCH; KDE/4.2.1; x86_64; ; )
In-reply-to: <200903252236.03010.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114675>

"--restricted" does for "core.restrictedRepository" what "--shared" does for
"core.sharedRepository".

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/config.txt   |    2 +-
 Documentation/git-init.txt |   38 +++++++++++++++++++++++++++++++++++++-
 builtin-init-db.c          |   22 ++++++++++++++++++----
 3 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0f2dd5c..08f8068 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -331,7 +331,7 @@ core.restrictedRepository::
 	Example: To set up a group-shared repository that is inaccessible to
 	all non-members, set both "core.sharedRepository" and
 	"core.restrictedRepository" to "group".
-	False by default.
+	See linkgit:git-init[1]. False by default.
 
 core.warnAmbiguousRefs::
 	If true, git will warn you if the ref name you passed it is ambiguous
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index bddc01b..2a431c2 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -8,7 +8,7 @@ git-init - Create an empty git repository or reinitialize an existing one
 
 SYNOPSIS
 --------
-'git init' [-q | --quiet] [--bare] [--template=<template_directory>] [--shared[=<permissions>]]
+'git init' [-q | --quiet] [--bare] [--template=<template_directory>] [--shared[=<permissions>]] [--restricted[=<permissions>]]
 
 
 OPTIONS
@@ -72,6 +72,42 @@ By default, the configuration flag receive.denyNonFastForwards is enabled
 in shared repositories, so that you cannot force a non fast-forwarding push
 into it.
 
+--restricted[={false|true|umask|group|user|0xxx}]::
+
+Specify that the git repository is to be restricted according to the given
+permission mask.  This allows you to more finely control access to the
+repository.  When specified, the config variable "core.restrictedRepository"
+is set so that files and directories under `$GIT_DIR` are created with the
+restrictions in the given mask.  When not specified, git will use permissions
+reported by umask(2). When specified, the permissions will still be no more
+lenient than the umask allows.
+
+The option can have the following values, defaulting to 'user' if no value
+is given:
+
+ - 'umask' (or 'false'): Use permissions reported by umask(2). The default,
+   when `--restricted` is not specified.
+
+ - 'group': Make the repository accessible only to members of the group
+   owning the repository.
+
+ - 'user' (or 'true'): Make the repository inaccessible to anybody but the
+   repository owner.
+
+ - '0xxx': '0xxx' is an octal number and each file will have (at least) these
+   mode bits masked off the repository permission. '0xxx' will override a
+   more lenient umask(2) value (but not a stricter/safer umask), and thus,
+   users with a lenient umask (e.g. 0022) can use this option to tighten
+   repository permissions. '0000' is equivalent to 'umask', '0007' is
+   equivalent to 'group', and '0077' is equivalent to 'user'.
+   '0027' will create a repository which is group-readable (unless overridden
+   by the current umask), but not group-writable, and inaccessible to others.
+
+You can combine `--shared` and `--restricted` to finely control the access to
+the repository. For example, specifying `--shared=group --restricted=group`
+will ensure that the repository is group-readable and group-writable, and
+also non world-readable and non world-writable.
+
 --
 
 
diff --git a/builtin-init-db.c b/builtin-init-db.c
index fc63d0f..8e7fa2d 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -19,6 +19,7 @@
 
 static int init_is_bare_repository = 0;
 static int init_shared_repository = -1;
+static int init_restricted_repository = -1;
 
 static void safe_create_dir(const char *dir, int share)
 {
@@ -29,7 +30,7 @@ static void safe_create_dir(const char *dir, int share)
 		}
 	}
 	else if (share && adjust_shared_perm(dir))
-		die("Could not make %s writable by group", dir);
+		die("Could not set proper permissions on %s", dir);
 }
 
 static void copy_templates_1(char *path, int baselen,
@@ -196,12 +197,14 @@ static int create_default_files(const char *template_path)
 	is_bare_repository_cfg = init_is_bare_repository;
 	if (init_shared_repository != -1)
 		shared_repository = init_shared_repository;
+	if (init_restricted_repository != -1)
+		restricted_repository = init_restricted_repository;
 
 	/*
 	 * We would have created the above under user's umask -- under
 	 * shared-repository settings, we would need to fix them up.
 	 */
-	if (shared_repository) {
+	if (shared_repository || restricted_repository) {
 		adjust_shared_perm(get_git_dir());
 		adjust_shared_perm(git_path("refs"));
 		adjust_shared_perm(git_path("refs/heads"));
@@ -321,11 +324,17 @@ int init_db(const char *template_dir, unsigned int flags)
 		git_config_set("core.sharedrepository", buf);
 		git_config_set("receive.denyNonFastforwards", "true");
 	}
+	if (restricted_repository) {
+		char buf[5];
+		sprintf(buf, "%04o", restricted_repository);
+		git_config_set("core.restrictedrepository", buf);
+	}
 
 	if (!(flags & INIT_DB_QUIET))
-		printf("%s%s Git repository in %s/\n",
+		printf("%s%s%s Git repository in %s/\n",
 		       reinit ? "Reinitialized existing" : "Initialized empty",
 		       shared_repository ? " shared" : "",
+		       restricted_repository ? " restricted" : "",
 		       get_git_dir());
 
 	return 0;
@@ -363,7 +372,7 @@ static int guess_repository_type(const char *git_dir)
 }
 
 static const char init_db_usage[] =
-"git init [-q | --quiet] [--bare] [--template=<template-directory>] [--shared[=<permissions>]]";
+"git init [-q | --quiet] [--bare] [--template=<template-directory>] [--shared[=<permissions>]] [--restricted[=<permissions>]]";
 
 /*
  * If you want to, you can share the DB area with any number of branches.
@@ -391,6 +400,11 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 			init_shared_repository = PERM_GROUP;
 		else if (!prefixcmp(arg, "--shared="))
 			init_shared_repository = git_config_perm("arg", arg+9);
+		else if (!strcmp(arg, "--restricted"))
+			init_restricted_repository = PERM_MASK_USER;
+		else if (!prefixcmp(arg, "--restricted="))
+			init_restricted_repository =
+				git_config_perm_mask("arg", arg+13);
 		else if (!strcmp(arg, "-q") || !strcmp(arg, "--quiet"))
 			flags |= INIT_DB_QUIET;
 		else
-- 
1.6.2.1.473.g92672
