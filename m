Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D1AC1FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 20:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbcFUUmE (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 16:42:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51609 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750998AbcFUUkl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 16:40:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 42DB5270D2;
	Tue, 21 Jun 2016 16:35:03 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MKjQKDrjsurZqOED7ZuNfM9WwlI=; b=kLHK6d
	NuUgPA4sNT2FJuGcZ3IJ3aiBsDvtqBIxLmtw5Wj4ADGzevj26vk0fsK9rX1xYa0x
	GYltKIYYsbIxAPHuiy9LbpMGIktcOZ+efEnwSx5XL3h8CenS9iTUeXUGxywYPkuB
	gsi74jsdVkrYm1PjDuE2v3wVjrchnIUdJrQMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DLo8kWXn/h4MSfW6df+QtZ7FHWwH9MpU
	NGTiEI6+sNCzh6yXIbrYUujUZuIGoFcpVjd10sZHWDiLBSX6yv+uZkrOF4p6FZ/s
	ggWwcM9t068teC3Eb6MX3dxpmIXF94RPU3gQYZ+4+fwxuG24EY3TpPxFi08SPlZx
	g26vC1C4Usk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 39A36270D1;
	Tue, 21 Jun 2016 16:35:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A22E0270D0;
	Tue, 21 Jun 2016 16:35:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v2] Make find_commit_subject() more robust
References: <34ef85eb4e2aef0b342ef5d3bce9e468c8339486.1466255489.git.johannes.schindelin@gmx.de>
	<901b24554eb4d0381d74ceb31f7bd08709d5eb25.1466512959.git.johannes.schindelin@gmx.de>
Date:	Tue, 21 Jun 2016 13:34:59 -0700
In-Reply-To: <901b24554eb4d0381d74ceb31f7bd08709d5eb25.1466512959.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Tue, 21 Jun 2016 14:43:22 +0200
	(CEST)")
Message-ID: <xmqq60t2p9fw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A17323E0-37EF-11E6-9591-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Just like the pretty printing machinery, we should simply ignore empty
> lines at the beginning of the commit messages.

Thanks.

>
> This discrepancy was noticed when an early version of the rebase--helper
> produced commit objects with more than one empty line between the header
> and the commit message.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Published-As: https://github.com/dscho/git/releases/tag/leading-empty-lines-v2
>
> 	git blame seemed to be the most accessible user of
> 	find_commit_subject()...
>
>  commit.c                 |  2 ++
>  t/t8008-blame-formats.sh | 17 +++++++++++++++++
>  2 files changed, 19 insertions(+)
> Interdiff vs v1:
>
>  diff --git a/t/t8008-blame-formats.sh b/t/t8008-blame-formats.sh
>  index 29f84a6..03bd313 100755
>  --- a/t/t8008-blame-formats.sh
>  +++ b/t/t8008-blame-formats.sh
>  @@ -87,4 +87,21 @@ test_expect_success 'blame --line-porcelain output' '
>   	test_cmp expect actual
>   '
>   
>  +test_expect_success '--porcelain detects first non-empty line as subject' '
>  +	(
>  +		GIT_INDEX_FILE=.git/tmp-index &&
>  +		export GIT_INDEX_FILE &&
>  +		echo "This is it" >single-file &&
>  +		git add single-file &&
>  +		tree=$(git write-tree) &&
>  +		commit=$(printf "%s\n%s\n%s\n\n\noneline\n\nbody\n" \
>  +			"tree $tree" \
>  +			"author A <a@b.c> 123456789 +0000" \
>  +			"committer C <c@d.e> 123456789 +0000" |
>  +		git hash-object -w -t commit --stdin) &&
>  +		git blame --porcelain $commit -- single-file >output &&
>  +		grep "^summary oneline$" output
>  +	)
>  +'
>  +
>   test_done
>
>
> diff --git a/commit.c b/commit.c
> index 3f4f371..7b00989 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -415,6 +415,8 @@ int find_commit_subject(const char *commit_buffer, const char **subject)
>  		p++;
>  	if (*p) {
>  		p += 2;
> +		while (*p == '\n')
> +			p++;
>  		for (eol = p; *eol && *eol != '\n'; eol++)
>  			; /* do nothing */
>  	} else
> diff --git a/t/t8008-blame-formats.sh b/t/t8008-blame-formats.sh
> index 29f84a6..03bd313 100755
> --- a/t/t8008-blame-formats.sh
> +++ b/t/t8008-blame-formats.sh
> @@ -87,4 +87,21 @@ test_expect_success 'blame --line-porcelain output' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success '--porcelain detects first non-empty line as subject' '
> +	(
> +		GIT_INDEX_FILE=.git/tmp-index &&
> +		export GIT_INDEX_FILE &&
> +		echo "This is it" >single-file &&
> +		git add single-file &&
> +		tree=$(git write-tree) &&
> +		commit=$(printf "%s\n%s\n%s\n\n\noneline\n\nbody\n" \
> +			"tree $tree" \
> +			"author A <a@b.c> 123456789 +0000" \
> +			"committer C <c@d.e> 123456789 +0000" |
> +		git hash-object -w -t commit --stdin) &&
> +		git blame --porcelain $commit -- single-file >output &&
> +		grep "^summary oneline$" output
> +	)
> +'
> +
>  test_done
