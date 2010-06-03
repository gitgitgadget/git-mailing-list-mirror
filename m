From: Johan Herland <johan@herland.net>
Subject: [PATCH 5/5] revision: Turn off history simplification in
 --ancestry-path mode
Date: Fri, 04 Jun 2010 01:17:37 +0200
Message-ID: <1275607057-26645-6-git-send-email-johan@herland.net>
References: <1275607057-26645-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 04 01:18:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKJg6-0007LN-98
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 01:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756682Ab0FCXST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 19:18:19 -0400
Received: from smtp.getmail.no ([84.208.15.66]:40874 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756611Ab0FCXSO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 19:18:14 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L3G00DCHOQ9CWC0@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 04 Jun 2010 01:18:09 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 34FB91EA55E3_C083831B	for <git@vger.kernel.org>; Thu,
 03 Jun 2010 23:18:09 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id E51D41EA2E13_C083830F	for <git@vger.kernel.org>; Thu,
 03 Jun 2010 23:18:08 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L3G007W6OPOV330@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 04 Jun 2010 01:18:08 +0200 (MEST)
X-Mailer: git-send-email 1.7.0.4
In-reply-to: <1275607057-26645-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148374>

When using --ancestry-path together with history simplification (typically
triggered by path limiting), history simplification would get in the way of
--ancestry-path by prematurely removing the parent links between commits on
which the ancestry path calculations are made.

This patch disables this history simplification when --ancestry-path is
enabled. This is similar to what e.g. --full-history already does.

The patch also includes a simple testcase verifying that --ancestry-path
works together with path limiting.

Signed-off-by: Johan Herland <johan@herland.net>
---
 revision.c                        |    1 +
 t/t6019-rev-list-ancestry-path.sh |   17 +++++++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index 7eeadb4..3f95680 100644
--- a/revision.c
+++ b/revision.c
@@ -1194,6 +1194,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->first_parent_only = 1;
 	} else if (!strcmp(arg, "--ancestry-path")) {
 		revs->ancestry_path = 1;
+		revs->simplify_history = 0;
 		revs->limited = 1;
 	} else if (!strcmp(arg, "-g") || !strcmp(arg, "--walk-reflogs")) {
 		init_reflog_walk(&revs->reflog_info);
diff --git a/t/t6019-rev-list-ancestry-path.sh b/t/t6019-rev-list-ancestry-path.sh
index 0230724..7641029 100755
--- a/t/t6019-rev-list-ancestry-path.sh
+++ b/t/t6019-rev-list-ancestry-path.sh
@@ -10,6 +10,9 @@ test_description='--ancestry-path'
 #
 #  D..M                 == E F G H I J K L M
 #  --ancestry-path D..M == E F H I J L M
+#
+#  D..M -- M.t                 == M
+#  --ancestry-path D..M -- M.t == M

 . ./test-lib.sh

@@ -53,4 +56,18 @@ test_expect_success 'rev-list --ancestry-path D..M' '
 	test_cmp expect actual
 '

+test_expect_success 'rev-list D..M -- M.t' '
+	echo M >expect &&
+	git rev-list --format=%s D..M -- M.t |
+	sed -e "/^commit /d" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rev-list --ancestry-patch D..M -- M.t' '
+	echo M >expect &&
+	git rev-list --ancestry-path --format=%s D..M -- M.t |
+	sed -e "/^commit /d" >actual &&
+	test_cmp expect actual
+'
+
 test_done
--
1.7.0.4
