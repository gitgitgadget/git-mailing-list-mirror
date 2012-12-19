From: wking@tremily.us
Subject: [PATCH v8 1/3] submodule: add get_submodule_config helper funtion
Date: Wed, 19 Dec 2012 11:03:31 -0500
Message-ID: <3377beb925bc209d90058493b74d174db1b7aa50.1355932282.git.wking@tremily.us>
References: <20121212230217.GB7729@odin.tremily.us>
 <cover.1355932282.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 19 17:04:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlM89-0003YL-OE
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 17:04:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755644Ab2LSQEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 11:04:04 -0500
Received: from vms173015pub.verizon.net ([206.46.173.15]:38340 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755640Ab2LSQD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 11:03:59 -0500
Received: from odin.tremily.us ([unknown] [72.68.92.119])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MFA003GMCLS0210@vms173015.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 19 Dec 2012 10:03:29 -0600 (CST)
Received: from mjolnir (mjolnir.tremily.us [192.168.0.6])
	by odin.tremily.us (Postfix) with SMTP id C04D5737705; Wed,
 19 Dec 2012 11:03:26 -0500 (EST)
Received: by mjolnir (sSMTP sendmail emulation); Wed, 19 Dec 2012 11:03:39 -0500
X-Mailer: git-send-email 1.8.0
In-reply-to: <cover.1355932282.git.wking@tremily.us>
In-reply-to: <cover.1355932282.git.wking@tremily.us>
References: <cover.1355932282.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211833>

From: "W. Trevor King" <wking@tremily.us>

Several submodule configuration variables
(e.g. fetchRecurseSubmodules) are read from .gitmodules with local
overrides from the usual git config files.  This shell function mimics
that logic to help initialize configuration variables in
git-submodule.sh.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 git-submodule.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2365149..263a60c 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -153,6 +153,32 @@ die_if_unmatched ()
 }
 
 #
+# Print a submodule configuration setting
+#
+# $1 = submodule name
+# $2 = option name
+# $3 = default value
+#
+# Checks in the usual git-config places first (for overrides),
+# otherwise it falls back on .gitmodules.  This allows you to
+# distribute project-wide defaults in .gitmodules, while still
+# customizing individual repositories if necessary.  If the option is
+# not in .gitmodules either, print a default value.
+#
+get_submodule_config () {
+	name="$1"
+	option="$2"
+	default="$3"
+	value=$(git config submodule."$name"."$option")
+	if test -z "$value"
+	then
+		value=$(git config -f .gitmodules submodule."$name"."$option")
+	fi
+	printf '%s' "${value:-$default}"
+}
+
+
+#
 # Map submodule path to submodule name
 #
 # $1 = path
-- 
1.8.0
