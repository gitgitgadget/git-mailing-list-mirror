Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B93E1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 18:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754587AbcIGSfs (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 14:35:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63197 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752124AbcIGSfr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 14:35:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C101337E75;
        Wed,  7 Sep 2016 14:35:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u8xeKDkLYanqSh8A2ryRAKmQXCU=; b=SSnma5
        wyh10Mv+5o6Gvlc2ZOuUnF3xxLj7v/izMBpmwyJTs/sSS6ZGKKYJ3AzK9zAKjL6d
        irSviJKkzFFwOFbtAm9CRfAyd6xzxMpGLTR8F/ILS+JelivpdoTq0+eSKXj8/8ke
        8kjc0UUJII1eDoew1RHvfmpMQgKqKmCRzitmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tmHNNZa9+1VSgnKTVBMHkr8yUq3O1HxF
        HQyoywjMf6mExohPfey1/kmZzyEYJNQWW3zwn0xGd5vxKSSyJIyt8/9Fsti3rN7I
        D0cffady6G+w0zv2GW7hWIEadg/0ibpAVorfVLlNRr+psq58GoIFfmzRDfAFe64s
        2WLyrvxgIeQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B755437E74;
        Wed,  7 Sep 2016 14:35:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4014537E71;
        Wed,  7 Sep 2016 14:35:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] t9903: fix broken && chain
References: <61de943c-df93-58e9-ca48-c469a71a1d43@kdbg.org>
Date:   Wed, 07 Sep 2016 11:35:44 -0700
In-Reply-To: <61de943c-df93-58e9-ca48-c469a71a1d43@kdbg.org> (Johannes Sixt's
        message of "Mon, 5 Sep 2016 21:00:47 +0200")
Message-ID: <xmqqbmzzmubj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E41FDF22-7529-11E6-AA3B-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> We might wonder why our && chain check does not catch this case:
> The && chain check uses a strange exit code with the expectation that
> the second or later part of a broken && chain would not exit with this
> particular code.
>
> This expectation does not work in this case because __git_ps1, being
> the first command in the second part of the broken && chain, records
> the current exit code, does its work, and finally returns to the caller
> with the recorded exit code. This fools our && chain check.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  t/t9903-bash-prompt.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> index 0db4469..97c9b32 100755
> --- a/t/t9903-bash-prompt.sh
> +++ b/t/t9903-bash-prompt.sh
> @@ -177,7 +177,7 @@ test_expect_success 'prompt - interactive rebase' '
>  	git checkout b1 &&
>  	test_when_finished "git checkout master" &&
>  	git rebase -i HEAD^ &&
> -	test_when_finished "git rebase --abort"
> +	test_when_finished "git rebase --abort" &&
>  	__git_ps1 >"$actual" &&
>  	test_cmp expected "$actual"
>  '

Thanks.
