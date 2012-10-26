From: Phil Hord <hordp@cisco.com>
Subject: [PATCHv2 1/2] Teach --recursive to submodule sync
Date: Fri, 26 Oct 2012 13:31:30 -0400
Message-ID: <1351272691-24718-2-git-send-email-hordp@cisco.com>
References: <5089BBE1.3040107@web.de>
 <1351272691-24718-1-git-send-email-hordp@cisco.com>
Cc: phil.hord@gmail.com, Jens Lehmann <Jens.Lehmann@web.de>,
	Jeff King <peff@peff.net>, Phil Hord <hordp@cisco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 26 19:32:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRnlb-00068O-A7
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 19:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965495Ab2JZRcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 13:32:07 -0400
Received: from rcdn-iport-8.cisco.com ([173.37.86.79]:12133 "EHLO
	rcdn-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965459Ab2JZRcF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 13:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2345; q=dns/txt; s=iport;
  t=1351272726; x=1352482326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=6qzZZG4YLTfRfLw5pcfQ1/hyrT6rKaGrLgPqO5NQuYk=;
  b=JCMiZc5BB1CAdHeKR0ZIfLwI4/RP4ajsjPUSsBZXvW+2N2JdCBI/2pbO
   7E4a887ukghe9+HNjXeitkkxg2KgCMN4qQlqG6MgmC7le+hk/x+J0sEWx
   yo5NcW8udDlzLP/Fo/Ans2iAuas9/JW4tEl+z/xcIELE8A1C8wvWgyEu8
   E=;
X-IronPort-AV: E=Sophos;i="4.80,654,1344211200"; 
   d="scan'208";a="135767093"
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-8.cisco.com with ESMTP; 26 Oct 2012 17:32:04 +0000
Received: from ipsn-lnx-hordp.cisco.com (dhcp-64-100-104-96.cisco.com [64.100.104.96])
	by rcdn-core-5.cisco.com (8.14.5/8.14.5) with ESMTP id q9QHVp49026203;
	Fri, 26 Oct 2012 17:32:03 GMT
X-Mailer: git-send-email 1.8.0.2.g35128e8
In-Reply-To: <1351272691-24718-1-git-send-email-hordp@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208469>

The submodule sync command was somehow left out when
--recursive was added to the other submodule commands.

Teach sync to handle the --recursive switch by recursing
when we're in a submodule we are sync'ing.

Change the report during sync to show submodule-path
instead of submodule-name to be consistent with the other
submodule commands and to help recursed paths make sense.

Signed-off-by: Phil Hord <hordp@cisco.com>
---
 git-submodule.sh | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ab6b110..f40da72 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -11,7 +11,7 @@ USAGE="[--quiet] add [-b branch] [-f|--force] [--reference <repository>] [--] <r
    or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
-   or: $dashless [--quiet] sync [--] [<path>...]"
+   or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
 OPTIONS_SPEC=
 . git-sh-setup
 . git-sh-i18n
@@ -1003,12 +1003,15 @@ cmd_status()
 #
 cmd_sync()
 {
+	orig_flags=
 	while test $# -ne 0
 	do
 		case "$1" in
 		-q|--quiet)
 			GIT_QUIET=1
-			shift
+			;;
+		--recursive)
+			recursive=1
 			;;
 		--)
 			shift
@@ -1021,6 +1024,8 @@ cmd_sync()
 			break
 			;;
 		esac
+		orig_flags="$orig_flags $(git rev-parse --sq-quote "$1")"
+		shift
 	done
 	cd_to_toplevel
 	module_list "$@" |
@@ -1051,7 +1056,7 @@ cmd_sync()
 
 		if git config "submodule.$name.url" >/dev/null 2>/dev/null
 		then
-			say "$(eval_gettext "Synchronizing submodule url for '\$name'")"
+			say "$(eval_gettext "Synchronizing submodule url for '\$prefix\$sm_path'")"
 			git config submodule."$name".url "$super_config_url"
 
 			if test -e "$sm_path"/.git
@@ -1061,6 +1066,14 @@ cmd_sync()
 				cd "$sm_path"
 				remote=$(get_default_remote)
 				git config remote."$remote".url "$sub_origin_url"
+
+				if test -n "$recursive"
+				then
+				(
+					prefix="$prefix$sm_path/"
+					eval cmd_sync "$orig_flags"
+				)
+			fi
 			)
 			fi
 		fi
-- 
1.8.0.2.g35128e8
