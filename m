Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7883CC433E1
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 23:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AD3C20760
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 23:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bxvI3lGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgGPXYF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:24:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50410 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgGPXYE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 19:24:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E6E18E9229;
        Thu, 16 Jul 2020 18:27:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RMhkZhqgXbNDuoPI1DeRhVA/5eg=; b=bxvI3l
        Gw4orN8AXYebrJR3pgFhMX+WiSsOVcIHaF63Ka6/llx8PATVbx0ViPtTP9q9RUsn
        DXM1Duhrvgn/hpW5jmG4lycABM8pXlXQvyfJbdvLh5aZ7Pj2E7IRL43ZPSwgH+/P
        Hl6AHwHyjuhTQ4LH8T/XiY3e9O4OSgdhAmNYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Kjp+HROmXXpOIwtCx2zH3540KNoWCX1H
        FuJdcG+q11jKWWvXbHvAT75mlwSkfHLkdAYDwRajIfcyiunnZT3cT91rCZLflx2e
        DHTahaV9UJ6NzxV0HOcxRhs0ST91yPtxHg1cwBPdxMpn28ppUJX98nNlxsczjMqD
        ig1pZJd+fcY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DFC90E9228;
        Thu, 16 Jul 2020 18:27:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2AAD3E9227;
        Thu, 16 Jul 2020 18:27:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: Compressing packed-refs
References: <20200716221026.dgduvxful32gkhwy@chatter.i7.local>
Date:   Thu, 16 Jul 2020 15:27:15 -0700
In-Reply-To: <20200716221026.dgduvxful32gkhwy@chatter.i7.local> (Konstantin
        Ryabitsev's message of "Thu, 16 Jul 2020 18:10:26 -0400")
Message-ID: <xmqqsgdrf64c.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81608F9A-C7B3-11EA-BA36-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> I know repos with too many refs is a corner-case for most people, but 
> it's looming large in my world, so I'm wondering if it makes sense to 
> compress the packed-refs file when "git pack-refs" is performed?

I think the reftable is the longer term direction, but let's see if
there is easy enough optimization opportunity that we can afford the
development and maintenance cost for the short term.

My .git/packed-refs file begins like so:

    # pack-refs with: peeled fully-peeled sorted 
    c3808ca6982b0ad7ee9b87eca9b50b9a24ec08b0 refs/heads/maint-2.10
    3b9e3c2cede15057af3ff8076c45ad5f33829436 refs/heads/maint-2.11
    584f8975d2d9530a34bd0b936ae774f82fe30fed refs/heads/master
    2cccc8116438182c988c7f26d9559a1c22e78f1c refs/heads/next
    8300349bc1f0a0e2623d5824266bd72c1f4b5f24 refs/notes/commits
    ...

A few observations that can lead to easy design elements are

 - Typically more than half of each records is consumed by the
   object name that is hard to "compress".

 - The file is sorted, so it could use the prefix compression like
   we do in the v4 index files.

So perhaps a new format could be

 - The header "# pack-refs with: " lists a new trait, "compressed";

 - Object names will be expressed in binary, saving 20 bytes per a
   record;

 - Prefix compression of the refnames similar to v4 index would save
   a bit more.

Storing binary object names would actually be favourable for
performance, as the in-core data structure we use to store the
result of parsing the file uses binary.


