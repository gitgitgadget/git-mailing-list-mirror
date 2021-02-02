Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC73FC433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 21:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A48D364F64
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 21:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhBBVmV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 16:42:21 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61556 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbhBBVmD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 16:42:03 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C70495F56;
        Tue,  2 Feb 2021 16:41:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nhqlptz9Idxwxn3ZpM8xhiU64hs=; b=Qvrh7o
        btR5Uskl5IYQs+2Rx6XlR8nV1a9ZSuf9Vf8WkbQVE1CBmuXMMAVJgVOjm4/kJhnL
        RBnhGw6ZBoXNbLkaotUA9AHNN1/PnZXKeVo4buk4xDunJotvI10sxVnSpQPpOFX8
        8s35XCBZsP12LBkEq350fpbGHZcwSsMvkTQog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jaGoGOvncONRibznc9d6Zc87CHrvmH3d
        nr045u7et49cxnaaPdBM65hEnfSD2rqwDkxi/9pNAEcS08KpQIYfJ1ZkKXtrAAKS
        NHPZ+vz/kYyVWjq4DXQOhEu820e04GcoTmJR5/E1k+dbNZ1W05nOUQiVVEUocAJl
        3RVM/SZvFP0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 344BB95F55;
        Tue,  2 Feb 2021 16:41:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 85A8295F54;
        Tue,  2 Feb 2021 16:41:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/9] t3905: move all commands into test cases
References: <cover.1612258145.git.liu.denton@gmail.com>
        <519840b1a280fd1a47c028ba9de776727ed77608.1612258145.git.liu.denton@gmail.com>
Date:   Tue, 02 Feb 2021 13:41:17 -0800
In-Reply-To: <519840b1a280fd1a47c028ba9de776727ed77608.1612258145.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 2 Feb 2021 01:33:20 -0800")
Message-ID: <xmqqft2ef8qq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6223DA30-659F-11EB-9083-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

>  test_expect_success 'stash save --include-untracked stashed the untracked files' '
> +	tracked=$(git rev-parse --short $(echo 1 | git hash-object --stdin)) &&
> +	untracked=$(git rev-parse --short $(echo untracked | git hash-object --stdin)) &&

Not a new issue introduced by this patch, but

 * these will fail if blobs that record "1\n" and "untracked\n" do
   not exist in the repository already, because the hash-object
   command lacks the "-w" option.

 * the reason why they do not fail is because there are these blobs
   already; grabbing them using extended SHA-1 expression may be
   simpler to read, e.g.

	tracked=$(git rev-parse --short HEAD:file)

 * even if it is not trivial to get to such a blob object, it
   probably is easier to read the test if a file that has the
   desired contents in it is used, not an "echo", e.g.

	untracked=$(git rev-parse --short $(git hash-object -w untracked/untracked))

We may want to clean these up someday, but it does not have to be
part of this topic (#leftoverbits).

> +	cat >expect.diff <<-EOF &&
> +	diff --git a/HEAD b/HEAD
> +	new file mode 100644
> +	index 0000000..$tracked
> +	--- /dev/null
> +	+++ b/HEAD
> +	@@ -0,0 +1 @@
> +	+1
> +	diff --git a/file2 b/file2
> +	new file mode 100644
> +	index 0000000..$tracked
> +	--- /dev/null
> +	+++ b/file2
> +	@@ -0,0 +1 @@
> +	+1
> +	diff --git a/untracked/untracked b/untracked/untracked
> +	new file mode 100644
> +	index 0000000..$untracked
> +	--- /dev/null
> +	+++ b/untracked/untracked
> +	@@ -0,0 +1 @@
> +	+untracked
> +	EOF

