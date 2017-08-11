Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AF63208B8
	for <e@80x24.org>; Fri, 11 Aug 2017 07:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752273AbdHKHny (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 03:43:54 -0400
Received: from vie01a-dmta-pe07-1.mx.upcmail.net ([84.116.36.17]:41863 "EHLO
        vie01a-dmta-pe05-1.mx.upcmail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751932AbdHKHny (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 11 Aug 2017 03:43:54 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe07.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1dg4bo-0006JO-Av
        for git@vger.kernel.org; Fri, 11 Aug 2017 09:43:52 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id vjjh1v0145BuuEg01jjjSu; Fri, 11 Aug 2017 09:43:43 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id 9789945D4512; Fri, 11 Aug 2017 09:43:41 +0200 (CEST)
Date:   Fri, 11 Aug 2017 09:43:41 +0200
From:   Martin Koegler <martin.koegler@chello.at>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin Koegler <martin.koegler@chello.at>, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH V2 1/2] Fix delta integer overflows
Message-ID: <20170811074341.GD15128@mail.zuhause>
References: <1502348462-4992-1-git-send-email-martin@mail.zuhause>
 <xmqqmv772nmc.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmv772nmc.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 01:07:07PM -0700, Junio C Hamano wrote:
> > The current delta code produces incorrect pack objects for files > 4GB.
> >
> > Signed-off-by: Martin Koegler <martin.koegler@chello.at>
> 
> I am a bit torn on this change.
> 
> Given that this is not merely a local storage format but it also is
> an interchange format, we would probably want to make sure that the
> receiving end (e.g. get_delta_hdr_size() that is used at the
> beginning of patch_delta()) on a platform whose size_t is smaller
> than that of a platform that produced the delta stream with this
> code behaves "sensibly".

Overflows would already be detected during unpack:
* Assuming size_t = uint32, the system should just be able to handle up to 4GB of process memory.
So loading any source blob larger than 4GB should already fail.
* Assuming size_t = uint32 and a source blob size < 4 GB, the target blob size would be readed
truncated. apply_delta checks, that the generated result matches the encoded size - this check would
fail.
 
> If we replaced ulong we use in create/patch delta codepaths with
> uint32_t, that would be safer, just because the encoder would not be
> able to emit varint that is larger than the receivers to handle.
> But that defeats the whole point of using varint() to encode the
> sizes in the first place.  It was partly done for space saving, but
> more for allowing larger sizes and larger ulong in the future
> without having to change the file format.

The ondisk-format is able to handle larger sizes [using a slightly worse compression].
The current implementation is just buggy.

I would not move to uint32_t. The remaing part of git uses "unsigned long", so the 
delta code could still be called with larger files.

We will also see more RAM as well as CPU power - reducing the limits just because of older plattforms,
which can't even handle such large blobs, is the wrong way.

Regards,
Martin
