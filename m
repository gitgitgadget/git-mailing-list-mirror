From: Johan Herland <johan@herland.net>
Subject: [PATCH 5/5] branch -d: Fix failure to remove branch aliases (symrefs)
Date: Tue, 16 Oct 2012 15:44:54 +0200
Message-ID: <1350395094-11404-6-git-send-email-johan@herland.net>
References: <CAPc5daUws-MfzC9imkytTrLaHyyywE4_OX1jAUVPCTK2WyUF=w@mail.gmail.com>
 <1350395094-11404-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, rene.scharfe@lsrfire.ath.cx, vmiklos@suse.cz,
	Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Oct 16 15:45:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO7Sf-0004f2-4u
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 15:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754227Ab2JPNpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 09:45:15 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:63923 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754190Ab2JPNpN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 09:45:13 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so3506457eek.19
        for <git@vger.kernel.org>; Tue, 16 Oct 2012 06:45:13 -0700 (PDT)
Received: by 10.14.214.2 with SMTP id b2mr12760983eep.32.1350395113105;
        Tue, 16 Oct 2012 06:45:13 -0700 (PDT)
Received: from gamma.cisco.com (64-103-25-233.cisco.com. [64.103.25.233])
        by mx.google.com with ESMTPS id o47sm11333415eem.11.2012.10.16.06.45.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 16 Oct 2012 06:45:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1.609.g5cd6968
In-Reply-To: <1350395094-11404-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207827>

With refs/heads/alias set up as a symref to refs/heads/master,
'git branch -d alias' should remove refs/heads/alias and not
refs/heads/master.

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin/branch.c                        | 2 +-
 t/t3220-symbolic-ref-as-branch-alias.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index ffd2684..31af114 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -221,7 +221,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			continue;
 		}
 
-		if (delete_ref(name, sha1, 0)) {
+		if (delete_ref(name, sha1, REF_NODEREF)) {
 			error(remote_branch
 			      ? _("Error deleting remote branch '%s'")
 			      : _("Error deleting branch '%s'"),
diff --git a/t/t3220-symbolic-ref-as-branch-alias.sh b/t/t3220-symbolic-ref-as-branch-alias.sh
index 39f3a33..8ebec7a 100755
--- a/t/t3220-symbolic-ref-as-branch-alias.sh
+++ b/t/t3220-symbolic-ref-as-branch-alias.sh
@@ -43,7 +43,7 @@ test_expect_success 'commits are reflected through "alias" symref' '
 	test_cmp expect alias
 '
 
-test_expect_failure '"branch -d" deletes the "alias" symref' '
+test_expect_success '"branch -d" deletes the "alias" symref' '
 	git branch -d alias &&
 	git rev-parse --verify master > master &&
 	test_must_fail git rev-parse --verify alias &&
-- 
1.7.12.1.609.g5cd6968
