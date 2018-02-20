Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8947B1F404
	for <e@80x24.org>; Tue, 20 Feb 2018 01:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932330AbeBTBW1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 20:22:27 -0500
Received: from imap.thunk.org ([74.207.234.97]:60042 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932280AbeBTBW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 20:22:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=OsuqgRUhsHxZ+rMUbsOQmwD4+juKRqfHJlPC2UpFRrE=; b=ts1Oz3WStdlXa2CC5iY6M8Bq5s
        RuUrzNnYoE+wpt022UhCbGuB7WdXRj/cuBuyZriboOFNc+u3rzd3FONTQkJ9F3e+4usK2CO3RPJ+g
        K8ZFaeAqhbkDx/uS5KJGg0XI9G/r4gDbSgH0DdI8c+tNh+NBsauWelPfmrYURvQtL+HM=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1enwdR-0000PV-Ey; Tue, 20 Feb 2018 01:22:21 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8BCF47A01F6; Mon, 19 Feb 2018 20:22:19 -0500 (EST)
Date:   Mon, 19 Feb 2018 20:22:19 -0500
From:   Theodore Ts'o <tytso@mit.edu>
To:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Git should preserve modification times at least on request
Message-ID: <20180220012219.GA9791@thunk.org>
References: <20180219212235.GA9891@helen.PLASMA.Xg8.DE>
 <nycvar.QRO.7.76.6.1802192257100.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180219220819.GA10466@helen.PLASMA.Xg8.DE>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219220819.GA10466@helen.PLASMA.Xg8.DE>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 19, 2018 at 11:08:19PM +0100, Peter Backes wrote:
> Is thetre some existing code that could be used? I think I read 
> somewhere that git once did preserve mtimes, but that this code was 
> removed because of the build tool issues. Perhaps that code could 
> simply be put back in, and surrounded by conditions.

I don't believe that was ever true, because the mod times is simply
not *stored* anywhere.

You might want to consider trying to implement it as hook scripts
first, and see how well/poorly it works for you.  I do have a use
case, which is to maintain the timestamps for guilt (a quilt-like
patch management system which uses git).  At the moment I just use a
manual script, save-timestamps, which looks like this:

#!/bin/sh
stat -c "touch -d @%Y %n" * | sort -k 3 | grep -v "~$" | sort -k3 > timestamps

and then I just include the timestamps file in thhe commit.  When I
unpack the file elsewhere, I just run the command ". timestamps", or
if I am manually editing a single file, I might do:

	grep file-name-of-patch timestamps | sht

This works because the timestamps file has lines which look like
this:

touch -d @1519007593 jbd2-clarify-recovery-checksum-error-msg

I've been too lazy to automate this using a "pre-commit" and
"post-checkout" hook, but it *really* wouldn't be that hard.  Right
now it also only works for files in the top-level of the repo, which
is all I have in my guilt patch repo.  Making this work in a
multiple-directory environment is also left as an exercise to the
reader.  :-)

Cheers,

						- Ted

P.S.  Also left to the reader is making it work on legacy OS's like
Windows.  :-)
