Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A67D31F4F8
	for <e@80x24.org>; Sun, 25 Sep 2016 19:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758812AbcIYTQq (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 15:16:46 -0400
Received: from userp1040.oracle.com ([156.151.31.81]:16616 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756330AbcIYTQp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 15:16:45 -0400
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u8PJDnVg023199
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Sep 2016 19:13:50 GMT
Received: from lenuta.oracle.com (dhcp-ukc1-twvpn-2-vpnpool-10-175-214-67.vpn.oracle.com [10.175.214.67])
        by userv0022.oracle.com (8.14.4/8.13.8) with ESMTP id u8PJDjnm004565;
        Sun, 25 Sep 2016 19:13:46 GMT
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>,
        Kevin Bracey <kevin@bracey.fi>,
        Philip Oakley <philipoakley@iee.org>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [RFC PATCH v3] revision: new rev^-n shorthand for rev^n..rev
Date:   Sun, 25 Sep 2016 21:13:12 +0200
Message-Id: <20160925191312.28760-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.10.0.rc0.1.g07c9292
X-Source-IP: userv0022.oracle.com [156.151.31.74]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I often use rev^..rev to get all the commits in the branch that was merged
in by the merge commit 'rev' (including the merge itself). To save typing
(or copy-pasting, if the rev is long -- like a full SHA-1 or branch name)
we can make rev^- a shorthand for that.

The existing syntax rev^! seems like it should do the same thing, but it
doesn't really do the right thing for merge commits (it doesn't include
the commits from side branches).

As a natural generalisation, we also accept rev^-n where n excludes the
nth parent of rev. For example, for a two-parent merge, you can use rev^-2
to get the set of commits which were made to the main branch while the
topic branch was prepared.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>

---

[v2: Use ^- instead of % as suggested by Junio Hamano and use some
 common helper functions for parsing.]

[v3: Use 'struct object_id' instead of 'char[20]' and add some tests as
 suggested by Matthieu Moy; fix missing '-' in Documentation/revisions.txt
 as suggested by Ramsay Jones; misc changelog + documentation fixes as
 suggested by Philip Oakley.]

Thanks for the helpful comments so far! I tried to take everything into
account. It's my first git.git patch so I'm not too familiar with how the
tests are set up. Should I add more tests than this?

---
 Documentation/revisions.txt     | 15 +++++++
 builtin/rev-parse.c             | 28 +++++++++++++
 revision.c                      | 91 +++++++++++++++++++++++++++++++++++++++++
 revision.h                      |  1 +
 t/t6070-rev-parent-exclusion.sh | 38 +++++++++++++++++
 5 files changed, 173 insertions(+)
 create mode 100755 t/t6070-rev-parent-exclusion.sh

diff --git Documentation/revisions.txt Documentation/revisions.txt
index 4bed5b1..8a27964 100644
--- Documentation/revisions.txt
+++ Documentation/revisions.txt
@@ -281,6 +281,15 @@ is a shorthand for 'HEAD..origin' and asks "What did the origin do since
 I forked from them?"  Note that '..' would mean 'HEAD..HEAD' which is an
 empty range that is both reachable and unreachable from HEAD.
 
+Parent Exclusion Notation
+~~~~~~~~~~~~~~~~~~~~~~~~~
+The '<rev>{caret}-{<n>}', Parent Exclusion Notation::
+Shorthand for '<rev>{caret}<n>..<rev>', with '<n>' = 1 if not
+given. This is typically useful for merge commits where you
+can just pass '<commit>{caret}-' to get all the commits in the branch
+that was merged in merge commit '<commit>' (including '<commit>'
+itself).
+
 Other <rev>{caret} Parent Shorthand Notations
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Two other shorthands exist, particularly useful for merge commits,
@@ -316,6 +325,10 @@ Revision Range Summary
 	<rev2> but exclude those that are reachable from both.  When
 	either <rev1> or <rev2> is omitted, it defaults to `HEAD`.
 
+'<rev>{caret}-{<n>}', e.g. 'HEAD{caret}-, HEAD{caret}-2'::
+	Equivalent to '<rev>{caret}<n>..<rev>', with '<n>' = 1 if not
+	given.
+
 '<rev>{caret}@', e.g. 'HEAD{caret}@'::
   A suffix '{caret}' followed by an at sign is the same as listing
   all parents of '<rev>' (meaning, include anything reachable from
@@ -339,6 +352,8 @@ spelt out:
    C                            I J F C
    B..C   = ^B C                C
    B...C  = B ^F C              G H D E B C
+   B^-    = B^..B
+	  = B ^B^1              E I J F B
    C^@    = C^1
 	  = F                   I J F
    B^@    = B^1 B^2 B^3
diff --git builtin/rev-parse.c builtin/rev-parse.c
index 76cf05e..2c573f1 100644
--- builtin/rev-parse.c
+++ builtin/rev-parse.c
@@ -292,6 +292,32 @@ static int try_difference(const char *arg)
 	return 0;
 }
 
+static int try_parent_exclusion(const char *arg)
+{
+	int ret = 0;
+	char *to_rev = NULL;
+	char *from_rev = NULL;
+	struct object_id to_oid;
+	struct object_id from_oid;
+
+	if (parse_parent_exclusion(arg, &to_rev, &from_rev))
+		goto out;
+	if (get_oid(to_rev, &to_oid))
+		goto out;
+	if (get_oid(from_rev, &from_oid))
+		goto out;
+
+	show_rev(NORMAL, to_oid.hash, to_rev);
+	show_rev(REVERSED, from_oid.hash, from_rev);
+
+	ret = 1;
+
+out:
+	free(to_rev);
+	free(from_rev);
+	return ret;
+}
+
 static int try_parent_shorthands(const char *arg)
 {
 	char *dotdot;
@@ -839,6 +865,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		/* Not a flag argument */
 		if (try_difference(arg))
 			continue;
+		if (try_parent_exclusion(arg))
+			continue;
 		if (try_parent_shorthands(arg))
 			continue;
 		name = arg;
diff --git revision.c revision.c
index 969b3d1..602bf88 100644
--- revision.c
+++ revision.c
@@ -1419,6 +1419,93 @@ static void prepare_show_merge(struct rev_info *revs)
 	revs->limited = 1;
 }
 
+/*
+ * If 'arg' is on the form '<rev>^-{<n>}', then return 0 and
+ * '*to_rev' and '*from_rev' will contain '<rev>' and '<rev>^<n>',
+ * respectively.
+ */
+int parse_parent_exclusion(const char *arg, char **to_rev, char **from_rev)
+{
+	char *caret;
+	unsigned int n = 1;
+
+	/*
+	 * <rev>^-{<n>} is shorthand for <rev>^<n>..<rev>, with <n> = 1 if
+	 * not given. This is typically used for merge commits where you
+	 * can just pass '<merge>^-' and it will show you all the commits in
+	 * the branch that was merged.
+	 */
+
+	if (!(caret = strstr(arg, "^-")))
+		return 1;
+	if (caret[2]) {
+		char *end;
+		n = strtoul(&caret[2], &end, 10);
+		if (*end != '\0')
+			return 1;
+	}
+	*to_rev = xstrndup(arg, caret - arg);
+	*from_rev = xstrfmt("%s^%u", *to_rev, n);
+	return 0;
+}
+
+static int handle_parent_exclusion(const char *arg, struct rev_info *revs, int flags)
+{
+	int ret = 1;
+	char *to_rev = NULL;
+	char *from_rev = NULL;
+	struct object_id to_oid;
+	struct object_id from_oid;
+
+	struct object *a_obj, *b_obj;
+	unsigned int flags_exclude = flags ^ (UNINTERESTING | BOTTOM);
+	unsigned int a_flags;
+
+	/*
+	 * <rev>^-{<n>} is shorthand for <rev>^<n>..<rev>, with <n> = 1 if
+	 * not given. This is typically used for merge commits where you
+	 * can just pass <merge>^- and it will show you all the commits in
+	 * the branches that were merged.
+	 */
+
+	if (parse_parent_exclusion(arg, &to_rev, &from_rev))
+		goto out;
+
+	if (get_oid(to_rev, &to_oid)) {
+		if (revs->ignore_missing)
+			goto out;
+		die("Unknown revision %s", to_rev);
+	}
+
+	if (get_oid(from_rev, &from_oid)) {
+		if (revs->ignore_missing)
+			goto out;
+		die("Unknown revision %s", from_rev);
+	}
+
+	a_obj = parse_object(from_oid.hash);
+	b_obj = parse_object(to_oid.hash);
+	if (!a_obj || !b_obj) {
+		if (revs->ignore_missing)
+			goto out;
+		die("Invalid revision range %s", arg);
+	}
+
+	a_flags = flags_exclude;
+	a_obj->flags |= a_flags;
+	b_obj->flags |= flags;
+	add_rev_cmdline(revs, a_obj, from_rev, REV_CMD_LEFT, a_flags);
+	add_pending_object(revs, a_obj, from_rev);
+	add_rev_cmdline(revs, b_obj, to_rev, REV_CMD_RIGHT, flags);
+	add_pending_object(revs, b_obj, to_rev);
+
+	ret = 0;
+out:
+	free(to_rev);
+	free(from_rev);
+	return ret;
+}
+
 int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsigned revarg_opt)
 {
 	struct object_context oc;
@@ -1519,6 +1606,10 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 		}
 		*dotdot = '.';
 	}
