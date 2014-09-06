From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH v3 3/8] merge-recursive: -Xindex-only to leave worktree unchanged
Date: Sat,  6 Sep 2014 19:57:01 +0200
Message-ID: <5d5715639af05dfd640d1a9827d10480e1313905.1409860234.git.tr@thomasrast.ch>
References: <cover.1409860234.git.tr@thomasrast.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 06 19:57:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQKEx-0005kv-9F
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 19:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287AbaIFR5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 13:57:31 -0400
Received: from ip1.thgersdorf.net ([148.251.9.194]:40799 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752059AbaIFR53 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2014 13:57:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 6FE904D66B6;
	Sat,  6 Sep 2014 19:57:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id NsxZVscmoix9; Sat,  6 Sep 2014 19:57:12 +0200 (CEST)
Received: from linux.local (unknown [65.50.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 494E54D6689;
	Sat,  6 Sep 2014 19:57:11 +0200 (CEST)
X-Mailer: git-send-email 2.1.0.72.g9b94086
In-Reply-To: <cover.1409860234.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256593>

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
index 7bbd19b..7716fda 100644
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
index 059ad03..d54bac2 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2108,6 +2108,8 @@ int parse_merge_opt(struct merge_options *o, const char *s)
 		if ((o->rename_score = parse_rename_score(&arg)) == -1 || *arg != 0)
 			return -1;
 	}
+	else if (!strcmp(s, "index-only"))
+		o->no_worktree = 1;
 	else
 		return -1;
 	return 0;
diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index 82e1854..be07705 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -297,6 +297,19 @@ test_expect_success 'merge-recursive result' '
 
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
2.1.0.72.g9b94086
