From: Chris Packham <judge.packham@gmail.com>
Subject: [RFC PATCH 2/2] submodule: add grep command
Date: Thu, 23 Sep 2010 14:17:07 -0700
Message-ID: <1285276627-7907-3-git-send-email-judge.packham@gmail.com>
References: <1285276627-7907-1-git-send-email-judge.packham@gmail.com>
Cc: Chris Packham <judge.packham@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 23 23:17:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OytAU-0002xQ-Pw
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 23:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756697Ab0IWVRD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 17:17:03 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:48925 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756173Ab0IWVRA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 17:17:00 -0400
Received: by pxi10 with SMTP id 10so629035pxi.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 14:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=JmNVLXvTODZnQvj/JvoQiLdBVg74/Wvx5Lwwp8z/314=;
        b=DCtmUKbv0GxYK4PjhgsVeNGpXdqBaSQgG0GN7XTnJMP7jZYxX6CGVpOopbBastIWws
         YYHMDc1CgJubIVwVFeeuUn0sV4Onhz5X0XWh49fCzxQfzPT/BGswOkJavyhF5R7qMYyb
         AwnnAakgeuzN21PdxkCpnQCEDPnAAEFWYyJJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IDKJjOXZw4Y6W5IsvzVzYCqS/Qqj0vVa7NCdE/WrLIuIHBGNNwkInyS3QA56FNYFiQ
         wuaR3EgGLy7AF4ab9izFMLPc3uiLASw6aa7niS+o0isyd5jpCTGd4Y0RuIiAEMYwt3h7
         fn7LgsevsRQPPXEc7krPEYRy2jNuolTAeE1PM=
Received: by 10.114.152.6 with SMTP id z6mr2477721wad.151.1285276620031;
        Thu, 23 Sep 2010 14:17:00 -0700 (PDT)
Received: from localhost.localdomain (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id o17sm2133641wal.21.2010.09.23.14.16.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Sep 2010 14:16:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.dirty
In-Reply-To: <1285276627-7907-1-git-send-email-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156914>

This adds a 'grep' command to the 'git submodule' commands. Internally it is
basically a wrapper for "git submodule foreach 'git grep <pattern>'" but
does have the advantage of supplying results with a path relative to the
current directory.

Unlike contrib/git-submodule-grep.sh this can only be run from the root of a
submodule or the root of the superproject.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
 git-sh-setup.sh  |   19 +++++++++++++++++++
 git-submodule.sh |   41 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 6131670..2a1d585 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -145,6 +145,25 @@ require_work_tree () {
 	die "fatal: $0 cannot be used without a working tree."
 }
 
+submodule_root_relative()
+{
+	ceiling="$HOME"
+	while test ! -e "$cdup.gitmodules"; do
+		cdup="$cdup../"
+		if test "$(cd $cdup && pwd)" == "$ceiling"; then
+			echo >&2 "fatal: failed to find superproject root."
+			echo >&2 "       stopped searching at $ceiling".
+			exit 1
+		fi
+	done
+    echo "$cdup"
+}
+
+submodule_root()
+{
+    (cd "$(submodule_root_relative)" && pwd)
+}
+
 get_author_ident_from_commit () {
 	pick_author_script='
 	/^author /{
diff --git a/git-submodule.sh b/git-submodule.sh
index 9ebbab7..3edaa49 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -11,7 +11,8 @@ USAGE="[--quiet] add [-b branch] [-f|--force] [--reference <repository>] [--] <r
    or: $dashless [--quiet] update [--init] [-N|--no-fetch] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
-   or: $dashless [--quiet] sync [--] [<path>...]"
+   or: $dashless [--quiet] sync [--] [<path>...]
+   or: $dashless [--quiet] grep [--] [-n] [<pattern>]"
 OPTIONS_SPEC=
 . git-sh-setup
 . git-parse-remote
@@ -849,6 +850,42 @@ cmd_sync()
 		fi
 	done
 }
+#
+# Search for a pattern within all submodules
+# This is a fairly simple wrapper using foreach and git grep,
+# arguments could be passed to git grep but for now we only
+# understand -n
+#
+cmd_grep()
+{
+	grep_args=""
+	while test $# -ne 0
+	do
+		case "$1" in
+		-n)
+			grep_args="$1"
+			shift
+			;;
+		--)
+			shift
+			break
+			;;
+		-*)
+			usage
+			;;
+		*)
+			break
+			;;
+		esac
+	done
+	test $# -lt 1 && die "fatal: no pattern given"
+
+	prefix="$(submodule_root_relative)" || exit 1
+	(cd "./$prefix"; \
+		cmd_foreach "git --no-pager grep $grep_args -- $@ | \
+			sed s\"|.*|$prefix\$path/&|\" || true") \
+				| git_pager
+}
 
 # This loop parses the command line arguments to find the
 # subcommand name to dispatch.  Parsing of the subcommand specific
@@ -859,7 +896,7 @@ cmd_sync()
 while test $# != 0 && test -z "$command"
 do
 	case "$1" in
-	add | foreach | init | update | status | summary | sync)
+	add | foreach | init | update | status | summary | sync | grep)
 		command=$1
 		;;
 	-q|--quiet)
-- 
1.7.3.dirty
