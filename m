From: Junio C Hamano <junkio@cox.net>
Subject: rev-list/tree committer/author information.
Date: Mon, 16 May 2005 14:33:11 -0700
Message-ID: <7vekc6onzc.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vzmuy13od.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505160837080.28162@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pasky@ucw.cz, Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 16 23:35:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXnDl-0007el-8B
	for gcvg-git@gmane.org; Mon, 16 May 2005 23:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVEPVeB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 May 2005 17:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbVEPVeB
	(ORCPT <rfc822;git-outgoing>); Mon, 16 May 2005 17:34:01 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:35975 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261915AbVEPVdV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2005 17:33:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050516213311.FLSG20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 16 May 2005 17:33:11 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505160837080.28162@ppc970.osdl.org> (Linus
 Torvalds's message of "Mon, 16 May 2005 09:10:10 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Anyway, everything I've read so far makes sense, and it
LT> might make sense to continue git development using just
LT> git-pb. The only thing I personally think sucks is the
LT> author/committer matching of git-rev-list/tree, since it
LT> would seem like somebody might well like to match on an
LT> arbitrary part of a commit, and special-casing
LT> author/committer seems somewhat broken.

Well, that author/committer thing is not in git-pb yet, if I am
not mistaken [*1].

The only reason why I did it that way was because the strategy
taken by "struct object" derivatives seemed to pick up bare
absolute minimum to support actual callers that have immediate
need for information stored in structural fields, as opposed to
designing for helping yet to be written callers by adding fields
to hold information of "having this might also help somebody in
the future" type.  And the author and committer names are in the
structured fields while signed-off-by and others are not.  Also
when author / committer name strings are intern'ed like the way
I did, the memory consumption even for a long sequence of
commits are kept reasonably low.  However,...

LT> I personally suspect that both git-rev-list and git-rev-tree
LT> should have an alternate output format that could be more
LT> easily grepped by subsequent commands. For example, right
LT> now git-rev-list just outputs a list of commit ID's, and it
LT> might make sense to have a flag to just append the commit
LT> message to the output, and zero-terminate it (and if the
LT> commit message has a NUL byte in it, just truncate it at
LT> that point).

I think what you said here makes more sense [*2*].  The above
implies to keep the unpacked raw data as a whole to be
accessible to the callers for at least commit objects and if we
go that route I think it would make more sense to do that
uniformly for everything (probably except for pure "blob"
objects for size concerns but we might as well do them while we
are at it).  On the other hand, the current lifetime rules being
what it is, that strategy may introduce memory consumption
problems when working on a huge project.

[Footnote]

*1* Petr has been applying quite good judgements. I would have
polluted git-jc with that patch already if I were still running
it.  So far, I have been generally happy with his acceptance
criteria for external patches.  Anything he places on hold or
just outright returns to me, I later find rooms for improvements
myself, and the later rounds that eventually get accepted always
turn out to be far cleaner, thanks to his comments.

*2* At least in principle.  I am not quite sure what the output
should look like for rev-tree.

