Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47B3A2070F
	for <e@80x24.org>; Wed, 14 Sep 2016 21:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762488AbcINVyr (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 17:54:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61319 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753312AbcINVyq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 17:54:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D65A93FE7F;
        Wed, 14 Sep 2016 17:54:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o6rBMe0+Q5176hZPdyxv+T4UJU8=; b=aa/1rN
        45lkShn5hM+V3xyiUHKeUMSpMKOTWmM9U4YD7q8ItcU1GGpRdQRKeUh8WlV5JIWD
        U9aHoFLhaQJ8Xu6/BSUhP2V8DiAwwW7KjPds35NSvhCJmP5jgWqeYKNpu54PuD/y
        seP7UdIMzpgoYNOtvRBsMZqXAqSYGkI/Z7/4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N1bt/XOGAwl3BDaL3dBhZysMlJhgiG5F
        M9Rrka+bA774+PiPa6sxdq9yHtFfa8j1f5SNZ3iMB/wb5rCpv0rCB8RuGiar8AAq
        /kXwOIW3e6uMVibqg8PxXvRM2LfoQL+YWtV/Mdj+m4x4j1zccML43HjYP+D+qeXZ
        pRt85Rl8ADs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CEB6C3FE7E;
        Wed, 14 Sep 2016 17:54:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 526A83FE7D;
        Wed, 14 Sep 2016 17:54:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jan Keromnes <janx@linux.com>,
        Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH v4 4/4] add: modify already added files when --chmod is given
References: <20160912210818.26282-1-t.gummerer@gmail.com>
        <20160914210747.15485-1-t.gummerer@gmail.com>
        <20160914210747.15485-5-t.gummerer@gmail.com>
Date:   Wed, 14 Sep 2016 14:54:42 -0700
In-Reply-To: <20160914210747.15485-5-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Wed, 14 Sep 2016 22:07:47 +0100")
Message-ID: <xmqq4m5iqh99.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D8AA011C-7AC5-11E6-83E8-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> When the chmod option was added to git add, it was hooked up to the diff
> machinery, meaning that it only works when the version in the index
> differs from the version on disk.
>
> As the option was supposed to mirror the chmod option in update-index,
> which always changes the mode in the index, regardless of the status of
> the file, make sure the option behaves the same way in git add.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---

This change essentially reverts most of what 4e55ed32 ("add: add
--chmod=+x / --chmod=-x options", 2016-05-31) did, except that it
keeps the command line option and adjusts its validation, and adds a
separate phase to "fix-up" the executable bits for all paths that
match the given pathspec, whether they were new or modified or
unchanged.

The patch makes sense to me.  Thanks.
