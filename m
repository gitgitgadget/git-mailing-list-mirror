Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6448F1F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 18:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfHLSRI (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 14:17:08 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53619 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfHLSRI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 14:17:08 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6BE0A7E6A9;
        Mon, 12 Aug 2019 14:17:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=p178IC8BV69Z
        eSVJoFFXfQiM+eo=; b=TjOSAZ9HsBjY8uKLEMaahgJkiff8zi0OslvsPOnh2dL/
        DBpmSlnXmPJJC76sbcPY9quB0CRG3EF/D1NkH3sZmhagwpnyEgBY57XizicNyOBK
        9PkDs7I4sBlTAYS+k7qqaYz11eZ7KQ3H57DSjYgHK2sMzDHthkETUV8A26TSk+4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=RRFX5V
        EWXi9T35oIM9Y96vm6rbY7Rec8sCLkj4dptJzXhtopoz7eb3AIyRN0nApxn0n806
        NqQy8gJxvTkNeaiDi5BSnntOiZzDKUWXhX1EdJUU7GwwWdBytiaKM+RypCjCTFAL
        wAwdKfo2xFyMT18UukkK51bvCDD9e9F5AV0mk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 657D37E6A8;
        Mon, 12 Aug 2019 14:17:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 944AA7E6A6;
        Mon, 12 Aug 2019 14:17:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: minor interactive rebase regression: HEAD points to wrong commit while rewording
References: <20190812175046.GM20404@szeder.dev>
Date:   Mon, 12 Aug 2019 11:17:01 -0700
In-Reply-To: <20190812175046.GM20404@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Mon, 12 Aug 2019 19:50:46 +0200")
Message-ID: <xmqqsgq69rky.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 628F2A40-BD2D-11E9-A1C3-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> ...
> So far so good.
> Save the updated commit message, and after the editor opens up the
> third commit's log message, check again where HEAD is pointing to now:
>
>   ~/tmp/reword (master +|REBASE-i 2/3)$ head -n1 .git/COMMIT_EDITMSG=20
>   third
>   ~/tmp/reword (master +|REBASE-i 2/3)$ git log --oneline -1
>   c3db735 (HEAD) second - updated
>
> As you can see, HEAD still points to the (now rewritten) second
> commit.
>
> It's only HEAD,...

Yuck.

That would still be annoying to some people and outright buggy to
others, if their workflow relies on HEAD (e.g. compare with HEAD
while reviewing the log messsage) and then now they instead need to
adjust (e.g. compare with the index instead).  Perhaps you are one
of them (apparently I am not, as I did not notice the behaviour
change until you pointed it out here).

