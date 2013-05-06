From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] merge-tree: handle directory/empty conflict correctly
Date: Mon, 6 May 2013 16:20:54 +0100
Message-ID: <20130506152054.GE25912@serenity.lan>
References: <CADEJa-5prhhY-fUHgkk91M8HKWRG3enODS_h7Mq0dgo7V9sYsQ@mail.gmail.com>
 <20130506133937.GB25912@serenity.lan>
 <CADEJa-5-UpkUaNQ=QResY54cH4TvXqiUSeG-jewH+n+HsZqmHA@mail.gmail.com>
 <20130506142923.GC25912@serenity.lan>
 <20130506144958.GD25912@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Andreas Jacobsen <andreas@andreasjacobsen.com>
X-From: git-owner@vger.kernel.org Mon May 06 17:21:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZNE0-0005VZ-I3
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 17:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754293Ab3EFPVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 11:21:07 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:53217 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001Ab3EFPVG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 11:21:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id C0F5223247;
	Mon,  6 May 2013 16:21:04 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7x-VwXWvaGjB; Mon,  6 May 2013 16:21:01 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 17D9A22F51;
	Mon,  6 May 2013 16:20:56 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130506144958.GD25912@serenity.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223460>

git-merge-tree causes a null pointer dereference when a directory
entry exists in only one or two of the three trees being compared with
no corresponding entry in the other tree(s).

When this happens, we want to handle the entry as a directory and not
attempt to mark it as a file merge.  Do this by setting the entries bit
in the directory mask when the entry is missing or when it is a
directory, only performing the file comparison when we know that a file
entry exists.

Reported-by: Andreas Jacobsen <andreas@andreasjacobsen.com>
Signed-off-by: John Keeping <john@keeping.me.uk>
---
Andreas, can you try this patch and see if it fixes your test case?

 builtin/merge-tree.c  |  6 +++++-
 t/t4300-merge-tree.sh | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index ec49917..61cbde4 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -251,7 +251,11 @@ static void unresolved(const struct traverse_info *info, struct name_entry n[3])
 
 	for (i = 0; i < 3; i++) {
 		mask |= (1 << i);
-		if (n[i].mode && S_ISDIR(n[i].mode))
+		/*
+		 * Treat missing entries as directories so that we return
+		 * after unresolved_directory has handled this.
+		 */
+		if (!n[i].mode || S_ISDIR(n[i].mode))
 			dirmask |= (1 << i);
 	}
 
diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
index 2defb42..9015e47 100755
--- a/t/t4300-merge-tree.sh
+++ b/t/t4300-merge-tree.sh
@@ -259,6 +259,57 @@ EXPECTED
 	test_cmp expected actual
 '
 
+test_expect_success 'tree add A, B (same)' '
+	cat >expect <<-\EOF &&
+	EOF
+	git reset --hard initial &&
+	mkdir sub &&
+	test_commit "add sub/file" "sub/file" "file" add-tree-A &&
+	git merge-tree initial add-tree-A add-tree-A >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'tree add A, B (different)' '
+	cat >expect <<-\EOF &&
+	added in both
+	  our    100644 43d5a8ed6ef6c00ff775008633f95787d088285d sub/file
+	  their  100644 ba629238ca89489f2b350e196ca445e09d8bb834 sub/file
+	@@ -1 +1,5 @@
+	+<<<<<<< .our
+	 AAA
+	+=======
+	+BBB
+	+>>>>>>> .their
+	EOF
+	git reset --hard initial &&
+	mkdir sub &&
+	test_commit "add sub/file" "sub/file" "AAA" add-tree-a-b-A &&
+	git reset --hard initial &&
+	mkdir sub &&
+	test_commit "add sub/file" "sub/file" "BBB" add-tree-a-b-B &&
+	git merge-tree initial add-tree-a-b-A add-tree-a-b-B >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'tree unchanged A, removed B' '
+	cat >expect <<-\EOF &&
+	removed in remote
+	  base   100644 43d5a8ed6ef6c00ff775008633f95787d088285d sub/file
+	  our    100644 43d5a8ed6ef6c00ff775008633f95787d088285d sub/file
+	@@ -1 +0,0 @@
+	-AAA
+	EOF
+	git reset --hard initial &&
+	mkdir sub &&
+	test_commit "add sub/file" "sub/file" "AAA" tree-remove-b-initial &&
+	git rm sub/file &&
+	test_tick &&
+	git commit -m "remove sub/file" &&
+	git tag tree-remove-b-B &&
+	git merge-tree tree-remove-b-initial tree-remove-b-initial tree-remove-b-B >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'turn file to tree' '
 	git reset --hard initial &&
 	rm initial-file &&
-- 
1.8.3.rc0.149.g98a72f2.dirty
