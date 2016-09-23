Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7FFF1F935
	for <e@80x24.org>; Fri, 23 Sep 2016 10:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965843AbcIWKz7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 06:55:59 -0400
Received: from userp1040.oracle.com ([156.151.31.81]:22079 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934960AbcIWKz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 06:55:56 -0400
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u8NArDJx028646
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Sep 2016 10:53:14 GMT
Received: from lenuta.oracle.com (dhcp-ukc1-twvpn-1-vpnpool-10-175-171-194.vpn.oracle.com [10.175.171.194])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id u8NArBAB013547;
        Fri, 23 Sep 2016 10:53:11 GMT
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>,
        Kevin Bracey <kevin@bracey.fi>,
        Philip Oakley <philipoakley@iee.org>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [RFC PATCH] revision: new rev%n shorthand for rev^n..rev
Date:   Fri, 23 Sep 2016 12:52:54 +0200
Message-Id: <20160923105254.10235-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.10.0.rc0.1.g07c9292
X-Source-IP: aserv0022.oracle.com [141.146.126.234]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I use rev^..rev daily, and I'm surely not the only one. To save typing
(or copy-pasting, if the rev is long -- like a full SHA-1 or branch name)
we can make rev% a shorthand for that.

The existing syntax rev^! seems like it should do the same, but it
doesn't really do the right thing for merge commits (it gives only the
merge itself).

As a natural generalisation, we also accept rev%n where n excludes the
nth parent of rev. It _may_ be more useful to define rev%n for an m-way
merge as:

 rev
 ^rev^1
 ^rev^[... except n]
 ^rev^m

so that you can see only the commits that arrived via the nth parent,
but this might be questionable/unintuitive in case any of the parents
that share commits (as you would get fewer commits than expected).

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/revisions.txt | 14 +++++++++++++
 builtin/rev-parse.c         | 38 ++++++++++++++++++++++++++++++++++
 revision.c                  | 50 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+)

diff --git Documentation/revisions.txt Documentation/revisions.txt
index 4bed5b1..ab2dc2c 100644
--- Documentation/revisions.txt
+++ Documentation/revisions.txt
@@ -281,6 +281,14 @@ is a shorthand for 'HEAD..origin' and asks "What did the origin do since
 I forked from them?"  Note that '..' would mean 'HEAD..HEAD' which is an
 empty range that is both reachable and unreachable from HEAD.
 
+Parent Exclusion Notation
+~~~~~~~~~~~~~~~~~~~~~~~~~
+The '<rev>%{<n>}', Parent Exclusion Notation::
+Shorthand for '<rev>{caret}<n>..<rev>', with '<n>' = 1 if not
+given. This is typically useful for merge commits where you
+can just pass '<commit>%' to get all the commits in the branch
+that was merged in merge commit '<commit>'.
+
 Other <rev>{caret} Parent Shorthand Notations
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Two other shorthands exist, particularly useful for merge commits,
@@ -316,6 +324,10 @@ Revision Range Summary
 	<rev2> but exclude those that are reachable from both.  When
 	either <rev1> or <rev2> is omitted, it defaults to `HEAD`.
 
+'<rev>%{<n>}', e.g. 'HEAD%, HEAD%2'::
+	Equivalent to '<rev>{caret}<n>..<rev>', with '<n>' = 1 if not
+	given.
+
 '<rev>{caret}@', e.g. 'HEAD{caret}@'::
   A suffix '{caret}' followed by an at sign is the same as listing
   all parents of '<rev>' (meaning, include anything reachable from
@@ -339,6 +351,8 @@ spelt out:
    C                            I J F C
    B..C   = ^B C                C
    B...C  = B ^F C              G H D E B C
+   B%     = B^..B
+	  = B ^B^1              E I J F B
    C^@    = C^1
 	  = F                   I J F
    B^@    = B^1 B^2 B^3
diff --git builtin/rev-parse.c builtin/rev-parse.c
index 76cf05e..f081b81 100644
--- builtin/rev-parse.c
+++ builtin/rev-parse.c
@@ -292,6 +292,42 @@ static int try_difference(const char *arg)
 	return 0;
 }
 
+static int try_branch(const char *arg)
+{
+	char *percent;
+	unsigned char sha1[20];
+	unsigned char end[20];
+
+	/*
+	 * <rev>%{<n>} is shorthand for <rev>^<n>..<rev>, with <n> = 1 if
+	 * not given. This is typically used for merge commits where you
+	 * can just pass <merge>% and it will show you all the commits in
+	 * the branch that was merged (for octopus merges, <n> is the nth
+	 * branch).
+	 */
+
+	if (!(percent = strstr(arg, "%")))
+		return 0;
+
+	*percent = '^';
+	if (!get_sha1_committish(arg, sha1)) {
+		*percent = '%';
+		return 0;
+	}
+
+	*percent = '\0';
+	if (!get_sha1_committish(arg, end)) {
+		*percent = '%';
+		return 0;
+	}
+
+	show_rev(NORMAL, end, arg);
+	*percent = '^';
+	show_rev(REVERSED, sha1, arg);
+	*percent = '%';
+	return 1;
+}
+
 static int try_parent_shorthands(const char *arg)
 {
 	char *dotdot;
@@ -839,6 +875,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		/* Not a flag argument */
 		if (try_difference(arg))
 			continue;
+		if (try_branch(arg))
+			continue;
 		if (try_parent_shorthands(arg))
 			continue;
 		name = arg;
diff --git revision.c revision.c
index 969b3d1..e20b618 100644
--- revision.c
+++ revision.c
@@ -1519,6 +1519,56 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 		}
 		*dotdot = '.';
 	}
+
+	/*
+	 * <rev>%{<n>} is shorthand for <rev>^<n>..<rev>, with <n> = 1 if
+	 * not given. This is typically used for merge commits where you
+	 * can just pass <merge>% and it will show you all the commits in
+	 * the branch that was merged (for octopus merges, <n> is the nth
+	 * branch).
+	 */
+	dotdot = strstr(arg, "%");
+	if (dotdot) {
+		unsigned char sha1[20];
+		unsigned char end[20];
+		struct object *a_obj, *b_obj;
+		unsigned int flags_exclude = flags ^ (UNINTERESTING | BOTTOM);
+		unsigned int a_flags;
+
+		*dotdot = '\0';
+		if (get_sha1_committish(arg, end)) {
+			if (revs->ignore_missing)
+				return 0;
+			die("Unknown revision %s", arg);
+		}
+
+		*dotdot = '^';
+		if (get_sha1_committish(arg, sha1)) {
+			if (revs->ignore_missing)
+				return 0;
+			die("Unknown revision %s", arg);
+		}
+
+		a_obj = parse_object(sha1);
+		b_obj = parse_object(end);
+		if (!a_obj || !b_obj) {
+			if (revs->ignore_missing)
+				return 0;
+			die("Invalid revision range %s", arg);
+		}
+
+		a_flags = flags_exclude;
+		a_obj->flags |= a_flags;
+		b_obj->flags |= flags;
+		*dotdot = '^';
+		add_rev_cmdline(revs, a_obj, arg, REV_CMD_LEFT, a_flags);
+		add_pending_object(revs, a_obj, arg);
+		*dotdot = '\0';
+		add_rev_cmdline(revs, b_obj, arg, REV_CMD_RIGHT, flags);
+		add_pending_object(revs, b_obj, arg);
+		*dotdot = '%';
+		return 0;
+	}
 	dotdot = strstr(arg, "^@");
 	if (dotdot && !dotdot[2]) {
 		*dotdot = 0;
-- 
2.10.0.rc0.1.g07c9292

