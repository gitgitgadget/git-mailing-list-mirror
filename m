Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EF4D20286
	for <e@80x24.org>; Wed, 13 Sep 2017 12:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751380AbdIMMeY (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 08:34:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:36598 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751120AbdIMMeX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 08:34:23 -0400
Received: (qmail 4796 invoked by uid 109); 13 Sep 2017 12:34:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 12:34:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13657 invoked by uid 111); 13 Sep 2017 12:34:57 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 08:34:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Sep 2017 08:34:21 -0400
Date:   Wed, 13 Sep 2017 08:34:21 -0400
From:   Jeff King <peff@peff.net>
To:     demerphq <demerphq@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Bug: git branch --unset-upstream command can nuke config when
 disk is full.
Message-ID: <20170913123420.die3thfcpaweakce@sigill.intra.peff.net>
References: <CANgJU+Wj_sN8Px6rweHMw_iAX8UA3mW9x4NVCctpUCs8_3ytLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANgJU+Wj_sN8Px6rweHMw_iAX8UA3mW9x4NVCctpUCs8_3ytLw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 13, 2017 at 01:59:17PM +0200, demerphq wrote:

> After being away for a while I saw the following message in one of my git repos:
> 
> $ git status
> On branch yves/xxx
> Your branch is based on 'origin/yves/xxx', but the upstream is gone.
>   (use "git branch --unset-upstream" to fixup)
> 
> nothing to commit, working tree clean
> $ git branch --unset-upstream
> fatal: could not unset 'branch.yves/simple_projection.merge'

Hrm. I wonder what caused this failure. The error would be in
git_config_set_multivar_in_file_gently(). Most errors there produce
another error message before hitting the die(). In fact, the only case I
see where it would not produce another message is if it found nothing to
unset (but in that case, "branch" would never have called the function
in the first place).

> At this point my .git/config file was empty, and all of my config was lost.
> 
> I assume that things that rewrite .git/config do not check for a
> successful write before deleting the old version of the file.

No, it writes the new content to "config.lock" and then renames it into
place. All of the write() calls to the temporary file are checked. The
old data is copied over after having been ready by mmap (which is also
error-checked).

Given that your output is consistent with it failing to find the key,
and that the result is an empty file, it sounds like somehow the mmap'd
input appeared empty (but neither open nor fstat nor mmap returned an
error). You're not on any kind of exotic filesystem, are you?

-Peff
