From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 09/10] builtin/replace: unset read_replace_refs
Date: Wed, 11 Dec 2013 08:46:12 +0100
Message-ID: <20131211074614.11117.18678.chriscool@tuxfamily.org>
References: <20131211074147.11117.1155.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 11 08:48:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqeWf-0007xL-62
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 08:48:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370Ab3LKHsC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 02:48:02 -0500
Received: from [194.158.98.15] ([194.158.98.15]:58271 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751280Ab3LKHrv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 02:47:51 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 38EA255;
	Wed, 11 Dec 2013 08:47:30 +0100 (CET)
X-git-sha1: b9a089528bff10e00c9cb766597b62e3ad11e40f 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131211074147.11117.1155.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239177>

When checking to see if some objects are of the same type
and when displaying the type of objects, git replace uses
the sha1_object_info() function.

Unfortunately this function by default respects replace
refs, so instead of the type of a replaced object, it
gives the type of the replacement object which might
be different.

To fix this bug, and because git replace should work at a
level before replacement takes place, let's unset the
read_replace_refs global variable at the beginning of
cmd_replace().

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replace.c  | 2 ++
 t/t6050-replace.sh | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 9f3619a..1672870 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -174,6 +174,8 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	read_replace_refs = 0;
+
 	argc = parse_options(argc, argv, prefix, options, git_replace_usage, 0);
 
 	if (list && delete)
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index e1cc3b8..d0c62f7 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -306,7 +306,7 @@ test_expect_success 'test --format medium' '
 	test_cmp expected actual
 '
 
-test_expect_failure 'test --format full' '
+test_expect_success 'test --format full' '
 	{
 		echo "$H1 (commit) -> $BLOB (blob)" &&
 		echo "$BLOB (blob) -> $REPLACED (blob)" &&
-- 
1.8.5.1.102.g090758b
