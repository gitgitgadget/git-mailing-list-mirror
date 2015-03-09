From: Kevin Daudt <me@ikke.info>
Subject: [PATCH v4] rev-list: refuse --first-parent combined with --bisect
Date: Mon,  9 Mar 2015 21:56:15 +0100
Message-ID: <1425934575-19581-1-git-send-email-me@ikke.info>
References: <1425827005-9602-1-git-send-email-me@ikke.info>
Cc: git@vger.kernel.org, Kevin Daudt <me@ikke.info>
To: "Junio C. Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 21:56:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YV4jL-0006a8-7S
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 21:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbbCIU4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 16:56:47 -0400
Received: from ikke.info ([178.21.113.177]:38406 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932258AbbCIU4q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 16:56:46 -0400
Received: by vps892.directvps.nl (Postfix, from userid 182)
	id EA30B1DCF6D; Mon,  9 Mar 2015 21:56:44 +0100 (CET)
Received: from ikke-laptop.ikke (unknown [10.8.0.6])
	by vps892.directvps.nl (Postfix) with ESMTP id C6E284400AE;
	Mon,  9 Mar 2015 21:56:42 +0100 (CET)
X-Mailer: git-send-email 2.3.0
In-Reply-To: <1425827005-9602-1-git-send-email-me@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265196>

rev-list --bisect is used by git bisect, but never together with
--first-parent. Because rev-list --bisect together with --first-parent
is not handled currently, and even leads to segfaults, refuse to use
both options together.

Suggested-by: Junio C. Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Kevin Daudt <me@ikke.info>
---
Changes since v3:

* Added an ifdef::git-rev-list[] guard around the warning in the
  --first-parent section so that it only shows up in `man git-rev-list`
  and not in `man git log`

* Added the warning also to the --bisect section.

 Documentation/rev-list-options.txt | 4 ++++
 builtin/rev-list.c                 | 3 +++
 t/t6000-rev-list-misc.sh           | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 4ed8587..a148672 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -124,6 +124,9 @@ parents) and `--max-parents=-1` (negative numbers denote no upper limit).
 	adjusting to updated upstream from time to time, and
 	this option allows you to ignore the individual commits
 	brought in to your history by such a merge.
+ifdef::git-rev-list[]
+	Cannot be combined with --bisect.
+endif::git-rev-list[]
 
 --not::
 	Reverses the meaning of the '{caret}' prefix (or lack thereof)
@@ -567,6 +570,7 @@ would be of roughly the same length.  Finding the change which
 introduces a regression is thus reduced to a binary search: repeatedly
 generate and test new 'midpoint's until the commit chain is of length
 one.
+Cannot be combined with --first-parent.
 
 --bisect-vars::
 	This calculates the same as `--bisect`, except that refs in
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ff84a82..f5da2a4 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -291,6 +291,9 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (revs.bisect)
 		bisect_list = 1;
 
+	if (revs.first_parent_only && revs.bisect)
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
2.3.0
