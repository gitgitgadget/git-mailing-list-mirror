Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E15302021E
	for <e@80x24.org>; Wed, 16 Nov 2016 01:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754716AbcKPBmH (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 20:42:07 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55321 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752206AbcKPBmH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 20:42:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 225624F869;
        Tue, 15 Nov 2016 20:42:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XsPRo940QCBBXU6xih66JWr9ORo=; b=Kf6+PU
        hkQeOTY3rSQIBo2MXYY2CSi4m/6wgoBESa6o9K8dGDjUvt45SaMALkDoyWVEmYnL
        QTfRAGTu5fEDQ50p0PiZsTcWxjuJNLpKriUbj/SDHBLD2vvjiK3PurO0v83iC+hl
        XyAt3GzVt5q32wFWHHPSkkWrf7QNmFHs1p/t8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ChoHQr2nO5YjVTzttw7Iq3DoHMaDQGvQ
        s0BwrUH6/ZdnxaD5W617WFMjWPJCUHmywN+xXoiA+MuWtT0JpR4qDE57P6lLcxun
        rISNNtK1wFP/EDthOblkhGHbTPFdP4Kh8++Zil45ULbqOaKrdpLQtKocO8yqHz4h
        7HKpAmumhtg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A5814F868;
        Tue, 15 Nov 2016 20:42:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7788A4F867;
        Tue, 15 Nov 2016 20:42:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Douglas Cox <ziflin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug with disabling compression and 'binary' files.
References: <CA+i4re65SsxcaLcpGyMDnJygQFmAq4X_x_uxrkqB0yqQkEYPUQ@mail.gmail.com>
Date:   Tue, 15 Nov 2016 17:42:03 -0800
In-Reply-To: <CA+i4re65SsxcaLcpGyMDnJygQFmAq4X_x_uxrkqB0yqQkEYPUQ@mail.gmail.com>
        (Douglas Cox's message of "Tue, 15 Nov 2016 19:21:14 -0500")
Message-ID: <xmqqk2c4ryj8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E10938CE-AB9D-11E6-A6C9-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Douglas Cox <ziflin@gmail.com> writes:

> I narrowed this down to the '-text' attribute that is set when
> specifying 'binary'.  For some reason this flag is cancelling out the
> core.compression = 0 setting and I think this is a bug?
>
> Unfortunately core.compression = 0 is also global. Ideally it would be
> great if there was a separate 'compression' attribute that could be
> specified in .gitattributes per wildcard similar to how -delta can be
> used. This way we would still be able to get compression for
> text/source files, while still getting the speed of skipping
> compression for binary files that do not compress well.
>
> Has there been any discussion on having an attribute similar to this?

Nope.  

I do not offhand think of a way for '-text' attribute (or any
attribute for what matter) to interfere with compression level, but
while reading the various parts of the system that futz with the
compression level configuration, I noticed one thing.  When we do an
initial "bulk-checkin" optimization that sends all objects to a
single packfile upon "git add", the packfile creation uses its own
compression level that is not affected by any configuration or
command line option.  This may or may not be related to the symptom
you are observing (if it is, then you would see a packfile created
in objects/pack/, not in loose objects in object/??/ directories).



