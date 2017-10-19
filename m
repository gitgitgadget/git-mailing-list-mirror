Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01A561FF72
	for <e@80x24.org>; Thu, 19 Oct 2017 00:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751414AbdJSAfb (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Oct 2017 20:35:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53372 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751060AbdJSAfa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Oct 2017 20:35:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2FD03B770E;
        Wed, 18 Oct 2017 20:35:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iOGkelyeuW0akmrUnsfQ+LuBhF0=; b=V6h3bc
        XmZDO2vxV5JIhXrHrQMvWUjmFJYhEAToX8KXSECkSp+U1WRcx3Ot0zCx++FWRWDB
        nEbk/sO3FE3grrk7QfPcUNM/tur0unyrXIgOLC4niOnHfTx0bclZeRtjPdLyJwUn
        dDyb2XCZxndcsctlWALt2ctjLmlHicJUTgSfk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=B+WusGAs0vKSfW/XJxoSkUUVP1bMnqpg
        RCkuRNdr6HMPAKAiySV4Ym8xD9xZLU79M5LWrrxvvdI8xDjpOXS4n9EpU0OHFQB0
        MEwDw6ycEUIo4mE0R26s8o7zQE0//mocPWqUTOqLmMU8cHkT3Lowx1vTzCIDg7kd
        on4XbJebDYk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 288E5B770D;
        Wed, 18 Oct 2017 20:35:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8DCC7B770C;
        Wed, 18 Oct 2017 20:35:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] implement fetching of moved submodules
References: <20171016135623.GA12756@book.hvoigt.net>
        <20171016135827.GC12756@book.hvoigt.net>
        <CAGZ79kZsQoU8wJk+i5aJOxFtsD=EWu_ycEPLM1KhTaOCWD7Y2w@mail.gmail.com>
        <xmqqfuahmif9.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaTXC9Eius3jMZGefZioJtS-uuf+ar5zt=WSEWQJxdcwQ@mail.gmail.com>
Date:   Thu, 19 Oct 2017 09:35:28 +0900
In-Reply-To: <CAGZ79kaTXC9Eius3jMZGefZioJtS-uuf+ar5zt=WSEWQJxdcwQ@mail.gmail.com>
        (Stefan Beller's message of "Wed, 18 Oct 2017 10:56:58 -0700")
Message-ID: <xmqqwp3sj7ov.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 687F9C6E-B465-11E7-8C50-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> but if we already have a submodule with that name (the most likely
>> explanation for its existence is because it started its life there
>> and then later moved), and the submodule is bound to a different
>> path, then that is a different submodule.  Skipping and warning both
>> are sensible thing to do.
>
> Skipping and warning is sensible once we decide to go this way.
>
> I propose to take a step back and not throw away the information
> whether the given string is a name or path, as then we do not have
> to warn&skip, but we can treat both correctly.

Now either one of us is utterly confused, and I suspect it is me, as
I do not see how "treat both correctly" could possibly work in the
case this code warns and skips.

At this point in the flow, we already know that it is not name,
because we asked and got a "Nah, there is no submodule registered in
.gitmodules at that path" from submodule_from_path().  Then we ask
submodule_from_name() if there is any submodule registered under the
name it would have got if it were added there, and we indeed find
one.  And that is definitely *not* a submodule we are looking for,
because if it were, its .path would have pointed at the path we were
using to ask in the first place.  The one we originally found at
path and are interested in finding out the details is not known to
.gitmodules, and the one under that name is not the one that we are
intereted in, so fetching from the repository the other one that
happens to have the same name but is different from the submodule we
are interested in would simply be wrong.

If we only have path without any .gitmodules entry (hence there is
not even URL), how would we proceed from that point on?

