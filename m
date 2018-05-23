Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A6E71F42D
	for <e@80x24.org>; Wed, 23 May 2018 22:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934832AbeEWWTG (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 18:19:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62136 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934147AbeEWWTE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 18:19:04 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3BCCBDE09B;
        Wed, 23 May 2018 18:19:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=rubNTym7AqiVWYcdArdkTp0jSig=; b=a7V189Y
        8vQLSKWAfzqPVZLCYxibB5ocWmVAk+nFzf4VWAYG6mu9IuchZYj6Qql+y5XjPZNC
        VsEG0vIByEtQnBCPgZWKHeEV/QVCd5AfvCYvhSIUCDfyr/zurbCCdVi2rhXETdkN
        HzJPxlO89nwHWtebecLYjY9BgWWFuyLIRmfg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=I+ia2tOzc7SZWizFIz4e8OhjCbsy5TYyX
        Xr6vLHZyEnTT6SFBWHTP7sGri4xPRxNioCY8u8VtR/ND+9kbZ2nKIiSelwYaFAgu
        C9suRUTYDKRtNUvhiXMcthxO8Dca5gSB1PYxKuvTdMGnqel2t2aZBUq8yM2aBBDY
        ol5TntFwIg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 33E06DE099;
        Wed, 23 May 2018 18:19:04 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B0E7DDE098;
        Wed, 23 May 2018 18:19:03 -0400 (EDT)
Date:   Wed, 23 May 2018 18:19:02 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, B.Steinbrink@gmx.de
Subject: Re: [PATCH 2/2] rev-parse: verify that commit looked up is not NULL
Message-ID: <20180523221901.GV26695@zaya.teonanacatl.net>
References: <CABPp-BFOwWvDpfLFa2yrUDU_3BU6F68oLTtO5FvQo8nr62_WtQ@mail.gmail.com>
 <20180523204613.11333-1-newren@gmail.com>
 <20180523204613.11333-2-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523204613.11333-2-newren@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: 4D0166C6-5ED7-11E8-AD07-67830C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> In commit 2122f8b963d4 ("rev-parse: Add support for the ^! and ^@ syntax",
> 2008-07-26), try_parent_shorthands() was introduced to parse the special
> ^! and ^@ syntax.  However, it did not check the commit returned from
> lookup_commit_reference() before proceeding to use it.  If it is NULL,
> bail early and notify the caller that this cannot be a valid revision
> range.

Thanks.  This fixes the segfault.  While I was testing this,
I wondered if the following cases should differ:

#          f*40
$ ./git-rev-parse ffffffffffffffffffffffffffffffffffffffff^@ ; echo $?
0

#          f*39
$ ./git-rev-parse fffffffffffffffffffffffffffffffffffffff^@ ; echo $?
fffffffffffffffffffffffffffffffffffffff^@
fatal: ambiguous argument 'fffffffffffffffffffffffffffffffffffffff^@': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
128

Looking a little further, this is deeper than the rev-parse
handling.  The difference in how these invalid refs are
handled appears in 'git show' as well.  With 'git show' a
(different) fatal error is returned in both cases.

#          f*40
$ git show ffffffffffffffffffffffffffffffffffffffff
fatal: bad object ffffffffffffffffffffffffffffffffffffffff

#          39*f
$ git show fffffffffffffffffffffffffffffffffffffff
fatal: ambiguous argument 'fffffffffffffffffffffffffffffffffffffff': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'

Should rev-parse return an error as well, rather than
silenty succeeding?

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
I refuse to spend my life worrying about what I eat. There is no
pleasure worth foregoing just for an extra three years in the
geriatric ward.
    -- John Mortimer

