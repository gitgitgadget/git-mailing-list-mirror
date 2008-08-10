From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-submodule - Add 'foreach' subcommand
Date: Sun, 10 Aug 2008 19:10:04 -0400
Message-ID: <1218409804-1556-1-git-send-email-mlevedahl@gmail.com>
References: <7vsktczebg.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, johan@herland.net,
	Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 11 01:11:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSK4A-0002WP-0W
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 01:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296AbYHJXKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 19:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752668AbYHJXKL
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 19:10:11 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:17096 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbYHJXKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 19:10:09 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1229906wri.5
        for <git@vger.kernel.org>; Sun, 10 Aug 2008 16:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4G6ZSGXgy+ZEfwgF1dDpaERbpbtmev+xXX9ZMVMtuLQ=;
        b=btjzibXPw4d5DO5rzbNLLK/GcjEz2pK/Gh7+CAu4wRo4tSCBRAHPfFkKu13911+W+z
         x4xz/prK8zi7V8Dv1RRV8ggSnUE+zEQWNvqQKBs0brGsBNi0viC7Ly1KYw4UpvUqeIg9
         WEcSSVLywiVt3CpUvcVNi8YbCJ2Xt9fjtGeVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=c6WzQLI2ifBYhXAtJ/Dh6Qs4Uiz1i25cvArx2X6iLTNfh44sdf5gXuRikkr5tx8JpW
         HCqAb/GGHsxjMrG0vpfe1WdtYdzCO6XXPeIzIXNFa210t6cVvan3jX0gIIMrSQKsr74s
         s39zOKi0pqRBwSd6ydHGfVgw4Z08xw2veAgXQ=
Received: by 10.90.93.13 with SMTP id q13mr7656235agb.106.1218409808475;
        Sun, 10 Aug 2008 16:10:08 -0700 (PDT)
Received: from localhost.localdomain ( [71.163.41.46])
        by mx.google.com with ESMTPS id g7sm618571wra.16.2008.08.10.16.10.06
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Aug 2008 16:10:07 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc2.44.g974eb
In-Reply-To: <7vsktczebg.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91900>

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
constitutes an error. The processing does terminate if the command-list
returns an error, but processing can easily be forced for all
submodules be terminating the list with ';true'.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 Documentation/git-submodule.txt |   15 +++++++++++++++
 git-submodule.sh                |   23 +++++++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index bf33b0c..1e7d352 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] update [--init] [--] [<path>...]
 'git submodule' [--quiet] summary [--summary-limit <n>] [commit] [--] [<path>...]
+'git submodule' foreach <command-list>
 
 
 DESCRIPTION
@@ -123,6 +124,20 @@ summary::
 	in the submodule between the given super project commit and the
 	index or working tree (switched by --cached) are shown.
 
+foreach::
+	Executes an arbitrary list of commands in each checked out submodule.
+	$path is the name of the submodule directory relative to the
+	superproject, and $sha1 is the commit as recorded in the superproject.
+	Any submodules defined in the superproject but not checked out are
+	ignored by this command, and an empty command-list provides no output.
+	A non-zero return from the command-list in any submodule causes
+	the processing to terminate. This can be overridden by adding '; true'
+	to the end of the command list.
++
+As an example, "git submodule foreach 'echo $path `git rev-parse HEAD`' will
+show the path and currently checked out commit for each submodule.
+
+
 OPTIONS
 -------
 -q::
diff --git a/git-submodule.sh b/git-submodule.sh
index b40f876..39a19f0 100755
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
@@ -199,6 +199,25 @@ cmd_add()
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
+			(cd "$path" && eval "$@") ||
+			die "Error detected evaluating commands in '$path'"
+		fi
+	done
+}
+
+#
 # Register submodules in .git/config
 #
 # $@ = requested paths (default to all)
@@ -583,7 +602,7 @@ cmd_status()
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
