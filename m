Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1803AC4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 07:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC11C23741
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 07:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgLQHil (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 02:38:41 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:20824 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgLQHik (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 02:38:40 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4CxP3n5dBZz5tlC;
        Thu, 17 Dec 2020 08:37:57 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id BF61C49B3;
        Thu, 17 Dec 2020 08:37:56 +0100 (CET)
Subject: Re: [PATCH v3] mergetool: add automerge configuration
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>, Seth House <seth@eseth.com>,
        git@vger.kernel.org
References: <20201217054524.856258-1-felipe.contreras@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <769774cf-a55f-c9ba-c33d-233d070bb3f1@kdbg.org>
Date:   Thu, 17 Dec 2020 08:37:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201217054524.856258-1-felipe.contreras@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.12.20 um 06:45 schrieb Felipe Contreras:
> It doesn't make sense to display easily-solvable conflicts in the
> different views of all mergetools.
> 
> Only the chunks that warrant conflict markers should be displayed.
> 
> In order to unobtrusively do this, add a new configuration:
> mergetool.autoMerge.
> 
> See Seth House's blog post [1] for the idea, and the rationale.
> 
> [1] https://www.eseth.org/2020/mergetools.html
> 
> Original-idea-by: Seth House <seth@eseth.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/config/mergetool.txt |  3 +++
>  git-mergetool.sh                   | 10 ++++++++++
>  t/t7610-mergetool.sh               | 18 ++++++++++++++++++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
> index 16a27443a3..43af7a96f9 100644
> --- a/Documentation/config/mergetool.txt
> +++ b/Documentation/config/mergetool.txt
> @@ -61,3 +61,6 @@ mergetool.writeToTemp::
>  
>  mergetool.prompt::
>  	Prompt before each invocation of the merge resolution program.
> +
> +mergetool.autoMerge::
> +	Automatically resolve conflicts that don't require user intervention.

As I hinted in an earlier message, some tools do know how to deal with
unconflicted changes. This should be a setting in the tool driver, not a
user-visible setting.

> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index e3f6d543fb..6e86d3b492 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -274,6 +274,7 @@ merge_file () {
>  		BASE=${BASE##*/}
>  	fi
>  
> +	DIFF3="$MERGETOOL_TMPDIR/${BASE}_DIFF3_$$$ext"
>  	BACKUP="$MERGETOOL_TMPDIR/${BASE}_BACKUP_$$$ext"
>  	LOCAL="$MERGETOOL_TMPDIR/${BASE}_LOCAL_$$$ext"
>  	REMOTE="$MERGETOOL_TMPDIR/${BASE}_REMOTE_$$$ext"
> @@ -322,6 +323,15 @@ merge_file () {
>  	checkout_staged_file 2 "$MERGED" "$LOCAL"
>  	checkout_staged_file 3 "$MERGED" "$REMOTE"
>  
> +	if test "$(git config --bool mergetool.autoMerge)" = "true"
> +	then
> +		git merge-file --diff3 -q -p "$LOCAL" "$BASE" "$REMOTE" >"$DIFF3"
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
> 

