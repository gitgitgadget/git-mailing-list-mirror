From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/3] rev-parse: fix using "--default" with "--verify"
Date: Sun, 11 May 2008 18:27:36 +0200
Message-ID: <20080511182736.b279b655.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 11 18:24:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvEKt-0002Qg-MT
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 18:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754716AbYEKQWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 12:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754660AbYEKQWz
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 12:22:55 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:33651 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754643AbYEKQWy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 12:22:54 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 9E6CA1AB2AD;
	Sun, 11 May 2008 18:22:53 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 68A531AB2DF;
	Sun, 11 May 2008 18:22:53 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81788>

Before this patch, something like:

$ git rev-parse --verify HEAD --default master

did not work, while:

$ git rev-parse --default master --verify HEAD

worked.

This patch fixes that, so that they both work (assuming
HEAD and master can be parsed).

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-rev-parse.c         |    2 ++
 t/t1503-rev-parse-verify.sh |   11 +++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 0e59707..7dbf282 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -583,6 +583,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			continue;
 		verify_filename(prefix, arg);
 	}
+	if (verify && revs_count == 1)
+		return 0;
 	show_default();
 	if (verify && revs_count != 1)
 		die_no_single_rev(quiet);
diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index a0d14cb..e93f1b3 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -97,18 +97,17 @@ test_expect_failure '3 no stdout output on error' '
 	test -z "$(git rev-parse --verify $HASH2 HEAD)"
 '
 
-test_expect_success '1 with --default' '
+test_expect_success 'use --default' '
 	git rev-parse --verify --default master &&
 	git rev-parse --verify --default master HEAD &&
 	git rev-parse --default master --verify &&
 	git rev-parse --default master --verify HEAD &&
+	git rev-parse --verify HEAD --default master &&
 	test_must_fail git rev-parse --verify foo --default master &&
 	test_must_fail git rev-parse --default HEAD --verify bar &&
-	test_must_fail git rev-parse --verify --default HEAD baz
-'
-
-test_expect_failure '2 with --default' '
-	git rev-parse --verify HEAD --default master
+	test_must_fail git rev-parse --verify --default HEAD baz &&
+	test_must_fail git rev-parse --default foo --verify &&
+	test_must_fail git rev-parse --verify --default bar
 '
 
 test_done
-- 
1.5.5.1.347.g86562
