From: Bill Lear <rael@zopyra.com>
Subject: Re: Git checkout preserve timestamp?
Date: Mon, 5 Mar 2007 16:25:24 -0600
Message-ID: <17900.39124.763603.695942@lisa.zopyra.com>
References: <17895.18265.710811.536526@lisa.zopyra.com>
	<20070302091426.GA2605@diana.vm.bytemark.co.uk>
	<17896.9631.316001.869157@lisa.zopyra.com>
	<Pine.LNX.4.63.0703021618000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070302162136.GA9593@diana.vm.bytemark.co.uk>
	<Pine.LNX.4.63.0703022018190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070305072323.GA31169@diana.vm.bytemark.co.uk>
	<Pine.LNX.4.63.0703051230390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17900.27067.247950.419438@lisa.zopyra.com>
	<Pine.LNX.4.63.0703052014020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17900.30394.172067.743310@lisa.zopyra.com>
	<Pine.LNX.4.63.0703052143120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17900.36569.805689.922989@lisa.zopyra.com>
	<Pine.LNX.4.64.0703051347490.3998@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 05 23:26:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOLdC-0002ZG-EA
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 23:26:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbXCEWZi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 17:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751552AbXCEWZi
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 17:25:38 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60266 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751443AbXCEWZh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 17:25:37 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l25MPRV06875;
	Mon, 5 Mar 2007 16:25:27 -0600
In-Reply-To: <Pine.LNX.4.64.0703051347490.3998@woody.linux-foundation.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41495>

On Monday, March 5, 2007 at 13:50:45 (-0800) Linus Torvalds writes:
>On Mon, 5 Mar 2007, Bill Lear wrote:
>> 
>> Not because git wrote the file, but because git notices that content
>> changes, and writes the file (and timestamps it) "smartly".  If
>> someone writes into the repo, the timestamp stored becomes invalidated
>> and the write of the file just creates the timestamp at the time of
>> the checkout.  If no write into the repo index occurs, the stored
>> timestamp is applied after the file is checked out.
>
>But Bill, don't you realize that restoring the timestamp is *WRONG*?

Maybe, maybe not.  Each argument I've seen doesn't convince me.  Sure,
it may be MESSY.  It may be UGLY, and therefore undesirable, but I
don't think any of the arguments have conclusively shown that it
is WRONG or INFEASIBLE in any way.

>There's no way that git can know whether you did a "make" in between 
>switching back and forth between branches. ...

Why should I care whether git knows this?  I never said it should.  As
I said, if I have make products in separate, per-branch directories (a
minor extension to my current make system), I don't see how this would
be confusing in the least.  Git should only care if the content of the
file in the index changes.  It shouldn't care in the least about my
make products.

>                                      .... That's true on a very 
>fundamental level, but it's doubly true when anybody uses a separate 
>object directory (which doesn't leave any information *at*all* in the 
>source tree about the fact that somebody did a "make").

Here's the flow.  Perhaps I'm fundamentally confused, and I'll be
the first to admit that is true in plenty of ways:

I edit sourcefile.c, compile it, then commit it with
N=timestamp(sourcefile.c) on master.  N is <
timestamp(.master/sourcefile.o).  I then switch to branchX.  N is
stored by git for master:sourcefile.c.  No stored timestamp are on
this branch, so the file gets the timestamp it gets on checkout
M=timestamp(sourcefile.c).  I compile the file again, all is well.  I
move back to master branch.  Git stores M as branchX:sourcefile.c Git
checks out the file, and stamps it with N.  I do a make.  No
recompilation happens.  I switch back to branchX, the file is checked
out and stamped with timestamp M.  I do a make.  No recompilation
happens.  Happy happy, joy joy.  If someone pushes into my repo,
as Johannes suggested (how that would work, being a non-bare
repo, is beyond me, but whatever), the timestamp for that file
on that branch would be invalidated, and the file would get
whatever timestamp it got when it was written to disk.

Now, all of this may be DISTASTEFUL, UGLY, POOR DESIGN, etc., but I
don't see how it is WRONG.  As someone who has professed the motto
"actually useful is a lot better than clean, but not as useful",
I fail to see what has gotten you so exercised about this.

>So stop even asking for this. We'd have to be totally and utterly 
>incompetent to do what you ask for. We're simply not that stupid. 
>
>We already pointed out how you can do what you want to do *other* ways 
>that are *not* idiotic and incompetent. I don't think you even answered.

I am not asking for this, I'm just arguing the point, waiting for a
convincing argument rather than having someone call me "idiotic and
incompetent" and "stupid" for asking for it in the first place and
carrying on in the spirit of discovery and open learning.

For your information, I did in fact answer, politely, thanking the
poster for pointing our hash-based "stamps" that could do this sort of
thing.  I downloaded the software pointed to and tried it out,
unsuccessfully, as it will require redoing our make system (not
that I'm opposed to that, just that it will take time).

So ... thanks.


Bill
