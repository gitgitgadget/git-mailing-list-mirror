From: Martin Fick <mfick@codeaurora.org>
Subject: Re: [BUG?] gc and impatience
Date: Mon, 5 Aug 2013 12:45:07 -0600
Organization: CAF
Message-ID: <201308051245.07995.mfick@codeaurora.org>
References: <1rpxs5pa827iefbyduyodlc7.1375495435629@email.android.com> <CALkWK0=djXdPMOvk8359nOs=rGLbBepxyXnpELfWs+wjjN7YZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Martin Fick <mfick@codeauror.org>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 20:45:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6PmQ-0001Yc-L2
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 20:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893Ab3HESpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 14:45:12 -0400
Received: from smtp.codeaurora.org ([198.145.11.231]:57132 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825Ab3HESpL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 14:45:11 -0400
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id 977AD13EEDF;
	Mon,  5 Aug 2013 18:45:10 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
	id 8AF7E13EFA7; Mon,  5 Aug 2013 18:45:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	pdx-caf-smtp.dmz.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from mfick-lnx.localnet (mfick-lnx.qualcomm.com [129.46.10.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mfick@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 33A6613EEDF;
	Mon,  5 Aug 2013 18:45:10 +0000 (UTC)
User-Agent: KMail/1.13.5 (Linux/2.6.32.49+drm33.21-mfick7; KDE/4.4.5; x86_64; ; )
In-Reply-To: <CALkWK0=djXdPMOvk8359nOs=rGLbBepxyXnpELfWs+wjjN7YZw@mail.gmail.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231688>

On Monday, August 05, 2013 11:34:24 am Ramkumar Ramachandra 
wrote:
> Martin Fick wrote:
> > https://gerrit-review.googlesource.com/#/c/35215/
> 
> Very cool. Of what I understood:
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

Yes, pretty much.  

I suspect that a smarter implementation would do a "less 
good job of packing" to save time also.  I think this can be 
done by further limiting much of the lookups to the packs 
being packed (or some limited set of the greater packfiles).  
I admit I don't really understand how much the packing does 
today, but I believe it still looks at the larger packs with 
keeps to potentially deltafy against them, or to determine 
which objects are duplicated and thus should not be put into 
the new smaller packfiles?  I say this because the time 
savings of this script is not as significant as I would have 
expected it to be (but the IO is).  I think that it is 
possible to design a git gc using this rolling approach that 
would actually greatly reduce the time spent packing also.  
However, I don't think that can easily be done in a script 
like mine which just wraps itself around git gc.  I hope 
that someone more familiar with git gc than me might take 
this on some day. :)


> I've checked it in and started using it; so yeah: I'll
> chew on it for a few weeks.

The script also does some nasty timestamp manipulations that 
I am not proud of.  They had significant time impacts for 
us, and likely could have been achieved some other way.  
They shouldn't be relevant to the packing algo though.  I 
hope it doesn't interfere with the evaluation of the 
approach.

Thanks for taking an interest in it,

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation
 
