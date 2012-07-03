From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 22/25] commit-tree: the command wants a tree and commits
Date: Tue,  3 Jul 2012 14:37:12 -0700
Message-ID: <1341351435-31011-23-git-send-email-gitster@pobox.com>
References: <1341351435-31011-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 23:38:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmAns-0005gY-2e
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 23:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932986Ab2GCVi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 17:38:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35277 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756580Ab2GCViB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 17:38:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EE78869D
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:38:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=7KEP
	CDAQUchEWceIGQeFKCXEQzo=; b=HC+P2uK75JzdrJqBxIO8D5YQYYkbu7kxx3h2
	FuP9qUfCeu/N30eFr4mDcQACjUbluZOFBLw/a+RNekChctGS5eE/KVlIubF7/Gph
	5CrTLE858VmKg9lIOri3K9neASONoyyCNQVTjr6uhM5NGnL9ZBgRthE78ZYcEAME
	HBqQ0Yo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=NNAyN1
	wFkHcVknuaoDwcro6n+g543XJC/XtE6zqEub1L7d1+MfJqolFg9DVFtJGaJ+fDaV
	qDLb6okfYtAiYsa2uKfrO1CFKsJFxcYYcHKylerLRwTGjM+72N7r/fJra++MgE1f
	S/l9re636brbFFxCQQKJTG/50G8GVSerQTKr4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84BD6869B
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:38:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 149F78699 for
 <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:59 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.229.g706c98f
In-Reply-To: <1341351435-31011-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5C6774A4-C557-11E1-A37F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200955>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit-tree.c               | 8 ++++----
 t/t1512-rev-parse-disambiguation.sh | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 164b655..cb982c5 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -48,8 +48,8 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	if (argc < 2 || !strcmp(argv[1], "-h"))
 		usage(commit_tree_usage);
 
-	if (get_sha1(argv[1], tree_sha1))
-		die("Not a valid object name %s", argv[1]);
+	if (get_sha1_tree(argv[1], tree_sha1))
+		die("Not a valid tree object name %s", argv[1]);
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
@@ -57,7 +57,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 			unsigned char sha1[20];
 			if (argc <= ++i)
 				usage(commit_tree_usage);
-			if (get_sha1(argv[i], sha1))
+			if (get_sha1_commit(argv[i], sha1))
 				die("Not a valid object name %s", argv[i]);
 			assert_sha1_type(sha1, OBJ_COMMIT);
 			new_parent(lookup_commit(sha1), &parents);
@@ -104,7 +104,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (get_sha1(arg, tree_sha1))
+		if (get_sha1_tree(arg, tree_sha1))
 			die("Not a valid object name %s", arg);
 		if (got_tree)
 			die("Cannot give more than one trees");
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 87270c9..dd42729 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -74,7 +74,7 @@ test_expect_success 'disambiguate blob' '
 	test_cmp bz01t33 actual
 '
 
-test_expect_failure 'disambiguate tree' '
+test_expect_success 'disambiguate tree' '
 	commit=$(echo "frotz" | git commit-tree 11021982) &&
 	test $(git rev-parse $commit^{tree}) = $(git rev-parse 1102198206)
 '
@@ -97,7 +97,7 @@ test_expect_success 'disambiguate commit-ish' '
 	git rev-parse --verify 11021982^0
 '
 
-test_expect_failure 'disambiguate commit' '
+test_expect_success 'disambiguate commit' '
 	commit=$(echo "frotz" | git commit-tree 11021982 -p 11021982) &&
 	test $(git rev-parse $commit^) = $(git rev-parse 1102198268)
 '
-- 
1.7.11.1.229.g706c98f
