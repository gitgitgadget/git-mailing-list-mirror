Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D14C63797
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 09:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjAPJOd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 04:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjAPJOD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 04:14:03 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B42812592
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 01:13:48 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8B2F835261;
        Mon, 16 Jan 2023 09:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1673860427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=itJth4Hj6bfJ8hK4z4beRJHuIaSSx/x7NfDqnvQPj5w=;
        b=LKKTJuroeOHh/LgkFKSjVveBRyEnhTM0uWGOF43KX5TXeuIP8qUi57LnaZ8FuK0WLI1C9R
        l3sY3JJQQ/cnk4YNMu8QrIQ+BYUxQnkFPNKp3qlrE+KCMFQ/8xzhHEqgEJUvJu8qtox0c6
        q6mWbdFEO7DBU73kyqsEM2/wxJ8l6iU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1673860427;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=itJth4Hj6bfJ8hK4z4beRJHuIaSSx/x7NfDqnvQPj5w=;
        b=XNVHfLb6emEDhdCCl+ZFO8WJBuRTJtIHf6vNPjy+yYpTjtZWPiwwFJ0DWk1pUkRDvUh9lz
        wwfeQy5qEZpfG8AA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7A4BA2C145;
        Mon, 16 Jan 2023 09:13:47 +0000 (UTC)
Date:   Mon, 16 Jan 2023 10:13:46 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Hans Petter Selasky <hps@selasky.org>
Cc:     git@vger.kernel.org
Subject: Re: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
Message-ID: <20230116091346.GC16547@kitsune.suse.cz>
References: <9c0fda42-67ab-f406-489b-38a2d9bbcfc2@selasky.org>
 <20230115135245.GB16547@kitsune.suse.cz>
 <b1984123-569a-c290-8048-158c1c5e08b4@selasky.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1984123-569a-c290-8048-158c1c5e08b4@selasky.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 16, 2023 at 08:17:58AM +0100, Hans Petter Selasky wrote:
> On 1/15/23 14:53, Michal Suchánek wrote:
> > > Many people think that bit errors cannot happen because the memory uses ECC
> > > and the file system uses cryptographic hashes to verify the integrity of the
> > > data. But what many people forget about is that when copying data from
> > > memory to disk, typically using a DMA channel data is copied w/o any kind of
> > > integrity protection, because the integrity protection is not end-to-end.
> > > The integrity protection is only per-link.
> >
> > So long as all links have integrity protection it's end-to-end.
> >
> 
> Hi Michael,
> 
> You clearly don't see what this is about! Only if the same CRC mechanism is
> end-to-end, you don't have any good integrity mechanism at all!
> 
> Let me try to explain what this is about in very simple words. Because
> memcpy() does not copy the ECC CRC values along with the data, it is an
> unsafe memory copy mechanism, which may introduce bit-errors without
> noticing. It does not help to only have ECC RAM or for that sake protect the
> PCI links.
The ECC protects against 1bit errors - so long as only 1 bit is flipped
along that path it is corrected.

If you have bigger errors ECC can sometimes detect them and your system
crashes or whatever, and sometimes they go unnoticed.

It does not make sense to copy around that CRC. It is used to recover
the corrupted bit, and when that data is copied to a new location a new
CRC is calculated that can detect an error in that location. Copying
that checksum around would only accumulate the errors.

Of course, that assumes that the corruption happens only in the cheaper
external long-term storage, and data does not get corrupted as it goes
through your CPU where it is stored only a few CPU cycles at a time. It
is mostly the case but when you need extreme reliability system-level
schemes that mitigate this possibility do exist.

Thanks

Michal
