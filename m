From: Johan Herland <johan@herland.net>
Subject: [PATCH 2/2] Fix failure to delete a packed ref through a symref
Date: Sun, 21 Oct 2012 12:40:32 +0200
Message-ID: <1350816032-16312-3-git-send-email-johan@herland.net>
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
	id 1TPsxs-0007AC-G1
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 12:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381Ab2JUKkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 06:40:46 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:60207 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481Ab2JUKko (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 06:40:44 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so1121856lbo.19
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 03:40:43 -0700 (PDT)
Received: by 10.112.39.161 with SMTP id q1mr2446248lbk.131.1350816043688;
        Sun, 21 Oct 2012 03:40:43 -0700 (PDT)
Received: from gamma.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPS id gk11sm2010244lab.3.2012.10.21.03.40.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 21 Oct 2012 03:40:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1.609.g5cd6968
In-Reply-To: <1350816032-16312-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208118>

When deleting a ref through a symref (e.g. using 'git update-ref -d HEAD'
to delete refs/heads/master), we would remove the loose ref, but a packed
version of the same ref would remain, the end result being that instead of
deleting refs/heads/master we would appear to reset it to its state as of
the last repack.

This patch fixes the issue, by making sure we pass the correct ref name
when invoking repack_without_ref() from within delete_ref().

Signed-off-by: Johan Herland <johan@herland.net>
---
 refs.c                | 2 +-
 t/t1400-update-ref.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 726c53c..6cec1c8 100644
--- a/refs.c
+++ b/refs.c
@@ -1779,7 +1779,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	 * packed one.  Also, if it was not loose we need to repack
 	 * without it.
 	 */
-	ret |= repack_without_ref(refname);
+	ret |= repack_without_ref(lock->ref_name);
 
 	unlink_or_warn(git_path("logs/%s", lock->ref_name));
 	invalidate_ref_cache(NULL);
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index f7ec203..e415ee0 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -85,7 +85,7 @@ test_expect_success \
 	"move $m (by HEAD)" \
 	"git update-ref HEAD $B $A &&
 	 test $B"' = $(cat .git/'"$m"')'
-test_expect_failure "delete $m (by HEAD) should remove both packed and loose $m" '
+test_expect_success "delete $m (by HEAD) should remove both packed and loose $m" '
 	git update-ref -d HEAD $B &&
 	! grep "$m" .git/packed-refs &&
 	! test -f .git/$m
-- 
1.7.12.1.609.g5cd6968
