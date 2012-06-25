From: =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
Subject: [PATCH 2/2] git-submodule: support 'rm' command.
Date: Mon, 25 Jun 2012 12:57:00 +0200
Message-ID: <1340621820-19448-2-git-send-email-mgorny@gentoo.org>
References: <1340621820-19448-1-git-send-email-mgorny@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 25 12:57:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj6z4-0003xr-Mj
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 12:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755853Ab2FYK5V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jun 2012 06:57:21 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:58263 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755833Ab2FYK5U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 06:57:20 -0400
Received: from pomiocik.lan (77-255-3-88.adsl.inetia.pl [77.255.3.88])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mgorny)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 002FE1B43CE;
	Mon, 25 Jun 2012 10:57:18 +0000 (UTC)
X-Mailer: git-send-email 1.7.10.2
In-Reply-To: <1340621820-19448-1-git-send-email-mgorny@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200565>

Add an 'rm' command to git-submodule which provides means to
(semi-)easily remove git submodules.

Signed-off-by: Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org>
---
Right now, it requires the submodule checkout to be removed manually
first (so it does not remove unstaged commits), and just removes
the index entry and module information from config.

I based it on 'cmd_add' code trying to preserve the original coding
standards.

 Documentation/git-submodule.txt |   12 +++++++
 git-submodule.sh                |   68 +++++++++++++++++++++++++++++++=
+++++++-
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submod=
ule.txt
index fbbbcb2..293c1bf 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git submodule' [--quiet] add [-b branch] [-f|--force]
 	      [--reference <repository>] [--] <repository> [<path>]
+'git submodule' [--quiet] rm <path>...
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>=
=2E..]
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase]
@@ -104,6 +105,17 @@ together in the same relative location, and only t=
he
 superproject's URL needs to be provided: git-submodule will correctly
 locate the submodule using the relative URL in .gitmodules.
=20
+rm::
+	Remove and unregister the submodules at given paths.
++
+This requires at least one <path> argument. The repository checkout
+existing at that directory needs to be removed manually from
+the filesystem prior to calling this command. Note that all local
+changes will be lost.
++
+This command removes the submodule from the current git index,
+the .gitmodules file and the local repository config.
+
 status::
 	Show the status of the submodules. This will print the SHA-1 of the
 	currently checked out commit for each submodule, along with the
diff --git a/git-submodule.sh b/git-submodule.sh
index fbf2faf..88fd414 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -6,6 +6,7 @@
=20
 dashless=3D$(basename "$0" | sed -e 's/-/ /')
 USAGE=3D"[--quiet] add [-b branch] [-f|--force] [--reference <reposito=
ry>] [--] <repository> [<path>]
+   or: $dashless [--quiet] rm [--] <path>...
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path=
>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force=
] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<=
path>...]
@@ -308,6 +309,71 @@ Use -f if you really want to add it." >&2
 }
=20
 #
+# Remove submodules from the working tree, .gitmodules and the index
+#
+# $@ =3D submodule paths
+#
+cmd_rm()
+{
+	# parse $args after "submodule ... rm".
+	while test $# -ne 0
+	do
+		case "$1" in
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
+		shift
+	done
+
+	if test -z "$1"; then
+		usage
+	fi
+
+	while test $# -ne 0
+	do
+		sm_path=3D$1
+		shift
+
+		# normalize path:
+		# multiple //; leading ./; /./; /../; trailing /
+		sm_path=3D$(printf '%s/\n' "$sm_path" |
+			sed -e '
+				s|//*|/|g
+				s|^\(\./\)*||
+				s|/\./|/|g
+				:start
+				s|\([^/]*\)/\.\./||
+				tstart
+				s|/*$||
+			')
+		git ls-files --error-unmatch "$sm_path" > /dev/null 2>&1 ||
+		die "$(eval_gettext "'\$sm_path' does not exist in the index")"
+
+		if test -e "$sm_path"
+		then
+			die "$(eval_gettext "'\$sm_path' needs to be removed manually first=
")"
+		fi
+
+		git rm --cached "$sm_path" ||
+		die "$(eval_gettext "Failed to remove submodule '\$sm_path'")"
+
+		git config -f .gitmodules --remove-section submodule."$sm_path" &&
+		git add --force .gitmodules ||
+		die "$(eval_gettext "Failed to unregister submodule '\$sm_path'")"
+
+		git config --remove-section submodule."$sm_path"
+	done
+}
+
+#
 # Execute an arbitrary command sequence in each checked out
 # submodule
 #
@@ -996,7 +1062,7 @@ cmd_sync()
 while test $# !=3D 0 && test -z "$command"
 do
 	case "$1" in
-	add | foreach | init | update | status | summary | sync)
+	add | rm | foreach | init | update | status | summary | sync)
 		command=3D$1
 		;;
 	-q|--quiet)
--=20
1.7.10.2
