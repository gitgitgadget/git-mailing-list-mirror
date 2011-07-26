From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 04/19] Disallow the empty string as an attribute name
Date: Tue, 26 Jul 2011 16:12:47 +0200
Message-ID: <1311689582-3116-5-git-send-email-mhagger@alum.mit.edu>
References: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 16:32:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qlig6-0005I5-Pt
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 16:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367Ab1GZOb7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 10:31:59 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:40203 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491Ab1GZObz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 10:31:55 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QliM6-0004aQ-Jk; Tue, 26 Jul 2011 16:11:30 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177875>

Previously, it was possible to have a line like "file.txt =foo" in a
.gitattribute file, after which an invocation like "git check-attr ''
-- file.txt" would succeed.  This patch disallows both constructs.

Please note that any existing .gitattributes file that tries to set an
empty attribute will now trigger the error message "error: : not a
valid attribute name" whereas previously the nonsense was allowed
through.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

Currently it is possible to use the empty string as an attribute name.
For example, a .gitattributes file can have a line

    file.txt =foo

and git-check-attr can be invoked as

    git check-attr '' -- file.txt

Indeed, the above command invocation would report that attribute ''
has value 'foo' (though the output looks weird).

I believe this behavior to be a bug, so this patch prohibits the empty
string as an attribute name.  Any attempt to use the empty string as
an attribute name will now trigger the error message "error: : not a
valid attribute name"

Please note that it is conceivable that there are existing
repositories with .gitattributes files that set empty attributes.  If
so, any attempt to read *any* attributes from a file in an affected
directory will fail with the above error message.

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
