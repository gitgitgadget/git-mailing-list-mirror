From: Martin Fick <mfick@codeaurora.org>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Tue, 22 May 2012 18:46:37 -0600
Organization: CAF
Message-ID: <201205221846.38230.mfick@codeaurora.org>
References: <4FB9F92D.8000305@alum.mit.edu> <201205221619.31738.mfick@codeaurora.org> <7v8vgj3imy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 23 02:46:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWziv-00028c-M2
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 02:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932914Ab2EWAqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 20:46:40 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:52132 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756924Ab2EWAqj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 20:46:39 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6719"; a="193720164"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine01.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 May 2012 17:46:38 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id C0BFB10004A9;
	Tue, 22 May 2012 17:46:38 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32.49+drm33.21-mfick7; KDE/4.4.5; x86_64; ; )
In-Reply-To: <7v8vgj3imy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198269>

On Tuesday, May 22, 2012 05:23:17 pm Junio C Hamano wrote:
> Martin Fick <mfick@codeaurora.org> writes:
>
> I think we can ignore that 400 part from the above for
> now.  As they are independent "projects", it is
> unreasonable to expect that any solution would add costs
> less than linearly when you add more projects.  

As far as git is concerned, sure they are independent, but 
the projects aren't really independent.  Separate repos were 
likely selected for scalibility reasons in the first place, 
but this ends up being a "scale fail" pattern.  I don't 
expect git to fix this * 400 issue, but I want to highlight, 
how difficult it is to make things scale in these cases and 
that this problems is a natural multiplier when you split 
something into separate git repos because your tags tend to 
now be multiplied.  So while 10K tags sound like a lot but 
manageable for 1 repo, it ends up actually being 4M tags if 
you split your repos.


...
> I think the assumption in your build-bot scenario needs
> to be a bit more clarified to give context.  I am
> assuming, when you say "see if projects are up to date",
> you mean your build-bot is interested in a single branch
> in each repository, possibly together with new tags that
> have become reachable from the updated tip of the branch
> (if the branch tip moved). 

Just the branch generally.


> I also assume that the
> build-bot polls very often and that is why 200MB (or
> divided by 400 it would be 0.5MB, which still is a lot
> when you talk about a single repository) hurts a lot.

To clarify for others (since you likely know), we serialize 
our submits, so the "poll" is before every build to ensure 
that we are up to date with what just got merged.  In our 
case we use Gerrit with slaves (read only Gerrit copies), so 
we offload the "update" to the slave, which incurs the same 
hit, all though it is not quite a No Op but close (there 
will have been a batch of commits added to a few projects).  
But then since the slave may be slightly behind the master 
(replication from the master to the slave takes time, 
partially because of the same ref advertisement problem), so 
we want to verify the slave update by polling the master, 
which if replication was fast enough would be a No Op.  So, 
our attempts to scale by using slaves does not help very 
much since the real update and the No Op are almost 
identical in their impacts... There are workarounds, but 
mostly hacks.


...
> Unlike the capability exchange that happens after the
> initial connection, there is no gap in the protocol for
> the side that initiates the connection to tell the
> serving side to skip/delay the initial ref
> advertisement.

Crazy stupid suggestion: could the URI somehow be exploited 
to signal the option to disable advertisements?  What if the 
path part of the URI started with something like several 
slashes?  Older servers just strip the extra slashes right?  
Newer servers could disable advertisements if they see the 
slashes.  Of course, this gets ugly if scripts add slashes 
and expect them to be stripped (old clients talking to new 
servers would probably then fail),

-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
