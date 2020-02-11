Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9DBC35242
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 18:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10EC020870
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 18:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fqse38re"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbgBKSPf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 13:15:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63141 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbgBKSPf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 13:15:35 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 715AC4C5C9;
        Tue, 11 Feb 2020 13:15:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=nFYT91+/ri7QlFhdCPtZFvEES30=; b=fqse38reU3CigwxHsv7Q
        /zK8CKjOolabtHM9PXURUr44PJgUOu8g/uqS2B0aMqdT8Sszr9pS7/MRj9CgwIho
        522/ipg/I7FuWJwOD8NaMRDweVPJHq9mTcr6GQnfAc9hW08Z56lTVBZAnEf9uto1
        SAWvOcDWrEKaBhQn6RvHEO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=ltpsqi4sXHY68cGp5Te1FUWHuFscOwj0Ez5SeLw35Rd9xJ
        QodHwizBM0IzO3cPeYyebTXxJI1LFhBIO48DkpGVjACqSdhbIrF37VD5NoMRL7IX
        0dSEYAsFTMMoeSN4zweP5HjCunzu/bC5IdOHjmQVAsQCnnw3S+Y7QoLqjNl5M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 628DB4C5C8;
        Tue, 11 Feb 2020 13:15:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7D8AC4C5C7;
        Tue, 11 Feb 2020 13:15:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Git List <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>, Alex Torok <alext9@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 1/1] rebase: --fork-point regression fix
References: <20191205235704.31385-1-alext9@gmail.com>
        <20191209145312.3251-1-alext9@gmail.com>
        <20191209145312.3251-2-alext9@gmail.com>
        <xmqq36dtwcvw.fsf@gitster-ct.c.googlers.com>
        <20191211122136.GA46399@generichostname>
        <CAPig+cQ-3Ds41hr91fRo_GvuFMTP7zNVJtaSqi-Yccq4Pk-8Qg@mail.gmail.com>
Date:   Tue, 11 Feb 2020 10:15:29 -0800
Message-ID: <xmqq5zgdvvlq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7CAA7472-4CFA-11EA-AD0D-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git rebase --fork-point master" used to work OK, as it internally
called "git merge-base --fork-point" that knew how to handle short
refname and dwim it to the full refname before calling the
underlying get_fork_point() function.

This is no longer true after the command was rewritten in C, as its
internall call made directly to get_fork_point() does not dwim a
short ref.

Move the "dwim the refname argument to the full refname" logic that
is used in "git merge-base" to the underlying get_fork_point()
function, so that the other caller of the function in the
implementation of "git rebase" behaves the same way to fix this
regression.

Signed-off-by: Alex Torok <alext9@gmail.com>
[jc: revamped the fix and used Alex's tests]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I was about to discard stalled topics and this caught my eyes.

 builtin/merge-base.c         | 12 +-----------
 commit.c                     | 15 +++++++++++++--
 t/t3431-rebase-fork-point.sh | 20 ++++++++++++++++++++
 3 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index e3f8da13b6..6719ac198d 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -114,26 +114,16 @@ static int handle_is_ancestor(int argc, const char **argv)
 static int handle_fork_point(int argc, const char **argv)
 {
 	struct object_id oid;
-	char *refname;
 	struct commit *derived, *fork_point;
 	const char *commitname;
 
-	switch (dwim_ref(argv[0], strlen(argv[0]), &oid, &refname)) {
-	case 0:
-		die("No such ref: '%s'", argv[0]);
-	case 1:
-		break; /* good */
-	default:
-		die("Ambiguous refname: '%s'", argv[0]);
-	}
-
 	commitname = (argc == 2) ? argv[1] : "HEAD";
 	if (get_oid(commitname, &oid))
 		die("Not a valid object name: '%s'", commitname);
 
 	derived = lookup_commit_reference(the_repository, &oid);
 
-	fork_point = get_fork_point(refname, derived);
+	fork_point = get_fork_point(argv[0], derived);
 
 	if (!fork_point)
 		return 1;
diff --git a/commit.c b/commit.c
index 40890ae7ce..016f14fe95 100644
--- a/commit.c
+++ b/commit.c
@@ -903,12 +903,22 @@ struct commit *get_fork_point(const char *refname, struct commit *commit)
 	struct commit_list *bases;
 	int i;
 	struct commit *ret = NULL;
+	char *full_refname;
+
+	switch (dwim_ref(refname, strlen(refname), &oid, &full_refname)) {
+	case 0:
+		die("No such ref: '%s'", refname);
+	case 1:
+		break; /* good */
+	default:
+		die("Ambiguous refname: '%s'", refname);
+	}
 
 	memset(&revs, 0, sizeof(revs));
 	revs.initial = 1;
-	for_each_reflog_ent(refname, collect_one_reflog_ent, &revs);
+	for_each_reflog_ent(full_refname, collect_one_reflog_ent, &revs);
 
-	if (!revs.nr && !get_oid(refname, &oid))
+	if (!revs.nr)
 		add_one_commit(&oid, &revs);
 
 	for (i = 0; i < revs.nr; i++)
@@ -934,6 +944,7 @@ struct commit *get_fork_point(const char *refname, struct commit *commit)
 
 cleanup_return:
 	free_commit_list(bases);
+	free(full_refname);
 	return ret;
 }
 
diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
index 78851b9a2a..172562789e 100755
--- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -47,11 +47,31 @@ test_rebase 'G F B A' --keep-base
 test_rebase 'G F C E D B A' --no-fork-point
 test_rebase 'G F C D B A' --no-fork-point --onto D
 test_rebase 'G F C B A' --no-fork-point --keep-base
+
 test_rebase 'G F E D B A' --fork-point refs/heads/master
+test_rebase 'G F E D B A' --fork-point master
+
 test_rebase 'G F D B A' --fork-point --onto D refs/heads/master
+test_rebase 'G F D B A' --fork-point --onto D master
+
 test_rebase 'G F B A' --fork-point --keep-base refs/heads/master
+test_rebase 'G F B A' --fork-point --keep-base master
+
 test_rebase 'G F C E D B A' refs/heads/master
+test_rebase 'G F C E D B A' master
+
 test_rebase 'G F C D B A' --onto D refs/heads/master
+test_rebase 'G F C D B A' --onto D master
+
 test_rebase 'G F C B A' --keep-base refs/heads/master
+test_rebase 'G F C B A' --keep-base master
+
+test_expect_success 'git rebase --fork-point with ambigous refname' '
+	git checkout master &&
+	git checkout -b one &&
+	git checkout side &&
+	git tag one &&
+	test_must_fail git rebase --fork-point --onto D one
+'
 
 test_done
