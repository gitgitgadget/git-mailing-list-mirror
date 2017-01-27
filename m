Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36CF61F437
	for <e@80x24.org>; Sat, 28 Jan 2017 00:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750781AbdA1AL6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 19:11:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61055 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750741AbdA1AL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 19:11:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 08C8C635CD;
        Fri, 27 Jan 2017 18:34:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WsiYcwqWViIK
        PQvhT2doGYmI5Xg=; b=TFIak2R8rlBWAal0a6jm1E89pMIEQ/6rsYDTNBwrKTu2
        Ak9a+h7pFDf496i9LI1eXLgxobuvJNLxTafgeZsNbR/VcON3ZSFehzs+sIV5R61w
        uZ9QYy7DL4K4uJl7izwxxcQBHwr6+S1G+6X0AvOZqiphyAXHM0wxcugWWYuIk44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=LiRsO8
        +h9P2Zg3rqr/+DSqQhiqfDS3Zip1PKkZJD2tv8e5q2LE0zXlmicPcyoDmdb14FF4
        zaSJuLdnyF8hIt5QV5pgxyVoUnRjHgO1IdVIef0Lq0j9fMtkeB9dIIzgMXTwJsqH
        w8D+kX2TlFGMYEjALmuNokVgS1ImgFISHcWAs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 00148635CC;
        Fri, 27 Jan 2017 18:34:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 58737635CB;
        Fri, 27 Jan 2017 18:34:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     tsuna <tsunanet@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Deadlock between git-remote-http and git fetch-pack
References: <CAFKYj4cMSK5nQ1nS66c4Opz8y7x+xQH+OdW8PTi7LmCiGBP1ZA@mail.gmail.com>
Date:   Fri, 27 Jan 2017 15:34:21 -0800
In-Reply-To: <CAFKYj4cMSK5nQ1nS66c4Opz8y7x+xQH+OdW8PTi7LmCiGBP1ZA@mail.gmail.com>
        (tsuna's message of "Fri, 27 Jan 2017 14:31:15 -0800")
Message-ID: <xmqqefzoxeki.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 219C4244-E4E9-11E6-A9C2-FE3F13518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tsuna <tsunanet@gmail.com> writes:

> While investigating a hung job in our CI system today, I think I found
> a deadlock in git-remote-http
> ...
> Here PID 27319 (git fetch-pack) is stuck reading on stdin, while its
> parent, PID 27317 (git-remote-http) is stuck reading on its child=E2=80=
=99s
> stdout.  Nothing has moved for like 2h, it=E2=80=99s deadlocked.

Hmph, would this be related to 296b847c0d ("remote-curl: don't hang
when a server dies before any output", 2016-11-18) I wonder...
