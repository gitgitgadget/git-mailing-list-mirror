From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 05/10] t6050: show that git cat-file --batch fails with
 replace objects
Date: Sat, 28 Dec 2013 12:00:10 +0100
Message-ID: <20131228110016.2272.70512.chriscool@tuxfamily.org>
References: <20131228105505.2272.58873.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 28 12:01:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vwrdx-0007j1-AC
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 12:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755150Ab3L1LAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Dec 2013 06:00:52 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:46905 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755089Ab3L1LAt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Dec 2013 06:00:49 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 753BC43;
	Sat, 28 Dec 2013 12:00:48 +0100 (CET)
X-git-sha1: 58390c4fd209626137f6ebaae38f76f53eff3669 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131228105505.2272.58873.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239774>

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
1.8.4.1.616.g07f5c81
