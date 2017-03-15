Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18D87202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 22:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754289AbdCOW6x (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 18:58:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55690 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754279AbdCOW6v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 18:58:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D1A4C7AE63;
        Wed, 15 Mar 2017 18:50:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=EGy6
        N69vV8IGlZ7yw1L1+aZNTe0=; b=i92LZZiC4cQG+s+x9jOWIbyZAW9kAA/FW0K8
        zmfrNyWc0vvpkNdrBZytY3IrC2SVnHKZT+SQqQKoz6gRVvrl/Td5Xr3oijhxkutX
        qjC+bfNaR9/banos5P95IxeeukUdW6E/mHovjllfA8RCg21oBtKFqNDXCfCfnwzu
        p17oO3k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        NgbKqD87bLgVDkDknG7c/CPzg0xnnIxFWxH0eahuQ8FDXcTLLIUhzmf30irsbnax
        sZPKJtowL7ynunNVyQP1qS7DyztPhexOMPexWMSMTQLxhitNMeQx2osYvVLi12ur
        YhFOJCLSm7aeZguU2ib0WTZt3i34R2VEI1o6+Pvqyas=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C9E617AE62;
        Wed, 15 Mar 2017 18:50:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 17E247AE5F;
        Wed, 15 Mar 2017 18:50:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/2] name-rev: favor describing with tags and use committer date to tiebreak
Date:   Wed, 15 Mar 2017 15:50:45 -0700
Message-Id: <20170315225045.15788-3-gitster@pobox.com>
X-Mailer: git-send-email 2.12.0-306-g4a9b9b32d4
In-Reply-To: <20170315225045.15788-1-gitster@pobox.com>
References: <xmqqd1die00j.fsf@gitster.mtv.corp.google.com>
 <20170315225045.15788-1-gitster@pobox.com>
X-Pobox-Relay-ID: D5FDEE24-09D1-11E7-A9F6-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git name-rev" assigned a phony "far in the future" date to tips of
refs that are not pointing at tag objects, and favored names based
on a ref with the oldest date.  This made it almost impossible for
an unannotated tags and branches to be counted as a viable base,
which was especially problematic when the command is run with the
"--tags" option.  If an unannotated tag that points at an ancient
commit and an annotated tag that points at a much newer commit
reaches the commit that is being named, the old unannotated tag was
ignored.

Update the "taggerdate" field of the rev-name structure, which is
initialized from the tip of ref, to have the committer date if the
object at the tip of ref is a commit, not a tag, so that we can
optionally take it into account when doing "is this name better?"
comparison logic.

When "name-rev" is run without the "--tags" option, the general
expectation is still to name the commit based on a tag if possible,
but use non-tag refs as fallback, and tiebreak among these non-tag
refs by favoring names with shorter hops from the tip.  The use of a
phony "far in the future" date in the original code was an effective
way to ensure this expectation is held: a non-tag tip gets the same
"far in the future" timestamp, giving precedence to tags, and among
non-tag tips, names with shorter hops are preferred over longer
hops, without taking the "taggerdate" into account.  As we are
taking over the "taggerdate" field to store the committer date for
tips with commits:

 (1) keep the original logic when comparing names based on two refs
     both of which are from refs/tags/;

 (2) favoring a name based on a ref in refs/tags/ hierarchy over
     a ref outside the hierarchy;

 (3) between two names based on a ref both outside refs/tags/, give
     precedence to a name with shorter hops and use "taggerdate"
     only to tie-break.

A change to t4202 is a natural consequence.  The test creates a
commit on a branch "side" and points at it with an unannotated tag
"refs/tags/side-2".  The original code couldn't decide which one to
favor at all, and gave a name based on a branch (simply because
refs/heads/side sorts earlier than refs/tags/side-2).  Because the
updated logic is taught to favor refs in refs/tags/ hierarchy, the
the test is updated to expect to see tags/side-2 instead.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I am sure others can add better heurisitics in is_better_name()
   for comparing names based on non-tag refs, and I do not mind
   people disagreeing with the logic that this patch happens to
   implement.  This is done primarily to illustrate the value of
   using a separate helper function is_better_name() instead of
   open-coding the selection logic in name_rev() function.
