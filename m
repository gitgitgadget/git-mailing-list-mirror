From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] new environment variable GIT_TEMPLATE_DIR to override default template
Date: Sat, 27 May 2006 20:57:19 +0200
Message-ID: <E1Fk3yR-0006Gd-36@moooo.ath.cx>
References: <20060527132554.GC10488@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat May 27 20:57:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fk3yY-0005aJ-L1
	for gcvg-git@gmane.org; Sat, 27 May 2006 20:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbWE0S5W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 14:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbWE0S5W
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 14:57:22 -0400
Received: from moooo.ath.cx ([85.116.203.178]:51662 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S964927AbWE0S5V (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 May 2006 14:57:21 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060527132554.GC10488@pasky.or.cz>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20868>

directory and --template=<template_directory> option for to git-clone

---
> Please document such changes, in the spirit of

That's right, here are both patches in one because the second patch
would also change the documentation of the first one.

---


ac3c3fdd2423d2184306af3e6e93397475953284
 Documentation/git-clone.txt   |   10 ++++++++--
 Documentation/git-init-db.txt |    2 ++
 builtin-init-db.c             |    3 +++
 git-clone.sh                  |    7 +++++--
 4 files changed, 18 insertions(+), 4 deletions(-)

ac3c3fdd2423d2184306af3e6e93397475953284
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index b333f51..8e833aa 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -9,8 +9,8 @@ git-clone - Clones a repository
 SYNOPSIS
 --------
 [verse]
-'git-clone' [-l [-s]] [-q] [-n] [--bare] [-o <name>] [-u <upload-pack>]
-	  [--reference <repository>]
+'git-clone' [--template=<template_directory>] [-l [-s]] [-q] [-n] [--bare]
+	  [-o <name>] [-u <upload-pack>] [--reference <repository>]
 	  <repository> [<directory>]
 
 DESCRIPTION
@@ -34,6 +34,12 @@ branch you are currently working on.  Re
 
 OPTIONS
 -------
+--template=<template_directory>::
+	Provide the directory from which templates will be used.
+	The default template directory is `/usr/share/git-core/templates`.
+	You can override the default template directory with the
+	`$GIT_TEMPLATE_DIR` environment variable.
+
 --local::
 -l::
 	When the repository to clone from is on a local machine,
diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
index 8a150d8..273f394 100644
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -16,6 +16,8 @@ OPTIONS
 --template=<template_directory>::
 	Provide the directory from which templates will be used.
 	The default template directory is `/usr/share/git-core/templates`.
+	You can override the default template directory with the
+	`$GIT_TEMPLATE_DIR` environment variable.
 
 --shared::
 	Specify that the git repository is to be shared amongst several users.
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 2a1384c..cf5bd39 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -253,6 +253,9 @@ int cmd_init_db(int argc, const char **a
 			die(init_db_usage);
 	}
 
+	if (!template_dir)
+		template_dir = getenv("GIT_TEMPLATE_DIR");
+
 	/*
 	 * Set up the default .git directory contents
 	 */
diff --git a/git-clone.sh b/git-clone.sh
index d96894d..1c7ae12 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -9,7 +9,7 @@ # See git-sh-setup why.
 unset CDPATH
 
 usage() {
-	echo >&2 "Usage: $0 [--use-separate-remote] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [-n] <repo> [<dir>]"
+	echo >&2 "Usage: $0 [--template=<template_directory>] [--use-separate-remote] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [-n] <repo> [<dir>]"
 	exit 1
 }
 
@@ -102,6 +102,7 @@ quiet=
 local=no
 use_local=no
 local_shared=no
+template=
 no_checkout=
 upload_pack=
 bare=
@@ -120,6 +121,8 @@ while
 	*,-l|*,--l|*,--lo|*,--loc|*,--loca|*,--local) use_local=yes ;;
         *,-s|*,--s|*,--sh|*,--sha|*,--shar|*,--share|*,--shared) 
           local_shared=yes; use_local=yes ;;
+	*,--template=*)
+	  template="$1" ;;
 	*,-q|*,--quiet) quiet=-q ;;
 	*,--use-separate-remote)
 		use_separate_remote=t ;;
@@ -203,7 +206,7 @@ trap 'err=$?; cd ..; rm -r "$D"; exit $e
 case "$bare" in
 yes) GIT_DIR="$D" ;;
 *) GIT_DIR="$D/.git" ;;
-esac && export GIT_DIR && git-init-db || usage
+esac && export GIT_DIR && git-init-db "$template" || usage
 case "$bare" in
 yes)
 	GIT_DIR="$D" ;;
-- 
1.3.3.g40505
