Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2D69207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 16:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755766AbcJLQzu (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 12:55:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50677 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753712AbcJLQzs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 12:55:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 278E44534B;
        Wed, 12 Oct 2016 12:55:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6RsRF7d/EUSoPOawXT0NgVXzyDU=; b=ShkfDM
        mjMXeZmeVHPwGyuWQqMnaY6CkATN0RIQ5CxXatmC2KRZpZClR/8JlhPO8WhrKKYo
        4qseiJzyDgj1NlQVSIEFyf/pU9yF+toyHhmQjcRxJkmoQy1x4znxDkSf5KtFISP5
        pCPQBG85/JG4GKRvsuBUTtmG8mPfpVSloVx4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UhVTQZ9714wQojmlog34krQHDFE/liw1
        WU624kdTmyx5xWyQy2NnjjgOh5DUORfgKUufMpXTzQn3n7+bYdIQYRiSCTGBR6a8
        zL/NEi/8l3K5pIlFtPMJDAyxJmga2/zYkLTpNps7XrXcmYsWomjRpiRTU+GMUqJG
        k0O8RBoMX74=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F1EC4534A;
        Wed, 12 Oct 2016 12:55:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 89AEF45349;
        Wed, 12 Oct 2016 12:55:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 13/25] sequencer: prepare for rebase -i's commit functionality
References: <cover.1473590966.git.johannes.schindelin@gmx.de>
        <cover.1476120229.git.johannes.schindelin@gmx.de>
        <9b2782e64f678ab2d261042b63fafc3e4a519295.1476120229.git.johannes.schindelin@gmx.de>
        <xmqqwphe8zl2.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610121356510.3492@virtualbox>
Date:   Wed, 12 Oct 2016 09:55:44 -0700
In-Reply-To: <alpine.DEB.2.20.1610121356510.3492@virtualbox> (Johannes
        Schindelin's message of "Wed, 12 Oct 2016 14:00:21 +0200 (CEST)")
Message-ID: <xmqq60ox5wxb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B87BA8EA-909C-11E6-868F-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Hmph, didn't we recently add parse_key_value_squoted() to build
>> read_author_script() in builtin/am.c on top of it, so that this
>> piece of code can also take advantage of and share the parser?
>
> I already pointed out that the author-script file may *not* be quoted.

I think my puzzlement comes from here.  What makes it OK for "am" to
expect the contents of author-script file to be quoted but it is not
OK to expect the same here?  What makes it not quoted for _this_
reader, in other words?

I am not sure what you meant by "nominally related", but the purpose
of the author-script in these two codepaths is the same, isn't it?
Somebody leaves the author information from the source (either from
an e-mailed patch or an existing commit), so that a later step can
use that pieces of information left in the file when (re)creating a
commit to record the tree made by using pieces of information from
the source.

Are our use in the author-script in these two codepaths _already_
inconsistent?  IOW, "am" never writes malformed unquoted values,
while the sequencer writes out in a way that is randomly quoted or
not quoted, iow, if you fed such an author-file to "am", it wouldn't
understand it?

I fully support your position to use different codepaths, if the
file that has the same name and that is used for the same purpose
uses different format in these two separate codepaths and the users
already expect them to be different.  We obviously need to have two
separate parsers.

But if that is not the case, IOW, if "am"'s author-script shares the
same issue (i.e. "'am' initially writes the file properly quoted,
but this or that can happen to change its quoting and we need to
read from such a file"), then perhaps sharing needs to happen the
other way around?  This patch may prepare "rebase -i" side for the
"this or that" (I still do not know what they are) to allow the
resulting file read correctly, but the same "this or that" can break
what "am" has used and is in use there if that is the case, no?

What makes it OK for "am" to expect the contents of author-script
file to be quoted but it is not OK to expect the same here?  What
makes it not quoted for _this_ reader, and doesn't "am" share the
same issue?

>> > +/*
>> 
>> Offtopic: this line and the beginning of the new comment block that
>> begins with "Read the author-script" above show a suboptimal marking
>> of what is added and what is left.  I wonder "diff-indent-heuristic"
>> topic by Michael can help to make it look better.
>
> Maybe. I'll try to look into that once the more serious questions about
> this patch series have been addressed.

You do not have to; the remark was meant for Michael (newly cc'ed in
the message you are responding to).
