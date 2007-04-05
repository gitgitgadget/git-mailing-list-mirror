From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] git-fetch: use fetch--tool pick-rref to avoid local fetch from alternate
Date: Thu, 05 Apr 2007 14:37:26 -0700
Message-ID: <7v7isqo63t.fsf@assigned-by-dhcp.cox.net>
References: <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
	<Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
	<alpine.LFD.0.98.0704031625050.28181@xanadu.home>
	<Pine.LNX.4.64.0704031346250.6730@woody.linux-foundation.org>
	<20070403210319.GH27706@spearce.org>
	<Pine.LNX.4.64.0704031411320.6730@woody.linux-foundation.org>
	<20070403211709.GJ27706@spearce.org>
	<Pine.LNX.4.64.0704031425220.6730@woody.linux-foundation.org>
	<Pine.LNX.4.64.0704031427050.6730@woody.linux-foundation.org>
	<7v1wizrugw.fsf@assigned-by-dhcp.cox.net>
	<20070405161537.GJ5436@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@cam.org>, Chris Lee <clee@kde.org>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Apr 05 23:37:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZZeK-0001HU-1G
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 23:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767343AbXDEVhb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 17:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767344AbXDEVhb
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 17:37:31 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:40785 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767343AbXDEVh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 17:37:28 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070405213726.OKBT24385.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Apr 2007 17:37:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id jZdS1W00a1kojtg0000000; Thu, 05 Apr 2007 17:37:27 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43860>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> +			# This will barf when $theirs reach an object that
>> +			# we do not have in our repository.  Otherwise,
>> +			# we already have everything the fetch would bring in.
>> +			git-rev-list --objects $theirs --not --all 2>/dev/null
>
> OK, I must be missing something here.
>
> That rev-list is going to print out the SHA-1s for the objects we
> would have copied, but didn't, isn't it?  So fetch--tool native-store
> is going to get a whole lot of SHA-1s it doesn't want to see, right?

True.  We should send the standard output also to /dev/null.

> Otherwise this is a nice trick.  It doesn't assure us that after the
> fetch those objects are still in the alternate.  Meaning someone
> could run prune in the alternate between the rev-list and the
> native-store, and whack these objects.  Given how small of a window
> it is, and the improvements this brings to alternates, I say its
> worth that small downside.  Just don't prune while fetching.  ;-)

That is "don't prune after making an alternate that depends on
you" in general.  Without this patch, and without the keep
(i.e. when the fetch is very small and the transfarred pack is
given to unpack-objects) you would have depended on the
alternates for those objects anyway.
