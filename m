From: Martin Fick <mfick@codeaurora.org>
Subject: Re: A naive proposal for preventing loose object explosions
Date: Fri, 6 Sep 2013 12:12:09 -0600
Organization: CAF
Message-ID: <201309061212.10165.mfick@codeaurora.org>
References: <54d0a7f13b53e15ad485e212057b85a3.squirrel@www.codeaurora.org> <xmqq61udzx4p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, nasserg@codeaurora.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 20:12:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI0W3-0008Eu-8X
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 20:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955Ab3IFSMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 14:12:15 -0400
Received: from smtp.codeaurora.org ([198.145.11.231]:36341 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877Ab3IFSMO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 14:12:14 -0400
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5E6D313EE0C;
	Fri,  6 Sep 2013 18:12:13 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
	id 4B86D13EFCC; Fri,  6 Sep 2013 18:12:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	pdx-caf-smtp.dmz.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from mfick-lnx.localnet (mfick-lnx.qualcomm.com [129.46.10.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mfick@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id BB4D813EE0C;
	Fri,  6 Sep 2013 18:12:12 +0000 (UTC)
User-Agent: KMail/1.13.5 (Linux/2.6.32.49+drm33.21-mfick7; KDE/4.4.5; x86_64; ; )
In-Reply-To: <xmqq61udzx4p.fsf@gitster.dls.corp.google.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234079>

On Friday, September 06, 2013 11:19:02 am Junio C Hamano 
wrote:
> mfick@codeaurora.org writes:
> > Object lookups should likely not get any slower than if
> > repack were not run, and the extra new pack might
> > actually help find some objects quicker.
> 
> In general, having an extra pack, only to keep objects
> that you know are available in other packs, will make
> _all_ object accesses, not just the ones that are
> contained in that extra pack, slower.

My assumption was that if the new pack, with all the 
consolidated reachable objects in it, happens to be searched 
first, it would actually speed things up.  And if it is 
searched last, then the objects weren't in the other packs 
so how could it have made it slower?  It seems this would 
only slow down the missing object path?

But it sounds like all the index files are mmaped up front?  
Then yes, I can see how it would slow things down.  However, 
it is one only extra (hopefully now well optimized) pack.  
My base assumption was that even if it does slow things 
down, it would likely be unmeasurable and a price worth 
paying to avoid an extreme penalty.


> Instead of mmapping all the .idx files for all the
> available packfiles, we could build a table that
> records, for each packed object, from which packfile at
> what offset the data is available to optimize the
> access, but obviously building that in-core table will
> take time, so it may not be a good trade-off to do so at
> runtime (a precomputed super-.idx that we can mmap at
> runtime might be a good way forward if that turns out to
> be the case).
> 
> > Does this sound like it would work?
> 
> Sorry, but it is unclear what problem you are trying to
> solve.

I think you guessed it below, I am trying to prevent loose 
object explosions by keeping unreachable objects around in 
packs (instead of loose) until expiry.  With the current way 
that pack-objects works, this is the best I could come up 
with (I said naive). :(

Today the git-repack calls git pack-objects like this:

git pack-objects --keep-true-parents --honor-pack-keep --
non-empty --all --reflog $args </dev/null "$PACKTMP"

This has no mechanism to place unreachable objects in a 
pack.  If git pack-objects supported an option which 
streamed them to a separate file (as you suggest below), 
that would likely be the main piece needed to avoid the 
heavy-handed approach I was suggesting.  

The problem is how to define the interface for this?  How do 
we get the filename of the new unreachable packfile?  Today 
the name of the new packfile is sent to stdout, would we 
just tack on another name?  That seems like it would break 
some assumptions?  Maybe it would be OK if it only did that 
when an --unreachable flag was added?  Then git-repack could 
be enhanced to understand that flag and the extra filenames 
it outputs?


> Is it that you do not like that "repack -A" ejects
> unreferenced objects and makes it loose, which you may
> have many?

Yes, several times a week we have people pushing the kernel 
to wrong projects, this leads to 4M loose objects. :(  
Without a solution for this regular problem, we are very 
scared to move our repos off of SSDs.  This leads to hour 
plus long fetches.


> The loosen_unused_packed_objects() function used by
> "repack -A" calls the force_object_loose() function
> (actually, it is the sole caller of the function).  If
> you tweak the latter to stream to a single new
> "graveyard" packfile and mark it as "kept until expiry",
> would it solve the issue the same way but with much
> smaller impact?

Yes.
 
> There already is an infrastructure available to open a
> single output packfile and send multiple objects to it
> in bulk-checkin.c, and I am wondering if you can take
> advantage of the framework.  The existing interface to
> it assumes that the object data is coming from a file
> descriptor (the interface was built to support
> bulk-checkin of many objects in an empty repository),
> and it needs refactoring to allow stream_to_pack() to
> take different kind of data sources in the form of
> stateful callback function, though.

That feels beyond what I could currently dedicate the time 
to do.  Like I said, my solution is heavy handed but it felt 
simple enough for me to try.  I can spare the extra disk 
space and I am not convinced the performance hit would be 
bad.  I would, of course, be delighted if someone else were 
to do what you suggest, but I get that it's my itch...

-Martin


-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation
 
