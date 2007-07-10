From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] series headers
Date: Mon, 09 Jul 2007 23:57:21 -0700
Message-ID: <7vejjgsq3y.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707100126250.6977@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Jul 10 08:57:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I89f6-0008Vw-4O
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 08:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762380AbXGJG5X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 02:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762370AbXGJG5X
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 02:57:23 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:34664 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762014AbXGJG5W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 02:57:22 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070710065722.WNHW1393.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Tue, 10 Jul 2007 02:57:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MixM1X0041kojtg0000000; Tue, 10 Jul 2007 02:57:21 -0400
In-Reply-To: <Pine.LNX.4.64.0707100126250.6977@iabervon.org> (Daniel
	Barkalow's message of "Tue, 10 Jul 2007 02:14:00 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52048>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I'd like to be able to get format-patch to produce a [PATCH 0/N] message, 
> with a message that's actually in my repository, plus various goodies 
> generated either from diffing the ends of the series or by running through 
> the log an extra time to pick up summary information.

So far, so good.

> As far as implementing this... would it be sane to make struct 
> rev_info.commit_format a callback, so that the code to generate an email 
> message can be somewhere that's easy to use to generate an email that 
> isn't for a commit in the log? I don't *think* git's quite fast enough for 
> the indirect jump to a callback instead of an if tree for an enum will 
> actually hurt us.

I suspect that temptation to touch rev_info.commit_format arises
purely because you are thinking about making 0/N a (perhaps
fake) commit.  I do not see a point in that.

What is the workflow?

 $ work work work, commit commit commit, reorder and perfect
 $ git tag end-of-series
 ... in $EDITOR, edit the [0/N] message
 $ git format-patch origin..end-of-series
 ... which notices end-of-series, and perhaps internally runs
 ... $ git-shortlog origin..end-of-series
 ... $ git diff --stat --summary origin..end-of-series
 ... $ git cat-file tag end-of-series
 ... to create 0/N which it did not do so far in
 ... 0000-cover-letter.txt
 $ git-send-email 0*.txt

Would it be so much better than this workflow which would
probably not need to touch much of the 'commit formatting" code
that is used for [1/N]..[N/N] messages?

 $ work work work, commit commit commit, reorder and perfect
 $ git format-patch --with-cover origin..HEAD
 ... which notices --with-cover, and perhaps does
 ... $ git-shortlog origin..HEAD
 ... $ git diff --stat --summary origin..HEAD
 ... $ echo "*** BLURB HERE ***"
 ... to create 0/N which it did not do so far in
 ... 0000-cover-letter.txt
 $ $EDITOR 0000-cover-letter.txt
 $ git-send-email 0*.txt
