Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FB4C433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 22:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245116AbiAEWis (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 17:38:48 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60176 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245110AbiAEWiq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 17:38:46 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E7A7100B24;
        Wed,  5 Jan 2022 17:38:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4ESs1LepoIDtwHhDswIGFjIGcnoC2b2nWpHRJe
        HGq3Y=; b=KshmTN2ZoII4bWmBQMQqBRMnRCPI1n31Mm+iXaFbc3DAixEOXtE8Du
        KgZ8upUlQfv0Y5A2ONMdwtSDHxioTHBqX6/UPRmCG3GU2wTiGuiQF65qKsSaqszr
        qlQ14k2dYb9FzjOGCimNjLWuVPRF0a9aAkRAUKShrQDorCKuDMXh0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 82DD7100B23;
        Wed,  5 Jan 2022 17:38:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DF41A100B22;
        Wed,  5 Jan 2022 17:38:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lessley Dennington <lessleydennington@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Bug report - sparse-checkout ignores prefix when run in
 subdirectories
References: <29f0410e-6dfa-2e86-394d-b1fb735e7608@gmail.com>
Date:   Wed, 05 Jan 2022 14:38:43 -0800
In-Reply-To: <29f0410e-6dfa-2e86-394d-b1fb735e7608@gmail.com> (Lessley
        Dennington's message of "Wed, 5 Jan 2022 14:13:22 -0600")
Message-ID: <xmqqsfu1g64s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D8B6548-6E78-11EC-9453-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lessley Dennington <lessleydennington@gmail.com> writes:

> Hello everyone! See the following bug report pertaining to sparse-checkout
> when run outside top-level directories.

In a bug report it is fine, but "outside top-level" usually means
above the top-level of the working tree.  Here, I think you meant
running in a subdirectory of the top-level.

Perhaps something along this line?

 builtin/sparse-checkout.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git c/builtin/sparse-checkout.c w/builtin/sparse-checkout.c
index 45e838d8f8..4e5efbb85e 100644
--- c/builtin/sparse-checkout.c
+++ w/builtin/sparse-checkout.c
@@ -753,6 +753,16 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 	if (!core_sparse_checkout_cone && argc == 0) {
 		argv = default_patterns;
 		argc = default_patterns_nr;
+	} else if (argc && prefix && *prefix) {
+		/* 
+		 * The args are not pathspecs, so unfortunately we
+		 * cannot imitate how cmd_add() uses parse_pathspec().
+		 */
+		int i;
+		int prefix_len = strlen(prefix);
+
+		for (i = 0; i < argc; i++)
+			argv[i] = prefix_path(prefix, prefix_len, argv[i]);
 	}
 
 	return modify_pattern_list(argc, argv, set_opts.use_stdin, REPLACE);
