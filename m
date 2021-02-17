Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E00C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 02:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5967E64E0F
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 02:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhBQCbw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 21:31:52 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60116 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhBQCbv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 21:31:51 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2642211C98B;
        Tue, 16 Feb 2021 21:31:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0tBOMsj5P4E1h+ycephRQbK3ZVs=; b=wYuxJ8
        NCm+EyeLfMbUJ/WmGWRbptJTZXhPN6OXSW4J/TnYGpwwLyyribSSIELslSgdgcOg
        k1cEE4UVPr1T1/HrRidUdNeAcz5RFNTVfMI2MCsNjc0FuFvOMxNMqA7W0fJOkbdi
        2Ew5HgqqWwgSjT/dGG2hfvBPu2dxwKNC4fz+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j1i/h1C1H8lfb+KBrkja/OmW3k2XKaUn
        cI3tk3GVCFSNTaDFi0INx+zTQ/1FHxZtmnUYPYxJWkCT9/7qaRN1GGxK6sv5nXn0
        /FJIqlvLquOH/RwLfp5HFzvSwwzOzoBk0TPdaVaPiJnISLxBKdMNM6Z6gf4zM/mX
        Oi60zVnQY8E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1E52E11C98A;
        Tue, 16 Feb 2021 21:31:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 62C2211C989;
        Tue, 16 Feb 2021 21:31:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/2] stash show: teach --include-untracked and
 --only-untracked
References: <cover.1612855690.git.liu.denton@gmail.com>
        <cover.1613459474.git.liu.denton@gmail.com>
        <85b81f2f06bd1b40ee2de220cc84dd74b425daf3.1613459475.git.liu.denton@gmail.com>
Date:   Tue, 16 Feb 2021 18:31:03 -0800
In-Reply-To: <85b81f2f06bd1b40ee2de220cc84dd74b425daf3.1613459475.git.liu.denton@gmail.com>
        (Denton Liu's message of "Mon, 15 Feb 2021 23:11:56 -0800")
Message-ID: <xmqqeehfmnmg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F4BC0D0-70C8-11EB-9A3C-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
> index b26a97aef4..978bc97baf 100755
> --- a/t/t3905-stash-include-untracked.sh
> +++ b/t/t3905-stash-include-untracked.sh
> @@ -297,4 +297,88 @@ test_expect_success 'stash -u with globs' '
>  	test_path_is_missing untracked.txt
>  '
>  
> +test_expect_success 'stash show --include-untracked shows untracked files' '
> + ...
> +	cat >expect <<-EOF &&
> +	diff --git a/tracked b/tracked
> +	new file mode 100644
> +	index 0000000..e69de29
> +	diff --git a/untracked b/untracked
> +	new file mode 100644
> +	index 0000000..e69de29
> +	EOF

We'd need this on top.

Thanks.

----- >8 ---------- >8 ---------- >8 ---------- >8 -----
Subject: [PATCH] SQUASH???

 t/t3905-stash-include-untracked.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index 8bcd4c5ca8..a706ab80a5 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -303,6 +303,7 @@ test_expect_success 'stash show --include-untracked shows untracked files' '
 	>untracked &&
 	>tracked &&
 	git add tracked &&
+	empty_blob_oid=$(git rev-parse --short :tracked) &&
 	git stash -u &&
 
 	cat >expect <<-EOF &&
@@ -324,10 +325,10 @@ test_expect_success 'stash show --include-untracked shows untracked files' '
 	cat >expect <<-EOF &&
 	diff --git a/tracked b/tracked
 	new file mode 100644
-	index 0000000..e69de29
+	index 0000000..$empty_blob_oid
 	diff --git a/untracked b/untracked
 	new file mode 100644
-	index 0000000..e69de29
+	index 0000000..$empty_blob_oid
 	EOF
 	git stash show -p --include-untracked >actual &&
 	test_cmp expect actual &&
@@ -341,6 +342,7 @@ test_expect_success 'stash show --only-untracked only shows untracked files' '
 	>untracked &&
 	>tracked &&
 	git add tracked &&
+	empty_blob_oid=$(git rev-parse --short :tracked) &&
 	git stash -u &&
 
 	cat >expect <<-EOF &&
@@ -357,7 +359,7 @@ test_expect_success 'stash show --only-untracked only shows untracked files' '
 	cat >expect <<-EOF &&
 	diff --git a/untracked b/untracked
 	new file mode 100644
-	index 0000000..e69de29
+	index 0000000..$empty_blob_oid
 	EOF
 	git stash show -p --only-untracked >actual &&
 	test_cmp expect actual &&
-- 
2.30.1-684-g310d03ec1a

