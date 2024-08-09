Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152E3C8D1
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 22:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723242655; cv=none; b=Kf2E15ytIs/6LP++x/NrJ8do6jVHn0JGgqXH59gZcznWtxfX0hz2F/mOhE9pu1hB7StChGny64xJn8W5pK2vZ+CRkscprGdVUyOrfmL4Ke/emhUKcSgbiw9tCxhsASuKp8XyxDf7iq4aiOrMmU+ct6fCXvboqcGcqGSu7GYlx4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723242655; c=relaxed/simple;
	bh=sazaGm3vsWIPxOaxeEteEff0MSczTCD+fMV+RfBLZ+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rczykYvT5zFYhDerwnAorfT4I891YM7fdhZqfymQFBNFumZWNnZuYz6vtoE1AK0ccT85HDf4FL9IsTZYlLy4bnvcLP/DHMreS0lHlgVgaLq7qpEntR51e/vfDpuxLIWvGPedgjglbqGXZGsJt2STbbVwxDoO5zYVEFg3Ns0VTls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=foqB+1QG; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="foqB+1QG"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E678D1E656;
	Fri,  9 Aug 2024 18:30:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=s
	azaGm3vsWIPxOaxeEteEff0MSczTCD+fMV+RfBLZ+E=; b=foqB+1QGaRfGYM2wo
	W6CMX/eSWSrRk36z5awyoppac7cZIBlFQbnafq2Xkb+2bxsGjRsX71qYRbO5Ih1v
	puC0dgDzkL0EUjodgzWY0cN4wYzFzZ0UL6p+rqwdzLdNW7mTbwsAd2mzzeiOQXvm
	rebsk8b11OhKjx6myQpa/kZDBQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DBA701E655;
	Fri,  9 Aug 2024 18:30:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 57D671E654;
	Fri,  9 Aug 2024 18:30:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    blanet <bupt_xingxin@163.com>,
    Xing Xin  <xingxin.xx@bytedance.com>
Subject: [PATCH 1/2] remerge-diff: lazily prpare temporary objdir on demand
Date: Fri, 09 Aug 2024 15:30:51 -0700
Message-ID: <xmqqv8099vms.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 09122A56-569F-11EF-BDB7-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

It is error prone for each caller that sets revs.remerge_diff bit
to be responsible for preparing a temporary object directory and
rotate it into the list of alternate object stores, making it the
primary object store.

Instead, remove the code to set up and arrange the temporary object
directory from the current callers and implement it in the code that
runs remerge-diff logic.  The code to undo the futzing of the list
of alternate object store is still spread across the callers, but we
will deal with it in future steps.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * So here are two patches to illustate how the code to do the lazy
   set-up and centralized tear down looks like.  The first part is
   the lazy set-up.

 builtin/diff-tree.c |  7 -------
 builtin/log.c       |  7 -------
 log-tree.c          | 16 ++++++++++++----
 3 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 12012ea093..af51cd29c6 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -168,13 +168,6 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 
 	opt->diffopt.rotate_to_strict = 1;
 
-	if (opt->remerge_diff) {
-		opt->remerge_objdir = tmp_objdir_create("remerge-diff");
-		if (!opt->remerge_objdir)
-			die(_("unable to create temporary object directory"));
-		tmp_objdir_replace_primary_odb(opt->remerge_objdir, 1);
-	}
-
 	/*
 	 * NOTE!  We expect "a..b" to expand to "^a b" but it is
 	 * perfectly valid for revision range parser to yield "b ^a",
diff --git a/builtin/log.c b/builtin/log.c
index af6403cb71..227823a16e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -494,13 +494,6 @@ static int cmd_log_walk_no_free(struct rev_info *rev)
 	int saved_nrl = 0;
 	int saved_dcctc = 0;
 
-	if (rev->remerge_diff) {
-		rev->remerge_objdir = tmp_objdir_create("remerge-diff");
-		if (!rev->remerge_objdir)
-			die(_("unable to create temporary object directory"));
-		tmp_objdir_replace_primary_odb(rev->remerge_objdir, 1);
-	}
-
 	if (rev->early_output)
 		setup_early_output();
 
diff --git a/log-tree.c b/log-tree.c
index 337b9334cd..83e648b7cd 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1019,6 +1019,17 @@ static int do_remerge_diff(struct rev_info *opt,
 	struct strbuf parent1_desc = STRBUF_INIT;
 	struct strbuf parent2_desc = STRBUF_INIT;
 
+	/*
+	 * Lazily prepare a temporary object directory and rotate it
+	 * into the alternative object store list as the primary.
+	 */
+	if (opt->remerge_diff && !opt->remerge_objdir) {
+		opt->remerge_objdir = tmp_objdir_create("remerge-diff");
+		if (!opt->remerge_objdir)
+			return error(_("unable to create temporary object directory"));
+		tmp_objdir_replace_primary_odb(opt->remerge_objdir, 1);
+	}
+
 	/* Setup merge options */
 	init_merge_options(&o, the_repository);
 	o.show_rename_progress = 0;
@@ -1053,10 +1064,7 @@ static int do_remerge_diff(struct rev_info *opt,
 	merge_finalize(&o, &res);
 
 	/* Clean up the contents of the temporary object directory */
-	if (opt->remerge_objdir)
-		tmp_objdir_discard_objects(opt->remerge_objdir);
-	else
-		BUG("did a remerge diff without remerge_objdir?!?");
+	tmp_objdir_discard_objects(opt->remerge_objdir);
 
 	return !opt->loginfo;
 }
-- 
2.46.0-326-g1e046905fc

