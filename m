From: Johan Herland <johan@herland.net>
Subject: [PATCH 1/2] t1400-update-ref: Add test verifying bug with symrefs in delete_ref()
Date: Sun, 21 Oct 2012 12:40:31 +0200
Message-ID: <1350816032-16312-2-git-send-email-johan@herland.net>
References: <7vpq4flb1c.fsf@alter.siamese.dyndns.org>
 <1350816032-16312-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, rene.scharfe@lsrfire.ath.cx, vmiklos@suse.cz,
	Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Oct 21 12:41:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPsxs-0007AC-13
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 12:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552Ab2JUKko (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 06:40:44 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:60207 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393Ab2JUKkn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 06:40:43 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so1121856lbo.19
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 03:40:41 -0700 (PDT)
Received: by 10.152.146.101 with SMTP id tb5mr5279148lab.44.1350816041900;
        Sun, 21 Oct 2012 03:40:41 -0700 (PDT)
Received: from gamma.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPS id gk11sm2010244lab.3.2012.10.21.03.40.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 21 Oct 2012 03:40:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1.609.g5cd6968
In-Reply-To: <1350816032-16312-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208119>

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
