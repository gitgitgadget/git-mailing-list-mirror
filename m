Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F56DC38142
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 20:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjAaUqW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 15:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjAaUqV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 15:46:21 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E7B59B65
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 12:45:53 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3DADB336B7;
        Tue, 31 Jan 2023 20:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1675197952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UTlbCN+9FSAgwoms2oh0gZObGFinIm94VUIz77QxdM0=;
        b=Pvm8ysQ4gWzKY4gfvvvls3BnvpUvxpWCbRnaForXUMpCq62ZgfchQvLkF6SqWGErD4oKSz
        XGkCH7lVRxktVRX/Y7Qw/6GhKAuSNsS+hsHgiYQUcZT+mmAixJahEQFCN4kAHhkHvjFC6M
        sQEPDTlbT+/4SY1UpyZa47MJN9IpeMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1675197952;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UTlbCN+9FSAgwoms2oh0gZObGFinIm94VUIz77QxdM0=;
        b=Kq6DxpAhRAEHcZFIKDsUxWthROlD6MU26hzMilwl5FJFxHotqLD4WnQ1tUQkz7JAQJFCeM
        /1j9xZ9/4F7ZWwBw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 11EC12C141;
        Tue, 31 Jan 2023 20:45:52 +0000 (UTC)
Date:   Tue, 31 Jan 2023 21:45:50 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Eli Schwartz <eschwartz93@gmail.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>
Subject: Re: Stability of git-archive, breaking (?) the Github universe, and
 a possible solution
Message-ID: <20230131204550.GI19419@kitsune.suse.cz>
References: <a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com>
 <Y9jlWYLzZ/yy4NqD@tapette.crustytoothpaste.net>
 <6fc8e122-a190-c291-c347-258a5a2ad9c9@gmail.com>
 <20230131162049.mgqdxcucjesw4afr@meerkat.local>
 <df7b0b43-efa2-ea04-dc5b-9515e7f1d86f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df7b0b43-efa2-ea04-dc5b-9515e7f1d86f@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 31, 2023 at 11:34:59AM -0500, Eli Schwartz wrote:
> On 1/31/23 11:20 AM, Konstantin Ryabitsev wrote:
> > On Tue, Jan 31, 2023 at 10:56:52AM -0500, Eli Schwartz wrote:
> >> And for tarballs that are generated once and uploaded to ftp storage,
> >> not repeatedly generated on the fly, we know the checksum will never
> >> legitimately change, so we *want* to hash the compressed file.
> >> Decompressing kernel.org tarballs in order to run PGP on them is *slow*.
> > 
> > FWIW, the most correct way is:
> > 
> > * download sha256sums.asc and verify its signature (auto-signed by infra)
> > * download the tarball you want and verify that the checksum matches
> > * uncompress and verify the PGP signature (signed by developer)
> > 
> > This script implements this workflow:
> > https://git.kernel.org/pub/scm/linux/kernel/git/mricon/korg-helpers.git/tree/get-verified-tarball
> 
> 
> This is just what I said, but with an additional first step for when you
> are updating to a new tarball and don't have your own checksums
> integrated into your own ecosystem tracking.
> 
> In most contexts, it's utterly unacceptable to not remember the checksum
> of the file you used last time and instead simply trust PGP identity
> verification. This permits upstream the technical means to be malicious,
> and re-upload a totally different tarball with the same name, different
> contents, and different PGP signature, and you will never notice because
> the PGP signature is still okay.

But where is the hash remembered?

The signature is a hash+signature, it you can replace that, you can also
repolace a hash without a signature.

You can store hashesd of anything you want locally, and indeed such
stored hashes in some build systemns did detect some code hosting
corruption but that's not for upstream to do, that's something that only
unrelated third party can do.

Thanks

Michal
