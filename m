Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 237C320437
	for <e@80x24.org>; Mon, 16 Oct 2017 17:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755564AbdJPRfB (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 13:35:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51948 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754169AbdJPRe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 13:34:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 294A9A74FA;
        Mon, 16 Oct 2017 13:34:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pa6R6DSPO93v
        C4RQKuxX5MyDXZM=; b=rKbSBjb9q76+2u38kMBaF3XHMlXBoOMGcx+D+O27NsoF
        LWi72LOqRbWUhCGINOndnB1MGqRgSDPe1wxDhf3gDFfkaPYmRaxjDpFtJYssY7kE
        avk2FWi8eWqAaPuz8C2YlsLUODfiQ5jEN9mO8FNHtWqx2350E4f1BnRT3vSJgv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=aMBQXp
        zpTuicnDjZvqu+wCLG3wbpbtTqCc/HZMep5lSks3OZa7JvREQ265AlsvisQWPq7q
        2ivKONd/N/IfIG/GL5Xs32ZiPrCeA+OHRID7opJNUfewvPhN1YX5wBRpJ5dPZnfB
        e6aybhpM+0wn986S/J0pnVvJMyIHXzGJWxmXY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 20CF2A74F9;
        Mon, 16 Oct 2017 13:34:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9495CA74F8;
        Mon, 16 Oct 2017 13:34:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v1 1/1] Introduce git add --renormalize .
References: <xmqqo9pm8e4l.fsf@gitster.mtv.corp.google.com>
        <20171016164907.4201-1-tboegi@web.de>
Date:   Tue, 17 Oct 2017 02:34:56 +0900
In-Reply-To: <20171016164907.4201-1-tboegi@web.de> (tboegi@web.de's message of
        "Mon, 16 Oct 2017 18:49:07 +0200")
Message-ID: <xmqqshejq9mn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 543E003E-B298-11E7-84C0-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> Make it safer to normalize the line endings in a repository:
> Files that had been commited with CRLF will be commited with LF.
> (Unless core.autorclf and .gitattributes specify that Git
>  should not do line ending conversions)

A few issues I saw after a quick read:

 - The log message tells us old and new ways, but does not make it
   clear why users are encouraged to use the new way at all.  You
   didn't make the implementation of "add --renormalize" to just
   start "git add" without calling read_cache() and letting all
   files added new to the index (which is how the old way worked) to
   give a sugarcoated equivalent of the old way for a reason, and
   that should be desribed in the log.

 - An ugly global variable is introduced instead of passing
   necessary information through the callchain properly, but the
   title does not say PATCH/RFC.

 - The documentation makes it sound as if this new feature is _only_
   about CRLF vs LF.  SHouldn't this equally apply after the user
   changes .gitattributes settings that govern the "clean" side of
   the filter and makes what is in the index "unclean"?

The second point is a showstopper from maintainability's point of
view, but none of the above should be insurmojntable.

Thanks.
