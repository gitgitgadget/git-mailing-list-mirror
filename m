From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff-tree -c: show a merge commit a bit more sensibly.
Date: Tue, 24 Jan 2006 18:08:59 -0800
Message-ID: <7virs92h50.fsf@assigned-by-dhcp.cox.net>
References: <7vwtgqas0y.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601241655090.10804@evo.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 25 03:09:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1a5z-00023H-TX
	for gcvg-git@gmane.org; Wed, 25 Jan 2006 03:09:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWAYCJE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jan 2006 21:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWAYCJE
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jan 2006 21:09:04 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:60131 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750957AbWAYCJB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2006 21:09:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060125020905.ORQI25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 24 Jan 2006 21:09:05 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15116>

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 24 Jan 2006, Junio C Hamano wrote:
>>
>> A new option '-c' to diff-tree changes the way a merge commit is
>> displayed when generating a patch output.  It shows a "combined
>> diff" (hence the option letter 'c'), which looks like this:
>
> Can you make this the default for "git-whatchanged" too? That way, merges 
> that have manual fixups will actually show up in the whatchanged output.

One problem with that I see is that it would mean making the
patch output as the default for whatchanged, since I made '-c'
to imply '-p' (I did not think of a reasonable 'combined diff'
behaviour for the diff-raw output).

I suspect many people are now used to the current default of
showing an abbreviated diff-raw and use it to quickly sanity
check the list of paths touched by each commit, so I am not so
sure that '-c' would be a good default for whatchanged.

For now, please do "git-repo-config whatchanged.difftree" ;-).

BTW, one feature that might be interesting is to tell either
rev-list or diff-tree to show _only_ merges.  My debugging
session went like this:

	$ git rev-list --all --parents |
          sed -ne 's/\([^ ]*\) [^ ]* [^ ].*/\1/p' |
          git diff-tree -c --stdin --pretty

I doubt such a flag would be of any practical value other than
curiosity, though.

> Also, it would be perhaps even nicer if it had a "dense" version, which 
> only showed the chunks that had differences from more than one parent. 
> Chunks that have diffs from just one parent obviously had no conflicts in 
> that chunk, so they are much less interesting than a chunk that was 
> different from more than one parent..

I agree that would be useful.  The logic to cull "uninteresting"
commit comes much earlier than the combined diff is split into
hunks, so it is probably not trivial (but I suspect not hard) to
arrange.  For now, I output the "diff --combined" header along
with the commit log even if "dense" ends up removing all hunks
as not-so-interesting.  An updated version is currently in the
"pu" branch.

I think the current output can be enhanced to have "-line,count"
for all parents to make the output machine applicable (i.e. we
could teach git-apply to take such a patch, which is somewhat
yucky) but I suspect dense mode would make that inpractical.  I
personally think combined diff is purely for human consumption,
so the machine applicability may not be an issue.
