From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 9/9] remove #!interpreter line from shell libraries
Date: Mon, 25 Nov 2013 13:03:52 -0800
Message-ID: <20131125210352.GZ4212@google.com>
References: <20131125205119.GQ4212@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Clemens Buchacher <drizzd@aon.at>,
	Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 22:04:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl3KB-0004tX-Lf
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 22:04:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391Ab3KYVD7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Nov 2013 16:03:59 -0500
Received: from mail-yh0-f49.google.com ([209.85.213.49]:60799 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308Ab3KYVDz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 16:03:55 -0500
Received: by mail-yh0-f49.google.com with SMTP id z20so3290167yhz.36
        for <git@vger.kernel.org>; Mon, 25 Nov 2013 13:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uRJPdMrZVQN9v178OQAP/p2VXUJ37ReZh/sTpFGxHvI=;
        b=tQw30/OskLyoOQt4v9QKoge7ik28No19196bM1EOpWlqP77C2YSgjzjRI3UusWN2wH
         e7Q5cWJ1zhZ4eWzXZUPp1yFfceB3Pi/DreQb4rEHGks0QNw16gCIeXiqw1XEzH8sIe+v
         FMbo1miopz6KC8mOsS8amh9D4MiuI0pX/5gsPz786gD+Mef4USMERqhytdUFlxYqUWbY
         uh2GF8vx52WdhhAQGeTIoWh5kJYoHFvfZz4l+RabyTOOPbKxrejyoih9BG866P7Ymg78
         yKcU2A6JsEIp0i7NvQvGVdd8747LRjYxETxE+I0LyQZtZxLj3bl7zgoLFBZCGpFEdkOP
         lYAQ==
X-Received: by 10.236.66.142 with SMTP id h14mr1765839yhd.74.1385413435162;
        Mon, 25 Nov 2013 13:03:55 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id w45sm14670416yhk.4.2013.11.25.13.03.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 Nov 2013 13:03:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131125205119.GQ4212@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238358>

In a shell snippet meant to be sourced by other shell scripts, an
opening #! line does more harm than good.

The harm:

 - When the shell library is sourced, the interpreter and options from
   the #! line are not used.  Specifying a particular shell can
   confuse the reader into thinking it is safe for the shell library
   to rely on idiosyncrasies of that shell.

 - Using #! instead of a plain comment drops a helpful visual clue
   that this is a shell library and not a self-contained script.

 - Tools such as lintian can use a #! line to tell when an
   installation script has failed by forgetting to set a script
   executable.  This check does not work if shell libraries also start
   with a #! line.

The good:

 - Text editors notice the #! line and use it for syntax highlighting
   if you try to edit the installed scripts (without ".sh" suffix) in
   place.

The use of the #! for file type detection is not needed because Git's
shell libraries are meant to be edited in source form (with ".sh"
suffix).  Replace the opening #! lines with comments.

This involves tweaking the test harness's valgrind support to find
shell libraries by looking for "# " in the first line instead of "#!"
(see v1.7.6-rc3~7, 2011-06-17).

Suggested by Russ Allbery through lintian.  Thanks to Jeff King and
Clemens Buchacher for further analysis.

Tested by searching for non-executable scripts with #! line:

	find . -name .git -prune -o -type f -not -executable |
	while read file
	do
		read line <"$file"
		case $line in
		'#!'*)
			echo "$file"
			;;
		esac
	done

The only remaining scripts found are templates for shell scripts
(unimplemented.sh, wrap-for-bin.sh) and sample input used in tests
(t/t4034/perl/{pre,post}).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks for reading.

 contrib/completion/git-completion.bash | 2 --
 contrib/completion/git-completion.tcsh | 2 --
 git-mergetool--lib.sh                  | 3 +--
 git-parse-remote.sh                    | 4 +++-
 git-rebase--am.sh                      | 3 ++-
 git-rebase--interactive.sh             | 9 +++------
 git-rebase--merge.sh                   | 4 +++-
 git-sh-i18n.sh                         | 5 ++---
 git-sh-setup.sh                        | 9 +++------
 t/test-lib.sh                          | 6 ++----
 10 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index dba3c15..be61931 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1,5 +1,3 @@
