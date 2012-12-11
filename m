From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v7 1/3] submodule: add get_submodule_config helper funtion
Date: Tue, 11 Dec 2012 13:58:15 -0500
Message-ID: <81a253f4d88cd2f3febedc9f24754c4390723a46.1355251862.git.wking@tremily.us>
References: <20121204001717.GA17375@odin.tremily.us>
 <cover.1355251862.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 19:59:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiV2s-00061S-Ea
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 19:59:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622Ab2LKS6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 13:58:46 -0500
Received: from vms173007pub.verizon.net ([206.46.173.7]:21040 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736Ab2LKS6o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 13:58:44 -0500
Received: from odin.tremily.us ([unknown] [72.68.110.234])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MEV00BUVRDAPI50@vms173007.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 11 Dec 2012 12:58:23 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 42FC871B432; Tue,
 11 Dec 2012 13:58:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1355252302; bh=N49dKJnepbyF3jQ7AShy1nL5zt108tLAs8uoDifKI6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=M3+3FCN4Vs4c+6ez9/cad27MruJ7JVBNOj4XEEmR2Pd5QuyPJpszi0DxpglBFJAHZ
 0NWyJcPIKSrvSSJiQVy4i4ts4Y07VisaNJkYG/fScqT9tKhpkf1PgKkRAdGTuLyUIC
 /EHhPauWyEIaz2s3WSiR8XRxEN7ye47pwjEcqc+0=
X-Mailer: git-send-email 1.7.8.6
In-reply-to: <cover.1355251862.git.wking@tremily.us>
In-reply-to: <cover.1355251862.git.wking@tremily.us>
References: <cover.1355251862.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211295>

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
index ab6b110..f969f28 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -152,6 +152,32 @@ die_if_unmatched ()
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
