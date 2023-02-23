Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16298C61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 01:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjBWBWi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 20:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjBWBWg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 20:22:36 -0500
X-Greylist: delayed 376 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Feb 2023 17:22:33 PST
Received: from out-2.mta1.migadu.com (out-2.mta1.migadu.com [95.215.58.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B699B199CC
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 17:22:33 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
        t=1677114975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jrDRMIpk0OvQzWNNbZDXxhp0UohVvdoQF63zBdzFOpw=;
        b=Rmuq0BN7qSbMjzw0MlePsam3EFoeYsvGaD5pmqDY4Nc40spKztnT6MLK2IJA28ZuMHBXh2
        hh4Pz4n8oa+N8uHWHf8p11v2+q0t+ddP0g/J1Hh749D+2FWNportz5ZetMJKlAiWpBnzZ1
        +INZVoslQL54UW84/ccAJ8jjRzbs6jY=
From:   Ronan Pigott <ronan@rjp.ie>
To:     git@vger.kernel.org
Cc:     Ronan Pigott <ronan@rjp.ie>, ps@pks.im, gitster@pobox.com
Subject: [PATCH] update-ref: add forward command to safely fast-forward refs
Date:   Wed, 22 Feb 2023 18:15:30 -0700
Message-Id: <20230223011530.47477-1-ronan@rjp.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

forward is an update-ref command that behaves similarly to update, but
takes an additional argument, <ancestor>, and verifies that the new
value is a descendent of ancestor before updating. This is useful for
fast-forwarding prefetched refs.
---
I've found git fetch --prefetch to be useful in my workflow for
asynchronously updating git repos, but I'd really like a nice way to
update my remote tracking branches using the latest prefetched refs
without querying the remote in case the remote is temporarily
unavailable or I'm on a plane or something. I've settled on using

$ git for-each-ref refs/prefetch/ --format='update refs/%(refname:lstrip=2) %(refname)'

to prepare a transaction for git update-ref, but it has a defect: if I
have fetched the remote more recently than the last prefetch my remote
tracking branches will be sent into the past. "forward" is a convenience
feature for update-ref that will save the trouble of looping through
each ref and finding the merge base so it can be fast-forwarded.
 Documentation/git-update-ref.txt |  5 ++++
 builtin/update-ref.c             | 49 ++++++++++++++++++++++++++++++++
 t/t1400-update-ref.sh            | 29 +++++++++++++++++++
 3 files changed, 83 insertions(+)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 48b6683071e6..138a478b437f 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -66,6 +66,7 @@ performs all modifications together.  Specify commands of the form:
 	delete SP <ref> [SP <oldvalue>] LF
 	verify SP <ref> [SP <oldvalue>] LF
 	option SP <opt> LF
+	forward SP <ref> SP <newvalue> SP <ancestor> [SP <oldvalue>] LF
 	start LF
 	prepare LF
 	commit LF
@@ -105,6 +106,10 @@ update::
 	after the update and/or a zero <oldvalue> to make sure the
 	ref does not exist before the update.
 
+forward::
+	Set <ref> to <newvalue> after verifying <oldvalue> only if
+	<newvalue> is a descendent of <ancestor>.
+
 create::
 	Create <ref> with <newvalue> after verifying it does not
 	exist.  The given <newvalue> may not be zero.
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index a84e7b47a206..cdffa52b2d93 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "commit-reach.h"
 #include "refs.h"
 #include "builtin.h"
 #include "parse-options.h"
@@ -86,6 +87,11 @@ static char *parse_refname(const char **next)
  */
 #define PARSE_SHA1_ALLOW_EMPTY 0x02
 
+/*
+ * The value being parsed is <ancestor>, for forward updates.
+ */
+#define PARSE_SHA1_ANCESTOR 0x04
+
 /*
  * Parse an argument separator followed by the next argument, if any.
  * If there is an argument, convert it to a SHA-1, write it to sha1,
@@ -157,12 +163,16 @@ static int parse_next_oid(const char **next, const char *end,
  invalid:
 	die(flags & PARSE_SHA1_OLD ?
 	    "%s %s: invalid <oldvalue>: %s" :
+	    flags & PARSE_SHA1_ANCESTOR ?
+	    "%s %s: invalid <ancestor>: %s" :
 	    "%s %s: invalid <newvalue>: %s",
 	    command, refname, arg.buf);
 
  eof:
 	die(flags & PARSE_SHA1_OLD ?
 	    "%s %s: unexpected end of input when reading <oldvalue>" :
+	    flags & PARSE_SHA1_ANCESTOR ?
+	    "%s %s: unexpected end of input when reading <ancestor>" :
 	    "%s %s: unexpected end of input when reading <newvalue>",
 	    command, refname);
 }
@@ -211,6 +221,44 @@ static void parse_cmd_update(struct ref_transaction *transaction,
 	strbuf_release(&err);
 }
 
+static void parse_cmd_forward(struct ref_transaction *transaction,
+			     const char *next, const char *end)
+{
+	struct strbuf err = STRBUF_INIT;
+	char *refname;
+	struct object_id new_oid, anc_oid, old_oid;
+	int have_old;
+
+	refname = parse_refname(&next);
+	if (!refname)
+		die("forward: missing <ref>");
+
+	if (parse_next_oid(&next, end, &new_oid, "forward", refname, 0))
+		die("forward %s: missing <newvalue>", refname);
+
+	if (parse_next_oid(&next, end, &anc_oid, "forward", refname, PARSE_SHA1_ANCESTOR))
+		die("forward %s: missing <ancestor>", refname);
+
+	have_old = !parse_next_oid(&next, end, &old_oid, "forward", refname,
+				   PARSE_SHA1_OLD);
+
+	if (*next != line_termination)
+		die("forward %s: extra input: %s", refname, next);
+
+	if (!ref_newer(&new_oid, &anc_oid))
+		die("forward %s: not a fast-forward", refname);
+
+	if (ref_transaction_update(transaction, refname,
+				   &new_oid, have_old ? &old_oid : NULL,
+				   update_flags | create_reflog_flag,
+				   msg, &err))
+		die("%s", err.buf);
+
+	update_flags = default_flags;
+	free(refname);
+	strbuf_release(&err);
+}
+
 static void parse_cmd_create(struct ref_transaction *transaction,
 			     const char *next, const char *end)
 {
@@ -378,6 +426,7 @@ static const struct parse_cmd {
 	enum update_refs_state state;
 } command[] = {
 	{ "update",  parse_cmd_update,  3, UPDATE_REFS_OPEN },
+	{ "forward", parse_cmd_forward, 4, UPDATE_REFS_OPEN },
 	{ "create",  parse_cmd_create,  2, UPDATE_REFS_OPEN },
 	{ "delete",  parse_cmd_delete,  2, UPDATE_REFS_OPEN },
 	{ "verify",  parse_cmd_verify,  2, UPDATE_REFS_OPEN },
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index cf58cf025cd2..6ac90aca1917 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -785,6 +785,35 @@ test_expect_success 'stdin update ref works with right old value' '
 	test_cmp expect actual
 '
 
+test_expect_success 'stdin forward ref fails with wrong ancestor value' '
+	echo "forward $c $m~1 $m" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "forward $c: not a fast-forward" err &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin forward ref fails with bad ancestor value' '
+	echo "forward $c $m does-not-exist" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: forward $c: invalid <ancestor>: does-not-exist" err &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin forward ref fails with bad old value' '
+	echo "forward $c $m $m~1 does-not-exist" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: forward $c: invalid <oldvalue>: does-not-exist" err &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin forward ref works with right ancestor value' '
+	echo "forward $b $m~1 $m~2" >stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse $m~1 >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'stdin delete ref fails with wrong old value' '
 	echo "delete $a $m~1" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-- 
2.39.2

