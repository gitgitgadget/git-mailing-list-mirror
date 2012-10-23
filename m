From: Phil Hord <hordp@cisco.com>
Subject: [PATCH 1/2] Teach --recursive to submodule sync
Date: Tue, 23 Oct 2012 19:15:40 -0400
Message-ID: <1351034141-2641-2-git-send-email-hordp@cisco.com>
References: <507EF86C.4050807@web.de>
 <1351034141-2641-1-git-send-email-hordp@cisco.com>
Cc: phil.hord@gmail.com, Jens Lehmann <Jens.Lehmann@web.de>,
	Phil Hord <hordp@cisco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 24 01:16:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQnhg-0002NS-Vb
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 01:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134Ab2JWXP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 19:15:57 -0400
Received: from rcdn-iport-7.cisco.com ([173.37.86.78]:58528 "EHLO
	rcdn-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934100Ab2JWXPy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 19:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2280; q=dns/txt; s=iport;
  t=1351034154; x=1352243754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Bcq8TzQA6SohCqxhXDbqrwCV8KbNhhAaib8W/rQbDM8=;
  b=ad+sdITZ1/UXFLGXDudmmb86mN/Rz+WjhD5bRdC6GzBOgmoLqILELLuT
   tlFtXsMt/5zMl400PTHsm9bAjOe5c+eoGNqrB8kMzBraKuYzDISAZmfVV
   zfQb4A2YelayA9fG2n2eFv/kpLv6ZDMkwB8oOFdpmB9KUkgK0yNZok8g2
   o=;
X-IronPort-AV: E=Sophos;i="4.80,637,1344211200"; 
   d="scan'208";a="134680802"
Received: from rcdn-core2-2.cisco.com ([173.37.113.189])
  by rcdn-iport-7.cisco.com with ESMTP; 23 Oct 2012 23:15:53 +0000
Received: from ipsn-lnx-hordp.cisco.com (dhcp-64-100-104-96.cisco.com [64.100.104.96])
	by rcdn-core2-2.cisco.com (8.14.5/8.14.5) with ESMTP id q9NNFp9I006158;
	Tue, 23 Oct 2012 23:15:53 GMT
X-Mailer: git-send-email 1.8.0.2.gcde19fc.dirty
In-Reply-To: <1351034141-2641-1-git-send-email-hordp@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208273>

The submodule sync command was somehow left out when
--recursive was added to the other submodule commands.

Teach sync to handle the --recursive switch by recursing
when we're in a submodule we are sync'ing.

Change the report during sync to show submodule-path
instead of submodule-name to be consistent with the other
submodule commands and to help recursed paths make sense.

Signed-off-by: Phil Hord <hordp@cisco.com>
---
 git-submodule.sh | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ab6b110..6dd2338 100755
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
@@ -1008,7 +1008,9 @@ cmd_sync()
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
@@ -1021,6 +1023,8 @@ cmd_sync()
 			break
 			;;
 		esac
+		orig_flags="$orig_flags $(git rev-parse --sq-quote "$1")"
+		shift
 	done
 	cd_to_toplevel
 	module_list "$@" |
@@ -1051,7 +1055,7 @@ cmd_sync()
 
 		if git config "submodule.$name.url" >/dev/null 2>/dev/null
 		then
-			say "$(eval_gettext "Synchronizing submodule url for '\$name'")"
+			say "$(eval_gettext "Synchronizing submodule url for '\$prefix\$sm_path'")"
 			git config submodule."$name".url "$super_config_url"
 
 			if test -e "$sm_path"/.git
@@ -1061,6 +1065,14 @@ cmd_sync()
 				cd "$sm_path"
 				remote=$(get_default_remote)
 				git config remote."$remote".url "$sub_origin_url"
+
+				if test -n "$recursive"
+				then
+				(
+					prefix="$prefix$sm_path/"
+					eval cmd_sync "$orig_args"
+				)
+			fi
 			)
 			fi
 		fi
-- 
1.8.0.2.gcde19fc.dirty
