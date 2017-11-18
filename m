Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C699202F2
	for <e@80x24.org>; Sat, 18 Nov 2017 03:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935395AbdKRDxJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 22:53:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63397 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934490AbdKRDxI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 22:53:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 652F2AF7B5;
        Fri, 17 Nov 2017 22:53:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ewN3Ij9VOK7j
        kMeLgfW9+URm9nU=; b=Vykj6iX3KKz9a99PRE2dT2b0EOqmwLKnfMvzPa7l6gKv
        V+jBml1f2qGVHQNsrQqVHPFwLc0qJwsUnVUjf6r0dmE/7QZez+McYSCd1MchDGV8
        qHvWF5FNPFYvZzCmgUHxAej6ft5FJsZ0xAwewJTLrSU07NcBYsYZNoxULEaBkY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=HtAMVG
        Y5JpTbk9ZE2wbzJkzEvuItK26Adn2U1g9mIrP8SSPlGARDA2WhFT7julnnIgVlKG
        7ijsRMwYbwpnZX9BfxSGIciMPgHt2UMZFyjNNkc2K+nMFUJOLC5zEQxS9bkPaOa/
        s78M4T9XaRKKpUd9fK94egXsh09b+CFYOnrqk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E199AF7B4;
        Fri, 17 Nov 2017 22:53:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D8848AF7B3;
        Fri, 17 Nov 2017 22:53:06 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?5bCP5bed5oGt5Y+y?= <aiueogawa217@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Is it not bug git stash -- <pathspec> does not work at non-root directory?
References: <CAC2Jkr+brEKLy-z45WwP2iqssA14na9xpaCoKrNKbPcTvtUxJA@mail.gmail.com>
Date:   Sat, 18 Nov 2017 12:53:05 +0900
In-Reply-To: <CAC2Jkr+brEKLy-z45WwP2iqssA14na9xpaCoKrNKbPcTvtUxJA@mail.gmail.com>
        (=?utf-8?B?IuWwj+W3neaBreWPsiIncw==?= message of "Sat, 18 Nov 2017 12:37:01
 +0900")
Message-ID: <xmqqzi7kp7j2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FC64D334-CC13-11E7-9123-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=E5=B0=8F=E5=B7=9D=E6=81=AD=E5=8F=B2 <aiueogawa217@gmail.com> writes:

> Is it not bug git stash -- <pathspec> does not work at non-root directo=
ry?

Please make it a habit (not limited to when interacting with _this_
project) to state a bit more than "does not work"; instead, say "it
is expected to do X, but instead it does Y, and the difference
between X and Y I perceive is Z".

If you mean

	cd sub && git stash -- Makefile

does not make a stash for only sub/Makefile and instead makes (or
attempts to make) a stash for only Makefile at the top-level, then
I think it is a bug, whose likely cause is that the implementation
forgets to prepend the $prefix to the pathspec it got from the
command line.  But I am writing this without looking at the
implementation and with your unclear description of the issue, so
I may be completely off the mark ;-)

Thanks.
