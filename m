From: Alex Linden Levy <lindenle@gmail.com>
Subject: [PATCH] Add rm to submodule command.
Date: Fri, 2 Nov 2012 10:26:11 -0700
Message-ID: <1351877171-3176-1-git-send-email-lindenle@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alex Linden Levy <lindenle@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 18:37:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TULAw-0000Ju-Ku
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 18:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763243Ab2KBRgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 13:36:46 -0400
Received: from mxout.myoutlookonline.com ([64.95.72.241]:16167 "EHLO
	mxout.myoutlookonline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763028Ab2KBRgp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 13:36:45 -0400
X-Greylist: delayed 619 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Nov 2012 13:36:45 EDT
Received: from mxout.myoutlookonline.com (localhost [127.0.0.1])
	by mxout.myoutlookonline.com (Postfix) with ESMTP id C9255416ABD;
	Fri,  2 Nov 2012 13:27:19 -0400 (EDT)
X-Virus-Scanned: by SpamTitan at mail.lan
Received: from HUB023.mail.lan (unknown [10.110.2.1])
	by mxout.myoutlookonline.com (Postfix) with ESMTP id 17D92416854;
	Fri,  2 Nov 2012 13:27:19 -0400 (EDT)
Received: from hubm01.mail.lan (10.110.17.53) by HUB023.mail.lan
 (10.110.17.23) with Microsoft SMTP Server (TLS) id 8.3.279.1; Fri, 2 Nov 2012
 13:26:07 -0400
Received: from lightning.mobitv.corp (75.55.199.5) by mail.myoutlookonline.com
 (10.110.17.53) with Microsoft SMTP Server (TLS) id 8.3.279.1; Fri, 2 Nov 2012
 13:26:22 -0400
X-Mailer: git-send-email 1.8.0.1.g3039071.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208965>

This change removes the config entries in .gitmodules and adds it.
---
 git-submodule.sh | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ab6b110..29d950f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -6,6 +6,7 @@
 
 dashless=$(basename "$0" | sed -e 's/-/ /')
 USAGE="[--quiet] add [-b branch] [-f|--force] [--reference <repository>] [--] <repository> [<path>]
+   or: $dashless [--quiet] rm [-b branch] [-f|--force] [--] [<path>]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
@@ -370,6 +371,65 @@ Use -f if you really want to add it." >&2
 	die "$(eval_gettext "Failed to register submodule '\$sm_path'")"
 }
 
+cmd_rm()
+{
+	# parse $args after "submodule ... rm".
+	while test $# -ne 0
+	do
+		case "$1" in
+		-b | --branch)
+			case "$2" in '') usage ;; esac
+			branch=$2
+			shift
+			;;
+		-f | --force)
+			force=$1
+			;;
+		-q|--quiet)
+			GIT_QUIET=1
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
+		shift
+	done
+	
+	sm_path=$1
+
+	# normalize path:
+	# multiple //; leading ./; /./; /../; trailing /
+	sm_path=$(printf '%s/\n' "$sm_path" |
+		sed -e '
+			s|//*|/|g
+			s|^\(\./\)*||
+			s|/\./|/|g
+			:start
+			s|\([^/]*\)/\.\./||
+			tstart
+			s|/*$||
+		')
+
+
+	#edit .gitmodules
+	git config -f .gitmodules --remove-section submodule."$sm_path" ||
+	die "$(eval_gettext "Failed to rm submodule '\$sm_path' section")"
+
+	#get rid of the submodule
+	git rm --cached $force "$sm_path" ||
+	die "$(eval_gettext "Failed to rm submodule '\$sm_path'")"
+	
+	#now add the .gitmodules change
+	git add ${force} .gitmodules ||
+	die "$(eval_gettext "Failed to remove submodule '\$sm_path'")"
+}
 #
 # Execute an arbitrary command sequence in each checked out
 # submodule
@@ -1076,7 +1136,7 @@ cmd_sync()
 while test $# != 0 && test -z "$command"
 do
 	case "$1" in
-	add | foreach | init | update | status | summary | sync)
+	add | rm | foreach | init | update | status | summary | sync)
 		command=$1
 		;;
 	-q|--quiet)
-- 
1.8.0.1.g3039071.dirty
