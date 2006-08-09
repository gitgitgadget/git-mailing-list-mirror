From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Update git-init-db(1) and documentation of core.sharedRepository
Date: Wed, 9 Aug 2006 02:26:23 +0200
Message-ID: <20060809002623.GB10115@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Aug 09 02:26:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAbu6-0002VZ-Rk
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 02:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbWHIA03 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 20:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbWHIA03
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 20:26:29 -0400
Received: from [130.225.96.91] ([130.225.96.91]:8903 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1030374AbWHIA02 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Aug 2006 20:26:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 905DE770002;
	Wed,  9 Aug 2006 02:26:25 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 03042-12; Wed,  9 Aug 2006 02:26:24 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id F23C4770001;
	Wed,  9 Aug 2006 02:26:23 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 291F46DF845; Wed,  9 Aug 2006 02:25:26 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id D849E629EB; Wed,  9 Aug 2006 02:26:23 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25105>

Combine option descriptions in git-init-db(1). Reflect the changes to
additionally allow all users to read the created git repository.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

I noticed that the git-init-db(1) --template description says: "The
default template directory is `/usr/share/git-core/templates`", which
makes me wonder if we should substitute these hard-coded paths when
installing the man pages ...

   $ sed \
	-e 's#/usr/share/git-core/templates#$(template_dir)#'
	... etc ...

... at least git-clone(1) also hard-codes this path.

 Documentation/config.txt      |    9 +++++--
 Documentation/git-init-db.txt |   51 ++++++++++++++++++++++++++++-------------
 2 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d89916b..4de7d72 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -83,9 +83,12 @@ core.repositoryFormatVersion::
 	version.
 
 core.sharedRepository::
-	If true, the repository is made shareable between several users
-	in a group (making sure all the files and objects are group-writable).
-	See gitlink:git-init-db[1]. False by default.
+	When 'group' (or 'true'), the repository is made shareable between
+	several users in a group (making sure all the files and objects are
+	group-writable). When 'all' (or 'world' or 'everybody'), the
+	repository will be readable by all users, additionally to being
+	group-shareable. When 'umask' (or 'false'), git will use permissions
+	reported by umask(2). See gitlink:git-init-db[1]. False by default.
 
 core.warnAmbiguousRefs::
 	If true, git will warn you if the ref name you passed it is ambiguous
diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
index 0a4fc14..3d04096 100644
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -8,17 +8,47 @@ git-init-db - Creates an empty git repos
 
 SYNOPSIS
 --------
-'git-init-db' [--template=<template_directory>] [--shared]
+'git-init-db' [--template=<template_directory>] [--shared[=<permissions>]]
 
 
 OPTIONS
 -------
+
+--
+
 --template=<template_directory>::
-	Provide the directory from which templates will be used.
-	The default template directory is `/usr/share/git-core/templates`.
 
---shared::
-	Specify that the git repository is to be shared amongst several users.
+Provide the directory from which templates will be used.  The default template
+directory is `/usr/share/git-core/templates`.
+
+When specified, `<template_directory>` is used as the source of the template
+files rather than the default.  The template files include some directory
+structure, some suggested "exclude patterns", and copies of non-executing
+"hook" files.  The suggested patterns and hook files are all modifiable and
+extensible.
+
+--shared[={false|true|umask|group|all|world|everybody}]::
+
+Specify that the git repository is to be shared amongst several users.  This
+allows users belonging to the same group to push into that
+repository.  When specified, the config variable "core.sharedRepository" is
+set so that files and directories under `$GIT_DIR` are created with the
+requested permissions.  When not specified, git will use permissions reported
+by umask(2).
+
+The option can have the following values, defaulting to 'group' if no value
+is given:
+
+ - 'umask' (or 'false'): Use permissions reported by umask(2). The default,
+   when `--shared` is not specified.
+
+ - 'group' (or 'true'): Make the repository group-writable, (and g+sx, since
+   the git group may be not the primary group of all users).
+
+ - 'all' (or 'world' or 'everybody'): Same as 'group', but make the repository
+   readable by all users.
+
+--
 
 
 DESCRIPTION
@@ -29,12 +59,6 @@ template files.
 An initial `HEAD` file that references the HEAD of the master branch
 is also created.
 
-If `--template=<template_directory>` is specified, `<template_directory>`
-is used as the source of the template files rather than the default.
-The template files include some directory structure, some suggested
-"exclude patterns", and copies of non-executing "hook" files.  The
-suggested patterns and hook files are all modifiable and extensible.
-
 If the `$GIT_DIR` environment variable is set then it specifies a path
 to use instead of `./.git` for the base of the repository.
 
@@ -42,11 +66,6 @@ If the object storage directory is speci
 environment variable then the sha1 directories are created underneath -
 otherwise the default `$GIT_DIR/objects` directory is used.
 
-A shared repository allows users belonging to the same group to push into that
-repository. When specifying `--shared` the config variable "core.sharedRepository" 
-is set to 'true' so that directories under `$GIT_DIR` are made group writable
-(and g+sx, since the git group may be not the primary group of all users).
-
 Running `git-init-db` in an existing repository is safe. It will not overwrite
 things that are already there. The primary reason for rerunning `git-init-db`
 is to pick up newly added templates.
-- 
Jonas Fonseca
