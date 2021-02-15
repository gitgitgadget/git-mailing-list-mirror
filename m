Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738F7C433DB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 17:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 346A9601FD
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 17:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhBORyQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 12:54:16 -0500
Received: from [93.83.142.38] ([93.83.142.38]:47384 "EHLO localhost"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S229604AbhBORyP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 12:54:15 -0500
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by localhost (Postfix) with ESMTP id E1A321B27B;
        Mon, 15 Feb 2021 18:53:53 +0100 (CET)
Subject: Re: [PATCH v2 12/27] userdiff tests: rewrite hunk header test
 infrastructure
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
 <20210215154427.32693-13-avarab@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <0f70d5e4-cf35-1e67-be02-2baf3036d471@kdbg.org>
Date:   Mon, 15 Feb 2021 18:53:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210215154427.32693-13-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.02.21 um 16:44 schrieb Ævar Arnfjörð Bjarmason:
> Rewrite the hunk header test infrastructure introduced in
> bfa7d01413 (t4018: an infrastructure to test hunk headers,
> 2014-03-21). See c228a5c077 (Merge branch 'js/userdiff-cc',
> 2014-03-31) for the whole series that commit was part of.
> 
> As noted in an earlier commit that change introduced the regression of
> not testing for the full hunk line, but just whether "RIGHT" appeared
> on it[1]. A preceding commit fixed that specific issue, but we were
> still left with the inflexibility of the approach described in the
> now-deleted t/t4018/README.
> 
> I.e. to add any sort of new tests that used the existing test data
> we'd either need to add more files like the recently added (but now
> deleted) *.ctx) files, using the filesystem as our test datastructure,
> or introduce more parsing for the custom file format we were growing
> here.
> 
> Let's instead just move this over to using a custom test
> function. This makes it trivial to add new tests by adding new
> optional parameters to the function. Let's still keep the relevant
> files in the "t/t4018/" subdirectory instead of adding ~1.5k
> lines (and growing) to "t/t4018-diff-funcname.sh"
> 
> If this diff is viewed with "--color-moved=plain" we can see that
> there's no changes to the lines being moved into the new *.sh files,
> i.e. all the deletions are moves. I'm just adding boilerplate around
> those existing lines.
> 
> The one-off refactoring was performed by an ad-hoc shellscript [2].
> 
> 1. https://lore.kernel.org/git/87wnvbbf2y.fsf@evledraar.gmail.com/
> 2.
> 	#!/bin/sh
> 	set -ex
> 
> 	git rm README*
> 	for t in $(git ls-files ':!*.ctx')
> 	do
> 		lang=$(echo $t | sed 's/-.*//')
> 		desc=$(echo $t | sed -E 's/^[^-]*-//' | tr - " ")
> 
> 		if ! test -e $lang.sh
> 		then
> 			cat >$lang.sh <<-EOF
> 			#!/bin/sh
> 			#
> 			# See ../t4018-diff-funcname.sh's test_diff_funcname()
> 			#
> 
> 			EOF
> 		else
> 			echo >>$lang.sh
> 	        fi
> 
> 		(
> 	            printf "test_diff_funcname '%s: %s' \\" "$lang" "$desc"
> 	            echo
> 	            printf "\t8<<%sEOF_HUNK 9<<%sEOF_TEST\n" '\' '\'
> 	            cat $t.ctx
> 	            printf "EOF_HUNK\n"
> 	            cat $t
> 	            printf "EOF_TEST\n"
> 		) >>$lang.sh
> 
> 		chmod +x $lang.sh
> 		git add $lang.sh
> 	        git rm $t $t.ctx
> 	done
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---

> diff --git a/t/t4018/bash.sh b/t/t4018/bash.sh
> new file mode 100755
> index 0000000000..69144d9144
> --- /dev/null
> +++ b/t/t4018/bash.sh
> @@ -0,0 +1,160 @@
> +#!/bin/sh
> +#
> +# See ../t4018-diff-funcname.sh's test_diff_funcname()
> +#
> +
> +test_diff_funcname 'bash: arithmetic function' \
> +	8<<\EOF_HUNK 9<<\EOF_TEST
> +RIGHT()
> +EOF_HUNK
> +RIGHT() ((
> +
> +    ChangeMe = "$x" + "$y"
> +))
> +EOF_TEST
> +
> +test_diff_funcname 'bash: bashism style compact' \
> +	8<<\EOF_HUNK 9<<\EOF_TEST
> +function RIGHT {
> +EOF_HUNK
> +function RIGHT {
> +    function InvalidSyntax{
> +        :
> +        echo 'ChangeMe'
> +    }
> +}
> +EOF_TEST
> +
> +test_diff_funcname 'bash: bashism style function' \
> +	8<<\EOF_HUNK 9<<\EOF_TEST
> +function RIGHT {
> +EOF_HUNK
> +function RIGHT {
> +    :
> +    echo 'ChangeMe'
> +}
> +EOF_TEST
> [...]

That is not my dream of "simple". But I'm not a userdiff author anymore, 
so...

I don't know, yet, where this is heading to what the advantage is. At 
any rate, "trivial to add new tests" was also the case when each test 
case was in its own file. Without the boilerplate!

-- Hannes
