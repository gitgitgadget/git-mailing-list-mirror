From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 09/10] builtin/replace: unset read_replace_refs
Date: Sat, 28 Dec 2013 12:00:14 +0100
Message-ID: <20131228110016.2272.5575.chriscool@tuxfamily.org>
References: <20131228105505.2272.58873.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 28 12:01:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwreD-0007rw-Mh
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 12:01:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755177Ab3L1LBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Dec 2013 06:01:21 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:33999 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755114Ab3L1LAv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Dec 2013 06:00:51 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 458F866;
	Sat, 28 Dec 2013 12:00:50 +0100 (CET)
X-git-sha1: 4b86d3f060086d31796759f0c5fa8c711ad85df1 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131228105505.2272.58873.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239776>

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
index b93d204..2336325 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -178,6 +178,8 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	read_replace_refs = 0;
+
 	argc = parse_options(argc, argv, prefix, options, git_replace_usage, 0);
 
 	if (list && delete)
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 9d05101..719a116 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -306,7 +306,7 @@ test_expect_success 'test --format medium' '
 	test_cmp expected actual
 '
 
-test_expect_failure 'test --format long' '
+test_expect_success 'test --format long' '
 	{
 		echo "$H1 (commit) -> $BLOB (blob)" &&
 		echo "$BLOB (blob) -> $REPLACED (blob)" &&
-- 
1.8.4.1.616.g07f5c81
