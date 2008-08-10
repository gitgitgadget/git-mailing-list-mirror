From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-submodule - Add 'foreach' subcommand
Date: Sun, 10 Aug 2008 12:44:07 -0400
Message-ID: <1218386647-2348-1-git-send-email-mlevedahl@gmail.com>
Cc: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 18:45:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSE2f-0006vH-9y
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 18:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753130AbYHJQoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 12:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753033AbYHJQoP
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 12:44:15 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:52651 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541AbYHJQoO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 12:44:14 -0400
Received: by wx-out-0506.google.com with SMTP id h29so1010433wxd.4
        for <git@vger.kernel.org>; Sun, 10 Aug 2008 09:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Ndphpg+7nhjRvKZHzcfGbxIhLCurtT9igUoVJrRr6kk=;
        b=qN72dxGzyXXUuyOvTEC7sFpbu245pShNRYTbv7MyDwlWtqxDKlUhxOmvaDKSOFFLNh
         NMCPNcMIkL9fj2v3Gc+3ZFZInwJWVjtJY5xg6iqscCTUY97JnyDYSbmuJtIjwHiGRjS/
         CCQoQobDW+gGoEBJeEYwEhON+A317v9FzPmUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=FRVXMI01cClv4zWNhwjcaq3OCWWrzDu44oKZ526G+ly+zY2UYaoCcEhC13qaeDZnTN
         ehDuotI8J/lDfPdd+EpZcOQpNWnHvF8BsEhlrCWuqr/COwe+NofR5l7uUgIJL/GUtXxq
         vSxbY44TFqycfcOTYTOL/Yea2OV+Y/HYmEONA=
Received: by 10.70.57.10 with SMTP id f10mr9520100wxa.20.1218386653835;
        Sun, 10 Aug 2008 09:44:13 -0700 (PDT)
Received: from localhost.localdomain ( [71.163.41.46])
        by mx.google.com with ESMTPS id h7sm4671123wxd.12.2008.08.10.09.44.11
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Aug 2008 09:44:12 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc2.44.g974eb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91855>

submodule foreach <command-list> will execute the list of commands in
each currently checked out submodule directory. The list of commands
is arbitrary as long as it is acceptable to sh. The variables '$path'
and '$sha1' are availble to the command-list, defining the submodule
path relative to the superproject and the submodules's commitID as
recorded in the superproject (this may be different than HEAD in the
submodule).

This utility is inspired by a number of threads on the mailing list
looking for ways to better integrate submodules in a tree and work
with them as a unit. This could include fetching a new branch in each
from a given source, or possibly checking out a given named branch in
each. Currently, there is no consensus as to what additional commands
should be implemented in the porcelain, requiring all users whose needs
exceed that of git-submodule to do their own scripting. The foreach
command is intended to support such scripting, and in particular does
no error checking and produces no output, thus allowing end users
complete control over any information printed out and over what
constitutes an error.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 Documentation/git-submodule.txt |   12 ++++++++++++
 git-submodule.sh                |   22 ++++++++++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index bf33b0c..5b52f35 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] update [--init] [--] [<path>...]
 'git submodule' [--quiet] summary [--summary-limit <n>] [commit] [--] [<path>...]
+'git submodule' foreach <command-list>
 
 
 DESCRIPTION
@@ -123,6 +124,17 @@ summary::
 	in the submodule between the given super project commit and the
 	index or working tree (switched by --cached) are shown.
 
+foreach::
+	Executes an arbitrary list of commands in each checked out submodule.
+	$path is the name of the submodule directory relative to the
+	superproject, and $sha1 is the commit as recorded in the superproject.
+	And submodules defined in the superproject but not checked out are
+	ignored by this command, and an empty command-list provides no output.
++
+As an example, "git submodule foreach 'echo $path `git rev-parse HEAD`' will
+show the path and currently checked out commit for each submodule.
+
+
 OPTIONS
 -------
 -q::
diff --git a/git-submodule.sh b/git-submodule.sh
index b40f876..abbc7bb 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -6,7 +6,7 @@
 
 USAGE="[--quiet] [--cached] \
 [add <repo> [-b branch] <path>]|[status|init|update [-i|--init]|summary [-n|--summary-limit <n>] [<commit>]] \
-[--] [<path>...]"
+[--] [<path>...]|[foreach <command-list>]"
 OPTIONS_SPEC=
 . git-sh-setup
 require_work_tree
@@ -199,6 +199,24 @@ cmd_add()
 }
 
 #
+# Execute an arbitrary command sequence in each checked out
+# submodule
+#
+# $@ = command to execute
+#
+cmd_foreach()
+{
+	git ls-files --stage | grep '^160000 ' |
+	while read mode sha1 stage path
+	do
+		if test -e "$path"/.git
+		then
+			(cd "$path" && eval "$@")
+		fi
+	done
+}
+
+#
 # Register submodules in .git/config
 #
 # $@ = requested paths (default to all)
@@ -583,7 +601,7 @@ cmd_status()
 while test $# != 0 && test -z "$command"
 do
 	case "$1" in
-	add | init | update | status | summary)
+	add | foreach | init | update | status | summary)
 		command=$1
 		;;
 	-q|--quiet)
-- 
1.6.0.rc2.44.g974eb
