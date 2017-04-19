Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0AE6207BC
	for <e@80x24.org>; Wed, 19 Apr 2017 02:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759135AbdDSCpK (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 22:45:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58658 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755120AbdDSCpI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 22:45:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 98CBE83BC1;
        Tue, 18 Apr 2017 22:45:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QMMWq809rVzyBPGbNOhonTu7nUs=; b=SeU9AB
        sPvv488u+fCRCfG/vPxI4omAMakGPlOha1nM8CHE1AMTUPXHgaCjW10ar9gD//do
        O7j+AirgbZUTzPYEQeoq9fWrheU9PzPWZGVNb4fbk8WzWVpCQux/cmrnVKpYM49n
        Wsbmowqloef4U4zTpCQboVISPNhCI+F4/dlvw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qHI/C4j2jn9zxe909hOJ9zNABkiFQoOH
        wDIvN6XxwLg4+kXMPtmUO96YbMn7TaMnDXyzZNkTovTVj4wHziPk+l2EgU1HSekD
        2zgBFEQOg8wZULsRF6qZb5Tn31awpohhyTabzzz7jh1uBLDq90gwkewDJV8m7mXH
        dvcxmGHJdyU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9148883BC0;
        Tue, 18 Apr 2017 22:45:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F1DE083BBF;
        Tue, 18 Apr 2017 22:45:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@jeffhostetler.com, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1] diffcore-rename: speed up register_rename_src
References: <20170418194421.22453-1-git@jeffhostetler.com>
        <20170418194421.22453-2-git@jeffhostetler.com>
        <20170419013214.q35jarvmk5jhqdyi@sigill.intra.peff.net>
Date:   Tue, 18 Apr 2017 19:45:05 -0700
In-Reply-To: <20170419013214.q35jarvmk5jhqdyi@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 18 Apr 2017 21:32:15 -0400")
Message-ID: <xmqqd1c9cdzi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3299FBD0-24AA-11E7-86E8-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Apr 18, 2017 at 07:44:21PM +0000, git@jeffhostetler.com wrote:
>
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>> 
>> Teach register_rename_src() to see if new file pair
>> can simply be appended to the rename_src[] array before
>> performing the binary search to find the proper insertion
>> point.
>
> I guess your perf results show some minor improvement. But I suspect
> this is because your synthetic repo does not resemble the real world
> very much. You're saving a few strcmps, but for each of those files
> you're potentially going to have actually zlib inflate the object
> contents and do similarity analysis.
>
> So "absurd number of files doing 100% exact renames" is the absolute
> best case, and it saves a few percent.
>
> I dunno. It is not that much code _here_, but I'm not excited about the
> prospect of sprinkling this same "check the last one" optimization all
> over the code base. I wonder if there's some way to generalize it.

When adding many things, we often just append and then sort at the
end after we finished adding.  I wonder if recent "check the last
one and append" optimization beats that strategy.
