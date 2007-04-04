From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Show binary file size change in diff --stat
Date: Wed, 04 Apr 2007 10:47:56 -0700
Message-ID: <7vbqi458vn.fsf@assigned-by-dhcp.cox.net>
References: <200704041414.14797.andyparkins@gmail.com>
	<4613A974.60808@dawes.za.net>
	<200704041540.59977.andyparkins@gmail.com>
	<4613C97C.9050600@dawes.za.net>
	<Pine.LNX.4.63.0704041819340.4045@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0704040935350.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Rogan Dawes <lists@dawes.za.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 04 19:48:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ9ae-0003Ba-Vz
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 19:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbXDDRsI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 13:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752225AbXDDRsI
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 13:48:08 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:58926 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205AbXDDRsG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 13:48:06 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070404174756.KXLB792.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 4 Apr 2007 13:47:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id j5nw1W00X1kojtg0000000; Wed, 04 Apr 2007 13:47:57 -0400
In-Reply-To: <Pine.LNX.4.64.0704040935350.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 4 Apr 2007 09:40:13 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43761>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 4 Apr 2007, Johannes Schindelin wrote:
>> 
>> The subtle difference: your approach is _expensive_ in terms of CPU time, 
>> while the byte change approach is _dirt cheap_.
>
> Well, you could do a combination (still dirt cheap):
>  - show the size before/after (and yes, new/delete should be separate from 
>    "zero size before/after")
>  - show the size of the binary patch.
>
> No "X added bytes" vs "Y bytes deleted", just "size of binary patch". It 
> could be really small, even if 10k was deleted, or the file was totally 
> re-organized by moving chunks around.
>
> It would still be a meaningful thing to know - if only because it tells 
> you how much space the delta takes.

I agree wrt the kind of information to give, except that I am
not so sure about new/delete vs zero before/after.  We do not do
that for a text file, and when people do care about the
distinction, they would use --summary.

I often have wished that we could make --stat imply --summary;
the only reason we did not do that is because the --stat option
started its life as an imitation of "diffstat".

I've seen our diff-delta change its output size once.  It was a
nice improvement to make the delta much smaller than before, but
I had to rewrite the rename similarity in diffcore not to depend
on the diff-delta algorithm change, to keep it stable across
diff-delta improvements (the alternative was to futz with the
default threshold).  I suspect we might see similar confusion if
we show the delta size, depending on people's expectations.
This is a very minor issue, but I thought I should mention it.

There is a machine readable output format for the same --stat
information called --numstat.  It currently signals the
binary-ness by showing '-' instead of line count.  We could
extend it by showing '-' + number of bytes.

So here are some more suggestions:

 (1) --stat for binary files to show preimage and postimage
     sizes like this (if we were to do delta size -- otherwise
     drop " (.*" at the end):

	penguin.jpg |  Bin 745245 -> 660689 (delta: 4434)

 (2) --numstat for binary files to show preimage and postimage
     sizes like this:

	penguin.jpg	-745245	-660689

 (3) independent from all of the above, make --stat imply
     --summary and perhaps introduce --no-summary if people do not
     want --summary given when they say --stat;
