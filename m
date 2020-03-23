Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9A6C54EEB
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 16:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6368B20722
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 16:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZgeZzu3t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbgCWQ2N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:28:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56877 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbgCWQ2N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 12:28:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 656094146A;
        Mon, 23 Mar 2020 12:28:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vey3qbukafHECYiaMx/aMncRy5M=; b=ZgeZzu
        3taKwWo3xiCnO/nmB9MQB5QisMUvSwtbKp6Ts7D1yixoonCa2vRjGkXyxohBZYhq
        FUdQSl0dr8+uf9Zh5u+wBWpeejhM6HFKTlink3pp8/mTon93eu8t8pi/pTWDjF+o
        3u39Ecbf4J0VSSygznLQe6lr5fyX+RvPtGtks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CtE81gYuAvllECY0h6JPYv66qNNyMUId
        LDPzvcOYL9uopyJxVMwYg3e1ue6I6uR3+kJBzQeqphh2etVbVUeW6fNjq+KD7LKC
        5SZsTfHlASLmE9/dfmB0sha8tb07rQ/+6J/lUC3hMy9M6HVWDh1gsJgEF0Kjt+KK
        v1CegMnklQo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B49C41469;
        Mon, 23 Mar 2020 12:28:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CEEA341466;
        Mon, 23 Mar 2020 12:28:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] tests(junit-xml): avoid invalid XML
References: <pull.732.git.git.1584967475669.gitgitgadget@gmail.com>
Date:   Mon, 23 Mar 2020 09:28:10 -0700
In-Reply-To: <pull.732.git.git.1584967475669.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Mon, 23 Mar 2020 12:44:35
        +0000")
Message-ID: <xmqqlfnr5945.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4943330A-6D23-11EA-A0AC-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When a test case is run in a subshell, we finalize the JUnit-style XML
> when said subshell exits. But then we continue to write into that XML as
> if nothing had happened.
>
> This leads to Azure Pipelines' Publish Test Results task complaining:
>
> 	Failed to read /home/vsts/work/1/s/t/out/TEST-t0000-basic.xml.
> 	Error : Unexpected end tag. Line 110, position 5.
>
> And indeed, the resulting XML is incorrect.
>
> Let's "re-open" the XML in such a case, i.e. remove the previously added
> closing tags.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     Fix Azure Pipelines for t0000
>     
>     When running t0000 in our Azure Pipeline, the "Publish Test Results"
>     step complains about an invalid JUnit-style XML, and it is correct.
>     Let's fix that.

Hmph, I have a vague recollection that I've seen this one, looked at
the patch and even understood the issue.  Did I then forget to apply
it back then?  If so, apologies for failing to do so before the
release.

Will queue.

Thanks.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-732%2Fdscho%2Fci-xml-error-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-732/dscho/ci-xml-error-v1
> Pull-Request: https://github.com/git/git/pull/732
>
>  t/test-lib.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 0ea1e5a05ed..7f0c02c016b 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1085,6 +1085,7 @@ finalize_junit_xml () {
>  		junit_time=$(test-tool date getnanos $junit_suite_start)
>  		sed -e "s/\(<testsuite.*\) time=\"[^\"]*\"/\1/" \
>  			-e "s/<testsuite [^>]*/& time=\"$junit_time\"/" \
> +			-e '/^ *<\/testsuite/d' \
>  			<"$junit_xml_path" >"$junit_xml_path.new"
>  		mv "$junit_xml_path.new" "$junit_xml_path"
>  
>
> base-commit: be8661a3286c67a5d4088f4226cbd7f8b76544b0
