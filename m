From: Phil Hord <hordp@cisco.com>
Subject: [PATCHv3 1/2] Teach --recursive to submodule sync
Date: Fri, 26 Oct 2012 15:44:42 -0400
Message-ID: <1351280683-8402-2-git-send-email-hordp@cisco.com>
References: <508AE3E9.6000304@web.de>
 <1351280683-8402-1-git-send-email-hordp@cisco.com>
Cc: phil.hord@gmail.com, Jens Lehmann <Jens.Lehmann@web.de>,
	Jeff King <peff@peff.net>, Phil Hord <hordp@cisco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 26 21:45:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRpq9-000852-4Q
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 21:45:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966228Ab2JZTow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 15:44:52 -0400
Received: from rcdn-iport-9.cisco.com ([173.37.86.80]:56674 "EHLO
	rcdn-iport-9.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966153Ab2JZTov (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 15:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2050; q=dns/txt; s=iport;
  t=1351280691; x=1352490291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=+GUE3daUtdDHnAC5vd+8/T9js46k01CL/mUHI18Dme0=;
  b=Zhhb2t377JPc+2OnA6tw2B/UL/WBhQhPuQabssMidWym5+y/ifA0wCwM
   MnIXS5U42fvfRTRTNslp5aCw5O+q5wfZSQW1E8+mjOLplF2SXKjA9IUZZ
   kW1HmMBkIrH0IzFjlS1QfluSa2AXww6cZN251kDijuzHswgWR3uDnNIGr
   w=;
X-IronPort-AV: E=Sophos;i="4.80,656,1344211200"; 
   d="scan'208";a="132814231"
Received: from rcdn-core2-2.cisco.com ([173.37.113.189])
  by rcdn-iport-9.cisco.com with ESMTP; 26 Oct 2012 19:44:51 +0000
Received: from ipsn-lnx-hordp.cisco.com (dhcp-64-100-104-96.cisco.com [64.100.104.96])
	by rcdn-core2-2.cisco.com (8.14.5/8.14.5) with ESMTP id q9QJimEG022008;
	Fri, 26 Oct 2012 19:44:51 GMT
X-Mailer: git-send-email 1.8.0.3.g9dae067
In-Reply-To: <1351280683-8402-1-git-send-email-hordp@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208485>

The submodule sync command was somehow left out when
--recursive was added to the other submodule commands.

Teach sync to handle the --recursive switch by recursing
when we're in a submodule we are sync'ing.

Change the report during sync to show submodule-path
instead of submodule-name to be consistent with the other
submodule commands and to help recursed paths make sense.

Signed-off-by: Phil Hord <hordp@cisco.com>
---
 git-submodule.sh | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ab6b110..0ca3af2 100755
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
@@ -1010,6 +1010,10 @@ cmd_sync()
 			GIT_QUIET=1
 			shift
 			;;
+		--recursive)
+			recursive=1
+			shift
+			;;
 		--)
 			shift
 			break
@@ -1051,7 +1055,7 @@ cmd_sync()
 
 		if git config "submodule.$name.url" >/dev/null 2>/dev/null
 		then
-			say "$(eval_gettext "Synchronizing submodule url for '\$name'")"
+			say "$(eval_gettext "Synchronizing submodule url for '\$prefix\$sm_path'")"
 			git config submodule."$name".url "$super_config_url"
 
 			if test -e "$sm_path"/.git
@@ -1061,6 +1065,12 @@ cmd_sync()
 				cd "$sm_path"
 				remote=$(get_default_remote)
 				git config remote."$remote".url "$sub_origin_url"
+
+				if test -n "$recursive"
+				then
+					prefix="$prefix$sm_path/"
+					eval cmd_sync
+				fi
 			)
 			fi
 		fi
-- 
1.8.0.3.g9dae067
