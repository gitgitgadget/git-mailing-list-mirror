Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C585C20899
	for <e@80x24.org>; Tue,  8 Aug 2017 19:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752362AbdHHThT (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 15:37:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63007 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752153AbdHHThS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 15:37:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D11A3946CB;
        Tue,  8 Aug 2017 15:37:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iybzaBGRWvjfLT1A2xLe+/8WWiY=; b=eya9jj
        EgePbNq1TkUQ/vPT2SCIFo38X6Cu+Aj/3plLIj98090Fhy6dsijKICyh4NYHqO51
        nF0N/rfr+dRToU189oXoJbzS3wGnHvv2oc8hF8R9HwVMj1YFcfmQ+OwMzgtY5OdO
        4YEUUV99wXu9wYdBZuOazhtMlVlG6EDiwdiTI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UdvRvLPdPLRqHQ7MWS8XXBNlv9L6wLv8
        P8Ll2dCVnALj2mQOLWr/SGQDCTeWUqcH2V2+cRom72ICp8/RCc3FdjOA3ev0SqN4
        dqdDP1yKj0Jw/tbw4K3Kcm2bnqSo+wb/FUXFM90ww/eZ5zhamQW39UrqSF+uvQIq
        EyKrpZWlm6g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C9A8B946CA;
        Tue,  8 Aug 2017 15:37:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3FDFF946C9;
        Tue,  8 Aug 2017 15:37:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] am: fix signoff when other trailers are present
References: <20170807102929.25151-1-phillip.wood@talktalk.net>
        <20170808102533.27516-1-phillip.wood@talktalk.net>
Date:   Tue, 08 Aug 2017 12:37:09 -0700
In-Reply-To: <20170808102533.27516-1-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Tue, 8 Aug 2017 11:25:33 +0100")
Message-ID: <xmqqlgmtc0m2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F857BD3A-7C70-11E7-A8AA-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

>  test_expect_success 'am --signoff does not add Signed-off-by: line if already there' '
> -	git format-patch --stdout HEAD^ >patch3 &&
> -	sed -e "/^Subject/ s,\[PATCH,Re: Re: Re: & 1/5 v2] [foo," patch3 >patch4 &&
> -	rm -fr .git/rebase-apply &&
> -	git reset --hard &&
> -	git checkout HEAD^ &&
> -	git am --signoff patch4 &&
> -	git cat-file commit HEAD >actual &&
> -	test $(grep -c "^Signed-off-by:" actual) -eq 1
> +	git format-patch --stdout first >patch3 &&
> +	git reset --hard first &&
> +	git am --signoff <patch3 &&
> +	git log --pretty=%B -2 HEAD >actual &&
> +	test_cmp expected-log actual
> +'
> +
> +test_expect_success 'am --signoff adds Signed-off-by: if another author is preset' '

Present?

I think the motivation for adding this is to make sure that what the
previous test checks will be true only when the one we are about to
add is already at the end.  So perhaps the previous test needs to be
retitled from "if already there" to something a bit tighter,
e.g. "if already at the end"?

Also, strictly speaking, I think this isn't testing if another
author is present---it is specifying what should happen when the
last one is not us.

> +	NAME="A N Other" &&
> +	EMAIL="a.n.other@example.com" &&
> +	{
> +		printf "third\n\nSigned-off-by: %s <%s>\nSigned-off-by: %s <%s>\n\n" \
> +			"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL" \
> +			"$NAME" "$EMAIL" &&

A "printf" tip: you can do

	printf "third\n\n"
	printf "S-o-b: %s <%s>\n" A B C D

to get two lines of the latter.  That would clarify what the next
test does which wants to add three of them.

> +		cat msg &&
> +		printf "Signed-off-by: %s <%s>\nSigned-off-by: %s <%s>\n\n" \
> +			"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL" \
> +			"$NAME" "$EMAIL"
> +	} >expected-log &&
> +	git reset --hard first &&
> +	GIT_COMMITTER_NAME="$NAME" GIT_COMMITTER_EMAIL="$EMAIL" \
> +		git am --signoff <patch3 &&
> +	git log --pretty=%B -2 HEAD >actual &&
> +	test_cmp expected-log actual
> +'
> +
> +test_expect_success 'am --signoff duplicates Signed-off-by: if it is not the last one' '
> +	NAME="A N Other" &&
> +	EMAIL="a.n.other@example.com" &&
> +	{
> +		printf "third\n\nSigned-off-by: %s <%s>\n\
> +Signed-off-by: %s <%s>\nSigned-off-by: %s <%s>\n\n" \
> +			"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL" \
> +			"$NAME" "$EMAIL" \
> +			"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL" &&
> +		cat msg &&
> +		printf "Signed-off-by: %s <%s>\nSigned-off-by: %s <%s>\n\
> +Signed-off-by: %s <%s>\n\n" \
> +			"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL" \
> +			"$NAME" "$EMAIL" \
> +			"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL"
> +	} >expected-log &&
> +	git format-patch --stdout first >patch3 &&
> +	git reset --hard first &&
> +	git am --signoff <patch3 &&
> +	git log --pretty=%B -2 HEAD >actual &&
> +	test_cmp expected-log actual
>  '
>  
>  test_expect_success 'am without --keep removes Re: and [PATCH] stuff' '
> +	git format-patch --stdout HEAD^ >tmp &&
> +	sed -e "/^Subject/ s,\[PATCH,Re: Re: Re: & 1/5 v2] [foo," tmp >patch4 &&
> +	git reset --hard HEAD^ &&
> +	git am <patch4 &&
>  	git rev-parse HEAD >expected &&
>  	git rev-parse master2 >actual &&
>  	test_cmp expected actual
