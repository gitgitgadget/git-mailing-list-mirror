Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15E591F461
	for <e@80x24.org>; Fri, 28 Jun 2019 16:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfF1QRc (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 12:17:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64502 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfF1QRb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 12:17:31 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D8CC281974;
        Fri, 28 Jun 2019 12:17:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HSfQRF9snv8u
        Z+76SZTsBbSmlsQ=; b=i8dwL9P+uipnEOph2rFdRDxRJSKdc3gyQfial/bUR/NG
        1hO3yhMMqEz7URay6t4edyDkmCis73JLNRfDYDhhcPgeMHyH/i0xR4k5yzX6E2DP
        ED7oR/mgXltqhiWJKEqRwAmyh0SJIz/wjnkhX4p2oLR1LESAC2DCqU4pK7gmS/M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=pn4GDT
        48G6Xm5Q2WX//aTBKQA1yeLoOLKjYshPQuOg6eK3MOhcGePN/PVCPrIaVGB0y07r
        w3zJ9W0TQMdq7VxqvCcCV+rnfxLnxoNYefCXO1p1eMyqB+h7KXAwPPw2py3nE4Ri
        F9J/6++aV5/MTqdjIyTADlEC2Tk1Lxb/+OuxI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D129B81973;
        Fri, 28 Jun 2019 12:17:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 02C7881964;
        Fri, 28 Jun 2019 12:17:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH v2 7/6] t7814: do not generate same commits in different repos
References: <20190627092852.11326-1-pclouds@gmail.com>
        <20190628093528.20372-1-pclouds@gmail.com>
Date:   Fri, 28 Jun 2019 09:17:24 -0700
In-Reply-To: <20190628093528.20372-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Fri, 28 Jun 2019 16:35:28 +0700")
Message-ID: <xmqqtvc98z1n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3862CD20-99C0-11E9-9DFB-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> t7814 has repo tree like this
>
>   initial-repo
>     submodule
>       sub
>
> In each repo 'submodule' and 'sub', a commit is made to add the same
> initial file 'a' with the same message 'add a'. If tests run fast
> enough, the two commits are made in the same second, resulting
> identical commits.
>
> There is nothing wrong with that per-se. But it could make the test
> flaky. Currently all submodule odbs are merged back in the main
> one (because we can't, or couldn't, access separate submodule repos
> otherwise). But eventually we need to access objects from the right
> repo.
>
> Because the same commit could sometimes be present in both 'submodule'
> and 'sub', if there is a bug looking up objects in the wrong repo,
> sometimes it will go unnoticed because it finds the needed object in th=
e
> wrong repo anyway.
>
> Fix this by changing commit time after every commit. This makes all
> commits unique. Of course there are still identical blobs in different
> repos, but because we often lookup commit first, then tree and blob,
> unique commits are already quite safe.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> ---
>  > And I can't quite understand how t7814 sometimes passed.
>
>  I do now. This patch makes it fail consistently for me.

Well analysed.  Very well done.  Thanks.
