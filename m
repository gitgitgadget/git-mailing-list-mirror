From: Patrick Steinhardt <ps@pks.im>
Subject: [RFC/PATCH 2/4] submodules: implement remote commands.
Date: Wed,  8 Apr 2015 12:58:23 +0200
Message-ID: <1428490705-11586-3-git-send-email-ps@pks.im>
References: <1428490705-11586-1-git-send-email-ps@pks.im>
Cc: Patrick Steinhardt <ps@pks.im>, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 13:17:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yfnyy-0007rY-Lz
	for gcvg-git-2@plane.gmane.org; Wed, 08 Apr 2015 13:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbbDHLRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2015 07:17:17 -0400
Received: from sender1.zohomail.com ([74.201.84.157]:50227 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179AbbDHLRO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2015 07:17:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=mail; d=pks.im; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=jlal4uEfVSnEg3e7wlnn16RpfPzoDzxYR7OfZ4wJudWJPr+zyK4VO900mGYRezSHNPaIW98de/H7
    ogGzhzpBFlefnp4UGzPIFcu81hfGf4CReAiL+XHaLbscs2pDw1MAsj2tfMQTod1Zv/er2ETyqVkM
    NMpphTaWUlw6WHbvaQI=  
Received: from localhost (x5ce10f35.dyn.telefonica.de [92.225.15.53]) by mx.zohomail.com
	with SMTPS id 1428490766393149.52693052983773; Wed, 8 Apr 2015 03:59:26 -0700 (PDT)
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1428490705-11586-1-git-send-email-ps@pks.im>
X-ZohoMail: Ss  SS_10 UW1 iCHF_KNW_WHT_EXT UW1 UB2468 iCHF_INT_SMD_EXT UW1 iSFP_NO_WHTCNT_EXT UW1 UB2468 iZSF-HLOLL_2  SGR3_0_01045_19
X-ZohoMail-Owner: <1428490705-11586-3-git-send-email-ps@pks.im>+zmo_0_<ps@pks.im>
X-ZohoMail-Sender: 92.225.15.53
X-Zoho-Virus-Status: 2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266955>

Add commands to modify a submodule's remote configuration. There
are commands to add and remove submodule remotes as well as to
modify the URL of a submodule remote.
---
 git-submodule.sh | 225 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 223 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 599a847..6904f29 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -12,7 +12,11 @@ USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <re
    or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--reference <repository>] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
-   or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
+   or: $dashless [--quiet] sync [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] remote add <path> <name> <url>
+   or: $dashless [--quiet] remote rm <path> <name>
+   or: $dashless [--quiet] remote show <path>
+   or: $dashless [--quiet] remote set-url [--push] <path> <name> <url>"
 OPTIONS_SPEC=
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
@@ -1270,6 +1274,223 @@ cmd_status()
 }
 
 #
