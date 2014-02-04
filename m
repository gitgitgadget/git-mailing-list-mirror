From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH 3/9] merge-recursive: -Xindex-only to leave worktree unchanged
Date: Tue,  4 Feb 2014 23:17:32 +0100
Message-ID: <fb913c1851cd411866d3e689eba5c49a3298a25e.1391549294.git.tr@thomasrast.ch>
References: <cover.1391549294.git.tr@thomasrast.ch>
Cc: Thomas Rast <trast@inf.ethz.ch>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 23:18:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAoJh-0001oN-LY
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 23:18:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935756AbaBDWR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 17:17:59 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:54769 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935029AbaBDWRw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 17:17:52 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 3ADCB4D6594;
	Tue,  4 Feb 2014 23:17:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id kBTxPBESlIb5; Tue,  4 Feb 2014 23:17:41 +0100 (CET)
Received: from linux.local (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 358594D65A6;
	Tue,  4 Feb 2014 23:17:41 +0100 (CET)
X-Mailer: git-send-email 1.9.rc2.232.gdd31389
In-Reply-To: <cover.1391549294.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241566>

From: Thomas Rast <trast@inf.ethz.ch>

Using the new no_worktree flag from the previous commit, we can teach
merge-recursive to leave the worktree untouched.  Expose this with a
new strategy option so that scripts can use it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/merge-strategies.txt |  4 ++++
 merge-recursive.c                  |  2 ++
 t/t3030-merge-recursive.sh         | 13 +++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index fb6e593..2934e99 100644
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
index 35be144..f59c1d3 100644
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
1.9.rc2.232.gdd31389
