From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH 3/3] merge-recursive: -Xindex-only to leave worktree unchanged
Date: Sat, 26 Oct 2013 16:43:18 +0200
Message-ID: <1df84557649b143c4ad11a8ad39000ef253c5e8a.1382798450.git.tr@thomasrast.ch>
References: <87ob6cm6y1.fsf@linux-k42r.v.cablecom.net>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 26 16:43:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Va55g-00052e-Bd
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 16:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695Ab3JZOnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Oct 2013 10:43:42 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:50879 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751355Ab3JZOnl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Oct 2013 10:43:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id E812C4D659B;
	Sat, 26 Oct 2013 16:43:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id KiNUs6com7Dm; Sat, 26 Oct 2013 16:43:38 +0200 (CEST)
Received: from linux-k42r.v.cablecom.net (unknown [213.55.184.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id ED5794D658B;
	Sat, 26 Oct 2013 16:43:37 +0200 (CEST)
X-Mailer: git-send-email 1.8.4.1.841.gb1dcd95
In-Reply-To: <87ob6cm6y1.fsf@linux-k42r.v.cablecom.net>
In-Reply-To: <262a408fc2f55df92eb2754eb1475c1af6fec19e.1382798450.git.tr@thomasrast.ch>
References: <262a408fc2f55df92eb2754eb1475c1af6fec19e.1382798450.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236754>

From: Thomas Rast <trast@inf.ethz.ch>

Using the new no_worktree flag from the previous commit, we can teach
merge-recursive to leave the worktree untouched.  Expose this with a
new strategy option so that scripts can use it.
---

Unchanged.

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
index 922a259..addfb72 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2096,6 +2096,8 @@ int parse_merge_opt(struct merge_options *o, const char *s)
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
1.8.4.1.841.gb1dcd95
