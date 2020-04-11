Return-Path: <SRS0=KYeX=53=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157A1C2BA19
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 21:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39A420CC7
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 21:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Oh0cBPkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgDKV51 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Apr 2020 17:57:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50637 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgDKV51 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Apr 2020 17:57:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0680DB26BA;
        Sat, 11 Apr 2020 17:57:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/jFCLzh9IJ9DYjbxijhK3MvKVJg=; b=Oh0cBP
        kgckZHwSK2+8i5j8/pWwH0pfRrazuAG7NraIukBB984OZ86YpASdjjC+fqdLGy2z
        ERiXwc718RwMdHnzDnPBo9Sd9gboBBqrD48WxFf0Pge1kQpKWvXrvGzjvtnbeyP6
        TTB1CWWU7NqSdgcbABkcWjNNc24gNcIBVoEuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LNJ5bh8dbdqdkCaqfMx80v1gKe6T2iVm
        PMjCPTABf0FO4Z91vZuPtcgkezrTS0cs/+K5r4x5Jq4Qhr3s64YorAzEKXmY5PFC
        4jZD9/DXYY5Rk7okcU11FvKfIOK5BjJl2QQUX/axuUMG8+1lzQ1tJ1jfzO6rQTAo
        +USwCYuvRAk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F270FB26B7;
        Sat, 11 Apr 2020 17:57:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 45158B26B6;
        Sat, 11 Apr 2020 17:57:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, jnareb@gmail.com,
        garimasigit@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/3] commit: write commit-graph with bloom filters
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
        <bb5ce39d0283f14095d87dd0645e641ae799f16c.1586566981.git.gitgitgadget@gmail.com>
Date:   Sat, 11 Apr 2020 14:57:18 -0700
In-Reply-To: <bb5ce39d0283f14095d87dd0645e641ae799f16c.1586566981.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Sat, 11 Apr 2020
        01:03:00 +0000")
Message-ID: <xmqqa73hheip.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6AB11B8A-7C3F-11EA-B279-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/commit.c b/builtin/commit.c
> index d3e7781e658..d2fdfdc4363 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1701,7 +1701,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		      "not exceeded, and then \"git restore --staged :/\" to recover."));
>  
>  	if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0) &&
> -	    write_commit_graph_reachable(the_repository->objects->odb, 0, NULL))
> +	    write_commit_graph_reachable(the_repository->objects->odb,
> +					 git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0) ? COMMIT_GRAPH_WRITE_BLOOM_FILTERS : 0,
> +					 NULL))

Yuck.  That is doubly mouthful.

I wonder how much value we are getting by having this call here in
the first place.  This function being cmd_commit(), by definition we
won't be updating the graph file unless the test script does "git
commit".  We won't update the graph file upon "git rebase", "git
merge", "git pull", "git fetch", etc., so it is not like with this
hack, the test coverage for various traversal using the graph file
would magically be perfect.  We'd still need an explicit call to
"commit-graph write" at strategic places in the test scripts, no?

How are we testing with and without bitmaps, and do we have a kludge
like this one for the feature, or do we use a different mechanism
to help writing tests easier to gain better coverage?

In any case, I can see why we want a separate knob specific to the
CHANGED_PATHS until the path filter part becomes as stable as the
rest of the graph file, but after some time, we should remove that
knob, and at that point, we always use the path filter whenever we
use commit-graph, so that we won't have to suffer from the ugliness.

Wait.  I wonder if we can tweak the arrangement a bit so that this
layer does not need to know any more than GIT_TEST_COMMIT_GRAPH?

For example, in commit-graph.c::write_commit_graph(), can we test
the CHANGED_PATHS environment variable and flip the .changed_paths
bit, no matter what the 'flags' argument to the function says?

Thanks.

>  		return 1;
>  
>  	repo_rerere(the_repository, 0);
