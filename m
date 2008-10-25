From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 2/2] Fix git update-ref --no-deref -d.
Date: Sat, 25 Oct 2008 14:58:42 +0200
Message-ID: <f4adb5a66764e620125adc99abd65b1ca897513d.1224939436.git.vmiklos@frugalware.org>
References: <cover.1224939436.git.vmiklos@frugalware.org>
 <a96243124c555cbc4081f733b348252ac200bd53.1224939436.git.vmiklos@frugalware.org>
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 25 14:59:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ktijv-00008K-L1
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 14:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbYJYM6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 08:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752108AbYJYM6A
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 08:58:00 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:43616 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbYJYM57 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 08:57:59 -0400
Received: from vmobile.example.net (dsl5401C809.pool.t-online.hu [84.1.200.9])
	by yugo.frugalware.org (Postfix) with ESMTPA id A0FCD446CD0;
	Sat, 25 Oct 2008 14:57:56 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id D54DF8B387; Sat, 25 Oct 2008 14:58:42 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <a96243124c555cbc4081f733b348252ac200bd53.1224939436.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1224939436.git.vmiklos@frugalware.org>
References: <cover.1224939436.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99105>

Till now --no-deref was just ignored when deleting refs, fix this.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-update-ref.c  |    8 +++++---
 t/t1400-update-ref.sh |    7 +++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin-update-ref.c b/builtin-update-ref.c
index d8f3142..378dc1b 100644
--- a/builtin-update-ref.c
+++ b/builtin-update-ref.c
@@ -13,7 +13,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 {
 	const char *refname, *oldval, *msg=NULL;
 	unsigned char sha1[20], oldsha1[20];
-	int delete = 0, no_deref = 0;
+	int delete = 0, no_deref = 0, flags = 0;
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, "reason", "reason of the update"),
 		OPT_BOOLEAN('d', NULL, &delete, "deletes the reference"),
@@ -47,9 +47,11 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	if (oldval && *oldval && get_sha1(oldval, oldsha1))
 		die("%s: not a valid old SHA1", oldval);
 
+	if (no_deref)
+		flags = REF_NODEREF;
 	if (delete)
-		return delete_ref(refname, oldval ? oldsha1 : NULL, 0);
+		return delete_ref(refname, oldval ? oldsha1 : NULL, flags);
 	else
 		return update_ref(msg, refname, sha1, oldval ? oldsha1 : NULL,
-				  no_deref ? REF_NODEREF : 0, DIE_ON_ERR);
+				  flags, DIE_ON_ERR);
 }
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 04c2b16..8139cd6 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -75,6 +75,13 @@ test_expect_success "delete $m (by HEAD)" '
 '
 rm -f .git/$m
 
+cp -f .git/HEAD .git/HEAD.orig
+test_expect_success "delete symref without dereference" '
+	git update-ref --no-deref -d HEAD &&
+	! test -f .git/HEAD
+'
+cp -f .git/HEAD.orig .git/HEAD
+
 test_expect_success '(not) create HEAD with old sha1' "
 	test_must_fail git update-ref HEAD $A $B
 "
-- 
1.6.0.2
