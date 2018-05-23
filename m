Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6489D1F42D
	for <e@80x24.org>; Wed, 23 May 2018 22:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934671AbeEWWYF (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 18:24:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63456 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934027AbeEWWYE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 18:24:04 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D3EDED7036;
        Wed, 23 May 2018 18:24:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=TQCl3npDMEwkDm4q7Tpjjr+ayKI=; b=aZcUCbj
        EOrm4zUiVMyNPw5U/wy2aGDmRuSH99GEYKQDsIAMpZJgL83ct/X1HlCsP/lCf2FW
        SMFJ+aLcv85OVXHI6ApybEcziwXGB91v0IOTUb9T35IZnd6j5ihaD3T+T9vmT/K6
        UVQswJ/hQuZl16kuJZkh8s1S457tjAHNKbpA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=qZRwMbrtJLttEuhvKxtJibo7vqJAjJgX9
        dz8rXMM/aZZrnE+rzVX1iwKpZ/shutX4TlPCgbhWCXVkxkp7sv70wd9b4EWOXjL4
        GO46+42LnnHoaOEe7WvlKeiwZCgBw376qAHlx5t+R/wZtmjQkQeHShyQBJjxRifk
        z+5h/4B/ec=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 739B5D7035;
        Wed, 23 May 2018 18:24:00 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D84F1D7033;
        Wed, 23 May 2018 18:23:59 -0400 (EDT)
Date:   Wed, 23 May 2018 18:23:58 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, B.Steinbrink@gmx.de,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] rev-parse: verify that commit looked up is not NULL
Message-ID: <20180523222358.GW26695@zaya.teonanacatl.net>
References: <CABPp-BFOwWvDpfLFa2yrUDU_3BU6F68oLTtO5FvQo8nr62_WtQ@mail.gmail.com>
 <20180523204613.11333-1-newren@gmail.com>
 <20180523204613.11333-2-newren@gmail.com>
 <20180523221901.GV26695@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523221901.GV26695@zaya.teonanacatl.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: FD88F19E-5ED7-11E8-933C-44CE1968708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I wrote:
> Thanks.  This fixes the segfault.  While I was testing this,
> I wondered if the following cases should differ:

Nevermind me.  Jeff beat me to a reply and included much
more useful details about why this occurs and suggestions
for fixing it. :)

> #          f*40
> $ ./git-rev-parse ffffffffffffffffffffffffffffffffffffffff^@ ; echo $?
> 0
> 
> #          f*39
> $ ./git-rev-parse fffffffffffffffffffffffffffffffffffffff^@ ; echo $?
> fffffffffffffffffffffffffffffffffffffff^@
> fatal: ambiguous argument 'fffffffffffffffffffffffffffffffffffffff^@': unknown revision or path not in the working tree.
> Use '--' to separate paths from revisions, like this:
> 'git <command> [<revision>...] -- [<file>...]'
> 128
> 
> Looking a little further, this is deeper than the rev-parse
> handling.  The difference in how these invalid refs are
> handled appears in 'git show' as well.  With 'git show' a
> (different) fatal error is returned in both cases.
> 
> #          f*40
> $ git show ffffffffffffffffffffffffffffffffffffffff
> fatal: bad object ffffffffffffffffffffffffffffffffffffffff
> 
> #          39*f
> $ git show fffffffffffffffffffffffffffffffffffffff
> fatal: ambiguous argument 'fffffffffffffffffffffffffffffffffffffff': unknown revision or path not in the working tree.
> Use '--' to separate paths from revisions, like this:
> 'git <command> [<revision>...] -- [<file>...]'
> 
> Should rev-parse return an error as well, rather than
> silenty succeeding?

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
How can I tell that the past isn't a fiction designed to account for
the discrepancy between my immediate physical sensation and my state
of mind?
    -- Douglas Adams

