Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECC7C001DE
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 16:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjGSQco (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 12:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGSQcn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 12:32:43 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2598EB6
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 09:32:42 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6B1E01C599;
        Wed, 19 Jul 2023 12:32:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dS5HZtm4vneLT/FtmKrN37HcagEDtdUJqySLbB
        iXGCI=; b=uRGQlKNYn5e25qLjHzo1LeB5jqkv6Ii2DMHtwEVkNTcWAn/QuapMXD
        +6vkCC4ls7PpZg71hgiHZ/7RZc+5SLg1M5DYdcAwVuKrFCMBqAd9QLMIVCkixPGy
        Jy1XcwWpwsnNeC9LQ/8QMpklxE2wzKvMSeg2xeEzMlQI69dmKkQUA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6395E1C595;
        Wed, 19 Jul 2023 12:32:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C55B11C593;
        Wed, 19 Jul 2023 12:32:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] show-branch: reject --[no-](topo|date)-order
References: <xmqq7cqwcet8.fsf@gitster.g>
Date:   Wed, 19 Jul 2023 09:32:36 -0700
In-Reply-To: <xmqq7cqwcet8.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        19 Jul 2023 04:37:39 -0700")
Message-ID: <xmqqh6pzc15n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF74C79A-2651-11EE-960E-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git show-branch --no-topo-order" behaved exactly the same way as
"git show-branch --topo-order" did, which was nonsense.  This was
because we choose between topo- and date- by setting a variable to
either REV_SORT_IN_GRAPH_ORDER or REV_SORT_BY_COMMIT_DATE with
OPT_SET_INT() and REV_SORT_IN_GRAPH_ORDER happens to be 0.  The
OPT_SET_INTO() macro assigns 0 to the target variable in respose to
the negated form of its option.

"--no-date-order" by luck behaves identically to "--topo-order"
exactly for the same reason, and it sort-of makes sense right now,
but the "sort-of makes sense" will quickly break down once we add a
third way to sort.  Not-A may be B when there are only two choices
between A and B, but once your choices become among A, B, and C,
not-A does not mean B.

Just mark these two ordering options to reject negation, and add a
test, which was missing.  "git show-branch --no-reflog" is also
unnegatable, so throw in a test for that while we are at it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Comes on top of the "--no-sparse should mean dense" patch.

 builtin/show-branch.c  | 14 +++++++-------
 t/t3202-show-branch.sh |  9 +++++++++
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git c/builtin/show-branch.c w/builtin/show-branch.c
index 67f3ef0639..b574afb7c3 100644
--- c/builtin/show-branch.c
+++ w/builtin/show-branch.c
@@ -667,17 +667,17 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			 N_("show possible merge bases")),
 		OPT_BOOL(0, "independent", &independent,
 			    N_("show refs unreachable from any other ref")),
-		OPT_SET_INT(0, "topo-order", &sort_order,
-			    N_("show commits in topological order"),
-			    REV_SORT_IN_GRAPH_ORDER),
+		OPT_SET_INT_F(0, "topo-order", &sort_order,
+			      N_("show commits in topological order"),
+			      REV_SORT_IN_GRAPH_ORDER, PARSE_OPT_NONEG),
 		OPT_BOOL(0, "topics", &topics,
 			 N_("show only commits not on the first branch")),
 		OPT_SET_INT(0, "sparse", &sparse,
 			    N_("show merges reachable from only one tip"), 1),
-		OPT_SET_INT(0, "date-order", &sort_order,
-			    N_("topologically sort, maintaining date order "
-			       "where possible"),
-			    REV_SORT_BY_COMMIT_DATE),
+		OPT_SET_INT_F(0, "date-order", &sort_order,
+			      N_("topologically sort, maintaining date order "
+				 "where possible"),
+			      REV_SORT_BY_COMMIT_DATE, PARSE_OPT_NONEG),
 		OPT_CALLBACK_F('g', "reflog", &reflog_base, N_("<n>[,<base>]"),
 			    N_("show <n> most recent ref-log entries starting at "
 			       "base"),
diff --git c/t/t3202-show-branch.sh w/t/t3202-show-branch.sh
index ca7c44f0f7..b17f388f56 100755
--- c/t/t3202-show-branch.sh
+++ w/t/t3202-show-branch.sh
@@ -213,6 +213,15 @@ done <<\EOF
 --reflog --current
 EOF
 
+# unnegatable options
+for opt in topo-order date-order reflog
+do
+	test_expect_success "show-branch --no-$opt (should fail)" '
+		test_must_fail git show-branch --no-$opt 2>err &&
+		grep "unknown option .no-$opt." err
+	'
+done
+
 test_expect_success 'error descriptions on non-existent branch' '
 	cat >expect <<-EOF &&
 	error: No branch named '\''non-existent'\'.'


