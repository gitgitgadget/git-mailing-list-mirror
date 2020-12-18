Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E52C2BBCD
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 00:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE000238A0
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 00:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbgLRAsM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 19:48:12 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62861 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730990AbgLRAsL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 19:48:11 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C7FCD109FA8;
        Thu, 17 Dec 2020 19:47:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T8TWj4WII1zRhzc4kHQrYOi4ABc=; b=bDTn6q
        Puuzh+SHndpwUtJUZHDgw/MlFIwib4ATYL1eQNR3ynwimGrODteZZH0CqkxZ+Pk5
        eJaHrZwhIHNOIT7repPR76JIJ5R0KF6r73NTaccqjTcnicxodIcqxWrIw9TNcgR8
        Z7hLhuh/INaie7fju3Y1go1lDPLZC3qQ8SEME=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=n7h+R8cJm9hCY0Z52n2Ry/HOwtTkdYD0
        tYd0FMJjyQSqEQcV+kJafWt+Yjqk3W/s83kX2VUcw8tyBVQmJcCgBFZmdZEqucVs
        UxThHiATPNYn7fRWi7YdILGUE3Oa8uwGKpqWyRTN5VC/TATkA3oN75qvpJCVAAwF
        qwWDFKiVzHM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ADE5E109FA7;
        Thu, 17 Dec 2020 19:47:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E48CB109FA6;
        Thu, 17 Dec 2020 19:47:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Seth House <seth@eseth.com>
Subject: Re: [PATCH v3] mergetool: add automerge configuration
References: <20201217054524.856258-1-felipe.contreras@gmail.com>
Date:   Thu, 17 Dec 2020 16:47:23 -0800
In-Reply-To: <20201217054524.856258-1-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Wed, 16 Dec 2020 23:45:24 -0600")
Message-ID: <xmqqk0tgx7ms.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 999A52D6-40CA-11EB-8DEE-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> It doesn't make sense to display easily-solvable conflicts in the
> different views of all mergetools.
>
> Only the chunks that warrant conflict markers should be displayed.
>
> In order to unobtrusively do this, add a new configuration:
> mergetool.autoMerge.

As pointed out by others, I think it makes more sense to have
mergetool.$tool.autoMerge, with optionally mergetool.autoMerge
that can be used as a fallback, and enable it by default.  If
we can make the default of enabling/disabling per tool, that
would be ideal (see my other reply on how to do these).

> +		git merge-file --diff3 -q -p "$LOCAL" "$BASE" "$REMOTE" >"$DIFF3"

Adding "--marker-size 7" to the command line would make the sed
scripts below more robust.

> +		sed -e '/^<<<<<<< /,/^||||||| /d' -e '/^=======\r\?$/,/^>>>>>>> /d' "$DIFF3" >"$BASE"
> +		sed -e '/^||||||| /,/^>>>>>>> /d' -e '/^<<<<<<< /d' "$DIFF3" >"$LOCAL"
> +		sed -e '/^<<<<<<< /,/^=======\r\?$/d' -e '/^>>>>>>> /d' "$DIFF3" >"$REMOTE"
> +		rm -- "$DIFF3"
> +	fi
> +
>  	if test -z "$local_mode" || test -z "$remote_mode"
>  	then
>  		echo "Deleted merge conflict for '$MERGED':"
> diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
> index 70afdd06fa..b75c91199b 100755
> --- a/t/t7610-mergetool.sh
> +++ b/t/t7610-mergetool.sh
> @@ -828,4 +828,22 @@ test_expect_success 'mergetool -Oorder-file is honored' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'mergetool automerge' '
> +	test_config mergetool.automerge true &&
> +	test_when_finished "git reset --hard" &&
> +	git checkout -b test${test_count}_b master &&
> +	echo -e "base\n\na" >file1 &&

I think test-lint-shell-syntax should have complained about the use
of "echo -e" here (that's the reason why I queued the patch in 'seen'
initially but it does not appear in what finally got pushed out).

You can either use the plain-vanilla

	cat >file1 <<-\EOF &&
	...
	EOF

because there is nothing gained by saving number of lines with
reduced readability, or can use

	test_write_lines >file1 base "" "" a &&
	...
	test_write_lines >file1 base "" "" c &&
	...
	test_write_lines >file1 local "" "" b &&
	...
	test_write_lines >file1 local "" "" c &&
	...

which would both save number of lines while making it a bit clearer
which 'line' corresponds to which other 'line' in different
preparation of the same "file1".

Will expect a reroll.  Thanks.

> +	git commit -a -m "base" &&
> +	echo -e "base\n\nc" >file1 &&
> +	git commit -a -m "remote update" &&
> +	git checkout -b test${test_count}_a HEAD~ &&
> +	echo -e "local\n\nb" >file1 &&
> +	git commit -a -m "local update" &&
> +	test_must_fail git merge test${test_count}_b &&
> +	yes "" | git mergetool file1 &&
> +	echo -e "local\n\nc" >expect &&
> +	test_cmp expect file1 &&
> +	git commit -m "test resolved with mergetool"
> +'
> +
>  test_done
