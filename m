From: Kevin Daudt <me@ikke.info>
Subject: [PATCH v5] rev-list: refuse --first-parent combined with --bisect
Date: Thu, 19 Mar 2015 23:14:08 +0100
Message-ID: <1426803248-6905-1-git-send-email-me@ikke.info>
References: <1425934575-19581-1-git-send-email-me@ikke.info>
Cc: git@vger.kernel.org, Kevin Daudt <me@ikke.info>
To: "Junio C. Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 23:14:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYihw-00030r-PO
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 23:14:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbbCSWOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 18:14:24 -0400
Received: from ikke.info ([178.21.113.177]:50518 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750969AbbCSWOX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 18:14:23 -0400
Received: by vps892.directvps.nl (Postfix, from userid 182)
	id D5F991DCF6D; Thu, 19 Mar 2015 23:14:22 +0100 (CET)
Received: from ikke-laptop.ikke (unknown [10.8.0.6])
	by vps892.directvps.nl (Postfix) with ESMTP id 5E7C74400AE;
	Thu, 19 Mar 2015 23:14:19 +0100 (CET)
X-Mailer: git-send-email 2.3.2
In-Reply-To: <1425934575-19581-1-git-send-email-me@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265847>

rev-list --bisect is used by git bisect, but never together with
--first-parent. Because rev-list --bisect together with --first-parent
is not handled currently, and even leads to segfaults, refuse to use
both options together.

Because this is not supported, it makes little sense to use git log
--bisect --first parent either, because refs/heads/bad is not limited to
the first parent chain.

Helped-by: Junio C. Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Kevin Daudt <me@ikke.info>
---
Updates since v4:

* Not only refusing rev-list --bisect --first-parent, but also log --bisect --first-parent

 Documentation/rev-list-options.txt | 7 ++++---
 revision.c                         | 3 +++
 t/t6000-rev-list-misc.sh           | 4 ++++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 4ed8587..e2de789 100644
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
@@ -185,7 +186,7 @@ ifndef::git-rev-list[]
 	Pretend as if the bad bisection ref `refs/bisect/bad`
 	was listed and as if it was followed by `--not` and the good
 	bisection refs `refs/bisect/good-*` on the command
-	line.
+	line. Cannot be combined with --first-parent.
 endif::git-rev-list[]
 
 --stdin::
@@ -566,7 +567,7 @@ outputs 'midpoint', the output of the two commands
 would be of roughly the same length.  Finding the change which
 introduces a regression is thus reduced to a binary search: repeatedly
 generate and test new 'midpoint's until the commit chain is of length
-one.
+one. Cannot be combined with --first-parent.
 
 --bisect-vars::
 	This calculates the same as `--bisect`, except that refs in
diff --git a/revision.c b/revision.c
index 66520c6..ed3f6e9 100644
--- a/revision.c
+++ b/revision.c
@@ -2342,6 +2342,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
 		die("cannot use --grep-reflog without --walk-reflogs");
 
+	if (revs->first_parent_only && revs->bisect)
+		die(_("--first-parent is incompatible with --bisect"));
+
 	return left;
 }
 
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
2.3.2
