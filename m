Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D09C433F5
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 22:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiJGWAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 18:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJGWAn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 18:00:43 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AD7A3F6C
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 15:00:41 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D5B8315D3B2;
        Fri,  7 Oct 2022 18:00:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=h
        10zf7tHedV27EVuBeXrGS/SDrQ4DDXTVX5c0HmnMSw=; b=aO8Har/USJjxNJteA
        YcwddpDWvdgGxCOQxjlJzraD5BbDghcO57QN/jQkjFgfrhim4l+V1XXli57r80MN
        4fhWFwDhlm4tcKYLkUmba7pV1IoGqTqRGA2yD9ILKw5RdJVAggkfIH5TSei7ZDcK
        xa0MFEBNkwmiBh8fcWEaV9hIPI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB96E15D3B1;
        Fri,  7 Oct 2022 18:00:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 28B2115D3B0;
        Fri,  7 Oct 2022 18:00:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] symbolic-ref: teach "--[no-]recurse" option
Date:   Fri, 07 Oct 2022 15:00:39 -0700
Message-ID: <xmqqleprcn08.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B542360-468B-11ED-A3C5-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Suppose you are managing many maintenance tracks in your project,
and some of the more recent ones are maint-2.36 and maint-2.37.
Further imagine that your project recently tagged the official 2.38
release, which means you would need to start maint-2.38 track soon,
by doing:

  $ git checkout -b maint-2.38 v2.38.0^0
  $ git branch --list 'maint-2.3[6-9]'
  * maint-2.38
    maint-2.36
    maint-2.37

So far, so good.  But it also is reasonable to want not to have to
worry about which maintenance track is the latest, by pointing a
more generic-sounding 'maint' branch at it, by doing:

  $ git symbolic-ref refs/heads/maint refs/heads/maint-2.38

which would allow you to say "whichever it is, check out the latest
maintenance track", by doing:

  $ git checkout maint
  $ git branch --show-current
  maint-2.38

It is arguably better to say that we are on 'maint-2.38' rather than
on 'maint', and "git merge/pull" would record "into maint-2.38" and
not "into maint", so I think what we have is a good behaviour.

One thing that is slightly irritating, however, is that I do not
think there is a good way (other than "cat .git/HEAD") to learn that
you checked out 'maint' to get into that state.  Just like the output
of "git branch --show-current" shows above, "git symbolic-ref HEAD"
would report 'refs/heads/maint-2.38', bypassing the intermediate
symbolic ref at 'refs/heads/maint' that is pointed at by HEAD.

The internal resolve_ref() API already has the necessary support for
stopping after resolving a single level of a symbolic-ref, and we
can expose it by adding a "--[no-]recurse" option to the command.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/symbolic-ref.c  | 16 ++++++++++------
 t/t1401-symbolic-ref.sh | 14 ++++++++++++++
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git c/builtin/symbolic-ref.c w/builtin/symbolic-ref.c
index 1b0f10225f..5c9de63267 100644
--- c/builtin/symbolic-ref.c
+++ w/builtin/symbolic-ref.c
@@ -10,10 +10,13 @@ static const char * const git_symbolic_ref_usage[] = {
 	NULL
 };
 
-static int check_symref(const char *HEAD, int quiet, int shorten, int print)
+static int check_symref(const char *HEAD, int quiet, int shorten, int recurse, int print)
 {
-	int flag;
-	const char *refname = resolve_ref_unsafe(HEAD, 0, NULL, &flag);
+	int resolve_flags, flag;
+	const char *refname;
+
+	resolve_flags = (recurse ? 0 : RESOLVE_REF_NO_RECURSE);
+	refname = resolve_ref_unsafe(HEAD, resolve_flags, NULL, &flag);
 
 	if (!refname)
 		die("No such ref: %s", HEAD);
@@ -35,13 +38,14 @@ static int check_symref(const char *HEAD, int quiet, int shorten, int print)
 
 int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 {
-	int quiet = 0, delete = 0, shorten = 0, ret = 0;
+	int quiet = 0, delete = 0, shorten = 0, recurse = 1, ret = 0;
 	const char *msg = NULL;
 	struct option options[] = {
 		OPT__QUIET(&quiet,
 			N_("suppress error message for non-symbolic (detached) refs")),
 		OPT_BOOL('d', "delete", &delete, N_("delete symbolic ref")),
 		OPT_BOOL(0, "short", &shorten, N_("shorten ref output")),
+		OPT_BOOL(0, "recurse", &recurse, N_("recursively dereference (default)")),
 		OPT_STRING('m', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_END(),
 	};
@@ -55,7 +59,7 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 	if (delete) {
 		if (argc != 1)
 			usage_with_options(git_symbolic_ref_usage, options);
-		ret = check_symref(argv[0], 1, 0, 0);
+		ret = check_symref(argv[0], 1, 0, 0, 0);
 		if (ret)
 			die("Cannot delete %s, not a symbolic ref", argv[0]);
 		if (!strcmp(argv[0], "HEAD"))
@@ -65,7 +69,7 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 
 	switch (argc) {
 	case 1:
-		ret = check_symref(argv[0], quiet, shorten, 1);
+		ret = check_symref(argv[0], quiet, shorten, recurse, 1);
 		break;
 	case 2:
 		if (!strcmp(argv[0], "HEAD") &&
diff --git c/t/t1401-symbolic-ref.sh w/t/t1401-symbolic-ref.sh
index 0c204089b8..d708acdb81 100755
--- c/t/t1401-symbolic-ref.sh
+++ w/t/t1401-symbolic-ref.sh
@@ -175,4 +175,18 @@ test_expect_success 'symbolic-ref allows top-level target for non-HEAD' '
 	test_cmp_rev top-level HEAD
 '
 
+test_expect_success 'symbolic-ref pointing at another' '
+	git update-ref refs/heads/maint-2.37 HEAD &&
+	git symbolic-ref refs/heads/maint refs/heads/maint-2.37 &&
+	git checkout maint &&
+
+	git symbolic-ref HEAD >actual &&
+	echo refs/heads/maint-2.37 >expect &&
+	test_cmp expect actual &&
+
+	git symbolic-ref --no-recurse HEAD >actual &&
+	echo refs/heads/maint >expect &&
+	test_cmp expect actual
+'
+
 test_done
