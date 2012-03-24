From: Jukka Lehtniemi <jukka.lehtniemi@gmail.com>
Subject: [PATCH] rev-list: fix place holder %N (notes) in user format
Date: Sat, 24 Mar 2012 21:38:31 +0200
Message-ID: <1332617911-8281-1-git-send-email-jukka.lehtniemi@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jukka Lehtniemi <jukka.lehtniemi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 24 20:39:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBWoZ-0007su-5m
	for gcvg-git-2@plane.gmane.org; Sat, 24 Mar 2012 20:39:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554Ab2CXTjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Mar 2012 15:39:18 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:50433 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078Ab2CXTjR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2012 15:39:17 -0400
Received: by lbbgm6 with SMTP id gm6so3232528lbb.19
        for <git@vger.kernel.org>; Sat, 24 Mar 2012 12:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=2DdtO2eh5ixEmskKQunUFVUQmqt2Q8l2xfvP8U7kaj8=;
        b=YMLP5rKUzYSqfZoY+mYwQPxHO78hPai7VHwWKrKUwYKGKo2ULnEF2+TN7yxCoSWVAZ
         4cC+xdaEv9yJMt+nEH8lqqOAWV0UK34q38ixoVxGSLwSjD2CYU8io/CZNjoHRlictzGo
         tetEFaOa9cEsuQsIQRY+rP03Hj5gY7gbAxvhHVA5GrhZQfj+hoyZuVWl6TmBF0K547vb
         5hvRrCOWHhHx58EIOMm1w6e5GUJ3UKB7BR+ucGucnyEhbihj7fQARsqTI68t6PmfnzQ4
         SkQMNBjm559BkKjxLdBI/Btvirl68igvgGK6WuIjnLx7/Ng7FpkiA5OqteXPum5a0Rsd
         V0VA==
Received: by 10.112.102.65 with SMTP id fm1mr5670750lbb.82.1332617956226;
        Sat, 24 Mar 2012 12:39:16 -0700 (PDT)
Received: from localhost.localdomain (dsl-hkibrasgw3-ff5bc100-135.dhcp.inet.fi. [88.193.91.135])
        by mx.google.com with ESMTPS id u4sm11842968lad.5.2012.03.24.12.39.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 24 Mar 2012 12:39:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193842>


Signed-off-by: Jukka Lehtniemi <jukka.lehtniemi@gmail.com>
---

 Fixes a bug where the place holder for notes (%N) was not expanded 
 in rev-list. To reproduce the bug:
   $ git notes add -m foo
   $ git rev-list --notes --format=format:%N HEAD ^HEAD^


 builtin/rev-list.c         |    4 +++-
 t/t6006-rev-list-format.sh |   12 ++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 4c4d404..d6e7dfc 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -110,6 +110,7 @@ static void show_commit(struct commit *commit, void *data)
 		ctx.abbrev = revs->abbrev;
 		ctx.date_mode = revs->date_mode;
 		ctx.fmt = revs->commit_format;
+		ctx.show_notes = revs->show_notes;
 		pretty_print_commit(&ctx, commit, &buf);
 		if (revs->graph) {
 			if (buf.len) {
@@ -323,7 +324,8 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	info.revs = &revs;
 	if (revs.bisect)
 		bisect_list = 1;
-
+	if (revs.show_notes)
+		init_display_notes(&revs.notes_opt);
 	if (DIFF_OPT_TST(&revs.diffopt, QUICK))
 		info.flags |= REV_LIST_QUIET;
 	for (i = 1 ; i < argc; i++) {
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 4442790..76af40a 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -7,18 +7,26 @@ test_description='git rev-list --pretty=format test'
 test_tick
 test_expect_success 'setup' '
 touch foo && git add foo && git commit -m "added foo" &&
-  echo changed >foo && git commit -a -m "changed foo"
+  echo changed >foo && git commit -a -m "changed foo" &&
+  git notes add -m "note foo"
 '
 
 # usage: test_format name format_string <expected_output
 test_format() {
 	cat >expect.$1
 	test_expect_success "format $1" "
-git rev-list --pretty=format:'$2' master >output.$1 &&
+git rev-list --notes --pretty=format:'$2' master >output.$1 &&
 test_cmp expect.$1 output.$1
 "
 }
 
+test_format notes %N <<'EOF'
+commit 131a310eb913d107dd3c09a65d1651175898735d
+note foo
+
+commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+EOF
+
 test_format percent %%h <<'EOF'
 commit 131a310eb913d107dd3c09a65d1651175898735d
 %h
-- 
1.7.4.1