+
+	if (!handle_parent_exclusion(arg, revs, flags))
+		return 0;
+
 	dotdot = strstr(arg, "^@");
 	if (dotdot && !dotdot[2]) {
 		*dotdot = 0;
diff --git revision.h revision.h
index 9fac1a6..ca5bebc 100644
--- revision.h
+++ revision.h
@@ -243,6 +243,7 @@ extern int setup_revisions(int argc, const char **argv, struct rev_info *revs,
 extern void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 			       const struct option *options,
 			       const char * const usagestr[]);
+extern int parse_parent_exclusion(const char *arg, char **to_rev, char **from_rev);
 #define REVARG_CANNOT_BE_FILENAME 01
 #define REVARG_COMMITTISH 02
 extern int handle_revision_arg(const char *arg, struct rev_info *revs,
diff --git t/t6070-rev-parent-exclusion.sh t/t6070-rev-parent-exclusion.sh
new file mode 100755
index 0000000..e02da47
--- /dev/null
+++ t/t6070-rev-parent-exclusion.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+
+test_description='rev-list/rev-parse rev^- parsing'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_commit one &&
+	test_commit two &&
+	test_commit three &&
+
+	# Merge in a branch for testing ^-
+	git checkout -b branch &&
+	git checkout HEAD^^ &&
+	git merge -m merge --no-edit --no-ff branch &&
+	git checkout -b merge
+'
+
+# The merged branch has 2 commits + the merge
+test_expect_success 'rev-list --count merge^- = merge^..merge' '
+	git rev-list --count merge^..merge >expect &&
+	echo 3 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rev-parse merge^- = merge^..merge' '
+	git rev-parse merge^..merge >expect &&
+	git rev-parse merge^- >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rev-list merge^- = merge^..merge' '
+	git rev-list merge^..merge >expect &&
+	git rev-list merge^- >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.10.0.rc0.1.g07c9292

