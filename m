Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC0B0202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 13:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753460AbdCONPS (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 09:15:18 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59778 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753400AbdCONPR (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Mar 2017 09:15:17 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B9F2620A35;
        Wed, 15 Mar 2017 09:15:15 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 15 Mar 2017 09:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
        date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=gKw
        6izAV62qgU7kjAP+Z1w8EdcM=; b=DnVczjD6el4gz+j0GSCgt3gVb4udriOngrJ
        eUiKL5nAY2QGxiImnfj7aG3GoKVUxAurmnGP90+/ybvZ8jx8cx7JDk3/LJFRj2QA
        if/xqzMPRrvbtRdbeI3LHlhquNAAaXWQJI1OT74bB/3rLuZeBvJDh1v0BAFAebGq
        EyBllUkk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc
        :x-sasl-enc; s=smtpout; bh=gKw6izAV62qgU7kjAP+Z1w8EdcM=; b=nfP5i
        TaSL0yY6rXtTK0TTG0Mg189YwKfTQqEQhOBsk8MSxwZMUbz1y/lkCtQSLnfCP7Rp
        hA4CbnKDrUeyXqJ2j6ZWioku38WLUL6pMPtREM78LzwOMgI240UpoIyMoRVWvu5l
        fOFLkn2HM+g4lZcrOVSOgjDnKiBINuDSgTWcEM=
X-ME-Sender: <xms:Yz7JWCX6C77D2KNGFhWnH1poAlolu4EQn76L_Irgp-Y9XC1sI4ONeA>
X-Sasl-enc: mvuJmuURNJZdwV1aII2KU6ZvWAEQoROoXKGoY3r5z/62 1489583715
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6445C24313;
        Wed, 15 Mar 2017 09:15:15 -0400 (EDT)
From:   Michael J Gruber <git@drmicha.warpmail.net>
To:     git@vger.kernel.org
Subject: [RFD PATCH 3/3] name-rev: Allow lightweight tags and branch refs
Date:   Wed, 15 Mar 2017 14:15:10 +0100
Message-Id: <db54f291407ef34080fe9e8c9dbdd482b4b3698d.1489581340.git.git@drmicha.warpmail.net>
X-Mailer: git-send-email 2.12.0.384.g157040b11f.dirty
In-Reply-To: <cover.1489581340.git.git@drmicha.warpmail.net>
References: <cover.1489581340.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When name-rev constructs possible names for a rev, it assigns the
taggerdate to an annotated tag and ULONG_MAX to other names such as
lightweight tags and branch names. Practically, this rules out even
naming a tagged commit by the tag if that is lightweight and there is
another possible indirect name (e.g. foo~5) coming from an annotated
tag.

Instead, assign the commit date to lightweight tags or branch refs so
that they get their fair chance of being picked up.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---

Originally, I didn't even think of submitting this as is until I noticed that
all tests succeed with it (bar one for git-prompt.h which looked strange
anyways); rather, I thought about another switch "--lightweight" or so.

I still submit it as RFD. This origin of my foray into name-rev came from
git describe, where a fair expectation should be that "--contains" mode
is the same as the odinary mode, albeit with a different direction in
time/traversal. (Technically, describe --contains is name-rev.)

Consider the following:

git init
echo past >tense
git add tense
git commit -m past
git tag -m past -a past
echo present >tense
git commit -am present
git tag present
echo future >tense
git commit -am future

"git describe past present future" gives

past
past-1-g5ad942f
future

because (as documented) it does not consider lightweight tags, and thus
has to describe present from the past.

"git describe --tags past present future" gives

past
present
future

because (as documented) it does consider lightweight tags.

"git describe --contains past present future" gives

past^0
future~1
future^0

and I have a hard time matching that with the documentation
(describe doc claims that --tags is automatic; name-rev doc does not
distinguish between tag types).
"--tags" does not make any difference here, nor does "--all"
(besides fully qualifying the tags).

"git describe --contains past present future" gives

past^0
present
future^0

with this patch (I'm tempted to say: with the present patch),
which is what I would expect.

I'm wondering whether I'm overlooking any side-effects that our test
suite doesn't cover, though. In any case, we may want to have
lightweight tags allowed based on an extra flag (like the
existing --tags for describe, which means something else for name-rev).

 builtin/name-rev.c     | 2 ++
 t/t9903-bash-prompt.sh | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 8bdc3eaa6f..75ba7bbad5 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -207,6 +207,8 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 	if (o && o->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)o;
 
+		if (taggerdate == ULONG_MAX) /* lightweight tag */
+			taggerdate = commit->date;
 		path = name_ref_abbrev(path, can_abbreviate_output);
 		name_rev(commit, xstrdup(path), taggerdate, 0, 0, deref);
 	}
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 97c9b32c2e..d467d5957d 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -107,7 +107,7 @@ test_expect_success 'prompt - describe detached head - contains' '
 '
 
 test_expect_success 'prompt - describe detached head - branch' '
-	printf " ((tags/t2~1))" >expected &&
+	printf " ((b1~1))" >expected &&
 	git checkout b1^ &&
 	test_when_finished "git checkout master" &&
 	(
-- 
2.12.0.384.g157040b11f.dirty

