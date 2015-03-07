From: Kevin Daudt <me@ikke.info>
Subject: [PATCH] rev-list: refuse --first-parent combined with --bisect
Date: Sat,  7 Mar 2015 22:31:16 +0100
Message-ID: <1425763876-15573-1-git-send-email-me@ikke.info>
References: <xmqq61ag72gc.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org, Kevin Daudt <me@ikke.info>
To: "Junio C. Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 22:32:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUMKS-0005Zc-IN
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 22:32:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbbCGVcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2015 16:32:07 -0500
Received: from ikke.info ([178.21.113.177]:36086 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892AbbCGVcG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2015 16:32:06 -0500
Received: by vps892.directvps.nl (Postfix, from userid 182)
	id 7F6671DCF6D; Sat,  7 Mar 2015 22:32:05 +0100 (CET)
Received: from ikke-laptop.ikke (unknown [10.8.0.6])
	by vps892.directvps.nl (Postfix) with ESMTP id 3F3954400AE;
	Sat,  7 Mar 2015 22:32:03 +0100 (CET)
X-Mailer: git-send-email 2.3.1.184.g97c12a8.dirty
In-Reply-To: <xmqq61ag72gc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265004>

rev-list --bisect is used by git bisect, but never together with
--first-parent. Because rev-list --bisect together with --first-parent
is not handled currently, and even leads to segfaults, refuse to use
both options together.

Signed-off-by: Kevin Daudt <me@ikke.info>
---
This is my first code patch, and thought this was a nice exercise.

 Documentation/rev-list-options.txt | 3 ++-
 builtin/rev-list.c                 | 3 +++
 t/t6000-rev-list-misc.sh           | 4 ++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 4ed8587..05c3f6d 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -123,7 +123,8 @@ parents) and `--max-parents=-1` (negative numbers denote no upper limit).
 	because merges into a topic branch tend to be only about
 	adjusting to updated upstream from time to time, and
 	this option allows you to ignore the individual commits
-	brought in to your history by such a merge.
+	brought in to your history by such a merge. Cannot be
+	combined with --bisect.
 
 --not::
 	Reverses the meaning of the '{caret}' prefix (or lack thereof)
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ff84a82..c271e15 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -291,6 +291,9 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (revs.bisect)
 		bisect_list = 1;
 
+	if(revs.first_parent_only && revs.bisect)
+		die(_("--first-parent is incompattible with --bisect"));
+
 	if (DIFF_OPT_TST(&revs.diffopt, QUICK))
 		info.flags |= REV_LIST_QUIET;
 	for (i = 1 ; i < argc; i++) {
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index 2602086..1f58b46 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -96,4 +96,8 @@ test_expect_success 'rev-list can show index objects' '
 	test_cmp expect actual
 '
 
+test_expect_success '--bisect and --first-parent can not be combined' '
+	test_must_fail git rev-list --bisect --first-parent HEAD
+'
+
 test_done
-- 
2.3.1.184.g97c12a8.dirty
