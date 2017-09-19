Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B6BE20281
	for <e@80x24.org>; Tue, 19 Sep 2017 03:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbdISD1W (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 23:27:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62174 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750897AbdISD1V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 23:27:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C1B3197CA2;
        Mon, 18 Sep 2017 23:27:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7m07ldaXL5ZCcym/d2FAOD4v3e4=; b=Q1UcD+
        B8XDlXpD8oSZVfQuCubLryLFL2lWKU6W0o8ib2JWJqbAMRXv/5GTZFYLWdU7KT+A
        xnOIZ++kWSoh40BGqiaho8DxpMCJ6FV7ZXtjhgW4yWBZqOU5JNIZ2aXQXqHQJg1K
        S+SM6Z791jBSYoxv7Iyf3gCCP0InhHiBFZ1YY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=thW7KcPQUJWdicDBc6c4mpPnSvYkif5q
        u5fWmI9+E4XgwRuuLg5BTQlUAjPDdnEbK2YoAgpzunvhPe5go/5ZeaEQlGyIaPxF
        AcuKTNNaEtkH5ZkME6+usSAY+ARsp38hIpdlART8h9zGDIGL4dgSj84z1coLHoa1
        FhyrpCmUNIM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BACD797CA1;
        Mon, 18 Sep 2017 23:27:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1ADDF97C9F;
        Mon, 18 Sep 2017 23:27:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jameson Miller <jameson.miller81@gmail.com>
Cc:     bmwill@google.com, git@vger.kernel.org, jamill@microsoft.com,
        peff@peff.net, sxlijin@gmail.com
Subject: Re: [PATCH v2] Improve performance of git status --ignored
References: <20170810184936.239542-1-jamill@microsoft.com>
        <1505755473-6720-1-git-send-email-jamill@microsoft.com>
        <1505755473-6720-2-git-send-email-jamill@microsoft.com>
Date:   Tue, 19 Sep 2017 12:27:18 +0900
In-Reply-To: <1505755473-6720-2-git-send-email-jamill@microsoft.com> (Jameson
        Miller's message of "Mon, 18 Sep 2017 13:24:33 -0400")
Message-ID: <xmqqd16nqsfd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 71A923F6-9CEA-11E7-A907-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jameson Miller <jameson.miller81@gmail.com> writes:

> Improve the performance of the directory listing logic when it wants to list
> non-empty ignored directories. In order to show non-empty ignored directories,
> the existing logic will recursively iterate through all contents of an ignored
> directory. This change introduces the optimization to stop iterating through
> the contents once it finds the first file.

Wow, such an obviously correct optimization.  Very nicely explained, too.

> This can have a significant
> improvement in 'git status --ignored' performance in repositories with a large
> number of files in ignored directories.
>
> For an example of the performance difference on an example repository with
> 196,000 files in 400 ignored directories:
>
> | Command                    |  Time (s) |
> | -------------------------- | --------- |
> | git status                 |   1.2     |
> | git status --ignored (old) |   3.9     |
> | git status --ignored (new) |   1.4     |
>
> Signed-off-by: Jameson Miller <jamill@microsoft.com>
> ---

I wish all the contributions I have to accept are as nicely done as
this one ;-)

Thanks.

>  dir.c | 47 +++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 41 insertions(+), 6 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 1c55dc3..1d17b80 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -49,7 +49,7 @@ struct cached_dir {
>  static enum path_treatment read_directory_recursive(struct dir_struct *dir,
>  	struct index_state *istate, const char *path, int len,
>  	struct untracked_cache_dir *untracked,
> -	int check_only, const struct pathspec *pathspec);
> +	int check_only, int stop_at_first_file, const struct pathspec *pathspec);

We might want to make check_only and stop_at_first_file into a
single "unsigned flags" used as a collection of bits, but we can
wait until we start feeling the urge to add the third boolean
parameter to this function (at which point I'd probably demand a
preliminary clean-up to merge these two into a single flags word
before adding the third one as a new bit in that word).

> @@ -1404,8 +1404,13 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>  
>  	untracked = lookup_untracked(dir->untracked, untracked,
>  				     dirname + baselen, len - baselen);
> +
> +	/*
> +	 * If this is an excluded directory, then we only need to check if
> +	 * the directory contains any files.
> +	 */
>  	return read_directory_recursive(dir, istate, dirname, len,
> -					untracked, 1, pathspec);
> +					untracked, 1, exclude, pathspec);

Nicely explained in the in-code comment.

I'd assume that you want your microsoft e-mail address used on the
signed-off-by line appear as the author, so I'll tweak this a bit to
make it so (otherwise, your 81@gmail.com would become the author).

Thanks.