+# Modify remote configuration in .gitmodules
+#
+cmd_remote()
+{
+	while test $# -ne 0
+	do
+		case "$1" in
+			-q|--quiet)
+				GIT_QUIET=1
+				shift
+				;;
+			add|rm|show)
+				subcommand=$1
+				shift
+				;;
+			set-url)
+				subcommand=set_url
+				shift
+				;;
+			*)
+				break;;
+		esac
+	done
+
+	if test -z "$subcommand"
+	then
+		usage
+	fi
+
+	"cmd_remote_$subcommand" "$@"
+}
+
+#
+# Show remote configuration for a gitmodule
+#
+cmd_remote_show()
+{
+	while test $# -ne 0
+	do
+		case "$1" in
+			-v|--verbose)
+				verbose=1
+				shift
+				;;
+			*)
+				sm_path="$1"
+				shift
+				break;;
+		esac
+	done
+
+	if test $# -ne 0
+	then
+		usage
+	fi
+
+	if test -z "$sm_path"
+	then
+		die "$(gettext "No submodule path specified")"
+	fi
+
+	sm_name=$(module_name "$sm_path") || exit
+
+	cd_to_toplevel
+
+	git config -f .gitmodules --get-regexp "submodule-remote\.$sm_name\..*\.url" 2>/dev/null |
+	while read key url
+	do
+		remote=$(echo "$key" | sed "s/submodule-remote\.$sm_name\.\(.*\)\.url/\1/")
+		section="submodule-remote.$sm_name.$remote"
+
+		if test -z "$verbose"
+		then
+			echo "$remote"
+		else
+			url=$(git config -f .gitmodules "$section.url" 2>/dev/null)
+			pushurl=$(git config -f .gitmodules "$section.pushurl" 2>/dev/null)
+
+			if test -z "$pushurl"
+			then
+				pushurl="$url"
+			fi
+
+			echo -e "$remote\t$url (fetch)"
+			echo -e "$remote\t$pushurl (push)"
+		fi
+	done
+}
+
+#
+# Add remote configuration to .gitmodules
+# This adds a new remote with the key
+# submodule-remote.$name.$remote.url set to the specified value
+# to .gitmodules.
+#
+cmd_remote_add()
+{
+	if test $# -ne 3
+	then
+		usage
+	fi
+
+	sm_path="$1"
+	remote_name="$2"
+	remote_url="$3"
+
+	sm_name=$(module_name "$sm_path") || exit
+	displaypath=$(relative_path "$sm_path")
+	key="submodule-remote.$sm_name.$remote_name.url"
+
+	if test -z "$remote_name"
+	then
+		die "$(eval_gettext "Empty remote name not allowed")"
+	fi
+
+	cd_to_toplevel
+
+	if git config -f .gitmodules "$key" >/dev/null 2>/dev/null
+	then
+		die "$(eval_gettext "Remote '\$remote_name' for submodule '\$sm_name' already present")"
+	fi
+
+	if git config -f .gitmodules "submodule-remote.$sm_name.$remote_name.url" "$remote_url"
+	then
+		say "$(eval_gettext "Remote '\$remote_name' added for path '\$displaypath'")"
+	else
+		die "$(eval_gettext "Remote '\$remote_name' could not be added for path '\$displaypath'")"
+	fi
+}
+
+#
+# Remove remote configuration from .gitmodules
+# This removes the remote for the specified submodule and remote
+# name.
+#
+cmd_remote_rm()
+{
+	if test $# -ne 2
+	then
+		usage
+	fi
+
+	sm_path="$1"
+	remote_name="$2"
+
+	sm_name=$(module_name "$sm_path") || exit
+	displaypath=$(relative_path "$sm_path")
+	section="submodule-remote.$sm_name.$remote_name"
+
+	if test -z "$remote_name"
+	then
+		die "$(eval_gettext "Empty remote name not allowed")"
+	fi
+
+	if ! git config -f .gitmodules "$section.url" >/dev/null 2>/dev/null
+	then
+		die "$(eval_gettext "No remote '\$remote_name' present for path '\$displaypath'")"
+	fi
+
+	if git config -f .gitmodules --remove-section "$section" >/dev/null 2>/dev/null
+	then
+		say "$(eval_gettext "Remote '\$remote_name' removed for path '\$displaypath'")"
+	else
+		die "$(eval_gettext "Remote '\$remote_name' could not be removed for path '\$displaypath'")"
+	fi
+}
+
+#
+# Change remote URL configuration in .gitmodules
+# This sets the values submodule-remote.$name.$remote.url and
+# submodule-remote.$name.$remote.pushurl in .gitmodules.
+#
+cmd_remote_set_url()
+{
+	if test $# -lt 3
+	then
+		usage
+	fi
+
+	if test "$1" = "--push"
+	then
+		push=1
+		shift
+	fi
+
+	sm_path="$1"
+	remote_name="$2"
+	url="$3"
+
+	sm_name=$(module_name "$sm_path") || exit
+	displaypath=$(relative_path "$sm_path")
+
+	if test -z "$remote_name"
+	then
+		die "$(eval_gettext "Empty remote name not allowed")"
+	fi
+
+	section="submodule-remote.$sm_name.$remote_name"
+	if test -z $push
+	then
+		key="$section.url"
+	else
+		key="$section.pushurl"
+	fi
+
+	if ! git config -f .gitmodules "$section.url" >/dev/null 2>/dev/null
+	then
+		die "$(eval_gettext "No remote '\$remote_name' specified for path '\$displaypath'")"
+	fi
+
+	if ! git config -f .gitmodules "$key" "$url"
+	then
+		die "$(eval_gettext "could not set URL for '\$displaypath'")"
+	fi
+}
+
+#
 # Sync remote urls for submodules
 # This makes the value for remote.$remote.url match the value
 # specified in .gitmodules.
@@ -1386,7 +1607,7 @@ cmd_sync()
 while test $# != 0 && test -z "$command"
 do
 	case "$1" in
-	add | foreach | init | deinit | update | status | summary | sync)
+	add | foreach | init | deinit | update | status | summary | sync | remote)
 		command=$1
 		;;
 	-q|--quiet)
-- 
2.3.5
