From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 3/3] Fix git update-ref --no-deref -d.
Date: Sun, 26 Oct 2008 03:33:58 +0100
Message-ID: <f10fa3f86cbdf14ae935eaf806ee6b4a1922e0c2.1224987945.git.vmiklos@frugalware.org>
References: <cover.1224987944.git.vmiklos@frugalware.org>
 <39b6bd01cf753d48a803e1d5908e543b66899c77.1224987944.git.vmiklos@frugalware.org>
 <b06bf89aeeb844903e16f7c231c6add011a910bf.1224987945.git.vmiklos@frugalware.org>
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 03:34:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtvSk-0001cv-O9
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 03:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbYJZCdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 22:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbYJZCdQ
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 22:33:16 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:53275 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbYJZCdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 22:33:16 -0400
Received: from vmobile.example.net (catv-80-98-230-81.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTPA id E9F67446CD1;
	Sun, 26 Oct 2008 03:33:13 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 10C128B389; Sun, 26 Oct 2008 03:33:59 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <b06bf89aeeb844903e16f7c231c6add011a910bf.1224987945.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1224987944.git.vmiklos@frugalware.org>
References: <cover.1224987944.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99135>

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
