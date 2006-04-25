From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and other commit links ideas)
Date: Tue, 25 Apr 2006 12:18:11 -0700
Message-ID: <7vslo1v4zw.fsf@assigned-by-dhcp.cox.net>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
	<e2kgga$d7q$1@sea.gmane.org> <7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604250811230.3701@g5.osdl.org>
	<Pine.LNX.4.64.0604250833540.3701@g5.osdl.org>
	<e2lijt$aco$1@sea.gmane.org>
	<Pine.LNX.4.64.0604251004410.3701@g5.osdl.org>
	<BAYC1-PASMTP091348C4C33C5A0E83C012AEBF0@CEZ.ICE>
	<Pine.LNX.4.64.0604251106400.3701@g5.osdl.org>
	<BAYC1-PASMTP04D82622D9D5DA7E352079AEBF0@CEZ.ICE>
	<Pine.LNX.4.64.0604251125010.3701@g5.osdl.org>
	<BAYC1-PASMTP03E0B5376ACFF165B29ED1AEBF0@CEZ.ICE>
	<Pine.LNX.4.64.0604251155530.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 25 21:18:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYT3S-0004CN-Gm
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 21:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWDYTSP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 15:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWDYTSP
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 15:18:15 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:12979 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932172AbWDYTSN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 15:18:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060425191812.FAZF4388.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 25 Apr 2006 15:18:12 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604251155530.3701@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 25 Apr 2006 12:00:02 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19172>

Linus Torvalds <torvalds@osdl.org> writes:

> And the rule is: git cares about the commit header, but not about the 
> free-form. Which means that anything it doesn't care about, it goes into 
> the free-form section, not into some "X-header" section.
>
> Whatever you build on TOP of git can have its own rules in that free-form 
> section. For example, the kernel project has this "X-header" thing called 
> the "sign-off", and git itself picked it up. There's even some support to 
> add it automatically to commits (the same way we add the "revert" info 
> automatically to commits), but nobody claims that git should "parse" that 
> information, or that it should be part of the "header".

Then we should drop the author header and make it part of free
form text.  The core does not give any meaning to it.  And the
name <email> part of the commit header as well.  The only thing
used by the core is the timestamp of the commit.

My initial 'related' without 'note' was flawed - it used
cherry-pick as an example of 'related' when it clearly should
have been 'note' (no connectivitiy required).

Having said what I wanted to say about 'note', let's clarify
what I have in mind about the 'related' that _means_
connectivity.  As I said, I am far less convinced it is a good
thing than I am about 'note' by now, but just for the sake of
completeness of the discussion.

I tend to agree with you that ability to misuse 'related' (I'd
call it 'link' to make it clear that it means connectivity) to
fetch/push "related" objects, with an unclear definition of
related-ness, is a bad thing.  Even if we fetched the objects
that are claimed to be related to the main project, if we do not
know what to do with them, it is not useful.

And for well defined connectivity, we could give separate names,
just like we have 'tree' and 'parent' in the commit header.
That's how "bind commit" was initially proposed.  It was not
'link bind'.

The suggestion of 'link bind' came primarily from the pain I
experienced when I taught rev-list --objects and fsck-objects
about it in the jc/bind branch.  If the only thing asked to the
core by 'link' is to make sure the related objects are made
available, and Porcelains take responsibility after they are
made available, we would be better off teaching the commit
parser how to parse 'link' (regardless of its nature of linkage)
and teach rev-list --objects and fsck-objects to do connectivity
just once, rather than adding 'bind' now and then having to do
the same backward incompatible change when adding something else
that requires connectivity.

There definitely needs to be an ability to specify a list of
"nature of links this repository accepts", if we were to do
'link'.  It probably should default to an empty set.  rev-list
--objects would include objects pointed by 'link' only when the
repository wants such links to be honored.  fsck-objects will
declare an object that is reachable only by a 'link' that is not
accepted by the repository "uninteresting" and let git-prune
remove it.
