From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 04/23] Disallow the empty string as an attribute name
Date: Thu,  4 Aug 2011 06:36:14 +0200
Message-ID: <1312432593-9841-5-git-send-email-mhagger@alum.mit.edu>
References: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 06:37:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QopgR-0005Mu-Jy
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 06:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325Ab1HDEhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 00:37:03 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39637 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873Ab1HDEg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 00:36:58 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB339.dip.t-dialin.net [84.190.179.57])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p744agHi029203;
	Thu, 4 Aug 2011 06:36:54 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178674>

Previously, it was possible to have a line like "file.txt =foo" in a
.gitattribute file, after which an invocation like "git check-attr ''
-- file.txt" would succeed.  This patch disallows both constructs.

Please note that any existing .gitattributes file that tries to set an
empty attribute will now trigger the error message "error: : not a
valid attribute name" whereas previously the nonsense was allowed
through.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 attr.c                |    2 +-
 t/t0003-attributes.sh |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/attr.c b/attr.c
index 4a1244f..b1d1d6d 100644
--- a/attr.c
+++ b/attr.c
@@ -53,7 +53,7 @@ static int invalid_attr_name(const char *name, int namelen)
 	 * Attribute name cannot begin with '-' and must consist of
 	 * characters from [-A-Za-z0-9_.].
 	 */
-	if (*name == '-')
+	if (namelen <= 0 || *name == '-')
 		return -1;
 	while (namelen--) {
 		char ch = *name++;
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index ebbc755..8c76b79 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -42,6 +42,12 @@ test_expect_success 'setup' '
 
 '
 
+test_expect_success 'command line checks' '
+
+	test_must_fail git check-attr "" -- f
+
+'
+
 test_expect_success 'attribute test' '
 
 	attr_check f f &&
-- 
1.7.6.8.gd2879
