Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9763120189
	for <e@80x24.org>; Wed, 22 Jun 2016 17:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbcFVRxw (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 13:53:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63871 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751396AbcFVRxv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 13:53:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8ED5D25E7E;
	Wed, 22 Jun 2016 13:53:50 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=udkmveEYXRXaOkB/TIz5/3tsoMs=; b=xEf0kG
	dLOVv1zFhzDPnABV7bfh2NMicZIFFDnrciANVZ/64pTAZI4P9zgK2043KHCHD7j4
	vKxJDm4K/ywWWCa4ZB2otYbeAricA5eIij5whDQKkdGzpU2BX7vn8bC+QCV89oFC
	mMUEuNNyYljlpfs9SLjEegU1cmpQr8Rb0P6nA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JX8mwgaGa/qz+bwF7ZrufwV3BcjRCfTj
	m20fIpNberXpKj1Vm+n04O0geRL3/kkc/Gb/+dmacHDquSTSeBFHgROWgg7Wb6h2
	BYhd042bq75uB4YUGWUkkMJ0wcQ5gO0DvQxtSCDpkob2f7RxQ4GpHhtjmB6gpEeF
	y4Zc7o5wyXc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8686B25E7D;
	Wed, 22 Jun 2016 13:53:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0E0C525E7C;
	Wed, 22 Jun 2016 13:53:49 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] format-patch: avoid freopen()
References: <cover.1466244194.git.johannes.schindelin@gmx.de>
	<de218a6cc529b3f5c33dc4b8282f16fd8a5329a8.1466244194.git.johannes.schindelin@gmx.de>
	<CAPig+cTiexRhzS3MwMEntGYxKms-XQvtoc7HOnUGJvDaBSK7JA@mail.gmail.com>
	<alpine.DEB.2.20.1606200814510.22630@virtualbox>
	<xmqq4m8nvodo.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1606210906190.22630@virtualbox>
	<xmqqvb12qyeu.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1606220849480.10382@virtualbox>
	<xmqqeg7pns0a.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1606221811300.10382@virtualbox>
Date:	Wed, 22 Jun 2016 10:53:47 -0700
In-Reply-To: <alpine.DEB.2.20.1606221811300.10382@virtualbox> (Johannes
	Schindelin's message of "Wed, 22 Jun 2016 18:14:43 +0200 (CEST)")
Message-ID: <xmqqpor9m7o4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 468A1BE2-38A2-11E6-A706-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Well, if I change `rev.diffopt.use_color != GIT_COLOR_ALWAYS` to
> `rev.diffopt.use_color == GIT_COLOR_AUTO`, then the files will contain
> ugly ANSI color sequences if I run `git format-patch -o . -3`.
>
> The reason is, as I tried to explain, that the use_color field is *not*
> initialized to GIT_COLOR_AUTO (which is equivalent to 2), but to -1.

OK.  I thought forcing no-color only when it is set to COLOR_AUTO or
it is set to -1 (the default) would be safer, but I changed my mind.

"when we add a new --color=<something.we.do.not.know.yet>,
overriding that end-user wish with the unconditional no-color is
likely to be seen as bug." was the implicit bias behind that
suggestion, but that is not substanticated and substatiatable.

If we write

	if (rev.diffopt.use_color != GIT_COLOR_ALWAYS)
        	rev.diffopt.use_color = 0;

and if a user of --color=<something.we.do.not.know.yet> wonders why
her output is not colored, it is clear in the code above that we
disable unless it is set with --color=always, so it won't make
fixing such a future breakage harder.  In fact, if we did

	if (rev.diffopt.use_color == GIT_COLOR_AUTO ||
            rev.diffopt.use_color < 0)
        	rev.diffopt.use_color = 0;

it would make it _harder_ to spot where use_color is turned off when
the person who debugs such an issue.

Thanks.
