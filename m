From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Lockless Refs?
Date: Fri, 28 Dec 2012 18:07:23 -0700
Organization: CAF
Message-ID: <201212281807.23533.mfick@codeaurora.org>
References: <20121221080449.GA21741@sigill.intra.peff.net> <201212271611.52203.mfick@codeaurora.org> <7vlicijepv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 02:07:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Toktx-0003FK-51
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 02:07:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755161Ab2L2BHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 20:07:31 -0500
Received: from wolverine02.qualcomm.com ([199.106.114.251]:53715 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755077Ab2L2BHa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 20:07:30 -0500
X-IronPort-AV: E=Sophos;i="4.84,372,1355126400"; 
   d="scan'208";a="16992961"
Received: from pdmz-ns-snip_115_219.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.115.219])
  by wolverine02.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 Dec 2012 17:07:29 -0800
Received: from mfick-laptop.localnet (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 323C710004B1;
	Fri, 28 Dec 2012 17:07:28 -0800 (PST)
User-Agent: KMail/1.13.5 (Linux/2.6.32-41-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <7vlicijepv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212280>

On Friday, December 28, 2012 09:58:36 am Junio C Hamano 
wrote:
> Martin Fick <mfick@codeaurora.org> writes:
> > 3) To create a ref, it must be renamed from the null
> > file (sha 0000...) to the new value just as if it were
> > being updated from any other value, but there is one
> > extra condition: before renaming the null file, a full
> > directory scan must be done to ensure that the null
> > file is the only file in the directory...
> 
> While you are scanning this directory to make sure it is
> empty, 

The objective is not to scan for an empty dir, but to scan 
for the existence of only the null file.

> I am contemplating to create the same ref with a
> different value.  You finished checking but haven't
> created the null.

The scan needs to happen after creating the null, not before, 
so I don't believe the rest of the scenario below is possible 
then?

> I have also scanned, created the null
> and renamed it to my value.  Now you try to create the
> null, succeed, and then rename.  We won't know which of
> the two non-null values are valid, but worse yet, I think
> one of them should have failed in the first place.



> Sounds like we would need some form of locking around
> here.  Is your goal "no locks", or "less locks"?
(answered below)

> > I don't know how this new scheme could be made to work
> > with the current scheme,...
> 
> It is much more important to know if/why yours is better
> than the current scheme in the first place.  

The goal is: "no locks which do not have a clearly defined 
reliable recovery procedure".

Stale locks without a reliable recovery procedure will lead 
to stolen locks.  At this point it is only a matter of luck 
whether this leads to data loss or not.  So I do hope to 
convince people first that the current scheme is bad, not that 
my scheme is better!  My scheme was proposed to get people 
thinking that we may not have to use locks to get reliable 
updates.


> Without an
> analysis on how the new scheme interacts with the packed
> refs and gives better behaviour, that is kinda difficult.

Fair enough. I will attempt this if the basic idea seems at 
least sane?  I do hope that eventually the packed-refs piece 
and its locking will be reconsidered also; as Michael pointed 
out it has issues already.  So, I am hoping to get people 
thinking more about lockless approaches to all the pieces. I 
think I have some solutions to some of the other pieces also, 
but I don't want to overwhelm the discussion all at once 
(especially if my first piece is shown to be flawed, or if no 
one has any interest in eliminating the current locks?)

 
> I think transition plans can wait until that is done.  If
> it is not even marginally better, we do not have to worry
> about transitioning at all.  If it is only marginally
> better, the transition has to be designed to be no impact
> to the existing repositories.  If it is vastly better, we
> might be able to afford a flag day.

OK, makes sense, I jumped the gun a bit,

-Martin
