Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2AAA20D09
	for <e@80x24.org>; Mon, 17 Apr 2017 03:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932578AbdDQDJ0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 23:09:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58324 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932401AbdDQDJX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 23:09:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C135B8BB25;
        Sun, 16 Apr 2017 23:09:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VKIuNqGmSpcZ9cqbHTc99/IMe9E=; b=B6VFsU
        p7wq34UXqiSeZu/+4G2k0jexdyS/EDoFpm+utmD840RmfDkZOzBGb5zHWDFEodeY
        lnM3VCi3BMkIb4ERG2EFOE5sC3P7RSlvsOGkkCkgOF0dZB5aVAApr9r/haTgsmeh
        LsJtJ2lJTdMYjGaMPFtNEZDYrTFfn99UF26I8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Rh5ZHXBB1QFHloLh4Xoy7a//5WFnvBZC
        rvcJNpTKOS0O4Zsvkk1csa0s0snB4jwryBgJivdnCLHfH70afdJTlMu935hF2LKj
        wfPCb1taU6ac7V9Jmuajq4b/T7KOVjZVNJyXb4WuThGDplFDbUa4UOvwqWrv+0cc
        P20zYBsOJqY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B9A668BB24;
        Sun, 16 Apr 2017 23:09:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3328B8BB23;
        Sun, 16 Apr 2017 23:09:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, jo@durchholz.org
Subject: Re: [PATCH] submodule: prevent backslash expantion in submodule names
References: <CAGZ79ka7PEWy2iA8V9s11n2kyD=vHyS2y1K3SJzDq-5HsY7how@mail.gmail.com>
        <20170407172306.172673-1-bmwill@google.com>
        <20170408105901.2osi2zadboqxhf34@sigill.intra.peff.net>
Date:   Sun, 16 Apr 2017 20:09:14 -0700
In-Reply-To: <20170408105901.2osi2zadboqxhf34@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 8 Apr 2017 06:59:01 -0400")
Message-ID: <xmqqr30rk9wl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3CFA5ABA-231B-11E7-9EB4-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The reason I mentioned escaping earlier is I wondered what would happen
> when the submodule starts with a double-quote, or has a newline in the
> name. Git's normal quoting would include backslash escape sequences, and
> I wondered if we might be relying on any of these "read" calls to
> interpret them. But I don't think so, for two reasons.
>
> One, because that quoting also puts double-quotes around the name. So
> plain "read" would not be sufficient to de-quote for us anyway.

Correct. These are c-quoting and "read" does not know what to do
with them.

> And two, because these are being fed from "submodule--helper", which
> does not seem to quote in the first place.

Which probably is a bug we can fix safely, as submodule--helper is
merely an implementation detail of our toolset, not something the
end users' scripts can rely on.
