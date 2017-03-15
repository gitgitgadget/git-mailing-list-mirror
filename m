Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 099C5202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 20:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbdCOUwA (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 16:52:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55190 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751480AbdCOUv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 16:51:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD01E7EFA3;
        Wed, 15 Mar 2017 16:51:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m6zap/JNCUN5cdnZc7gcytvIZT0=; b=wrAJEi
        zRbfbkCYaTXzMl3PkzsLDUNoTE+r4EJjAmuBliE/KfbUrMCeStJbb93+vy3rHQVQ
        A7CaK3gvrf6tanKD3bvERri58wFwgcrOUO2xMDr74jxiGsBfb9gZg6yBJ/AWrqqW
        le0mWSU/RnTdU3tiUynipB1PU9mVnLZKT4pp8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ceqblwFe+pLZ6tlU2YdxB6Zu1vVVHpxW
        V778iig2WbPl1WaoN7kyn6zRaSslshf5A8rxcs9V1LYZo2BlRQG5jhRgoIHVaU5Q
        sqeOEf42pZGPT6gbo8Y7Tgg73uLHliZdLRBVPs1myBB9RL/OFUi3+kuRUty7HQ1I
        nHeZRUl0v7Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C51557EFA2;
        Wed, 15 Mar 2017 16:51:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3B0747EFA1;
        Wed, 15 Mar 2017 16:51:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@drmicha.warpmail.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFD PATCH 3/3] name-rev: Allow lightweight tags and branch refs
References: <cover.1489581340.git.git@drmicha.warpmail.net>
        <db54f291407ef34080fe9e8c9dbdd482b4b3698d.1489581340.git.git@drmicha.warpmail.net>
        <xmqqlgs6e2uv.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 15 Mar 2017 13:51:56 -0700
In-Reply-To: <xmqqlgs6e2uv.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 15 Mar 2017 12:50:32 -0700")
Message-ID: <xmqqd1die00j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A7AAF56-09C1-11E7-8050-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> This could have been an invocation of "name-rev" without "--tags",
> where _any_ tip of ref can be used to name a revision, and in such a
> case, retaining commit->date may still be valuable, but it is
> probably wrong to use it for nothing more than tie-breaking.
> ...
> I think you can do this change _ONLY_ when we are operating under
> the "--tags" option.  That would place unannotated tags at a better
> location in the timestamp order than the current code does, without
> introducing issues with refs that are actively moving.

I'll leave "only do so under --tags" as an exercise to the reader,
but if we want to use the timestamp for tie-breaking between names
based on two branches, a patch to do so may look like this one.  

I am presenting it as a single ball of wax, but in the real history
I have (which I am not publishing, as I haven't decided if this is a
good direction to go in the first place), this is a two-patch
series, the first one that factors out is_better_name() without
doing anything else, followed by a commit that adds "from_tag" and
passes it throughout the callpath to allow is_better_name() to use
it to:

 - always favor names based on a tag;

 - between two names based on tags, favor name based on an older tag
   and tiebreak with distance;

 - between two names based on non-tags, favor name with shorter hops
   and tiebreak with age.

 builtin/name-rev.c | 43 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index cd89d48b65..ba30c9ca23 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -13,6 +13,7 @@ typedef struct rev_name {
 	unsigned long taggerdate;
 	int generation;
 	int distance;
+	int from_tag;
 } rev_name;
 
 static long cutoff = LONG_MAX;
@@ -20,9 +21,31 @@ static long cutoff = LONG_MAX;
 /* How many generations are maximally preferred over _one_ merge traversal? */
 #define MERGE_TRAVERSAL_WEIGHT 65535
 
+static int is_better_name(struct rev_name *name,
+			  const char *tip_name,
+			  unsigned long taggerdate,
+			  int generation,
+			  int distance,
+			  int from_tag)
+{
+	if (name->from_tag > from_tag)
+		return 0;
+	else if (name->from_tag < from_tag)
+		return 1;
+
+	if (from_tag)
+		return (name->taggerdate > taggerdate ||
+			(name->taggerdate == taggerdate &&
+			 name->distance > distance));
+	else
+		return (name->distance > distance ||
+			(name->distance == distance &&
+			 name->taggerdate > taggerdate));
+}
+
 static void name_rev(struct commit *commit,
 		const char *tip_name, unsigned long taggerdate,
-		int generation, int distance,
+		int generation, int distance, int from_tag,
 		int deref)
 {
 	struct rev_name *name = (struct rev_name *)commit->util;
@@ -45,14 +68,14 @@ static void name_rev(struct commit *commit,
 		name = xmalloc(sizeof(rev_name));
 		commit->util = name;
 		goto copy_data;
-	} else if (name->taggerdate > taggerdate ||
-			(name->taggerdate == taggerdate &&
-			 name->distance > distance)) {
+	} else if (is_better_name(name, tip_name, taggerdate,
+				  generation, distance, from_tag)) {
 copy_data:
 		name->tip_name = tip_name;
 		name->taggerdate = taggerdate;
 		name->generation = generation;
 		name->distance = distance;
+		name->from_tag = from_tag;
 	} else
 		return;
 
@@ -72,10 +95,12 @@ static void name_rev(struct commit *commit,
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
@@ -174,9 +199,13 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
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