---
 builtin/name-rev.c | 57 +++++++++++++++++++++++++++++++++++++++++++++---------
 t/t4202-log.sh     |  2 +-
 2 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index f64c71d9bc..eac0180c62 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -13,6 +13,7 @@ typedef struct rev_name {
 	unsigned long taggerdate;
 	int generation;
 	int distance;
+	int from_tag;
 } rev_name;
 
 static long cutoff = LONG_MAX;
@@ -24,16 +25,47 @@ static int is_better_name(struct rev_name *name,
 			  const char *tip_name,
 			  unsigned long taggerdate,
 			  int generation,
-			  int distance)
+			  int distance,
+			  int from_tag)
 {
-	return (name->taggerdate > taggerdate ||
-		(name->taggerdate == taggerdate &&
-		 name->distance > distance));
+	/*
+	 * When comparing names based on tags, prefer names
+	 * based on the older tag, even if it is farther away.
+	 */
+	if (from_tag && name->from_tag)
+		return (name->taggerdate > taggerdate ||
+			(name->taggerdate == taggerdate &&
+			 name->distance > distance));
+
+#define COMPARE(attribute, smaller_is_better)	 \
+	if (name->attribute > attribute) \
+		return smaller_is_better; \
+	if (name->attribute < attribute) \
+		return !smaller_is_better
+
+	/*
+	 * We know that at least one of them is a non-tag at this point.
+	 * favor a tag over a non-tag.
+	 */
+	COMPARE(from_tag, 0);
+
+	/*
+	 * We are now looking at two non-tags.  Tiebreak to favor
+	 * shorter hops.
+	 */
+	COMPARE(distance, 1);
+
+	/* ... or tiebreak to favor older date */
+	COMPARE(taggerdate, 1);
+
+	/* keep the current one if we cannot decide */
+	return 0;
+#undef COMPARE
 }
 
 static void name_rev(struct commit *commit,
 		const char *tip_name, unsigned long taggerdate,
-		int generation, int distance,
+		int generation, int distance, int from_tag,
 		int deref)
 {
 	struct rev_name *name = (struct rev_name *)commit->util;
@@ -57,12 +89,13 @@ static void name_rev(struct commit *commit,
 		commit->util = name;
 		goto copy_data;
 	} else if (is_better_name(name, tip_name, taggerdate,
-				  generation, distance)) {
+				  generation, distance, from_tag)) {
 copy_data:
 		name->tip_name = tip_name;
 		name->taggerdate = taggerdate;
 		name->generation = generation;
 		name->distance = distance;
+		name->from_tag = from_tag;
 	} else
 		return;
 
@@ -82,10 +115,12 @@ static void name_rev(struct commit *commit,
 						   parent_number);
 
 			name_rev(parents->item, new_name, taggerdate, 0,
-				distance + MERGE_TRAVERSAL_WEIGHT, 0);
+				 distance + MERGE_TRAVERSAL_WEIGHT,
+				 from_tag, 0);
 		} else {
 			name_rev(parents->item, tip_name, taggerdate,
-				generation + 1, distance + 1, 0);
+				 generation + 1, distance + 1,
+				 from_tag, 0);
 		}
 	}
 }
@@ -184,9 +219,13 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 	}
 	if (o && o->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)o;
+		int from_tag = starts_with(path, "refs/tags/");
 
+		if (taggerdate == ULONG_MAX)
+			taggerdate = ((struct commit *)o)->date;
 		path = name_ref_abbrev(path, can_abbreviate_output);
-		name_rev(commit, xstrdup(path), taggerdate, 0, 0, deref);
+		name_rev(commit, xstrdup(path), taggerdate, 0, 0,
+			 from_tag, deref);
 	}
 	return 0;
 }
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 48b55bfd27..038911f230 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -398,7 +398,7 @@ cat > expect <<\EOF
 | |
 | |     Merge branch 'side'
 | |
-| * commit side
+| * commit tags/side-2
 | | Author: A U Thor <author@example.com>
 | |
 | |     side-2
-- 
2.12.0-306-g4a9b9b32d4

