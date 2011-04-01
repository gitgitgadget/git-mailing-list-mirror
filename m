From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] git diff -D: omit the preimage of deletes
Date: Fri,  1 Apr 2011 15:31:38 +0200
Message-ID: <b6975fdc80a338e47c1426e8bf8450b68130b84a.1301664623.git.git@drmicha.warpmail.net>
References: <7v62qzhqp4.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 15:35:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5eVT-0002hT-7E
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 15:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755596Ab1DANfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 09:35:11 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:50717 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755444Ab1DANfK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Apr 2011 09:35:10 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7A3F920A8D;
	Fri,  1 Apr 2011 09:35:09 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Fri, 01 Apr 2011 09:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=4gPm0LuCmaK/2ggW5MeLWu6xcrE=; b=Gko7AQNnCNpPFYmb37+44oSaPauKQYDsRNmK73ZWmKRPs+85sPwQXKSte9jyuOwtnZ0waZXP9X8dvXU2tiPqr6Gda9UJFuSBxWFE6pxd1FHDVPoFlj3W9pwsqMzyg36tTMZ8zZsvWFDXOTMQN/ddTmWyLV2w1sU4D7LubK5ThvE=
X-Sasl-enc: r5kRkOY5/oVZY7+HQrAxvyRFcs0BBsXgvJXR9O2ic46y 1301664908
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C4B6840AE23;
	Fri,  1 Apr 2011 09:35:08 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.2.668.gba03a4
In-Reply-To: <7v62qzhqp4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170581>

Introduce the -D/--irreversible-delete option which omits the diff for
total deletes. It is similar to -M,-C in its output but irreversible in
the sense that the resulting patch can not be reversed (-R).

When used in connection with -B, omit the diff of the deletion part of a
complete rewrite.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/diff-options.txt |   10 +++++++++
 diff.c                         |   14 +++++++++---
 diff.h                         |    1 +
 t/t4022-diff-rewrite.sh        |   43 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index c93124b..4760d7a 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -259,6 +259,16 @@ endif::git-log[]
 	projects, so use it with caution.  Giving more than one
 	`-C` option has the same effect.
 
+-D::
+--irreversible-delete::
+	Omit the preimage for deletes, i.e. print only the header but not
+	the diff between the preimage and `/dev/null`. The resulting patch
+	is irreversible in the sense that it can not be applied in reverse
+	(-R).
++
+When used together with `-B`, omit also the preimage in the deletion part
+of a delete/create pair.
+
 -l<num>::
 	The `-M` and `-C` options require O(n^2) processing time where n
 	is the number of potential rename/copy targets.  This
diff --git a/diff.c b/diff.c
index 5422c43..9ea1de1 100644
--- a/diff.c
+++ b/diff.c
@@ -1943,7 +1943,11 @@ static void builtin_diff(const char *name_a,
 		}
 	}
 
-	if (!DIFF_OPT_TST(o, TEXT) &&
+	if (o->irreversible_delete && lbl[1][0] == '/') {
+		fprintf(o->file, "%s", header.buf);
+		strbuf_reset(&header);
+		goto free_ab_and_return;
+	} else if (!DIFF_OPT_TST(o, TEXT) &&
 	    ( (!textconv_one && diff_filespec_is_binary(one)) ||
 	      (!textconv_two && diff_filespec_is_binary(two)) )) {
 		if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
@@ -1963,8 +1967,7 @@ static void builtin_diff(const char *name_a,
 			fprintf(o->file, "%sBinary files %s and %s differ\n",
 				line_prefix, lbl[0], lbl[1]);
 		o->found_changes = 1;
-	}
-	else {
+	} else {
 		/* Crazy xdl interfaces.. */
 		const char *diffopts = getenv("GIT_DIFF_OPTS");
 		xpparam_t xpp;
@@ -3160,6 +3163,9 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 			return error("invalid argument to -M: %s", arg+2);
 		options->detect_rename = DIFF_DETECT_RENAME;
 	}
+	else if (!strcmp(arg, "-D") || !strcmp(arg, "--irreversible-delete")) {
+		options->irreversible_delete = 1;
+	}
 	else if (!prefixcmp(arg, "-C") || !prefixcmp(arg, "--find-copies=") ||
 		 !strcmp(arg, "--find-copies")) {
 		if (options->detect_rename == DIFF_DETECT_COPY)
@@ -4205,7 +4211,7 @@ void diffcore_std(struct diff_options *options)
 			diffcore_break(options->break_opt);
 		if (options->detect_rename)
 			diffcore_rename(options);
-		if (options->break_opt != -1)
+		if (options->break_opt != -1 && !options->irreversible_delete)
 			diffcore_merge_broken();
 	}
 	if (options->pickaxe)
diff --git a/diff.h b/diff.h
index 310bd6b..11d13cf 100644
--- a/diff.h
+++ b/diff.h
@@ -104,6 +104,7 @@ struct diff_options {
 	int interhunkcontext;
 	int break_opt;
 	int detect_rename;
+	int irreversible_delete;
 	int skip_stat_unmatch;
 	int line_termination;
 	int output_format;
diff --git a/t/t4022-diff-rewrite.sh b/t/t4022-diff-rewrite.sh
index 2a537a2..c00a94b 100755
--- a/t/t4022-diff-rewrite.sh
+++ b/t/t4022-diff-rewrite.sh
@@ -11,7 +11,9 @@ test_expect_success setup '
 	tr \
 	  "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" \
 	  "nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM" \
-	  <"$TEST_DIRECTORY"/../COPYING >test
+	  <"$TEST_DIRECTORY"/../COPYING >test &&
+	echo "to be deleted" >test2 &&
+	git add test2
 
 '
 
@@ -25,5 +27,44 @@ test_expect_success 'detect rewrite' '
 
 '
 
+cat >expect <<EOF
+diff --git a/test2 b/test2
+deleted file mode 100644
+index 4202011..0000000
+--- a/test2
++++ /dev/null
+@@ -1 +0,0 @@
+-to be deleted
+EOF
+test_expect_success 'show deletion diff without -D' '
+
+	rm test2 &&
+	git diff -- test2 >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<EOF
+diff --git a/test2 b/test2
+deleted file mode 100644
+index 4202011..0000000
+EOF
+test_expect_success 'suppress deletion diff with -D' '
+
+	git diff -D -- test2 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'show deletion diff with -B' '
+
+	git diff -B -- test >actual &&
+	grep "Linus Torvalds" actual
+'
+
+test_expect_success 'suppress deletion diff with -B -D' '
+
+	git diff -B -D -- test >actual &&
+	grep -v "Linus Torvalds" actual
+'
+
 test_done
 
-- 
1.7.4.2.668.gba03a4
