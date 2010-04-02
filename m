From: Chris Webb <chris@arachsys.com>
Subject: [PATCH 1/6] whitespace: we cannot "catch all errors known to git"
 anymore
Date: Sat, 3 Apr 2010 00:37:00 +0100
Message-ID: <d2d764a408f3e9c9223c699ba77dba39ba118bac.1270250437.git.chris@arachsys.com>
References: <cover.1270250437.git.chris@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 03 01:37:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxqQq-00051w-Vf
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 01:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187Ab0DBXhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 19:37:12 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:39376 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144Ab0DBXhD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 19:37:03 -0400
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1NxqQ8-0004uv-Gp; Sat, 03 Apr 2010 00:37:00 +0100
Content-Disposition: inline
In-Reply-To: <cover.1270250437.git.chris@arachsys.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143865>

From: Junio C Hamano <gitster@pobox.com>

Traditionally, "*.txt whitespace" in .gitattributes file has been an
instruction to catch _all_ classes of whitespace errors known to git.

This has to change, however, in order to introduce "tab-in-indent" which
is inherently incompatible with "indent-with-non-tab".  As we do not want
to break configuration of existing users, add a mechanism to allow marking
selected rules to be excluded from "all rules known to git".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Chris Webb <chris@arachsys.com>
---
 ws.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/ws.c b/ws.c
index c089338..f4afcdd 100644
--- a/ws.c
+++ b/ws.c
@@ -10,7 +10,8 @@
 static struct whitespace_rule {
 	const char *rule_name;
 	unsigned rule_bits;
-	unsigned loosens_error;
+	unsigned loosens_error:1,
+		exclude_default:1;
 } whitespace_rule_names[] = {
 	{ "trailing-space", WS_TRAILING_SPACE, 0 },
 	{ "space-before-tab", WS_SPACE_BEFORE_TAB, 0 },
@@ -82,7 +83,8 @@ unsigned whitespace_rule(const char *pathname)
 			unsigned all_rule = 0;
 			int i;
 			for (i = 0; i < ARRAY_SIZE(whitespace_rule_names); i++)
-				if (!whitespace_rule_names[i].loosens_error)
+				if (!whitespace_rule_names[i].loosens_error &&
+				    !whitespace_rule_names[i].exclude_default)
 					all_rule |= whitespace_rule_names[i].rule_bits;
 			return all_rule;
 		} else if (ATTR_FALSE(value)) {
-- 
1.7.0.3
