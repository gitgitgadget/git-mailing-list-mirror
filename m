Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA4CF201C2
	for <e@80x24.org>; Tue, 14 Nov 2017 01:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751511AbdKNBKJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 20:10:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61635 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751161AbdKNBKI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 20:10:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8961DAB34C;
        Mon, 13 Nov 2017 20:10:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v+NA8AjzCf6lfuFNZ9ahyvsFoSA=; b=sQFIjA
        p4nakLY8SWNQjGnZFtcbSpYvq5mQV8FPkiXJJBnDB+/seaAbN0TC31rkE5brWDfW
        tcV8FlSGcJGKnzTL9pISxp6TS80J1XLIYzCD9Scmj8P5IPgsqK+fWQfPi/PJ+YNG
        NbKIVhj5iwysc48iFVe2l9FULhShjxehADXNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Jp8VfPovkdb4MvkcgjNZLsbYKD96O+c6
        Qz0hKyyFQb2bchyDceYGrntc0EIvG6lf73shGPBwG9YBWsaXPie357to9LQsxAv9
        tWbkiEa0zSWnCcSWsDKFPpdflPCaZyw0pz58b4NErfB9l/QFXTaOAbZNiq/mQunB
        QlA1dS5tMZA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F20CAB34B;
        Mon, 13 Nov 2017 20:10:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C1A05AB34A;
        Mon, 13 Nov 2017 20:10:06 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <benpeart@microsoft.com>, git@vger.kernel.org,
        pclouds@gmail.com, chriscool@tuxfamily.org,
        Johannes.Schindelin@gmx.de, alexmv@dropbox.com, peff@peff.net
Subject: Re: [PATCH v1 1/4] fastindex: speed up index load through parallelization
References: <20171109141737.47976-1-benpeart@microsoft.com>
        <20171109141737.47976-2-benpeart@microsoft.com>
        <xmqqbmkahhar.fsf@gitster.mtv.corp.google.com>
        <7e5a9fde-67fc-2bb9-51b6-54bdaed162db@gmail.com>
Date:   Tue, 14 Nov 2017 10:10:05 +0900
In-Reply-To: <7e5a9fde-67fc-2bb9-51b6-54bdaed162db@gmail.com> (Ben Peart's
        message of "Mon, 13 Nov 2017 11:42:07 -0500")
Message-ID: <xmqq7eut8y36.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D65010E-C8D8-11E7-BC97-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> The proposed format for extensions (ie having both a header and a
> footer with name and size) in the current patch already enables having
> multiple extensions that can be parsed forward or backward.  Any
> extensions that would want to be parse-able in reverse would just all
> need to be written one after the other after right before the trailing
> SHA1 (and of course, include the proper footer).

In other words, anything that wants to be scannable from the tail is
welcome to reimplement the same validation structure used by IEOT to
check the section specific sanity constraint, and this series is not
interested in introducing a more general infrastructure to make it
easy for code that want to find where each extension section in the
file begins without pasing the body of the index.

I find it somewhat unsatisfactory in that it is a fundamental change
to allow jumping to the start of an extension section from the tail
that can benefit any future codepath, and have expected a feature
neutral extension whose sole purpose is to do so [*1*].

That way, extension sections whose names are all-caps can stay to be
optional, even if they allow locating from the tail of the file.  If
you require them to implement the same validation struture as IEOT
to perform section specific sanity constraint and also require them
to be placed consecutively at the end, the reader MUST know about
all such extensions---otherwise they cannot scan backwards and find
ones that appear before an unknown but optional one.  If you keep an
extension section at the end whose sole purpose is to point at the
beginning of extension sections, the reader can then scan forward as
usual, skipping over unknown but optional ones, and reading your
IEOT can merely be an user (and the first user) of that more generic
feature that is futureproof, no?


