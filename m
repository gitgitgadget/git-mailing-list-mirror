From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/5] index-pack: --verify
Date: Mon, 28 Feb 2011 09:48:57 -0800
Message-ID: <20110228174857.GB17278@spearce.org>
References: <1298886583-30965-1-git-send-email-gitster@pobox.com>
 <1298886583-30965-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 18:49:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu7DY-0008Q5-9m
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 18:49:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824Ab1B1RtB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 12:49:01 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38393 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509Ab1B1RtB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 12:49:01 -0500
Received: by pwi15 with SMTP id 15so767283pwi.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 09:49:00 -0800 (PST)
Received: by 10.143.132.6 with SMTP id j6mr4488937wfn.264.1298915340760;
        Mon, 28 Feb 2011 09:49:00 -0800 (PST)
Received: from localhost (sop.mtv.corp.google.com [172.18.74.69])
        by mx.google.com with ESMTPS id w19sm6262794wfd.20.2011.02.28.09.48.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Feb 2011 09:48:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1298886583-30965-4-git-send-email-gitster@pobox.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168127>

Junio C Hamano <gitster@pobox.com> wrote:
> Given an existing .pack file and the .idx file that describes it,
> this new mode of operation reads and re-index the packfile and makes
> sure the existing .idx file matches the result byte-for-byte.
> 
> All the objects in the .pack file are validated during this operation as
> well.  Unlike verify-pack, which visits each object described in the .idx
> file in the SHA-1 order, index-pack efficiently exploits the delta-chain
> to avoid rebuilding the objects that are used as the base of deltified
> objects over and over again while validating the objects.  This should
> result in much quicker verification of the .pack file and its .idx file.
> 
> This version however cannot verify a .pack/.idx pair with a handcrafted v2
> index that uses 64-bit offset representation for offsets that would fit
> within 31-bit. You can create such an .idx file by giving a custom offset
> to --index-version option to the command.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * This does not make much of a difference in a small project like git.git
>    itself, especially when the repository is packed with not very big depth
>    value.

However it is useful on larger repositories, like linux-2.6. I'd like
to see this series cleaned up and submitted, because as Peff's tests
shows, it shaves 1 minute off the linux-2.6 fsck.

Skim reading the code it mostly looked OK, though the NEEDSWORK
stuff has to be cleaned up. And I wonder if the series cannot be
flipped around a bit to put the 4/5 earlier and try to avoid a
stage where `index-pack --verify` doesn't do the right thing on
the hand-rolled lower 32 bit index limit.

In this patch I'm not happy about csum-file having this check_fd
part of its contents. But its probably the shortest way to inject
validation into index-pack without butchering a large part of its
index generation function.

-- 
Shawn.
