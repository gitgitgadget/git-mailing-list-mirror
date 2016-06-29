Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 640411FF40
	for <e@80x24.org>; Wed, 29 Jun 2016 14:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124AbcF2ODO (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 10:03:14 -0400
Received: from mout.gmx.net ([212.227.15.19]:50438 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752609AbcF2ODJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 10:03:09 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Mdren-1azCgb461d-00Paky; Wed, 29 Jun 2016 16:02:13
 +0200
Date:	Wed, 29 Jun 2016 16:02:11 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Patrick Steinhardt <ps@pks.im>
cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Daniel Hahler <git@thequod.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] rebase -i: restore autostash on abort
In-Reply-To: <20160629062127.8946-1-ps@pks.im>
Message-ID: <alpine.DEB.2.20.1606291600300.12947@virtualbox>
References: <20160628175704.26095-1-ps@pks.im> <20160629062127.8946-1-ps@pks.im>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:IUzCsuLlFmWCBmAp0uHXFMjnG5SNh6UQDihNdRlpA62InTrsYhL
 PA+XBKjvC5endiuyb1w8ZNsPt4VgTMdEhNzn9FnVAXQ54rOr5tnsRctwajOsRUx1xX9gnjR
 GRbamyzvr/rvq5Hwodmo0YcCzV7V8LkfvfWkZ76Hk9JoJrp1A8sZi2uj4Y/Q0G7NeMdjluY
 XTrZrmiXnay6YR42JPsnw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:1Cfir46Fn+E=:dvbqw7QaUhPOShEye2A5Az
 H3bf/ubtOcjB5hn1tjVB9JLISU8vASPUa8pSE1eRrlXoYY5EcVloZzAnZ0pv+lqi3eaHpS3sQ
 U/QzKdJFnQ5SqtvrBfKdWjHZeRsgtjx91u7kLQFa7Q3zpDsX6UGb2AgRHy2nCVvFZk41dWclE
 /kzgDhHj7OSK473s+1zgsO56T2xEogZnLG8ieVKOjApkMdnH3/mCu4cvu8uofcgageB+zhY9a
 q4qkCBy0P2BYFfHzN1aC2K/BqyY3swCDAkhhBEJCAb0K30mF816OnJtCCi4aIq8ScFpj5uw85
 0JHSq0y/FAkpI0Z7E6KdtxMQrp89XbfKUfut+48ZMDpgzNIqXEmCXmglfJiT+1rOC13UfPZx3
 W/Zra6YqZw8JtJxMAb63pMXKUsjfs3xdlT0K6H483z2qFUr0q+np0VCnW86XF4FC82l8Cnu0f
 x8ID3UpG8ebT1qGWBAG5H+Ni3jziAR86dbC+vyatYZBwsOkbM3UrgUMbOdZ6im8s0tMJtrboj
 vMAksxeRt74iL03Mm0rtbY7SoKET4/OpR4phzhxDkn8kvsVrpwcp+cp+wQIOXpNfJ48KA2gu+
 nc9ArJfdk91BssNGLTWRGVuDpke5c7V7HB1mayDwrFJwbaZ4NCuy05mLhKAwVJbhXgiDFZnYr
 Wb2V9l4z/0hcrKMOOp3HiuOftTRXjl2Y+h8kJO1bWTvYQi0OJ4bxwFeRHAWDRThTV3nmLbJ+I
 A/Q8STl9vBEfloQbGXpubj1/QOXx5n7nUwk2tOsrhj9ajpyty4QZqjicYP8lcNkapdNzJja8t
 YOBsGbD
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Patrick,

On Wed, 29 Jun 2016, Patrick Steinhardt wrote:

> When we abort an interactive rebase we do so by calling
> `die_abort`, which cleans up after us by removing the rebase
> state directory. If the user has requested to use the autostash
> feature, though, the state directory may also contain a reference
> to the autostash, which will now be deleted.
> 
> Fix the issue by trying to re-apply the autostash in `die_abort`.
> This will also handle the case where the autostash does not apply
> cleanly anymore by recording it in a user-visible stash.

I like it. Thanks for including the tests, they were very helpful to
verify that my rebase--helper work is unaffected: the patch touches only
those parts that are not moved into the rebase--helper.

Thanks,
Johannes
