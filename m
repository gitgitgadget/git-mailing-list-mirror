Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99F651F461
	for <e@80x24.org>; Mon, 26 Aug 2019 17:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbfHZRU1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 13:20:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52836 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbfHZRU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 13:20:27 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3F7D2738C5;
        Mon, 26 Aug 2019 13:20:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LZlAoI16YJd/u1nnMUITDjARCwU=; b=PexAC6
        hsPKnYBbMx8hv7DegzW7M1vwHbC3w45/yX3uNURRGuL+SN+3x7dgUvKy/4b/+r+1
        QDpDxgLhwHL8oMzsqc7YaKIO02TLIJIwkGqecABDgazfWPG0kW8pZDwyt4lNKrd+
        PCvE9Dsimy9dzJ9k6ntIHLAaRhE1MqjMfg9Sw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Rwvt60BYUp6ZHK7pxGWEvfXVHUT/uLlv
        1lumAkzqFpwq6xul5JMLN7+jb11pF1H0U/rQFhKDOgHtQNSMIOEbJkwl2LuD90eB
        I2nxzGGYjlV0aauCE+RN2cF/wIi/TuNHRBHnclwd99zNj7zwpU8JTw31SuP5uTEC
        HbyignJP+G0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 37E34738C4;
        Mon, 26 Aug 2019 13:20:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6694E738C1;
        Mon, 26 Aug 2019 13:20:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Sperling <stsp@stsp.name>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [PATCH] fix segv with corrupt tag object
References: <20190824230944.GA14132@jessup.stsp.name>
        <bcc29199-a4ac-6bdc-6715-9807737253d8@web.de>
        <20190826115715.GB71935@jessup.stsp.name>
Date:   Mon, 26 Aug 2019 10:20:20 -0700
In-Reply-To: <20190826115715.GB71935@jessup.stsp.name> (Stefan Sperling's
        message of "Mon, 26 Aug 2019 13:57:15 +0200")
Message-ID: <xmqqo90bhmi3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9134A46-C825-11E9-A479-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Sperling <stsp@stsp.name> writes:

> The root cause of this bug seems to be that the valid assumption
> that obj->parsed implies a successfully parsed object is broken by
> parse_tag_buffer() because this function sets the 'parsed' flag even
> if errors occur during parsing.

I am mildly negative about that approach.  obj->parsed is about
"we've done all we need to do to attempt parsing this object" (so
that next person who gets hold of the object knows that fact---one
of the reasons why may be that the caller who wants to ensure that
the fields are ready to be accessed does not have to spend extra
cycles, but that is not the only one).  Those that want to look at
various fields in the object (e.g. the tagged object of a tag, the
tagger identity of a tag, etc.) should be prepared to see and react
to NULL in there so that they can gracefully handle "slightly"
corrupt objects.

