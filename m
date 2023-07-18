Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634F2EB64DD
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 21:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjGRVXB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jul 2023 17:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjGRVWx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 17:22:53 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E37A9D
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 14:22:51 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 78F3419B0CB;
        Tue, 18 Jul 2023 17:22:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=b
        pTrN1DkKMviRySm8JtugwMgIv1gZfa1eHILSEgbDos=; b=Wy0563lB7aqMmNcYC
        MQ3lHBkPZeDJfKLeJDDscqLj8D08NYBBk8V5p6zBGCOPdEgw3R4aqOaqarpcqyJ1
        tis0BRPvpZV2oGvOSHh6OXeePb0NopaN7K8jzvekFuj+OGzNFhvYoHkFPJbG15FZ
        Ffd6j0JuSlSRdNPOKc/byWVjcU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71E8F19B0CA;
        Tue, 18 Jul 2023 17:22:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D807819B0C9;
        Tue, 18 Jul 2023 17:22:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] describe: --no-exact-match should not be the same as
 --exact-match
Date:   Tue, 18 Jul 2023 14:22:48 -0700
Message-ID: <xmqqy1jcgbiv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F72D764-25B1-11EE-B746-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git describe --exact-match X" is designed to fail when no tags are
pointing at X.  When given "--no-exact-match", the command line
parser did the same thing as "--exact-match", which was clearly
bogus.

What "--no-exact-match" should do is not entirely clear, though.

Internally, there is an integer "max-candidates" that specifies how
many possible "describe" names are computed (among which, the best
name is picked), and this limit is set to 10 by default.  The
"--candidates=<number>" option sets it to an arbitrary number (the
idea being that by spending a bit more computing resource, we might
be able to come up with a better name).  "--exact-match" uses this
mechanism to express that the user refuses to accept a name that is
any non-zero distance away from a tag, and it does so by setting the
limit to 0.

Making "--no-exact-match" reset the counter to its default value
would allow "git describe --exact-match --no-exact-match X" to
defeat the earlier "--exact-match", and that is the solution we
adopt here in this patch.  However, it is not clear what should
happen in this command:

    git describe --exact-match --candidates=20 --no-exact-match X

Saying --candidates=20 allows us to go inexact, but then should
"--no-exact-match" become a no-op?  The implementation in this patch
resets the counter to its default value, defeating the earlier
setting done by the "--candidates" option.  We probably could solve
it by introducing an extra variable and combining the two after
parse_options() returns, but let's declare that it is not worth
solving and use the simpler solution, i.e. "--no-exact-match" resets
the limit to its default value.

The "--no-exact-match" option was not covered in the tests, so let's
add a few.  Also add a case where --exact-match option is used on a
commit that cannot be described without distance from tags and make
sure the command fails.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/describe.c  | 11 ++++++++---
 t/t6120-describe.sh |  8 ++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 55b4baaa22..879f8a8d45 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -34,13 +34,15 @@ static const char * const describe_usage[] = {
 	NULL
 };
 
+#define DEFAULT_MAX_CANDIATES 10
+
 static int debug;	/* Display lots of verbose info */
 static int all;	/* Any valid ref can be used */
 static int tags;	/* Allow lightweight tags */
 static int longformat;
 static int first_parent;
 static int abbrev = -1; /* unspecified */
-static int max_candidates = 10;
+static int max_candidates = DEFAULT_MAX_CANDIATES;
 static struct hashmap names;
 static int have_util;
 static struct string_list patterns = STRING_LIST_INIT_NODUP;
@@ -567,8 +569,11 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "long",       &longformat, N_("always use long format")),
 		OPT_BOOL(0, "first-parent", &first_parent, N_("only follow first parent")),
 		OPT__ABBREV(&abbrev),
-		OPT_SET_INT(0, "exact-match", &max_candidates,
-			    N_("only output exact matches"), 0),
+		OPT_SET_INT_F(0, "exact-match", &max_candidates,
+			      N_("only output exact matches"), 0, PARSE_OPT_NONEG),
+		OPT_SET_INT_F(0, "no-exact-match", &max_candidates,
+			      N_("only output exact matches"), DEFAULT_MAX_CANDIATES,
+			      PARSE_OPT_NONEG),
 		OPT_INTEGER(0, "candidates", &max_candidates,
 			    N_("consider <n> most recent tags (default: 10)")),
 		OPT_STRING_LIST(0, "match", &patterns, N_("pattern"),
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index c9afcef201..0a5c487540 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -85,6 +85,7 @@ check_describe e-1-gHASH --tags HEAD^^
 check_describe c-2-gHASH --tags HEAD^^2
 check_describe B --tags HEAD^^2^
 check_describe e --tags HEAD^^^
+check_describe e --tags --exact-match HEAD^^^
 
 check_describe heads/main --all HEAD
 check_describe tags/c-6-gHASH --all HEAD^
@@ -96,6 +97,13 @@ check_describe A-3-gHASH --long HEAD^^2
 check_describe c-7-gHASH --tags
 check_describe e-3-gHASH --first-parent --tags
 
+check_describe c-7-gHASH --tags --no-exact-match HEAD
+check_describe e-3-gHASH --first-parent --tags --no-exact-match HEAD
+
+test_expect_success '--exact-match failure' '
+	test_must_fail git describe --exact-match HEAD 2>err
+'
+
 test_expect_success 'describe --contains defaults to HEAD without commit-ish' '
 	echo "A^0" >expect &&
 	git checkout A &&
-- 
2.41.0-376-gcba07a324d

