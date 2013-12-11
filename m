From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 05/10] t6050: show that git cat-file --batch fails with
 replace objects
Date: Wed, 11 Dec 2013 08:46:08 +0100
Message-ID: <20131211074614.11117.30044.chriscool@tuxfamily.org>
References: <20131211074147.11117.1155.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 11 08:48:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqeWe-0007xL-3K
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 08:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346Ab3LKHrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 02:47:53 -0500
Received: from [194.158.98.14] ([194.158.98.14]:53300 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751252Ab3LKHrt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 02:47:49 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 6286E46;
	Wed, 11 Dec 2013 08:47:28 +0100 (CET)
X-git-sha1: 58390c4fd209626137f6ebaae38f76f53eff3669 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131211074147.11117.1155.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239174>

When --batch is passed to git cat-file, the sha1_object_info_extended()
function is used to get information about the objects passed to
git cat-file.

Unfortunately sha1_object_info_extended() doesn't take care of
object replacement properly, so it will often fail with a
message like this:

$ echo a3fb2e1845a1aaf129b7975048973414dc172173 | git cat-file --batch
a3fb2e1845a1aaf129b7975048973414dc172173 commit 231
fatal: object a3fb2e1845a1aaf129b7975048973414dc172173 change size!?

The goal of this patch is to show this breakage.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6050-replace.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 7d47984..b90dbdc 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -276,6 +276,11 @@ test_expect_success '-f option bypasses the type check' '
 	git replace -f HEAD^ $BLOB
 '
 
+test_expect_failure 'git cat-file --batch works on replace objects' '
+	git replace | grep $PARA3 &&
+	echo $PARA3 | git cat-file --batch
+'
+
 test_expect_success 'replace ref cleanup' '
 	test -n "$(git replace)" &&
 	git replace -d $(git replace) &&
-- 
1.8.5.1.102.g090758b
