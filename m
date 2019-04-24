Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 428481F453
	for <e@80x24.org>; Wed, 24 Apr 2019 01:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbfDXBDp (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 21:03:45 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64577 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbfDXBDo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 21:03:44 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C17E754077;
        Tue, 23 Apr 2019 21:03:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Fc1LQXk/Zf7I
        owMRN1ift39oCSg=; b=bivp8EjR7BDELAzJjoOA7jodE4iqPkTlyHPsW4y17lsS
        RRLcDxXjmaz15eEBUg2+eC4i8DPs+ux4k65Bw1vXQM0rFKBSlGP3eFNCHvED4OOJ
        yA/gyQfTJyFZUtInAKr2YyY3vtz3183APPp3zYZsGpaMDMlfqF7dsRwMBN57GmE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=SHHlBx
        2HIXSehk0/uzgD99gONcgifQxY5unAh6paaM+KcDxoAYz70bj22UiDCAcB+dcMgh
        ta5xw633XrvwQ6rJpDMxQ5NqCgoIrN4AwkKRLK8jL8gkPozVOgBra6ExPd0IsoA7
        +CiepvoBTfHxRSWHEsVlCRgNo4m+OpZ8Bd65E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B9F9B54076;
        Tue, 23 Apr 2019 21:03:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ED45154072;
        Tue, 23 Apr 2019 21:03:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH/RFC] Makefile: dedup list of files obtained from ls-files
References: <xmqqy343a43b.fsf@gitster-ct.c.googlers.com>
        <20190422144927.GA6519@sigill.intra.peff.net>
        <20190423202109.GA8695@szeder.dev>
Date:   Wed, 24 Apr 2019 10:03:37 +0900
In-Reply-To: <20190423202109.GA8695@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Tue, 23 Apr 2019 22:21:09 +0200")
Message-ID: <xmqqlg0043km.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CC12A986-662C-11E9-988D-D01F9763A999-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> I remember being rather puzzled by 'git ls-files' listing the same
> file more than once depending on its --options when I was working on
> the git-aware path completion parts of our completion script.

Yup, I recall a thread we recently had where we wondered why we see
two entries reported when we ask for 'modified' and 'deleted' at the
same time.

Perhaps not-so-low-hanging fruit miniproject would be to teach
"ls-files" a new "--dedup" option that does two things:

 * When -m and -d are asked at the same time, ignore '-d', because
   '-d' will give duplicates for subsets of what '-m' would show
   anyway; and

 * When neither -s nor -u is given, do not show the same path more
   than once, even the ones with multiple stages.

