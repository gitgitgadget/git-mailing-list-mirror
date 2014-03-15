From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2] mv: prevent mismatched data when ignoring errors.
Date: Sat, 15 Mar 2014 18:56:52 +0000
Message-ID: <1394909812-92472-1-git-send-email-sandals@crustytoothpaste.net>
References: <1394306499-50871-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Guillaume Gelin <contact@ramnes.eu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 19:57:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOtla-0002aY-Pn
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 19:57:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756088AbaCOS5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 14:57:00 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:52625 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755951AbaCOS5A (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Mar 2014 14:57:00 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 32C1628074;
	Sat, 15 Mar 2014 18:56:58 +0000 (UTC)
X-Mailer: git-send-email 1.9.0.1010.g6633b85.dirty
In-Reply-To: <1394306499-50871-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 () ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244162>

We shrink the source and destination arrays, but not the modes or
submodule_gitfile arrays, resulting in potentially mismatched data.  Shrink
all the arrays at the same time to prevent this.  Add tests to ensure the
problem does not recur.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---

I attempted to come up with a second patch that would refactor out the
four different arrays into one array of struct, as Jeff suggested, but
it became very ugly very quickly.  So this patch simply fixes the
problem and adds tests.

 builtin/mv.c  |  5 +++++
 t/t7001-mv.sh | 13 ++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index f99c91e..09bbc63 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -230,6 +230,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 					memmove(destination + i,
 						destination + i + 1,
 						(argc - i) * sizeof(char *));
+					memmove(modes + i, modes + i + 1,
+						(argc - i) * sizeof(enum update_mode));
+					memmove(submodule_gitfile + i,
+						submodule_gitfile + i + 1,
+						(argc - i) * sizeof(char *));
 					i--;
 				}
 			} else
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index e3c8c2c..215d43d 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -294,7 +294,8 @@ test_expect_success 'setup submodule' '
 	git submodule add ./. sub &&
 	echo content >file &&
 	git add file &&
-	git commit -m "added sub and file"
+	git commit -m "added sub and file" &&
+	git branch submodule
 '
 
 test_expect_success 'git mv cannot move a submodule in a file' '
@@ -463,4 +464,14 @@ test_expect_success 'checking out a commit before submodule moved needs manual u
 	! test -s actual
 '
 
+test_expect_success 'mv -k does not accidentally destroy submodules' '
+	git checkout submodule &&
+	mkdir dummy dest &&
+	git mv -k dummy sub dest &&
+	git status --porcelain >actual &&
+	grep "^R  sub -> dest/sub" actual &&
+	git reset --hard &&
+	git checkout .
+'
+
 test_done
-- 
1.9.0.1010.g6633b85.dirty
