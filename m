From: Martin Fick <mfick@codeaurora.org>
Subject: Re: [PATCH] git exproll: steps to tackle gc aggression
Date: Tue, 6 Aug 2013 18:10:46 -0600
Organization: CAF
Message-ID: <201308061810.46562.mfick@codeaurora.org>
References: <1375756727-1275-1-git-send-email-artagnon@gmail.com> <CACsJy8CGWJ07Uk8EBjfejdyshKB1NKk=_7VUoeyZWZgJFqCSkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 07 02:10:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6rL3-0008K0-Gn
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 02:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756014Ab3HGAKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 20:10:49 -0400
Received: from smtp.codeaurora.org ([198.145.11.231]:47895 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755125Ab3HGAKt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 20:10:49 -0400
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id C15E413EF02;
	Wed,  7 Aug 2013 00:10:48 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
	id B446513EF19; Wed,  7 Aug 2013 00:10:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	pdx-caf-smtp.dmz.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from mfick-lnx.localnet (mfick-lnx.qualcomm.com [129.46.10.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mfick@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 5285313EF02;
	Wed,  7 Aug 2013 00:10:48 +0000 (UTC)
User-Agent: KMail/1.13.5 (Linux/2.6.32.49+drm33.21-mfick7; KDE/4.4.5; x86_64; ; )
In-Reply-To: <CACsJy8CGWJ07Uk8EBjfejdyshKB1NKk=_7VUoeyZWZgJFqCSkg@mail.gmail.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231800>

On Tuesday, August 06, 2013 06:24:50 am Duy Nguyen wrote:
> On Tue, Aug 6, 2013 at 9:38 AM, Ramkumar Ramachandra 
<artagnon@gmail.com> wrote:
> > +               Garbage collect using a pseudo
> > logarithmic packfile maintenance +              
> > approach.  This approach attempts to minimize packfile
> > churn +               by keeping several generations
> > of varying sized packfiles around +               and
> > only consolidating packfiles (or loose objects) which
> > are +               either new packfiles, or packfiles
> > close to the same size as +               another
> > packfile.
> 
> I wonder if a simpler approach may be nearly efficient as
> this one: keep the largest pack out, repack the rest at
> fetch/push time so there are at most 2 packs at a time.
> Or we we could do the repack at 'gc --auto' time, but
> with lower pack threshold (about 10 or so). When the
> second pack is as big as, say half the size of the
> first, merge them into one at "gc --auto" time. This can
> be easily implemented in git-repack.sh.

It would definitely be better than the current gc approach.  

However, I suspect it is still at least one to two orders of 
magnitude off from where it should be.  To give you a real 
world example, on our server today when gitexproll ran on 
our kernel/msm repo, it consolidated 317 pack files into one 
almost 8M packfile (it compresses/dedupes shockingly well, 
one of those new packs was 33M).  Our largest packfile in 
that repo is 1.5G!  

So let's now imagine that the second closest packfile is 
only 100M, it would keep getting consolidated with 8M worth 
of data every day (assuming the same conditions and no extra 
compression).  That would take (750M-100M)/8M ~ 81 days to 
finally build up large enough to no longer consolidate the 
new packs with the second largest pack file daily.  During 
those 80+ days, it will be on average writing 325M too much 
per day (when it should be writing just 8M).

So I can see the appeal of a simple solution, unfortunately 
I think one layer would still "suck" though.  And if you are 
going to add even just one extra layer, I suspect that you 
might as well go the full distance since you probably 
already need to implement the logic to do so?

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation
 
