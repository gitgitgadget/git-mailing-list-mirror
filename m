From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 09/13] drop objects larger than --blob-limit if specified
Date: Fri, 06 Apr 2007 15:33:23 -0700
Message-ID: <7v1wixjfpo.fsf@assigned-by-dhcp.cox.net>
References: <56b7f5510704051536s7de9638fs8cd811d580f6a7dc@mail.gmail.com>
	<alpine.LFD.0.98.0704052103410.28181@xanadu.home>
	<56b7f5510704051919v7daac590m6ac52c4fcabd5321@mail.gmail.com>
	<alpine.LFD.0.98.0704052257200.28181@xanadu.home>
	<Pine.LNX.4.64.0704060845120.6730@woody.linux-foundation.org>
	<56b7f5510704061109n2878a221p391b7c3edba89c63@mail.gmail.com>
	<Pine.LNX.4.64.0704061214230.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dana How <danahow@gmail.com>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Apr 07 01:57:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZwzp-0004u2-EW
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 00:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933152AbXDFWd0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 18:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933256AbXDFWd0
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 18:33:26 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:60141 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933217AbXDFWdY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 18:33:24 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070406223324.JCCG24385.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 6 Apr 2007 18:33:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id jyZP1W0041kojtg0000000; Fri, 06 Apr 2007 18:33:23 -0400
In-Reply-To: <Pine.LNX.4.64.0704061214230.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 6 Apr 2007 12:24:53 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43936>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 6 Apr 2007, Dana How wrote:
>> ...
>> * Avoiding (e.g.) 2GB+ files when none already exist in the repository --
>>  either the filesystem doesn't support anything beyond the limit,
>>  or we don't want to use a >31b off_t with mmap.  (Perhaps
>>  the latter case is completely avoided by some glibc 64b trickery,
>>  but is that always true?)  Only the write rollback approach can address this.
>
> I disagree violently. 
>
> IN THEORY only write rollback can address that. But "theory" is not 
> practice, and anybody who thinks that theory is even *relevant* here is 
> missing the big picture.

Although I agree the "starting offset" is a very good
compromise, if we talk about THEORY, you should be able to
notice you are going to go beyond the limit inside write_one().
At that point, we know everything we need to know about all
objects that might be involved in writing that one object: if
they have been written out, what their offsets are, and how big
their in-pack representation will be.

And I agree with Nico that rollback after a failed write beyond
the boundary may not work correctly, so if we really want to do
this safely and sanely while satisfying Dana's desire to have a
hard limit, I think something like this is needed:

 - use "starting offset" to decide when to split;

 - introduce a "hard limit", perhaps optionally, to make sure
   that the result of writing out a packfile does not overstep
   that limit (i.e. the last object written below the "starting
   offset limit" might make the pack go over 700MB).

which means you would specify 600 as starting offset limit and
680 (or something like that) as the hard tail offset limit

> Again, *in*practice*, for any sane situation, if you want to fit things on 
> a CD-ROM, just give a limit of 600MB, and I can pretty much guarantee that 
> you'll see a slop of just a percent or two for any realistic setup. And if 
> it goes up to 660MB, you'll still fit on any CD.

if you really care the result fits on a CD.
