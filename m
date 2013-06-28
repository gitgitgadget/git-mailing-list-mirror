From: Chris Packham <judge.packham@gmail.com>
Subject: [RFC/PATCH] submodule: add 'exec' option to submodule update
Date: Fri, 28 Jun 2013 21:53:10 +1200
Message-ID: <1372413190-32732-1-git-send-email-judge.packham@gmail.com>
Cc: Jens.Lehmann@web.de, Chris Packham <judge.packham@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 28 11:53:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsVN2-0001Eh-OV
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 11:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187Ab3F1Jxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 05:53:32 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:62254 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755015Ab3F1Jxb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 05:53:31 -0400
Received: by mail-pb0-f51.google.com with SMTP id um15so2080777pbc.24
        for <git@vger.kernel.org>; Fri, 28 Jun 2013 02:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=cTHb8zKa10iA8LMq+BrulS5T4S5IkzBdhnF+dOR8yuA=;
        b=xD15JcWoRWJEryY13ZBQZlbMtJE2KjxPEtsz7FSgyebhes+G/U1c47hAmH5Y4R+LUu
         mP3EtLVrOVhdTi0HvzkOWDvvVnrKgaDJIP24h54idPKTuiQLSKC1Wvlz0U/jwo7OSRIi
         woQIDHgwys2NqAwgOaPDHwENDapTlm35u4trDrVU4FmN86+ira6Qzkhe+6nkCvRbypZJ
         b2AsmtAAWnyKhe+8K7bh3SIgcb8A/nVkG+v3EdomNkcWzSfOabFWzrww8kzfWiGODfqh
         ZbXUqJM7Gpv7rBgMWr1G93SKpI1d9XETW0fIvvq606zwzQFzeS756VzX7ibaZbF8zDKo
         YIMA==
X-Received: by 10.68.252.233 with SMTP id zv9mr10535742pbc.69.1372413210869;
        Fri, 28 Jun 2013 02:53:30 -0700 (PDT)
Received: from chrisp3-dl.ws.atlnz.lc ([202.36.163.2])
        by mx.google.com with ESMTPSA id bs3sm7342723pbc.42.2013.06.28.02.53.28
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 28 Jun 2013 02:53:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.643.gebeea52.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229183>

This allows the user some finer grained control over how the update is
done. The primary motivation for this was interoperability with stgit
however being able to intercept the submodule update process may prove
useful for integrating or extending other tools.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
--
Hi,

At $dayjob we have a number of users that are accustomed to using stgit.
Stgit doesn't play nicely with git rebase which would be the logical
setting for submodule.*.update for our usage. Instead we need to run
'stg rebase --merged' on those submodules that have been initialised
with stgit.

Our current solution is an in-house script which is a poor substitute
for git submodule update. I'd much rather replace our script with git
submodule update but we do have a requirement to keep stgit for the
foreseeable future.  Rather than narrowing in on stgit it seems logical
to allow an arbitrary update command to be executed.
---
 Documentation/git-submodule.txt |  8 +++++++-
 git-submodule.sh                | 22 +++++++++++++++++++++-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index e576713..a0d8b89 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
 'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
 	      [-f|--force] [--rebase] [--reference <repository>]
-	      [--merge] [--recursive] [--] [<path>...]
+	      [--merge] [--recursive] [--exec <command>] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
 	      [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
@@ -172,6 +172,12 @@ If `--force` is specified, the submodule will be checked out (using
 `git checkout --force` if appropriate), even if the commit specified in the
 index of the containing repository already matches the commit checked out in
 the submodule.
++
+If `--exec` is specified the next argument is an arbitrary shell command that
+can be used to gain finer control over how the update is done or integrate with
+external tools. The command should take one argument namely the sha1 of the
+commit to update to. The config variable `submodule.$name.update` can be set
+to `exec` along with `submodule.$name.update.command`.
 
 summary::
 	Show commit summary between the given commit (defaults to HEAD) and
diff --git a/git-submodule.sh b/git-submodule.sh
index eb58c8e..44631c8 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -9,7 +9,7 @@ USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <re
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
-   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--exec <command>] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
@@ -32,6 +32,7 @@ nofetch=
 update=
 prefix=
 custom_name=
+update_exec_command=
 
 # The function takes at most 2 arguments. The first argument is the
 # URL that navigates to the submodule origin repo. When relative, this URL
@@ -677,6 +678,12 @@ cmd_update()
 		--checkout)
 			update="checkout"
 			;;
+		--exec)
+			case "$2" in '') usage ;; esac
+			update="exec"
+			update_exec_command="$2"
+			shift
+			;;
 		--)
 			shift
 			break
@@ -718,6 +725,11 @@ cmd_update()
 			update_module=$(git config submodule."$name".update)
 		fi
 
+		if test -z "$update_exec_command"
+		then
+			exec_command=$(git config submodule."$name".update.command)
+		fi
+
 		if test "$update_module" = "none"
 		then
 			echo "Skipping submodule '$prefix$sm_path'"
@@ -799,6 +811,14 @@ Maybe you want to use 'update --init'?")"
 				say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': merged in '\$sha1'")"
 				must_die_on_failure=yes
 				;;
+			exec)
+				test -n "$exec_command" || \
+					die "$(eval_gettext "Unable to update '\$prefix\$sm_path' exec command not specified")"
+				command="$exec_command"
+				die_msg="$(eval_gettext "Unable to exec '\$command \$sha1' in submodule path '\$prefix\$sm_path'")"
+				say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': '\$command \$sha1'")"
+				must_die_on_failure=yes
+				;;
 			*)
 				command="git checkout $subforce -q"
 				die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$prefix\$sm_path'")"
-- 
1.8.3.1.643.gebeea52.dirty
