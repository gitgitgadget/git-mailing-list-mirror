Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E43E211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 05:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeK2Q4B (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 11:56:01 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64070 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbeK2Q4B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 11:56:01 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F0C35106149;
        Thu, 29 Nov 2018 00:51:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vx2VbqQ9tMs86++7Z0VVjsc0CWY=; b=aPIki6
        zg1b4YQkpSXLjfLn7Xa6PQeEJRapVcaSOkem5GRqrdDKzHbtifAlgirTch5w+nUn
        xncA1p10S0SX34dv9y3ob+Gay8v9nn63LWDeiMLXsBZEcxGpLkfUU0VYAwS9zMnC
        k0VFOn63E8/t2gmmI3cTgbnZbEk9CZXzpNrXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iiGr+RZlTCUX+J2CmSYJUeG91VWoVJsb
        ib1HrRGnrWSQQJw8gAz3WL7WB8xq06PaXz4j9AQWn+QWeu8VEv9IkUg32Z+YM4Uf
        d0szc9z7SXhRunduZRUH+hSiVR+DITfE5Am6I9yT3kVdcaDFT9GaEAoY7YT2Cf5A
        pa/5ctt7uC8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E74D9106148;
        Thu, 29 Nov 2018 00:51:49 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5AD3A106146;
        Thu, 29 Nov 2018 00:51:49 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] rebase --stat: fix when rebasing to an unrelated history
References: <pull.88.git.gitgitgadget@gmail.com>
        <680385e4bd5c34a5fcf9651a776c52db61557652.1543317195.git.gitgitgadget@gmail.com>
Date:   Thu, 29 Nov 2018 14:51:48 +0900
In-Reply-To: <680385e4bd5c34a5fcf9651a776c52db61557652.1543317195.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 27 Nov 2018
        03:13:19 -0800 (PST)")
Message-ID: <xmqqlg5cph1n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD0BE202-F39A-11E8-BAE7-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> The built-in version of the `git rebase` command blindly translated that
> shell script code, assuming that there is no need to test whether there
> *was* a merge base, and due to its better error checking, exited with a
> fatal error (because it tried to read the object with hash 00000000...
> as a tree).

And the scripted version produced a wrong result because it did not
check the lack of merge base and fed an empty string (presumably, as
that is what you would get from mb=$(merge-base A B) when A and B
are unrelated) to later steps?  If that is the case, then it *is* a
very significant thing to record here.  As it was not merely "failed
to stop due to lack of error checking", but a lot worse.  It was
producing a wrong result.

A more faithful reimplementation would not have exited with fatal
error, but would have produced the same wrong result, so "a better
error checking caused the reimplementation die where the original
did not die" may be correct but is much less important than the fact
that "the logic used in the original to produce diffstat forgot that
there may not be a merge base and would not have worked correctly in
such a case, and that is what we are correcting" is more important.

Please descibe the issue as such, if that is the case (I cannot read
from the description in the proposed log message if that is the
case---but I came to the conclusion that it is what you wanted to
fix reading the code).

>  		if (options.flags & REBASE_VERBOSE)
>  			printf(_("Changes from %s to %s:\n"),
> -				oid_to_hex(&merge_base),
> +				is_null_oid(&merge_base) ?
> +				"(empty)" : oid_to_hex(&merge_base),

I am not sure (empty) is a good idea for two reasons.  It is going
to be inserted into an translated string without translation.  Also
it is too similar to the fallback string used by some printf
implementations when NULL was given to %s by mistake.

If there weren't i18n issues, I would suggest to use "empty merge
base" or "empty tree" instead, but the old one would have shown
0{40}, so perhaps empty_tree_oid_hex() is a good substitute?

> @@ -1494,8 +1495,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
>  		opts.detect_rename = DIFF_DETECT_RENAME;
>  		diff_setup_done(&opts);
> -		diff_tree_oid(&merge_base, &options.onto->object.oid,
> -			      "", &opts);
> +		diff_tree_oid(is_null_oid(&merge_base) ?
> +			      the_hash_algo->empty_tree : &merge_base,
> +			      &options.onto->object.oid, "", &opts);

The original would have run "git diff '' $onto", and died with an
error message, so both the original and the reimplementation were
failing.  Just in different ways ;-)

> diff --git a/git-legacy-rebase.sh b/git-legacy-rebase.sh
> index b97ffdc9dd..be3b241676 100755
> --- a/git-legacy-rebase.sh
> +++ b/git-legacy-rebase.sh
> @@ -718,10 +718,12 @@ if test -n "$diffstat"
>  then
>  	if test -n "$verbose"
>  	then
> -		echo "$(eval_gettext "Changes from \$mb to \$onto:")"
> +		mb_display="${mb:-(empty)}"
> +		echo "$(eval_gettext "Changes from \$mb_display to \$onto:")"
>  	fi
> +	mb_tree="${mb:-$(git hash-object -t tree /dev/null)}"
>  	# We want color (if set), but no pager
> -	GIT_PAGER='' git diff --stat --summary "$mb" "$onto"
> +	GIT_PAGER='' git diff --stat --summary "$mb_tree" "$onto"

Code fix for diff-tree invocation, both in the builtin/ version and
this one, looks correct.
