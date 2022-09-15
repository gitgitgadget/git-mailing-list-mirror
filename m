Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3250BC6FA86
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 17:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiIORxn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 13:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiIORxl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 13:53:41 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582D39C508
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 10:53:40 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 83AA81552CA;
        Thu, 15 Sep 2022 13:53:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3gcg8d9Mdpwh
        Z3Xfx1umCrY0yAsUN1tRNLqIEmCHX+s=; b=NJfkBi2y5oZI0LTqdjyjx7bBfXVz
        bw/US5rKt4ZJk4BQ/IeaXxai5jH2+oYh2mPdq9rQO5E0g87rXh5pSBKwEfOna87J
        gmElRKwjW7f4J+Zb7FJSUfAqF4M8YsKjnR98B9wgALoNsXX3rOVM6N4G2ICEaPLC
        T6WO/jjOgPPIDKw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C16D1552C9;
        Thu, 15 Sep 2022 13:53:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D68301552C8;
        Thu, 15 Sep 2022 13:53:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Tim Jaacks <tim.jaacks@garz-fricke.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH 6/6] revision: add parents after child for ^!
References: <ba6eea28-fb3a-b376-2529-351727c02f1a@web.de>
        <84018532-169f-dc9b-f894-3d19bb7b4245@web.de>
Date:   Thu, 15 Sep 2022 10:53:37 -0700
In-Reply-To: <84018532-169f-dc9b-f894-3d19bb7b4245@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 15 Sep 2022 16:55:12 +0200")
Message-ID: <xmqq5yhoo76m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 541137A2-351F-11ED-A1EC-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> gitrevisions(7) says: "A suffix '^' followed by an exclamation mark is
> the same as giving commit '<rev>' and then all its parents prefixed wit=
h
> '^' to exclude them (and their ancestors)."

I did not mean to specify the order at all in that description when
I wrote ca5ee2d1 (Enumerate revision range specifiers in the
documentation, 2012-07-24) and I do not think it should be read as
such.

> handle_revision_arg_1() however adds the negated parents first.

I suspect that this was deliberately done so to match how A..B is
added to the pending commit list in revisions.c::handle_dotdot_1()
to tolerate "git diff A..B" as a synonym to "git diff A B", which
dates back to cd2bdc53 (Common option parsing for "git log --diff"
and friends, 2006-04-14).

> Split up the handling of ^! by moving the actual addition of the
> parents after the addition of the child.

I do not offhand think of anything other than the "diff" frontend
that cares about the order of these commits from the command line, I
am afraid that this might end up robbing Peter to pay paul. =20

Can't we "fix" it at the consumer end, perhaps by checking where
these commits came from by looking at rev.cmdline?