-#!bash
-#
 # bash/zsh completion support for core Git.
 #
 # Copyright (C) 2006,2007 Shawn O. Pearce <spearce@spearce.org>
diff --git a/contrib/completion/git-completion.tcsh b/contrib/completio=
n/git-completion.tcsh
index eaacaf0..6104a42 100644
--- a/contrib/completion/git-completion.tcsh
+++ b/contrib/completion/git-completion.tcsh
@@ -1,5 +1,3 @@
-#!tcsh
-#
 # tcsh completion support for core Git.
 #
 # Copyright (C) 2012 Marc Khouzam <marc.khouzam@gmail.com>
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index a280f49..c45a020 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -1,5 +1,4 @@
-#!/bin/sh
-# git-mergetool--lib is a library for common merge tool functions
+# git-mergetool--lib is a shell library for common merge tool function=
s
=20
 : ${MERGE_TOOLS_DIR=3D$(git --exec-path)/mergetools}
=20
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 0e87e09..55fe8d5 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -1,4 +1,6 @@
-#!/bin/sh
+# This is a shell library to calculate the remote repository and
+# upstream branch that should be pulled by "git pull" from the current
+# branch.
=20
 # git-ls-remote could be called from outside a git managed repository;
 # this would fail in that case and would issue an error message.
diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 34e3102..a4f683a 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -1,4 +1,5 @@
-#!/bin/sh
+# This shell script fragment is sourced by git-rebase to implement
+# its default, fast, patch-based, non-interactive mode.
 #
 # Copyright (c) 2010 Junio C Hamano.
 #
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3c6bed9..43c19e0 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1,11 +1,8 @@
-#!/bin/sh
+# This shell script fragment is sourced by git-rebase to implement
+# its interactive mode.  "git rebase --interactive" makes it easy
+# to fix up commits in the middle of a series and rearrange commits.
 #
 # Copyright (c) 2006 Johannes E. Schindelin
-
-# SHORT DESCRIPTION
-#
-# This script makes it easy to fix up commits in the middle of a serie=
s,
-# and rearrange commits.
 #
 # The original idea comes from Eric W. Biederman, in
 # http://article.gmane.org/gmane.comp.version-control.git/22407
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index 16d1817..e7d96de 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -1,4 +1,6 @@
-#!/bin/sh
+# This shell script fragment is sourced by git-rebase to implement
+# its merge-based non-interactive mode that copes well with renamed
+# files.
 #
 # Copyright (c) 2010 Junio C Hamano.
 #
diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index 6a27f68..e6c3116 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -1,9 +1,8 @@
-#!/bin/sh
+# This shell library is Git's interface to gettext.sh. See po/README
+# for usage instructions.
 #
 # Copyright (c) 2010 =C6var Arnfj=F6r=F0 Bjarmason
 #
-# This is Git's interface to gettext.sh. See po/README for usage
-# instructions.
=20
 # Export the TEXTDOMAIN* data that we need for Git
 TEXTDOMAIN=3Dgit
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index ebfe8f7..190a539 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -1,9 +1,6 @@
-#!/bin/sh
-#
-# This is included in commands that either have to be run from the top=
level
-# of the repository, or with GIT_DIR environment variable properly.
-# If the GIT_DIR does not look like the right correct git-repository,
-# it dies.
+# This shell scriplet is meant to be included by other shell scripts
+# to set up some variables pointing at the normal git directories and
+# a few helper shell functions.
=20
 # Having this variable in your environment would break scripts because
 # you would cause "cd" to be taken to unexpected places.  If you
diff --git a/t/test-lib.sh b/t/test-lib.sh
index c306bd0..c3e07b9 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -573,11 +573,9 @@ then
=20
 	make_valgrind_symlink () {
 		# handle only executables, unless they are shell libraries that
-		# need to be in the exec-path.  We will just use "#!" as a
-		# guess for a shell-script, since we have no idea what the user
-		# may have configured as the shell path.
+		# need to be in the exec-path.
 		test -x "$1" ||
-		test "#!" =3D "$(head -c 2 <"$1")" ||
+		test "# " =3D "$(head -c 2 <"$1")" ||
 		return;
=20
 		base=3D$(basename "$1")
--=20
1.8.4.1
