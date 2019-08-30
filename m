Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 026721F4B7
	for <e@80x24.org>; Fri, 30 Aug 2019 20:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfH3UPQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 16:15:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53121 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbfH3UPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 16:15:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 44D60165EA2;
        Fri, 30 Aug 2019 16:15:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3dcl9Wdb2+511TPDrJgqhoXWZFU=; b=HpuRWS
        15BwUr/6RN2BEvyJc9ZyyRa81J8qYxjFYGjPSR4+WQ4oitwecvMhDlkVv+x/cfmq
        uWQpEI6mNTMfX/ZDxb6rMCFPMOEsC+UZkwwjy1K1kLss9XXXPK/CmDIFG6mdoaYz
        hUM6AIsmo2HuDfKQZhyFykBIkezaMlFBPft3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o0ZayGQT+lXS5s2dddfN5dT5o0ddSRL4
        qz/Aj42LO7XBwQu9VBLL0O0tMPUo4QR9J69JMhIvjD9mQSe5yaRnSsDuZr8ne8In
        njfmxeO58FZBnorLK9bWGFWVyWpI2UygXuAOu5nhDamKVrPiIIM0cNFw+LEyOqCY
        Shn97UTN6Gc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3AE09165E9F;
        Fri, 30 Aug 2019 16:15:13 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9D8EF165E9E;
        Fri, 30 Aug 2019 16:15:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Wijen <ben@wijen.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Szeder =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v6 1/2] builtin/rebase.c: make sure the active branch isn't moved when autostashing
References: <20190829164757.7301-1-ben@wijen.net>
        <20190830151607.4208-1-ben@wijen.net>
        <20190830151607.4208-2-ben@wijen.net>
Date:   Fri, 30 Aug 2019 13:15:11 -0700
In-Reply-To: <20190830151607.4208-2-ben@wijen.net> (Ben Wijen's message of
        "Fri, 30 Aug 2019 17:16:05 +0200")
Message-ID: <xmqqsgpiwgts.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF63CBFA-CB62-11E9-AA79-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Wijen <ben@wijen.net> writes:

> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 670096c065..abcbfb8f01 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1968,9 +1968,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  				state_dir_path("autostash", &options);
>  			struct child_process stash = CHILD_PROCESS_INIT;
>  			struct object_id oid;
> +			struct object_id head_oid;
> +			if (get_oid("HEAD", &head_oid)) {
> +				die(_("could not determine HEAD revision"));
> +			}

Pointless {} pair around a single statement.

> +
>  			struct commit *head =
> -				lookup_commit_reference(the_repository,
> -							&options.orig_head);
> +				lookup_commit_reference(the_repository, &head_oid);

This introduces decl-after-statement error, doesn't it?

Perhaps like so...

diff --git a/builtin/rebase.c b/builtin/rebase.c
index abcbfb8f01..0a2f9273ee 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1969,12 +1969,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			struct child_process stash = CHILD_PROCESS_INIT;
 			struct object_id oid;
 			struct object_id head_oid;
-			if (get_oid("HEAD", &head_oid)) {
-				die(_("could not determine HEAD revision"));
-			}
+			struct commit *head;
 
-			struct commit *head =
-				lookup_commit_reference(the_repository, &head_oid);
+			if (get_oid("HEAD", &head_oid))
+				die(_("could not determine HEAD revision"));
+			head = lookup_commit_reference(the_repository, &head_oid);
 
 			argv_array_pushl(&stash.args,
 					 "stash", "create", "autostash", NULL);
