From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v6 1/4] submodule: add get_submodule_config helper funtion
Date: Sat, 01 Dec 2012 22:17:01 -0500
Message-ID: <436a73a8fdc8f0695aa597d53483d4c4bae16ebb.1354417618.git.wking@tremily.us>
References: <20121130032719.GE29257@odin.tremily.us>
 <cover.1354417618.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 02 04:18:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tf04m-00067R-3H
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 04:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754042Ab2LBDSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 22:18:25 -0500
Received: from vms173011pub.verizon.net ([206.46.173.11]:56008 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753994Ab2LBDSN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 22:18:13 -0500
Received: from odin.tremily.us ([unknown] [72.68.87.250])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MED00H7OVTZ1T60@vms173011.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 01 Dec 2012 21:18:00 -0600 (CST)
Received: from localhost (tyr.tremily.us [192.168.0.5])
	by odin.tremily.us (Postfix) with ESMTP id 2C50E6E4036; Sat,
 01 Dec 2012 22:17:59 -0500 (EST)
X-Mailer: git-send-email 1.8.0.4.gf74b0fc.dirty
In-reply-to: <cover.1354417618.git.wking@tremily.us>
In-reply-to: <cover.1354417618.git.wking@tremily.us>
References: <cover.1354417618.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210998>

From: "W. Trevor King" <wking@tremily.us>

Several submodule configuration variables
(e.g. fetchRecurseSubmodules) are read from .gitmodules with local
overrides from the usual git config files.  This shell function mimics
that logic to help initialize configuration variables in
git-submodule.sh.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 git-submodule.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index ab6b110..97ce5e4 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -152,6 +152,33 @@ die_if_unmatched ()
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
+get_submodule_config()
+{
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
1.8.0.4.gf74b0fc.dirty
