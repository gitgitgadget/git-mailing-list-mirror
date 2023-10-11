Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAEDCDB464
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 16:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjJKQ36 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 12:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjJKQ35 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 12:29:57 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A075D91
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 09:29:56 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 085B81AABD;
        Wed, 11 Oct 2023 12:29:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=Ocl3CiCPDZIgbEI5wvim3iFFddKRLMPufIs7I7
        X/J8Q=; b=MEcWmSepwNT9+2su+XtNT4DkjcAl4otKF++BYJad5Cf5c1IO7x0Wyy
        dARB7mkG9yVQTq7xI6YXRxlygcKv3lbgIw3BTs7xIbjq/I/GsVSD36raE3Rmjf3l
        CIAz7tz2zvpQk7CnBkxskoV/QBpbYGz+NoM4PWtpd2E0WhZQVz/1o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 018F71AABC;
        Wed, 11 Oct 2023 12:29:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3228A1AABB;
        Wed, 11 Oct 2023 12:29:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Bug: git stash store can create stash entries that can't be
 dropped
In-Reply-To: <CA+JQ7M_effxh9BSOhF67N+rsvBVTULe0dWZzp-kq1yOiDq3+hQ@mail.gmail.com>
        (Erik Cervin Edin's message of "Wed, 11 Oct 2023 10:42:31 +0200")
References: <CA+JQ7M_effxh9BSOhF67N+rsvBVTULe0dWZzp-kq1yOiDq3+hQ@mail.gmail.com>
Date:   Wed, 11 Oct 2023 09:29:50 -0700
Message-ID: <xmqqzg0pnmv5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 677299E0-6853-11EE-8608-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Erik Cervin Edin <erik@cervined.in> writes:

> ... even if it wasn't created using git stash create

I am of two minds.  As "stash store" and "stash create" were
invented as, and have always been ever since, pretty much
implementation details of scripted "stash save", the user deserves
what they get when they abuse them: garbage-in, garbage-out.

> A stash entry is created that cannot be dropped, because it's not
> stash-like commit.
>
>   git stash drop
>   fatal: 'refs/stash@{0}' is not a stash-like commit

Yes, this is exactly what the user deserves.

Having said that, I agree that this shows an uneven UI.  The "drop"
command cares about what it is dropping and refuses if it is not a
stash-like thing, so it is understandable to wish "store" to also
care to the same degree.

It may be just the matter of doing something silly like this.  Not
even compile tested, but hopefully it is sufficient to convey the
idea.

 builtin/stash.c  | 6 ++++++
 t/t3903-stash.sh | 4 ++++
 2 files changed, 10 insertions(+)

diff --git c/builtin/stash.c w/builtin/stash.c
index 1ad496985a..4a6771c9f4 100644
--- c/builtin/stash.c
+++ w/builtin/stash.c
@@ -989,6 +989,12 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 static int do_store_stash(const struct object_id *w_commit, const char *stash_msg,
 			  int quiet)
 {
+	struct stash_info info;
+	char revision[GIT_MAX_HEXSZ];
+
+	oid_to_hex_r(revision, w_commit);
+	assert_stash_like(&info, revision);
+
 	if (!stash_msg)
 		stash_msg = "Created via \"git stash store\".";
 
diff --git c/t/t3903-stash.sh w/t/t3903-stash.sh
index 0b3dfeaea2..30b64260a8 100755
--- c/t/t3903-stash.sh
+++ w/t/t3903-stash.sh
@@ -931,6 +931,10 @@ test_expect_success 'store called with invalid commit' '
 	test_must_fail git stash store foo
 '
 
+test_expect_success 'store called with non-stash commit' '
+	test_must_fail git stash store HEAD
+'
+
 test_expect_success 'store updates stash ref and reflog' '
 	git stash clear &&
 	git reset --hard &&
