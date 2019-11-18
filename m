Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D65281F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 03:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfKRDgY (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 22:36:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59904 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfKRDgY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 22:36:24 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED8642D4DD;
        Sun, 17 Nov 2019 22:36:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u3Zil4qwJni7cH/CGWL+AiU216E=; b=XdCX4O
        qeyNFVCg/lRf1uMcLtsQbZ4WlyNGYTUk925PXcQV+mqfo0CfzKUtDpFS1SxyTn/o
        pFtuDStvb+HO76SGTzORfCWhe243qnH3X8I2tffByCTwcKxiCFO9UDj/Gt7bQy8n
        uEgTjZ54qO8LybJmdspDXTvWhRT/RddORZsI0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=okVg4Drb5EyZ3iAuZEUaxThJ3+1P+jm2
        eWylC1yo+MUA+l9Ws9SPmXuCMaxJ0y+jYpcUk0ILHbzx+dbynyDIrUrqhvuxYY34
        lJkXGH0rmg44/WItjoksmbrOjFNxa49IlBjM3437TcFmuC7bmFQ+Msef2ddX4KJq
        50Y7uxvDU88=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E67022D4DC;
        Sun, 17 Nov 2019 22:36:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 575EB2D4DB;
        Sun, 17 Nov 2019 22:36:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [RFC PATCH] wt-status: show amended content when verbose
References: <20191116161856.28883-1-me@yadavpratyush.com>
Date:   Mon, 18 Nov 2019 12:36:20 +0900
In-Reply-To: <20191116161856.28883-1-me@yadavpratyush.com> (Pratyush Yadav's
        message of "Sat, 16 Nov 2019 21:48:56 +0530")
Message-ID: <xmqqd0dp3lfv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 969B6F1E-09B4-11EA-8818-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> I am working on a simple little feature which shows the "amended
> content" when running 'git-commit -v'. Currently, only the changes in
> the _entire_ commit are shown. In a large commit, it is difficult to
> spot a line or two that were amended. So, show just the amended content
> in a different section.

[jc: even though the diff generation is done before the final commit
is made, let me refer to the commits with refs _after_ the amend is
done].

You want to show changes between HEAD@{1}..HEAD (which is what the
"amend" did) in addition to changes between HEAD^..HEAD (which is
what the "amended commit" does) separately.

The reason why "git commit -v" lets you see the diff since HEAD^ is
to help you write the commit log message.  So it is wrong to show
only "what the amend did", as the message you would be writing while
amending is to explain the entire "why the amended commit does what
it does" and by definition the log message for "amend" should not
talk about "why the amend did what it did"---the readers would not
even have access to the older version before the amend.

It too makes quite a lot of sense to allow readers to see what the
'amend' did, but that is not something that would help write the log
message.  And that is why "git commit -v --amend" does not show it.
It should be inspected even _before_ the user contemplates to run
"git commit --amend" (e.g. "git diff HEAD" before starting to amend).

So, I am not enthused with this change---it sends a wrong message
(i.e. what the diff in the editor "commit -v" gives the user for).







