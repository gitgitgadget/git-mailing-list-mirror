Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAAC41F859
	for <e@80x24.org>; Fri, 19 Aug 2016 20:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754067AbcHSUGx (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 16:06:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55535 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752435AbcHSUGw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 16:06:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6145B37C10;
        Fri, 19 Aug 2016 16:06:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cH+q4wb5ehuPCfaSI6+GHpnt8EE=; b=FoAImk
        fAJESBeWqfH9crZEgGp+5chgPikQNBj3z+6t1hXX/crzD/FnGTk36Z/O0ORvtQOf
        paB2yrjoWRShhZaXT905yyluvg9zg1mTnKzIYX2DZmUm/xftajUWD+onQd0R+18f
        Mf8cq5OZhfWL5lcawq3TYA7I1JlgGd3L6+pHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JJz5Q1vSwC4nguRZH4n3wchrz1l4Bm4+
        JBJDOIfk0EvWDmJb3zC+Pk4R2UmtE3qmZDkjKzXCujlKl8aPv+egkRfN3A1Yd06A
        sbaTFNGMvBTOH60gC9dDzvkzSgFT/ElHUiNUYzronxejooTLyZsa3y2zsyV8UASR
        jnwOnzNNrM4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 58BDB37C0F;
        Fri, 19 Aug 2016 16:06:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BE0C337C0E;
        Fri, 19 Aug 2016 16:06:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v8 4/8] submodule: allow add_submodule_odb to work even if path is not checked out
References: <20160819000031.24854-1-jacob.e.keller@intel.com>
        <20160819000031.24854-5-jacob.e.keller@intel.com>
Date:   Fri, 19 Aug 2016 13:06:48 -0700
In-Reply-To: <20160819000031.24854-5-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Thu, 18 Aug 2016 17:00:27 -0700")
Message-ID: <xmqqvayw1q1z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 776AC99A-6648-11E6-9C97-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> diff --git a/path.c b/path.c
> index 17551c483476..0cb30123e988 100644
> --- a/path.c
> +++ b/path.c
> @@ -482,6 +482,11 @@ static void do_submodule_path(struct strbuf *buf, const char *path,
>  		strbuf_reset(buf);
>  		strbuf_addstr(buf, git_dir);
>  	}
> +	if (!is_git_directory(buf->buf)) {
> +		strbuf_reset(buf);
> +		strbuf_git_path(buf, "%s/%s", "modules", path);
> +	}
> +
>  	strbuf_addch(buf, '/');
>  	strbuf_addbuf(&git_submodule_dir, buf);

So, given submodule at $path, so far we have tried $path/.git and
would have been happy if it was already a directory (i.e. an
embedded repository in place), would have been happy if it was
pointing at elsewhere (presumably at .git/modules/$name) that is a
directory, and this is a fallback that covers the case where $path
in the working tree of the superproject is missing.

I _think_ "path" needs to be mapped to the "name" of the submodule
that should be at the "path".  Other than that, this hunk looks
correct to me.

> diff --git a/submodule.c b/submodule.c
> index 1b5cdfb7e784..e1a51b7506ff 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -348,7 +348,7 @@ void show_submodule_summary(FILE *f, const char *path,
>  	if (is_null_sha1(two))
>  		message = "(submodule deleted)";
>  	else if (add_submodule_odb(path))
> -		message = "(not checked out)";
> +		message = "(not initialized)";
>  	else if (is_null_sha1(one))
>  		message = "(new submodule)";
>  	else if (!(left = lookup_commit_reference(one)) ||

This is a change unrelated to the fix you made above, and should be
done in its own separate patch, I would think.

> diff --git a/t/t4059-diff-submodule-not-initialized.sh b/t/t4059-diff-submodule-not-initialized.sh
> new file mode 100755
> index 000000000000..cc787454033a
> --- /dev/null
> +++ b/t/t4059-diff-submodule-not-initialized.sh
> @@ -0,0 +1,105 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2016 Jacob Keller, based on t4041 by Jens Lehmann
> +#
> +
> +test_description='Test for submodule diff on non-checked out submodule
> +
> +This test tries to verify that add_submodule_odb works when the submodule was
> +initialized previously but the checkout has since been removed.
> +'
> +
> +TEST_NO_CREATE_REPO=1
> +. ./test-lib.sh
> +
> +# Tested non-UTF-8 encoding
> +test_encoding="ISO8859-1"
> +
> +# String "added" in German (translated with Google Translate), encoded in UTF-8,
> +# used in sample commit log messages in add_file() function below.
> +added=$(printf "hinzugef\303\274gt")

Have an empty line here?

> +add_file () {
> +	(
> +		cd "$1" &&
> +		shift &&
> +		for name
> +		do
> +			echo "$name" >"$name" &&
> +			git add "$name" &&
> +			test_tick &&
> +			# "git commit -m" would break MinGW, as Windows refuse to pass
> +			# $test_encoding encoded parameter to git.
> +			echo "Add $name ($added $name)" | iconv -f utf-8 -t $test_encoding |
> +			git -c "i18n.commitEncoding=$test_encoding" commit -F -
> +		done >/dev/null &&
> +		git rev-parse --short --verify HEAD
> +	)
> +}

Have an empty line here?

> +commit_file () {
> +	test_tick &&
> +	git commit "$@" -m "Commit $*" >/dev/null
> +}

Surround these ...

> +test_create_repo sm1 &&
> +test_create_repo sm2 &&
> +add_file sm1 foo >/dev/null &&
> +add_file sm2 foo1 foo2 >/dev/null &&
> +smhead1=$(cd sm2; git rev-parse --short --verify HEAD) &&

... inside its own "test_expect_success setup"?  

None of the ">/dev/null" we see in the above helper functions (and
use of these helper functions) are necessary or desired, I would
think.

The last one can become "$(git -C sm2 rev-parse ...)".

> +cd sm1

I can sort of see the attraction of doing it this way, but we avoid
chdir'ing around outside subshells, especially in a newly added test
script.  It is very easy to go down and forget to come back up, or
worse yet, stop going down and forget to remove matching "cd .." and
end up being outside the $TEST_DIRECTORY by mistake.

> +test_expect_success 'setup - submodule directory' '
> +...
> +
> +cd ..
> +
> +test_expect_success 'submodule not initialized in new clone' '
> +...

The tests themselves looked sensible.  Thanks.
