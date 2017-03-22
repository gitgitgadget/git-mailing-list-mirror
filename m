Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1DD220323
	for <e@80x24.org>; Wed, 22 Mar 2017 17:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934898AbdCVRVs (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 13:21:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63471 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933161AbdCVRVq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 13:21:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 58CFC7CF5F;
        Wed, 22 Mar 2017 13:21:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kRJO+7OPEavzvCQvFAbVhhlW4e0=; b=QK90JP
        lbtax92TlHqMQ+7HQx99TbXFQ6s7KibQdBkS19n21pB9csQ54C4giGKLW+mC75nS
        OglWz3V0A7w1JIyDysfohZzhfVlQEKH0aabTcXCgWAt+EVKyWSis2SCbO1ZRXtNO
        jLHDF9+Ods+3mW+Fu7vTtia69wrHEiXz9cLAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qB+BZ6UsqjiNQmno+QGtB0VcBIJoZD85
        GQWjwBtT+ZlKHYy/t/RIytllviCPeP1FEyGiOqFrKdO7IDN2dkeo1X3cJeAXru8D
        NraHdoH2XrEhfLpOsoNFkOIXLKCEdsVoosggoF1UtiExllzc7KzYd3+JkxtlIUqD
        djj2xPOLTTo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 518677CF5E;
        Wed, 22 Mar 2017 13:21:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A80E57CF5D;
        Wed, 22 Mar 2017 13:21:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     jrnieder@gmail.com, git@vger.kernel.org, mfick@codeaurora.org
Subject: Re: [PATCH v2] builtin/describe: introduce --broken flag
References: <CAGZ79kYfrKRbs40UH73VCgMsJgFyh1aG5ZrYMj3O_wGdu6rSUA@mail.gmail.com>
        <20170321225718.18633-1-sbeller@google.com>
Date:   Wed, 22 Mar 2017 10:21:37 -0700
In-Reply-To: <20170321225718.18633-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 21 Mar 2017 15:57:18 -0700")
Message-ID: <xmqqinn1mdlq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02209180-0F24-11E7-9EC5-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> git-describe tells you the version number you're at, or errors out, e.g.
> when you run it outside of a repository, which may happen when downloading
> a tar ball instead of using git to obtain the source code.
>
> To keep this property of only erroring out, when not in a repository,
> severe (submodule) errors must be downgraded to reporting them gently
> instead of having git-describe error out completely.
>
> To achieve that a flag '--broken' is introduced, which is in the same
> vein as '--dirty' but uses an actual child process to check for dirtiness.
> When that child dies unexpectedly, we'll append '-broken' instead of
> '-dirty'.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/git-describe.txt | 11 +++++++---
>  builtin/describe.c             | 47 ++++++++++++++++++++++++++++++++++--------
>  t/t6120-describe.sh            | 20 ++++++++++++++++++
>  3 files changed, 66 insertions(+), 12 deletions(-)

I admit that my suggestion to use pushv() was done without trying it
out myself, but I do agree that the result looks better, especially
because the "dirty" (not "broken") side does not even have to use a
separate argv_array to prepare the command line in the first place
(which I failed to spot exactly because I didn't try it myself ;-).

We probably _could_ use cp.argv to point at the diff_index_args()
without doing pushv(&cp.args), and that would save a bit of
allocation, but it would not matter in practice as this is not a
performance critical codepath.

Thanks.
> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index 167491fd5b..16952e44fc 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -233,4 +233,24 @@ test_expect_success 'describe --contains and --no-match' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'setup and absorb a submodule' '
> +	test_create_repo sub1 &&
> +	test_commit -C sub1 initial &&
> +	git submodule add ./sub1 &&
> +	git submodule absorbgitdirs &&
> +	git commit -a -m "add submodule" &&
> +	git describe --dirty >expect &&
> +	git describe --broken >out &&
> +	test_cmp expect out
> +'
> +
> +test_expect_success 'describe chokes on severly broken submodules' '
> +	mv .git/modules/sub1/ .git/modules/sub_moved &&
> +	test_must_fail git describe --dirty
> +'
> +test_expect_success 'describe ignoring a borken submodule' '
> +	git describe --broken >out &&
> +	grep broken out
> +'
> +
>  test_done
