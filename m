Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2876AC433DB
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 00:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DACDD224D3
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 00:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgLWALL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 19:11:11 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61951 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgLWALK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 19:11:10 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 677D71040CB;
        Tue, 22 Dec 2020 19:10:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C3QMUwdJ4zcwh+xsokdSyXOiRzU=; b=mnbCF+
        +8Molrfe0rcyqGis9vwZUD+ogTOiHZELnnXUUBvdvsg3t6JKU0REfqyH4+ZoypU6
        i41rZwNgi2ApLtpSs/bbjOqHeEBakO+fV1gOhNwFns6FZMPdWzdtLF4p4Gzbauas
        j+WNb7dXz6EasHlr4rsGZFGYMIzSOY+YskbLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DB9bOIs42HR4gsZu+FLyF+5hXwy/AFXH
        5THFxys6h/YzGT1I5ciycuJ1IKzz2lo2BxlTYeAgM3c1ZNux23qeevWbcWsdswF9
        NsL6SGwRbY1OSgThLCjzNnJWjsavn2Qzdn3OYW9P87V0QzqLVViar2oHe9ALbvDc
        YZD+081stws=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 609801040CA;
        Tue, 22 Dec 2020 19:10:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A98721040C3;
        Tue, 22 Dec 2020 19:10:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>, Derrick Stolee <stolee@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] core.abbrev <off|false|no> disables abbreviations
References: <20200901074355.GA4498@dcvr>
        <9c00f29b-45e4-ccdf-6d81-5eabd58c875b@gmail.com>
        <20200901144323.GA14554@dcvr>
        <xmqqbleliq58.fsf@gitster.c.googlers.com>
        <20201222231702.GA17661@dcvr>
        <xmqqk0t9fmq6.fsf@gitster.c.googlers.com>
Date:   Tue, 22 Dec 2020 16:10:23 -0800
In-Reply-To: <xmqqk0t9fmq6.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 22 Dec 2020 15:24:33 -0800")
Message-ID: <xmqq8s9pfkls.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 411BD4DA-44B3-11EB-AED4-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Wong <e@80x24.org>
Date: Tue, 1 Sep 2020 07:43:55 +0000
Subject: [PATCH] core.abbrev=no disables abbreviations

These allows users to write hash-agnostic scripts and configs to
disable abbreviations.  Using "-c core.abbrev=40" will be
insufficient with SHA-256, and "-c core.abbrev=64" won't work
with SHA-1 repos today.

Signed-off-by: Eric Wong <e@80x24.org>
[jc: tweaked implementation, added doc and a test]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/core.txt | 2 ++
 config.c                      | 2 ++
 t/t3200-branch.sh             | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 160aacad84..c04f62a54a 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -625,4 +625,6 @@ core.abbrev::
 	computed based on the approximate number of packed objects
 	in your repository, which hopefully is enough for
 	abbreviated object names to stay unique for some time.
+	If set to "no", no abbreviation is made and the object names
+	are shown in their full length.
 	The minimum length is 4.
diff --git a/config.c b/config.c
index 1137bd73af..4c0cf3a1c1 100644
--- a/config.c
+++ b/config.c
@@ -1217,6 +1217,8 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 			return config_error_nonbool(var);
 		if (!strcasecmp(value, "auto"))
 			default_abbrev = -1;
+		else if (!git_parse_maybe_bool_text(value))
+			default_abbrev = the_hash_algo->hexsz;
 		else {
 			int abbrev = git_config_int(var, value);
 			if (abbrev < minimum_abbrev || abbrev > the_hash_algo->hexsz)
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index a0b832d59e..67db316911 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -305,7 +305,9 @@ test_expect_success 'git branch --list -v with --abbrev' '
 
 	git branch -v --list --no-abbrev t >actual.noabbrev &&
 	git branch -v --list --abbrev=0 t >actual.0abbrev &&
+	git -c core.abbrev=no branch -v --list t >actual.noabbrev-conf &&
 	test_cmp actual.noabbrev actual.0abbrev &&
+	test_cmp actual.noabbrev actual.noabbrev-conf &&
 
 	git branch -v --list --abbrev=36 t >actual.36abbrev &&
 	# how many hexdigits are used?
-- 
2.30.0-rc1-197-gdf840da780

