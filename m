From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git reflog show
Date: Tue, 26 Dec 2006 15:50:57 -0800
Message-ID: <7vhcvicj32.fsf@assigned-by-dhcp.cox.net>
References: <20061223101956.GD9396@spearce.org>
	<7v4prmsxjl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612231552140.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<20061224061151.GE7443@spearce.org>
	<Pine.LNX.4.63.0612241333280.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v1wmpq83g.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612251449140.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vwt4fj1cs.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612261654330.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v64byfpic.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612270006460.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 27 00:51:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzM4T-0004Zp-LQ
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 00:51:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932839AbWLZXu7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Dec 2006 18:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932837AbWLZXu7
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Dec 2006 18:50:59 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:45064 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932866AbWLZXu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Dec 2006 18:50:58 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061226235057.ZOP19398.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Tue, 26 Dec 2006 18:50:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3brA1W00p1kojtg0000000; Tue, 26 Dec 2006 18:51:11 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612270006460.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 27 Dec 2006 00:20:14 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35435>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I am not proposing to introduce a new object type here, but
>> conceptually we could.  Maybe a quick hack would be to represent
>> each reflog entry as a phony "struct commit" in core,
>> 
>>  1. whose tree is taken from the tree of the tip commit,
>> 
>>  2. whose buffer is handcrafted by the true commit log message
>>     with data from reflog, and
>> 
>>  3. whose parent list points at another phony "commit" that
>>     represents ref@{N+1} reflog entry.
>
> I see only one problem with this approach: "next..master@{0}" would stop 
> to work as expected.

I was not talking about doing this as part of the usual
"rev-list".  This is a special hack to support reflog, and that
is Ok, because reflog is a very special hack itself.  I was
trying to rephrase what you said about reusing revision
traversal machinery for walking reflog.  The actual syntax would
more likely to be:

	reflog show master@{20}..master@{4} -- paths...

where you do NOT even allow handle_revision_arg() to interpret
double-dots, nor sha1_hex() to interpret master@{20}.  We do not
want the real commit objects when walking reflog entries.

You are going to synthesize an imaginary commit ancestry chain
that corresponds to the reflog entries of 'master' branch (so
you would error out when your replacement handle_revision_arg()
finds either is not a reflog entry and/or talk about different
refs).

In other words, the usual "next..master@{0}" WILL not do this
phony wrapping with "imaginary reflog objects".  We know it
cannot work.

>> I think I misunderstood your proposal and the misunderstanding resulted 
>> in an unrelated useful enhancement ;-).  If HEAD@{0} and HEAD@{2} points 
>> at the same commit, then obviously commits reachable from that commit 
>> did not come into the branch no later than HEAD@{2} time (what HEAD@{0} 
>> says becomes irrelevant), so you can define an order that lists commits 
>> in the order the earliest time they appeared on a branch.
>
> I fear that this traversal is not as easy as it seems. We cannot just 
> blindly walk the reflogs, since the simplification relies on being able to 
> actually rewrite the commit_list. Also, if a commit was seen, it must be 
> possible to show it _again_. And if you show the commit diff, you rely on 
> commit->parents actually containing the rewritten parents. And the same 
> commit could be in revs->commits twice, and the correct reflog has still 
> to be shown.

I think you are misunderstanding me completely.  This part is
about a separate topic of using reflog when walking the real
history.  We do not wrap or do anything funky like that.  We
just walk the true history.  We do not walk reflog at all.

Then, before you output anything, at the point you would call
topological sort, instead you would sort the commits with the
timestamp of the earliest appearance in the repository (or on
a particular branch), instead of the usual commit date.  And
reflog data is how you would determine when each commit appeared
in this repository (or on this particular branch).
