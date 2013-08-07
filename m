From: Martin Fick <mfick@codeaurora.org>
Subject: Re: [PATCH] git exproll: steps to tackle gc aggression
Date: Tue, 6 Aug 2013 18:25:28 -0600
Organization: CAF
Message-ID: <201308061825.28579.mfick@codeaurora.org>
References: <1375756727-1275-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 07 02:25:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6rZI-00083U-9H
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 02:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756365Ab3HGAZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 20:25:32 -0400
Received: from smtp.codeaurora.org ([198.145.11.231]:48379 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756326Ab3HGAZb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 20:25:31 -0400
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id E48C513F10E;
	Wed,  7 Aug 2013 00:25:30 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
	id D8D3113F342; Wed,  7 Aug 2013 00:25:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	pdx-caf-smtp.dmz.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from mfick-lnx.localnet (mfick-lnx.qualcomm.com [129.46.10.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mfick@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 5B60713F10E;
	Wed,  7 Aug 2013 00:25:30 +0000 (UTC)
User-Agent: KMail/1.13.5 (Linux/2.6.32.49+drm33.21-mfick7; KDE/4.4.5; x86_64; ; )
In-Reply-To: <1375756727-1275-1-git-send-email-artagnon@gmail.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231801>

On Monday, August 05, 2013 08:38:47 pm Ramkumar Ramachandra 
wrote:
> This is the rough explanation I wrote down after reading
> it:
> 
> So, the problem is that my .git/objects/pack is polluted
> with little packs everytime I fetch (or push, if you're
> the server), and this is problematic from the
> perspective of a overtly (naively) aggressive gc that
> hammers out all fragmentation.  So, on the first run,
> the little packfiles I have are all "consolidated" into
> big packfiles; you also write .keep files to say that
> "don't gc these big packs we just generated".  In
> subsequent runs, the little packfiles from the fetch are
> absorbed into a pack that is immune to gc.  You're also
> using a size heuristic, to consolidate similarly sized
> packfiles.  You also have a --ratio to tweak the ratio
> of sizes.
> 
> From: Martin Fick<mfick@codeaurora.org>
> See: https://gerrit-review.googlesource.com/#/c/35215/
> Thread:
> http://thread.gmane.org/gmane.comp.version-control.git/2
> 31555 (Martin's emails are missing from the archive)
> ---

After analyzing today's data, I recognize that in some 
circumstances the size estimation after consolidation can be 
off by huge amounts.  The script naively just adds the 
current sizes together.  This gives a very rough estimate, 
of the new packfile size, but sometimes it can be off by 
over 2 orders of magnitude. :(  While many new packfiles are 
tiny (several K only), it seems like the larger new 
packfiles have a terrible tendency to throw the estimate way 
off (I suspect they simply have many duplicate objects).  
But despite this poor estimate, the script still offers 
drastic improvements over plain git gc.

So, it has me wondering if there isn't a more accurate way 
to estimate the new packfile without wasting a ton of time?

If not, one approach which might be worth experimenting with 
is to just assume that new packfiles have size 0!  Then just 
consolidate them with any other packfile which is ready for 
consolidation, or if none are ready, with the smallest 
packfile.  I would not be surprised to see this work on 
average better than the current summation,

-Martin


-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation
 
