From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 2/2] git-submodule: add "sync" command
Date: Fri, 22 Aug 2008 00:30:51 -0700
Message-ID: <e1d3f1871f869a0161fb3f0d84777de9e0125023.1219390139.git.davvid@gmail.com>
References: <edc9ece47ca86c3c3e4265e7f4222c8ea6917461.1219390139.git.davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 22 09:40:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWRFk-0007os-3p
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 09:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865AbYHVHjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 03:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822AbYHVHjA
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 03:39:00 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:4923 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbYHVHi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 03:38:57 -0400
Received: by rv-out-0506.google.com with SMTP id k40so316218rvb.1
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 00:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=Eiir3joPKjepBesyg6HIRSXXgsMEiC0DwdNnLIufAiQ=;
        b=Nb4/Es1FWEkim3lGY/oKfAw4o9vyR2/UwXIzjTsjSROxrekFRNcpustN31lJC4WRM/
         WCFahiOTYQH2oE/03wbQHnAlWCvfJpSM/8E+tawptnVgkIbiJCMKOgXxIxz/75oKJdPW
         e0LDVayhqhwbhloRkR3JrJz4ZlZyUVgFBpZyg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=B1ryAMOK/jWW35sbEZmBhk2PoDbAwdg4+vUJudARCqIkM5qN3ipqdHGKrAk/yLxa72
         htZSIFBxDO5Gy43dznJm1J4Y9aj77yik7H+5EumFWOd5f5oMWEbHnDy9KmJ31MOy4FUP
         h2MS/l4Bep/qJk1FZHPC4R4QFGAMSF4Q9imkE=
Received: by 10.141.106.14 with SMTP id i14mr374533rvm.178.1219390737183;
        Fri, 22 Aug 2008 00:38:57 -0700 (PDT)
Received: from localhost ( [208.106.56.2])
        by mx.google.com with ESMTPS id c20sm1438398rvf.3.2008.08.22.00.38.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Aug 2008 00:38:56 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.90.g436ed
In-Reply-To: <edc9ece47ca86c3c3e4265e7f4222c8ea6917461.1219390139.git.davvid@gmail.com>
In-Reply-To: <edc9ece47ca86c3c3e4265e7f4222c8ea6917461.1219390139.git.davvid@gmail.com>
References: <edc9ece47ca86c3c3e4265e7f4222c8ea6917461.1219390139.git.davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93265>

When a submodule's URL changes upstream, existing submodules
will be out of sync since their remote.origin.url will still
be set to the old value.

This change adds a "git submodule sync" command that reads the
submodule URLs from .gitmodules and updates any existing
submodules accordingly.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Documentation/git-submodule.txt |    7 ++++++
 git-submodule.sh                |   45 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index abbd5b7..a229032 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 'git submodule' [--quiet] update [--init] [--] [<path>...]
 'git submodule' [--quiet] summary [--summary-limit <n>] [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach <command>
+'git submodule' [--quiet] sync [--] [<path>...]
 
 
 DESCRIPTION
@@ -139,6 +140,12 @@ foreach::
 As an example, "git submodule foreach 'echo $path `git rev-parse HEAD`' will
 show the path and currently checked out commit for each submodule.
 
+sync::
+	Synchronizes each submodule's remote.origin.url configuration
+	setting to match that of the corresponding submodule.*.url
+	value as specified in .gitmodules.  This is useful if your
+	submodule URLs have changed upstream and you want to update your
+	local repositories accordingly.
 
 OPTIONS
 -------
diff --git a/git-submodule.sh b/git-submodule.sh
index 2a3a197..46739de 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -6,7 +6,7 @@
 
 USAGE="[--quiet] [--cached] \
 [add <repo> [-b branch] <path>]|[status|init|update [-i|--init]|summary [-n|--summary-limit <n>] [<commit>]] \
-[--] [<path>...]|[foreach <command>]"
+[--] [<path>...]|[foreach <command>]|[sync [<path>...]]"
 OPTIONS_SPEC=
 . git-sh-setup
 require_work_tree
@@ -602,6 +602,47 @@ cmd_status()
 		fi
 	done
 }
+#
+# Sync git urls for submodules
+# This makes the value for remote.origin.url match the value
+# specified in .gitmodules.
+#
+cmd_sync()
+{
+	while test $# -ne 0
+	do
+		case "$1" in
+		-q|--quiet)
+			quiet=1
+			;;
+		-*)
+			usage
+			;;
+		--)
+			shift
+			break
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+
+	cd_to_toplevel
+
+	module_list "$@" |
+	while read mode sha1 stage path
+	do
+		! test -f "$path"/.git/config &&
+		echo "Warn: submodule at path '$path' does not exist."
+		test -f "$path"/.git/config || continue
+		name=$(module_name "$path")
+		url=$(git config -f .gitmodules --get submodule."$name".url)
+		say "Synchronizing submodule url for '$name'"
+		git config -f "$path"/.git/config remote.origin.url "$url"
+	done
+}
 
 # This loop parses the command line arguments to find the
 # subcommand name to dispatch.  Parsing of the subcommand specific
@@ -612,7 +653,7 @@ cmd_status()
 while test $# != 0 && test -z "$command"
 do
 	case "$1" in
-	add | foreach | init | update | status | summary)
+	add | foreach | init | update | status | summary | sync)
 		command=$1
 		;;
 	-q|--quiet)
-- 
1.6.0.90.g436ed
