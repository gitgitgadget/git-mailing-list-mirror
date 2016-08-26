Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D4371FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 17:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753003AbcHZRUS (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 13:20:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60888 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751321AbcHZRUR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 13:20:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 92140374E2;
        Fri, 26 Aug 2016 13:17:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wF/d03YYgZuef8YpUFKZ/eiDtS8=; b=RnV/9i
        n6FgJly3QhWMcP0acrGslg4QlkA+ThqNB0+3vdxGCVaEg1isMqQQ9sMRpmtBZLyn
        m0uAUi7OnoVlmJz0yyeZxowz2Wp/voEelk8AmkPQezQ63eTYQ6b1QFyULV4QBZ5g
        i24xF5w32Rs/Rf+gkXoimmEXEV5E4KuzoRvbg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qIdOyUlUvf9ORcOPdYYXgEaEGS50TNr+
        +01l+TtLbL5blHczfyMLp71WMtin0nVyLUWo1XnL3t7JP+HrNDsMkULBOLbY622g
        1an1JjcHxYz+0+SGbMufPW0yB8AbqDdAOdK9RDVlt0laSgumF8XixsFxTxgO4h5B
        qAlaAaMvHZk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A1D0374E1;
        Fri, 26 Aug 2016 13:17:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 05695374E0;
        Fri, 26 Aug 2016 13:17:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>
Subject: Re: [PATCH v6 06/13] pkt-line: add functions to read/write flush terminated packet streams
References: <20160825110752.31581-1-larsxschneider@gmail.com>
        <20160825110752.31581-7-larsxschneider@gmail.com>
        <CAGZ79kaVg40H-LeDtFfDYqDFDDbr+um3ZYj8oAaqGu+q6k5e+A@mail.gmail.com>
        <xmqqvayojx9e.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xrYM_r+Q_27hWM2FwbreV90AqPgoiH-qPZN0hoPiHpKhQ@mail.gmail.com>
Date:   Fri, 26 Aug 2016 10:17:00 -0700
In-Reply-To: <CA+P7+xrYM_r+Q_27hWM2FwbreV90AqPgoiH-qPZN0hoPiHpKhQ@mail.gmail.com>
        (Jacob Keller's message of "Thu, 25 Aug 2016 17:55:54 -0700")
Message-ID: <xmqqa8fzih6b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E75645DC-6BB0-11E6-827B-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> Stefan's argument to me is thus "If we're already going to ignore
> sideband packets here, why not go all the way and make variable length
> packets and send a single packet of a maximum length? Doing thus will
> solve some set of future problems nicely and makes this code easier."
>
> I'm not sure I agree myself, but that's the logic as I understand it.

I do not know if I agree, but now I understand the flow of logic.

Thanks.
