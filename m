Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB9EA207BD
	for <e@80x24.org>; Fri, 21 Apr 2017 00:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S948278AbdDUAtA (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 20:49:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63821 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S948273AbdDUAs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 20:48:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB3F37EADC;
        Thu, 20 Apr 2017 20:48:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/5ZU/onb3dRt
        rghfGkqa4T7RHbE=; b=p/E4XKAm5A2zEKHcnnrtStkp4+N4gP2pzkG13KmE8mLz
        1ZDqXzeEk7LCZfogeI7W0mcoSkDzLMf51XUQXCXkOKfsSmMB6lNgzVcYc1Rzfx5e
        gsT1zDl7hzPDjdZIlzF0MNOvKDZA9MCqxbpw5PQefqa2PTkhi/CE4422stGB6l4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=xzE3ry
        SOvCY+I6htm90B6pmlYC1qfwmBlC+u5IK01tE6Jb5KPUzB7NN/LUEK7LjFTFrMB5
        TZpnvfU5OMK4Y5KxZvKlm0u7Lh9wNbxauYD6oO8Xh13Th08u9tLb22HOZtVyZyzJ
        QSBv9LD2DExVevZrwFySuMc3g+rdGTesHNr9A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC8DD7EAD9;
        Thu, 20 Apr 2017 20:48:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3C1437EAD8;
        Thu, 20 Apr 2017 20:48:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        David Turner <dturner@twosigma.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: abort when can't remove trash directory
References: <CAM0VKjm1m4v9vTpwFEejBuD3NuGm+kAdEV-_rzCXCz2G4m5NGw@mail.gmail.com>
        <20170420165230.5951-1-szeder.dev@gmail.com>
Date:   Thu, 20 Apr 2017 17:48:55 -0700
In-Reply-To: <20170420165230.5951-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Thu, 20 Apr 2017 18:52:30 +0200")
Message-ID: <xmqq7f2e8u14.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4C93425C-262C-11E7-B7F2-C260AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> We had two similar bugs in the tests sporadically triggering error
> messages during the removal of the trash directory, see commits
> bb05510e5 (t5510: run auto-gc in the foreground, 2016-05-01) and
> ef09036cf (t6500: wait for detached auto gc at the end of the test
> script, 2017-04-13).  The test script succeeded nonetheless, because
> these errors are ignored during housekeeping in 'test_done'.
>
> However, such an error is a sign that something is fishy in the test
> script.  Print an error message and abort the test script when the
> trash directory can't be removed successfully or is already removed,
> because that's unexpected and we woud prefer somebody notice and
> figure out why.

Makes sense to me, too.

>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>
> Note, that the commit message references ef09036cf (t6500: wait for
> detached auto gc at the end of the test script, 2017-04-13), which
> is still only in 'pu'.

I think that one is already part of 2.13-rc0 ;-)

>  t/test-lib.sh | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 13b569682..e9e6f677d 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -761,9 +761,12 @@ test_done () {
>  			say "1..$test_count$skip_all"
>  		fi
> =20
> -		test -d "$remove_trash" &&
> +		test -d "$remove_trash" ||
> +		error "Tests passed but trash directory already removed before test =
cleanup; aborting"
> +
>  		cd "$(dirname "$remove_trash")" &&
> -		rm -rf "$(basename "$remove_trash")"
> +		rm -rf "$(basename "$remove_trash")" ||
> +		error "Tests passed but test cleanup failed; aborting"
> =20
>  		test_at_end_hook_
