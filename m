From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v3] git-submodule: add "sync" command
Date: Sun, 24 Aug 2008 12:43:37 -0700
Message-ID: <ebeb5aba6f679e1259a011bcc245bd723c6cf8d1.1219606749.git.davvid@gmail.com>
References: <7vwsi6meas.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Aug 24 21:52:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXLdl-0000pZ-3W
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 21:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052AbYHXTvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 15:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753049AbYHXTvd
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 15:51:33 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:38820 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964AbYHXTvc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 15:51:32 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1328619rvb.1
        for <git@vger.kernel.org>; Sun, 24 Aug 2008 12:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=IQGUD4slEAgIhACgrO2eG+LdB0yMFBKGlaGJAQ9Npvg=;
        b=Ph8NXB0u+E4efqwFoM5hGojTLG6Iw1SpxyRWIFo5gLfz9+HiS8oMmdDwxSk7Mqpr+Q
         mfEF/nJSmDQmHhm83V1+MTuKpP+4t+mdj8QcPT99IZG1IgZn0xsOMbEH2PowyOr1y6s/
         d6ftsnWOmFXxzQnhyx7TknGszVsw3cJUzhQEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VZBvKlmy6V/586RlIwg3RFbjDglyMJXpRfGdsH+Pqgiq2t8GCy3nEEkh+7ZHm0MA2b
         u5K0VoKFg6h46cpiIO3SPlaziqUu3LtxpnhEaIULqbCXQ9973yvdwePJgP+BHnfVoD6Z
         FgFBnBTSgiwmBcDTAWeXzD/sRYOckoFV2yz3M=
Received: by 10.141.176.4 with SMTP id d4mr1749487rvp.14.1219607492152;
        Sun, 24 Aug 2008 12:51:32 -0700 (PDT)
Received: from localhost ( [208.106.56.2])
        by mx.google.com with ESMTPS id f42sm6242984rvb.6.2008.08.24.12.51.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Aug 2008 12:51:31 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.106.gd6096
In-Reply-To: <7vwsi6meas.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93557>

When a submodule's URL changes upstream, existing submodules
will be out of sync since their remote."$origin".url will still
be set to the old value.

This adds a "git submodule sync" command that reads submodules'
URLs from .gitmodules and updates them accordingly.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

This uses get_default_remote() per Mark's latest update.

 Documentation/git-submodule.txt |    9 +++++++
 git-submodule.sh                |   48 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index abbd5b7..babaa9b 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 'git submodule' [--quiet] update [--init] [--] [<path>...]
 'git submodule' [--quiet] summary [--summary-limit <n>] [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach <command>
+'git submodule' [--quiet] sync [--] [<path>...]
 
 
 DESCRIPTION
@@ -139,6 +140,14 @@ foreach::
 As an example, "git submodule foreach 'echo $path `git rev-parse HEAD`' will
 show the path and currently checked out commit for each submodule.
 
+sync::
+	Synchronizes submodules' remote URL configuration setting
+	to the value specified in .gitmodules.  This is useful when
+	submodule URLs change upstream and you need to update your local
+	repositories accordingly.
++
+"git submodule sync" synchronizes all submodules while
+"git submodule sync -- A" synchronizes submodule "A" only.
 
 OPTIONS
 -------
diff --git a/git-submodule.sh b/git-submodule.sh
index 59fe7b3..4a95035 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -6,7 +6,7 @@
 
 USAGE="[--quiet] [--cached] \
 [add <repo> [-b branch] <path>]|[status|init|update [-i|--init]|summary [-n|--summary-limit <n>] [<commit>]] \
-[--] [<path>...]|[foreach <command>]"
+[--] [<path>...]|[foreach <command>]|[sync [--] [<path>...]]"
 OPTIONS_SPEC=
 . git-sh-setup
 . git-parse-remote
@@ -601,6 +601,50 @@ cmd_status()
 		fi
 	done
 }
+#
+# Sync remote urls for submodules
+# This makes the value for remote.$remote.url match the value
+# specified in .gitmodules.
+#
+cmd_sync()
+{
+	while test $# -ne 0
+	do
+		case "$1" in
+		-q|--quiet)
+			quiet=1
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
+	cd_to_toplevel
+	module_list "$@" |
+	while read mode sha1 stage path
+	do
+		name=$(module_name "$path")
+		url=$(git config -f .gitmodules --get submodule."$name".url)
+		if test -e "$path"/.git
+		then
+		(
+			unset GIT_DIR
+			cd "$path"
+			remote=$(get_default_remote)
+			say "Synchronizing submodule url for '$name'"
+			git config remote."$remote".url "$url"
+		)
+		fi
+	done
+}
 
 # This loop parses the command line arguments to find the
 # subcommand name to dispatch.  Parsing of the subcommand specific
@@ -611,7 +655,7 @@ cmd_status()
 while test $# != 0 && test -z "$command"
 do
 	case "$1" in
-	add | foreach | init | update | status | summary)
+	add | foreach | init | update | status | summary | sync)
 		command=$1
 		;;
 	-q|--quiet)
-- 
1.6.0.106.gd6096
