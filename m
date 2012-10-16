From: Johan Herland <johan@herland.net>
Subject: [PATCH 1/5] t1400-update-ref: Add test verifying bug with symrefs in delete_ref()
Date: Tue, 16 Oct 2012 15:44:50 +0200
Message-ID: <1350395094-11404-2-git-send-email-johan@herland.net>
References: <CAPc5daUws-MfzC9imkytTrLaHyyywE4_OX1jAUVPCTK2WyUF=w@mail.gmail.com>
 <1350395094-11404-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, rene.scharfe@lsrfire.ath.cx, vmiklos@suse.cz,
	Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Oct 16 15:45:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO7ST-0004Sl-Mk
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 15:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754169Ab2JPNpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 09:45:09 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:63923 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754061Ab2JPNpI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 09:45:08 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so3506457eek.19
        for <git@vger.kernel.org>; Tue, 16 Oct 2012 06:45:07 -0700 (PDT)
Received: by 10.14.178.195 with SMTP id f43mr21216983eem.44.1350395106937;
        Tue, 16 Oct 2012 06:45:06 -0700 (PDT)
Received: from gamma.cisco.com (64-103-25-233.cisco.com. [64.103.25.233])
        by mx.google.com with ESMTPS id o47sm11333415eem.11.2012.10.16.06.45.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 16 Oct 2012 06:45:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1.609.g5cd6968
In-Reply-To: <1350395094-11404-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207824>

When deleting a ref through a symref (e.g. using 'git update-ref -d HEAD'
to delete refs/heads/master), we currently fail to remove the packed
version of that ref. This testcase demonstrates the bug.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t1400-update-ref.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 4fd83a6..f7ec203 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -74,6 +74,24 @@ test_expect_success "delete $m (by HEAD)" '
 '
 rm -f .git/$m
 
+test_expect_success \
+	"create $m (by HEAD)" \
+	"git update-ref HEAD $A &&
+	 test $A"' = $(cat .git/'"$m"')'
+test_expect_success \
+	"pack refs" \
+	"git pack-refs --all"
+test_expect_success \
+	"move $m (by HEAD)" \
+	"git update-ref HEAD $B $A &&
+	 test $B"' = $(cat .git/'"$m"')'
+test_expect_failure "delete $m (by HEAD) should remove both packed and loose $m" '
+	git update-ref -d HEAD $B &&
+	! grep "$m" .git/packed-refs &&
+	! test -f .git/$m
+'
+rm -f .git/$m
+
 cp -f .git/HEAD .git/HEAD.orig
 test_expect_success "delete symref without dereference" '
 	git update-ref --no-deref -d HEAD &&
-- 
1.7.12.1.609.g5cd6968
