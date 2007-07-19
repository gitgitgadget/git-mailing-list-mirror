From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Wed, 18 Jul 2007 22:28:12 -0700
Message-ID: <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net>
References: <85lkdezi08.fsf@lola.goethe.zz>
	<Pine.LNX.4.64.0707180135200.14781@racer.site>
	<858x9ez1li.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
	<vpq4pk1vf7q.fsf@bauges.imag.fr>
	<alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org>
	<85644hxujp.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
	<alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
	<85abttwa7m.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 19 07:28:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBOYj-0004Hi-No
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 07:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbXGSF2O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 01:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbXGSF2O
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 01:28:14 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:38810 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715AbXGSF2N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 01:28:13 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070719052812.JGHJ1428.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 19 Jul 2007 01:28:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RHUC1X0081kojtg0000000; Thu, 19 Jul 2007 01:28:13 -0400
In-Reply-To: <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 18 Jul 2007 17:22:57 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52935>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 19 Jul 2007, David Kastrup wrote:
>> 
>> Well, kudos.  Together with the analysis from Junio, this seems like a
>> good start.  Would you have any recommendations about what stuff one
>> should really read in order to get up to scratch about git internals?
>
> Well, you do need to understand the index. That's where all the new 
> subtlety happens.
>
> The data structures themselves are trivial, and we've supported empty 
> trees (at the top level) from the beginning, so that part is not anything 
> new.
>
> However, now having a new entry type in the index (S_IFDIR) means that 
> anything that interacts with the index needs to think twice. But a lot of 
> that is just testing what happens, and so the first thing to do is to have 
> a test-suite.
>
> There's also the question about how to show an empty tree in a diff. We've 
> never had that: the only time we had empty trees was when we compared a 
> totally empty "root" tree against another tree, and then it was obvious. 
> But what if the empty tree is a subdirectory of another tree - how do you 
> express that in a diff? Do you care? Right now, since we always recurse 
> into the tree (and then not find anything), empty trees will simply not 
> show up _at_all_ in any diffs.
>
> And what about usability issues elsewhere? With my patch, doing something 
> like a
>
> 	git add directory/
>
> still won't do anything, because the behaviour of "git add" has always 
> been to recurse into directories. So to add a new empty directory, you'd 
> have to do
>
> 	git update-index --add directory
>
> and that's not exactly user-friendly.
>
> So do you add a "-n" flag to "git add" to tell it to not recurse? Or do 
> you always recurse, but then if you notice that the end result is empty, 
> you add it as a directory?

Another issue I thought about was what you would do in the step
3 in the following:

 1. David says "mkdir D; git add D"; you add S_IFDIR entry in
    the index at D;

 2. David says "date >D/F; git add D/F"; presumably you drop D
    from the index (to keep the index more backward compatible)
    and add S_IFREG entry at D/F.

 3. David says "git rm D/F".

Have we stopped keeping track of the "empty directory" at this
point?
