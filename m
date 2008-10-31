From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] update-ref --no-deref -d: handle the case when the pointed ref is packed
Date: Sat,  1 Nov 2008 00:25:44 +0100
Message-ID: <1225495544-21487-1-git-send-email-vmiklos@frugalware.org>
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 00:26:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw3Nc-0007zx-Rk
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 00:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbYJaXYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 19:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbYJaXYy
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 19:24:54 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:53666 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbYJaXYx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 19:24:53 -0400
Received: from vmobile.example.net (dsl5401C4E2.pool.t-online.hu [84.1.196.226])
	by yugo.frugalware.org (Postfix) with ESMTPA id 90FEB446CCD;
	Sat,  1 Nov 2008 00:24:51 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 9884F14E35; Sat,  1 Nov 2008 00:25:44 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99676>

In this case we did nothing in the past, but we should delete the
reference in fact.

The problem was that when the symref is not packed but the referenced
ref is packed, then we assumed that the symref is packed as well, but
symrefs are never packed.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

This applies on top of 'mv/maint-branch-m-symref' (fa58186).

 refs.c                |    2 +-
 t/t1400-update-ref.sh |   11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index 8a38e08..0d239e1 100644
--- a/refs.c
+++ b/refs.c
@@ -920,7 +920,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	lock = lock_ref_sha1_basic(refname, sha1, 0, &flag);
 	if (!lock)
 		return 1;
-	if (!(flag & REF_ISPACKED)) {
+	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
 		/* loose */
 		const char *path;
 
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 8139cd6..bd58926 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -82,6 +82,17 @@ test_expect_success "delete symref without dereference" '
 '
 cp -f .git/HEAD.orig .git/HEAD
 
+test_expect_success "delete symref without dereference when the referred ref is packed" '
+	echo foo >foo.c &&
+	git add foo.c &&
+	git commit -m foo &&
+	git pack-refs --all &&
+	git update-ref --no-deref -d HEAD &&
+	! test -f .git/HEAD
+'
+cp -f .git/HEAD.orig .git/HEAD
+git update-ref -d $m
+
 test_expect_success '(not) create HEAD with old sha1' "
 	test_must_fail git update-ref HEAD $A $B
 "
-- 
1.6.0.2
