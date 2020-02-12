Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081D0C2BA83
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 17:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A032082F
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 17:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="atKTvadR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgBLRTW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 12:19:22 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65352 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgBLRTW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 12:19:22 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5492F4B084;
        Wed, 12 Feb 2020 12:19:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=agv6zashQuhX
        IwIRetcfeTLj5t4=; b=atKTvadRPiII7aiZVOTd9BV4OUEvLcGYf4QzW06RF5tu
        +vM6rg+kLTnm+APjkK9U9jWHlW74B7atF4qMDi3eIUu7Pkmontbgq9xm4I1yxT53
        eu4q01CU2cxPfINyOAhhlrkoD12p8Wkl/PBqL6/l8ybRVRz6Vpq3MBKdCrHUjzA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=quRWYd
        C+Aw7d/opaaXTlWC9IuF2+GzrgsHYAL8zbxbCdDwTTVrOE94zM/0i91ytx+RPhiU
        Ti6jgF9Z9clW0bYUmXhgzx3Hj9Pzmtz7cGtTmLSQeVe1dXm+8XFDZQfRlT/RKcyG
        uGFJnwpclaPHhdBRRW13cGsFwzSEtEy6TmC9c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A6344B083;
        Wed, 12 Feb 2020 12:19:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 89A2B4B082;
        Wed, 12 Feb 2020 12:19:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] tests: fix --write-junit-xml with subshells
References: <pull.552.git.1581506876000.gitgitgadget@gmail.com>
Date:   Wed, 12 Feb 2020 09:19:18 -0800
In-Reply-To: <pull.552.git.1581506876000.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 12 Feb 2020 11:27:55
        +0000")
Message-ID: <xmqqftffvi3t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CE6F09FA-4DBB-11EA-A223-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In t0000, more precisely in its `test_bool_env` test case, there are tw=
o
> subshells that are supposed to fail. To be even _more_ precise, they
> fail by calling the `error` function, and that is okay, because it is i=
n
> a subshell, and it is expected that those two subshell invocations fail=
.
>
> However, the `error` function also tries to finalize the JUnit XML (if
> that XML was asked for, via `--write-junit-xml`. As a consequence, the
> XML is edited to add a `time` attribute for the `testsuite` tag. And
> since there are two expected `error` calls in addition to the final
> `test_done`, the `finalize_junit_xml` function is called three times an=
d
> naturally the `time` attribute is added _three times_.
>
> Azure Pipelines is not happy with that, complaining thusly:
>
>  ##[warning]Failed to read D:\a\1\s\t\out\TEST-t0000-basic.xml. Error :=
 'time' is a duplicate attribute name. Line 2, position 82..
>
> One possible way to address this would be to unset `write_junit_xml` in
> the `test_bool_env` test case.
>
> But that would be fragile, as other `error` calls in subshells could be
> introduced.

Interesting.  Na=C3=AFvely, I would have expected that the right fix,
especially after reading "as other error calls can be introduced"
was to stop calling finalize from error() and instead call it from
the exit trap, but that would not work, as the exit trap would also
be called even from a subshell X-<.

> So let's just modify `finalize_junit_xml` to remove any `time` attribut=
e
> before adding the authoritative one.

It feels wrong to repeatedly rewrite the $junit_xml_path file during
the test, and it feels doubly wrong to call finalize many number of
times, but given that we do not have a good way to revamp the code
to stop doing so, I think "strip existing time attribute, if any,
and then add what we have" we see here is the best solution
available.

Will queue.  Thanks.

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 44df51be8f..0ea1e5a05e 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1083,7 +1083,8 @@ finalize_junit_xml () {
> =20
>  		# adjust the overall time
>  		junit_time=3D$(test-tool date getnanos $junit_suite_start)
> -		sed "s/<testsuite [^>]*/& time=3D\"$junit_time\"/" \
> +		sed -e "s/\(<testsuite.*\) time=3D\"[^\"]*\"/\1/" \
> +			-e "s/<testsuite [^>]*/& time=3D\"$junit_time\"/" \
>  			<"$junit_xml_path" >"$junit_xml_path.new"
>  		mv "$junit_xml_path.new" "$junit_xml_path"
> =20
>
> base-commit: de93cc14ab7e8db7645d8dbe4fd2603f76d5851f
