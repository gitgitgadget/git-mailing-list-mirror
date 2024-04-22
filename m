Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA32219E0
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 19:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713812470; cv=none; b=IJLZPVb3JJ8LzQlG0QH//4eN5tHwQcoJKtXXlYWNvvljAjZ0Yp9qyZngKa2wdDdeMWCpkHo1nVRKWU+Man6/K6igbk0xALbqTeMftOhp2twKgqQzigxYey26D1VHhrc4r4DFM2cEcSCYTsYA5D3mmlIwsy5YiJDhz3nJQYlDiF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713812470; c=relaxed/simple;
	bh=hpblE9gx8YPRNZtU0qoqGI48eHq+0kjUhO3EkYBEymk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZkHMEj5qWphaodWYBM3QbQnbgyzDKWqQdrNPLexmb5wC/4D2gZkk7yH8/r0PRg1Nve+tUs0o3nbMzS+rcdJRDMcGZbZMmiCbAohnvvqmZuq21IlfLylYfw1mZHARYhI6gfS0if1hKAKHlRGyM/2dKGwJuYyIU9hTOctpr2c7cUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GBL1hi42; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GBL1hi42"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7DFB62A87B;
	Mon, 22 Apr 2024 15:01:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hpblE9gx8YPRNZtU0qoqGI48eHq+0kjUhO3EkY
	BEymk=; b=GBL1hi42zo7TvI30lLAgpz2++RKUCvBs97jQu3oiCOekeRwTZDatxt
	7m5l+P4oUeXq2kRPBcWBf3GPXzunwJG3LIDgcvaV4YaWUIAHfpU4OpRXZJiuEWoR
	JPO03OJiMvF5aZE7Odu3LidHDqQpXsjSZI75r0kCuJBh2ssJfuB2o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 75A482A87A;
	Mon, 22 Apr 2024 15:01:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5D9682A876;
	Mon, 22 Apr 2024 15:00:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  "Randall S. Becker"
 <randall.becker@nexbridge.ca>,  Adam Johnson <me@adamj.eu>
Subject: Re: [PATCH] stash: fix "--staged" with binary files
In-Reply-To: <pull.1722.git.1713781694490.gitgitgadget@gmail.com> (Adam
	Johnson via GitGitGadget's message of "Mon, 22 Apr 2024 10:28:14
	+0000")
References: <pull.1722.git.1713781694490.gitgitgadget@gmail.com>
Date: Mon, 22 Apr 2024 12:00:56 -0700
Message-ID: <xmqqsezdw7br.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A7730F46-00DA-11EF-A671-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Adam Johnson <me@adamj.eu>
>
> "git stash --staged" would crash with binary files, after saving the stash.

"would crash with" -> "errors out when given", probably.

We would be better off reserving the word "crash" to refer to an
uncontrolled exit with non-zero status of the command, possibly
killed via system signals like SEGV and SIGBUS.  In this case, I
suspect that you would get an "error:" from underlying apply
machinery, which leads the caller to exit with a non-zero status
due to an error.

> This behaviour dates back to the addition of the feature in 41a28eb6c1
> (stash: implement '--staged' option for 'push' and 'save', 2021-10-18).

When you find the commit that introduced the problem you are fixing,
especially when the author of the commit is still active on the
mailing list, it would be nice to give a carbon-copy of the message
to them.

> Adding the "--binary" option of "diff-tree" fixes this. The "diff-tree" call
> in stash_patch() also omits "--binary", but that is fine since binary files
> cannot be selected interactively.

I love seeing an explanation like this in a proposed commit log
message.  It is concise but very clear at the same time.  It is so
clearly written that anybody who is reasonably familiar with the
code does not even need to look at the patch text itself to see what
the actual fix would look like.

Very nicely explained.

> Helped-By: Jeff King <peff@peff.net>
> Helped-By: Randall S. Becker <randall.becker@nexbridge.ca>
> Signed-off-by: Adam Johnson <me@adamj.eu>
> ---

Will queue.

Thanks.

> diff --git a/builtin/stash.c b/builtin/stash.c
> index 062be1fbc07..7751bca868e 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -1205,8 +1205,8 @@ static int stash_staged(struct stash_info *info, struct strbuf *out_patch,
>  	}
>  
>  	cp_diff_tree.git_cmd = 1;
> -	strvec_pushl(&cp_diff_tree.args, "diff-tree", "-p", "-U1", "HEAD",
> -		     oid_to_hex(&info->w_tree), "--", NULL);
> +	strvec_pushl(&cp_diff_tree.args, "diff-tree", "-p", "--binary",
> +		     "-U1", "HEAD", oid_to_hex(&info->w_tree), "--", NULL);
>  	if (pipe_command(&cp_diff_tree, NULL, 0, out_patch, 0, NULL, 0)) {
>  		ret = -1;
>  		goto done;
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 00db82fb245..a7f71f8126f 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -393,6 +393,15 @@ test_expect_success 'stash --staged' '
>  	test bar,bar4 = $(cat file),$(cat file2)
>  '
>  
> +test_expect_success 'stash --staged with binary file' '
> +	printf "\0" >file &&
> +	git add file &&
> +	git stash --staged &&
> +	git stash pop &&
> +	printf "\0" >expect &&
> +	test_cmp expect file
> +'

