Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7EF61FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 17:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932909AbcLSRto (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 12:49:44 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52233 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932358AbcLSRtn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 12:49:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B1E9C5916F;
        Mon, 19 Dec 2016 12:49:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PM8+rjbFwMm8Al9DEgjWye9Pd2w=; b=uHtxYK
        vo2YLxwW5EWvwkU/cOfqL0er23pe7kB9aaJhg38Roq9IWH5eF41CXRP7rQDe0kKA
        f9ELKMc/J7YsAz+ekY2CsJcJ5qoCSSvfibqzySkMdPLI1IoxfP8f7e3uqlGJJtOc
        d3tYGlooQYtXr6ZFEYMyoxoS14I2UU21qH0Oo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=odeqJBVmA565NT0Q+9gqgPAw8+uVZYg/
        IoJINw+3MDDg5J0kZcnRhZFyt3P28lFDM1hJ6a8BMyjuuVwVIczBj/jNnpIQxxaZ
        WtmOy64xzLRQWU1AZ4sWPsohrMDPzRGBmXiditN26HlRilMs3TTuvlfMN2hMdbZ0
        dbRN4jV0yT4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9ED795916E;
        Mon, 19 Dec 2016 12:49:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E8BD85916D;
        Mon, 19 Dec 2016 12:49:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     git@vger.kernel.org, George Vanburgh <george@vanburgh.me>
Subject: Re: [PATCH v2] git-p4: Fix multi-path changelist empty commits
References: <01020159037a8995-2d1da9d4-4a27-4b98-818b-432fc0ad8a52-000000@eu-west-1.amazonses.com>
        <010201590ed6ecaa-740c2532-827e-4f5a-af46-0f58d0722db6-000000@eu-west-1.amazonses.com>
Date:   Mon, 19 Dec 2016 09:49:39 -0800
In-Reply-To: <010201590ed6ecaa-740c2532-827e-4f5a-af46-0f58d0722db6-000000@eu-west-1.amazonses.com>
        (George Vanburgh's message of "Sat, 17 Dec 2016 22:11:23 +0000")
Message-ID: <xmqqy3zbq05o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 846BDB18-C613-11E6-9021-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

George Vanburgh <george@vanburgh.me> writes:

> From: George Vanburgh <gvanburgh@bloomberg.net>
>
> When importing from multiple perforce paths - we may attempt to import
> a changelist that contains files from two (or more) of these depot
> paths. Currently, this results in multiple git commits - one
> containing the changes, and the other(s) as empty commit(s). This
> behavior was introduced in commit 1f90a64
> ("git-p4: reduce number of server queries for fetches", 2015-12-19).
>
> Reproduction Steps:
>
> 1. Have a git repo cloned from a perforce repo using multiple depot
> paths (e.g. //depot/foo and //depot/bar).
> 2. Submit a single change to the perforce repo that makes changes in
> both //depot/foo and //depot/bar.
> 3. Run "git p4 sync" to sync the change from #2.
>
> Change is synced as multiple commits, one for each depot path that was
> affected.
>
> Using a set, instead of a list inside p4ChangesForPaths() ensures that
> each changelist is unique to the returned list, and therefore only a
> single commit is generated for each changelist.
>
> Reported-by: James Farwell <jfarwell@vmware.com>
> Signed-off-by: George Vanburgh <gvanburgh@bloomberg.net>
> ---

Thanks, George.  Luke, can I add your "Reviewed-by:" here?

>  git-p4.py               |  4 ++--
>  t/t9800-git-p4-basic.sh | 22 +++++++++++++++++++++-
>  2 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index fd5ca52..6307bc8 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -822,7 +822,7 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
>                  die("cannot use --changes-block-size with non-numeric revisions")
>              block_size = None
>  
> -    changes = []
> +    changes = set()
>  
>      # Retrieve changes a block at a time, to prevent running
>      # into a MaxResults/MaxScanRows error from the server.
> @@ -841,7 +841,7 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
>  
>          # Insert changes in chronological order
>          for line in reversed(p4_read_pipe_lines(cmd)):
> -            changes.append(int(line.split(" ")[1]))
> +            changes.add(int(line.split(" ")[1]))
>  
>          if not block_size:
>              break
> diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
> index 0730f18..4d93522 100755
> --- a/t/t9800-git-p4-basic.sh
> +++ b/t/t9800-git-p4-basic.sh
> @@ -131,6 +131,26 @@ test_expect_success 'clone two dirs, @all, conflicting files' '
>  	)
>  '
>  
> +test_expect_success 'clone two dirs, each edited by submit, single git commit' '
> +	(
> +		cd "$cli" &&
> +		echo sub1/f4 >sub1/f4 &&
> +		p4 add sub1/f4 &&
> +		echo sub2/f4 >sub2/f4 &&
> +		p4 add sub2/f4 &&
> +		p4 submit -d "sub1/f4 and sub2/f4"
> +	) &&
> +	git p4 clone --dest="$git" //depot/sub1@all //depot/sub2@all &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		git ls-files >lines &&
> +		test_line_count = 4 lines &&
> +		git log --oneline p4/master >lines &&
> +		test_line_count = 5 lines
> +	)
> +'
> +
>  revision_ranges="2000/01/01,#head \
>  		 1,2080/01/01 \
>  		 2000/01/01,2080/01/01 \
> @@ -147,7 +167,7 @@ test_expect_success 'clone using non-numeric revision ranges' '
>  		(
>  			cd "$git" &&
>  			git ls-files >lines &&
> -			test_line_count = 6 lines
> +			test_line_count = 8 lines
>  		)
>  	done
>  '
>
> --
> https://github.com/git/git/pull/311
