Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9400820281
	for <e@80x24.org>; Tue, 31 Oct 2017 05:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753028AbdJaFXj (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 01:23:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60116 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752874AbdJaFXi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 01:23:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 12366A8DF3;
        Tue, 31 Oct 2017 01:23:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Zuavdso8FD8uGeiu5+XVt/Dy3U8=; b=BxswPfJcJv2Xi8HzCYy3
        WODEoLOd2gf65Tp3Wmv98DjyaL27m64pj6pQDzAxm8jch9aVeD+y48EJ5h41rRNH
        cTO0KmwXj08/EW/ZvZGtYaz2PONvBZqiYEaw1ZRMQL+OetskLO5ER26UQDiRC8Fx
        lI+McE83xLmMZP+dPFS082s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=A4/IZ/Oc2qM+iGURQeGqH2jlLI8TmsNnbhVyVtOrk14uFf
        NpJgYEtO0aXAS1c2lENCfF6sdIuAw1B07udBwDZx7JEbWPzvCu4vz/zUI7ItxET0
        j/hzzdWU7CpJMhLRHQD3cH39/NxFGirOmQ2RVVjQRy2pe3x3N6yxxrAzcgkQ4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A8D8A8DF2;
        Tue, 31 Oct 2017 01:23:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7CB80A8DF1;
        Tue, 31 Oct 2017 01:23:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: [PATCH 2.5/4] diff: avoid returning a struct by value from diff_flags_or()
References: <20171027222853.180981-1-bmwill@google.com>
        <20171030194646.27473-1-bmwill@google.com>
        <20171030194646.27473-3-bmwill@google.com>
Date:   Tue, 31 Oct 2017 14:23:36 +0900
Message-ID: <xmqqo9on28mf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5DCF7E2-BDFB-11E7-9265-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That is more in line with the design decision made in the previous
step to pass struct by reference.

We may want to squash this into the previous patch eventually.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I am OK either way as long as things are consistent; as you took
   time to change the code to pass the struct by reference, let's
   unify the API in that direction.

 diff-lib.c |  2 +-
 diff.h     | 12 ++++--------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 6c1c05c5b0..ed37f24c68 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -547,7 +547,7 @@ int index_differs_from(const char *def, const struct diff_flags *flags,
 	DIFF_OPT_SET(&rev.diffopt, QUICK);
 	DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
 	if (flags)
-		rev.diffopt.flags = diff_flags_or(&rev.diffopt.flags, flags);
+		diff_flags_or(&rev.diffopt.flags, flags);
 	rev.diffopt.ita_invisible_in_index = ita_invisible_in_index;
 	run_diff_index(&rev, 1);
 	object_array_clear(&rev.pending);
diff --git a/diff.h b/diff.h
index 47e6d43cbc..e512cf44d0 100644
--- a/diff.h
+++ b/diff.h
@@ -94,19 +94,15 @@ struct diff_flags {
 	unsigned DEFAULT_FOLLOW_RENAMES:1;
 };
 
-static inline struct diff_flags diff_flags_or(const struct diff_flags *a,
-					      const struct diff_flags *b)
+static inline void diff_flags_or(struct diff_flags *a,
+				 const struct diff_flags *b)
 {
-	struct diff_flags out;
 	char *tmp_a = (char *)a;
-	char *tmp_b = (char *)b;
-	char *tmp_out = (char *)&out;
+	const char *tmp_b = (const char *)b;
 	int i;
 
 	for (i = 0; i < sizeof(struct diff_flags); i++)
-		tmp_out[i] = tmp_a[i] | tmp_b[i];
-
-	return out;
+		tmp_a[i] |= tmp_b[i];
 }
 
 #define DIFF_OPT_TST(opts, flag)	((opts)->flags.flag)
-- 
2.15.0-224-g5109123e6a

