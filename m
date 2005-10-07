From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add support for parallel HTTP transfers
Date: Fri, 07 Oct 2005 11:08:17 -0700
Message-ID: <7vhdbt42um.fsf@assigned-by-dhcp.cox.net>
References: <20051005214447.GF15593@reactrix.com>
	<Pine.LNX.4.63.0510061550510.23242@iabervon.org>
	<20051007000041.GH15593@reactrix.com>
	<Pine.LNX.4.63.0510071149550.23242@iabervon.org>
	<7v8xx55kia.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0510071323070.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 07 20:10:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENwdq-0008NY-Ie
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 20:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030542AbVJGSIU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 14:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030543AbVJGSIT
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 14:08:19 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:37015 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1030542AbVJGSIT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2005 14:08:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051007180814.BASF16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Oct 2005 14:08:14 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0510071323070.23242@iabervon.org> (Daniel
	Barkalow's message of "Fri, 7 Oct 2005 13:41:48 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9810>

Daniel Barkalow <barkalow@iabervon.org> writes:

>> The check was added in 029f6de377c7e0484f5c4cf070934599580f1784
>> because back then calling fetch() on an object that we already
>> had had a funny interaction with what http-fetch.c did.  I
>> suspect that Nick's curl-multi changes made it unnecessary, but
>> you should double check for other transports.
>
> Hmm; my intended convention was that fetch() would always be called if 
> prefetch() was called, even if something had happened to make it appear in 
> between (e.g., prefetch() causing it to be fetched or a different call to 
> fetch() speculatively also getting it).

When I re-read the code, I think that check was probably a wrong
fix to begin with.

The original problem sequence, when the http-fetch was still
synchronous, was this:

 (1) we ask for an object, fetch_object() did not find one and
     fetch_pack() got a pack that contained the object and
     installed it;  the pack is removed from the "yet to be
     downloaded from this repository" list.

 (2) we ask for another object, fetch_object() did not find one
     and fetch_pack() was asked to see if there is a pack we
     have not downloaded that contained the object -- the pack
     downloaded in step (1) did not count, and this request
     failed.  Overall fetch() said "Nope, I cannot get it", when
     it already had one.

We should remove that check as you suggested, and fix fetch()
implementation in http-fetch.c to notice the above situation,
perhaps?
