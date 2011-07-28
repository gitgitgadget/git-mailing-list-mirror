From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 04/19] Disallow the empty string as an attribute name
Date: Thu, 28 Jul 2011 06:46:43 +0200
Message-ID: <1311828418-2676-5-git-send-email-mhagger@alum.mit.edu>
References: <1311828418-2676-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 28 06:47:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmIVZ-0005eI-P1
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 06:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297Ab1G1Era (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 00:47:30 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:57257 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490Ab1G1ErV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 00:47:21 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QmITD-000889-Av; Thu, 28 Jul 2011 06:45:15 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1311828418-2676-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178019>

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
