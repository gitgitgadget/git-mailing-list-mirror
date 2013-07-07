From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 3/3] merge-recursive: -Xindex-only to leave worktree unchanged
Date: Sun, 7 Jul 2013 20:02:40 +0200
Message-ID: <9733c853e2f674380c64e9b3a6f319414816ef28.1373219466.git.trast@inf.ethz.ch>
References: <cover.1373219466.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 07 20:03:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvtIe-0000Tt-62
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 20:03:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914Ab3GGSC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 14:02:56 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:25399 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752849Ab3GGSCu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 14:02:50 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 7 Jul
 2013 20:02:42 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 7 Jul
 2013 20:02:47 +0200
X-Mailer: git-send-email 1.8.3.2.908.gbd0dbd0
In-Reply-To: <cover.1373219466.git.trast@inf.ethz.ch>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229790>

Using the new no_worktree flag from the previous commit, we can teach
merge-recursive to leave the worktree untouched.  Expose this with a
new strategy option so that scripts can use it.
---
 Documentation/merge-strategies.txt |  4 ++++
 merge-recursive.c                  |  2 ++
 t/t3030-merge-recursive.sh         | 13 +++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 49a9a7d..b663a2e 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -92,6 +92,10 @@ subtree[=<path>];;
 	is prefixed (or stripped from the beginning) to make the shape of
 	two trees to match.
 
+index-only;;
+	Write the merge result only to the index; do not touch the
+	worktree.
+
 octopus::
 	This resolves cases with more than two heads, but refuses to do
 	a complex merge that needs manual resolution.  It is
diff --git a/merge-recursive.c b/merge-recursive.c
index b93b762..a58d691 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2094,6 +2094,8 @@ int parse_merge_opt(struct merge_options *o, const char *s)
 		if ((o->rename_score = parse_rename_score(&score)) == -1 || *score != 0)
 			return -1;
 	}
+	else if (!strcmp(s, "index-only"))
+		o->no_worktree = 1;
 	else
 		return -1;
 	return 0;
diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index 2f96100..2f3a16c 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -296,6 +296,19 @@ test_expect_success 'merge-recursive result' '
 
 '
 
+test_expect_success 'merge-recursive --index-only' '
+
+	rm -fr [abcd] &&
+	git checkout -f "$c2" &&
+	test_expect_code 1 git merge-recursive --index-only "$c0" -- "$c2" "$c1" &&
+	git ls-files -s >actual &&
+	# reuses "expected" from previous test!
+	test_cmp expected actual &&
+	git diff HEAD >actual-diff &&
+	: >expected-diff &&
+	test_cmp expected-diff actual-diff
+'
+
 test_expect_success 'fail if the index has unresolved entries' '
 
 	rm -fr [abcd] &&
-- 
1.8.3.2.908.gbd0dbd0
