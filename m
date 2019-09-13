Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59AD31F463
	for <e@80x24.org>; Fri, 13 Sep 2019 19:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388607AbfIMTpZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 15:45:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57839 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388309AbfIMTpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 15:45:25 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2009084CEC;
        Fri, 13 Sep 2019 15:45:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OiAqIrfd6I7rSG1+1ewCCzcs2RI=; b=iGx8aF
        tPp81E0ZNvUClJKSemhpNSL2OCb2VhBUpBbqr5cy3aiJjNrHrfcFWBdl86furAWL
        fXuMuw0LJJXVK4hClVdbx15tOVP9cfIO6WRjlrHHDmdWc1g8IvweEhsky8wEab2N
        r7WS16zC/SRTbp3m3o11HWrlY7sXAH+cOFRcE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IRjVb+/pd6hKUXws1BUx1CeCTld246jG
        ZSXQHoIcJYdXP3YIFapxcny0RWA5/FqdAowfo+8vQWKhDpmlIYNDUaOxeHaIgtYw
        nxqFB3IOuIYAJ7Tp50NC8p/bSZtNml9kJ3h7atfV+URFoBcJmLSb8+JsRcyYBXju
        dgcZbjuZBHg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 15F2484CEB;
        Fri, 13 Sep 2019 15:45:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AE20384CEA;
        Fri, 13 Sep 2019 15:45:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Rafael =?utf-8?Q?Asc?= =?utf-8?Q?ens=C3=A3o?= 
        <rafa.almas@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1b?= =?utf-8?Q?or?= 
        <szeder.dev@gmail.com>, Samuel Lijin <sxlijin@gmail.com>
Subject: Re: [PATCH v3 06/12] dir: if our pathspec might match files under a dir, recurse into it
References: <20190905154735.29784-1-newren@gmail.com>
        <20190912221240.18057-1-newren@gmail.com>
        <20190912221240.18057-7-newren@gmail.com>
Date:   Fri, 13 Sep 2019 12:45:17 -0700
In-Reply-To: <20190912221240.18057-7-newren@gmail.com> (Elijah Newren's
        message of "Thu, 12 Sep 2019 15:12:34 -0700")
Message-ID: <xmqqwoecc75e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0480E326-D65F-11E9-AB65-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> For git clean, if a directory is entirely untracked and the user did not
> specify -d (corresponding to DIR_SHOW_IGNORED_TOO), then we usually do
> not want to remove that directory and thus do not recurse into it.

Makes sense.  To clean named paths in such a directory, we'd need an
option to recurse into it to find them, yet make sure the directory
itself does not get removed.

> However, if the user manually specified specific (or even globbed) paths
> somewhere under that directory to remove, then we need to recurse into
> the directory to make sure we remove the relevant paths under that
> directory as the user requested.

Surely.

> @@ -1939,8 +1939,10 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
>  		/* recurse into subdir if instructed by treat_path */
>  		if ((state == path_recurse) ||
>  			((state == path_untracked) &&
> -			 (dir->flags & DIR_SHOW_IGNORED_TOO) &&
> -			 (get_dtype(cdir.de, istate, path.buf, path.len) == DT_DIR))) {
> +			 (get_dtype(cdir.de, istate, path.buf, path.len) == DT_DIR) &&
> +			 ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
> +			  do_match_pathspec(istate, pathspec, path.buf, path.len,
> +					    baselen, NULL, DO_MATCH_LEADING_PATHSPEC) == MATCHED_RECURSIVELY_LEADING_PATHSPEC))) {
>  			struct untracked_cache_dir *ud;
>  			ud = lookup_untracked(dir->untracked, untracked,
>  					      path.buf + baselen,

OK.

> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> index 12617158db..d83aeb7dc2 100755
> --- a/t/t7300-clean.sh
> +++ b/t/t7300-clean.sh
> @@ -691,7 +691,7 @@ test_expect_failure 'git clean -d skips nested repo containing ignored files' '
>  	test_path_is_file nested-repo-with-ignored-file/file
>  '
>  
> -test_expect_failure 'git clean handles being told what to clean' '
> +test_expect_success 'git clean handles being told what to clean' '
>  	mkdir -p d1 d2 &&
>  	touch d1/ut d2/ut &&
>  	git clean -f */ut &&
> @@ -707,7 +707,7 @@ test_expect_success 'git clean handles being told what to clean, with -d' '
>  	test_path_is_missing d2/ut
>  '
>  
> -test_expect_failure 'git clean works if a glob is passed without -d' '
> +test_expect_success 'git clean works if a glob is passed without -d' '
>  	mkdir -p d1 d2 &&
>  	touch d1/ut d2/ut &&
>  	git clean -f "*ut" &&

Nice.

Thanks.
