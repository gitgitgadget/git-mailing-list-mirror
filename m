Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92C9F1F859
	for <e@80x24.org>; Sun,  4 Sep 2016 22:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752681AbcIDWUD (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 18:20:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52529 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752034AbcIDWUC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 18:20:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D51423952D;
        Sun,  4 Sep 2016 18:20:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9XX0R1xJ1vua3VagPMZ8sKDqTFA=; b=sDsq2o
        q6AmpAFT2zrFbyMuMdcYIIlzBBxMYCYFs88d0WMvU7dlZP5jpriWGaji658ioP83
        dnMiuReP1EGfBP74bZVHtvA6G3GuubzKupKHRjegIW3tnTj+d+LjAjphWWWo5NN/
        PBm+AifptolbkNZAavdqV6/OsXjLnq42iohSk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vIzt+iSmqQhjxWyhKL1wqnUypR9BCjLD
        D3fVfrSIV9O83qgBQFnivZlvbZLQgnNjcHOSSPcKqAExI0kr4N1oIpRQ+qOKdze7
        +INi4Au4y2PO4weqEunIKHGxfeeFQ7wtVKEUNP8jvb7b/fIeVno/qMQ6EGOu8N4/
        0t2a1mgFZzI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 95A663952B;
        Sun,  4 Sep 2016 18:20:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F39493952A;
        Sun,  4 Sep 2016 18:19:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC/PATCH 0/2] Color moved code differently
References: <20160903033120.20511-1-sbeller@google.com>
        <xmqqtwdxqxh6.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYGnkcOxviukj9a8gyaERip5aunXcvsdH-UpBCb=vrVeQ@mail.gmail.com>
        <xmqqpookqi8k.fsf@gitster.mtv.corp.google.com>
Date:   Sun, 04 Sep 2016 15:19:58 -0700
In-Reply-To: <xmqqpookqi8k.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sat, 03 Sep 2016 23:41:47 -0700")
Message-ID: <xmqq60qbqpdd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7EF4426-72ED-11E6-BFE2-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I do not think you should step outside diff_flush().  Only when
> producing textual diff, you would have to run the textual diff
> twice by going over the q twice:
>
>  * The first pass would run diff_flush_patch(), which would call
>    into xdiff the usual way, but the callback from xdiff would
>    capture the removed lines and the added lines without making any
>    output.
>
>  * The second pass would run diff_flush_patch(), but the callback
>    from xdiff would be called with additional information, namely,
>    the removed and the added lines captured in the first pass.
> ...
>    The fn_out_consume() function working in the "second pass of
>    moved from/moved to mode" would inspect line[] and see if it is
>    an added or a removed line, and then:
>
>    - if it is an added line, and it appears as a removed line
>      elsewhere in the patchset (you obtained the information in the
>      first pass), you show it as "this was moved from elsewhere".
>
>    - if it is a removed line, and it appears as an added line
>      elsewhere in the patchset (you obtained the information in the
>      first pass), you show it as "this was moved to elsewhere".
>
> Or something like that.

Actually, the first pass above ends up queuing majority of the diff
output in-core _anyway_, so it would make much more sense not to
rely on the reproducibility of xdiff machinery by not calling it
twice.  Instead, I would imagine that the first pass can queue all
what it receives in the callback, then with the whole-patch picture
at hand, you can call updated fn_out_consume() yourself (instead of
letting xdiff machinery to call you), and that would become the
"second pass".
