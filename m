From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and other commit links ideas)
Date: Tue, 25 Apr 2006 12:00:30 -0700
Message-ID: <7vr73lwkdt.fsf@assigned-by-dhcp.cox.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 25 21:00:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYSm2-0000rR-MA
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 21:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWDYTAc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 15:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbWDYTAc
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 15:00:32 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:21953 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751483AbWDYTAb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 15:00:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060425190030.FECD25692.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 25 Apr 2006 15:00:30 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604251125010.3701@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 25 Apr 2006 11:26:25 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19169>

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 25 Apr 2006, sean wrote:
>
>> On Tue, 25 Apr 2006 11:08:31 -0700 (PDT)
>> Linus Torvalds <torvalds@osdl.org> wrote:
>> 
>> > Which is exactly what I told you to do. Just don't make it a git header. 
>> 
>> Well I just don't see how making it a header, or plopping it at the
>> end of a commit message makes an iota of difference to git, while it 
>> can help porcelain.
>
> It can't help porcelain.
>
> If we have undefined or bad semantics for it, the only thing it can do is 
> _hurt_ porcelain, because it will cause confusion down the line.
>
> Semantics for data objects are _the_ most important part of a SCM. Pretty 
> much any project, in fact. 
>
> And bad or weakly defined semantics will invariably cause problems later.
>
>> But that's exactly the point, it's no different than extending git to be
>> able to store more than one comment.
>
> So why argue for it?
>
> Just use the existing comment field.

Actually, it does help Porcelain to be able to mark unrelated
crud as 'note'.  Sane people (including git barebone
Porcelainish) would just ignore it.  Unless --pretty=raw is used
the 'note' headers will not be shown.  It would unclutter
things for us.

If different Porcelains use "the existing comment field" by
defining certain mark-up to embed their own data, it has the
same "weak semantics causing confusion down the line" issue,
_and_ the crud will be shown to the end user by "git log".

So I am starting to be actually in favor of the 'note' header.

Earlier somebody wondered if that has impact on merge semantics.
I think we do _not_ care.  The core level does not track how
things changed (the operation to make preimage to postimage),
but tracks what the results of changes are (the content).

Some "misguided" set of Porcelains may come up with a convention
to record renames and token-replaces in the 'note' header to
say:

	tree 0000000000000000000000000000000000000000
        parent 0000000000000000000000000000000000000000
	author A U Thor <author@example.com> 000000000 +0000
	committer C O Mitter <comitter@example.com> 000000000 +0000
	note rename hello.c world.c
        note token-replace s/cache/index/

        Replaced old nomenclature 'cache' to 'index'.  Oh, while
        at it, I renamed hello.c to world.c.

But unlike systems that records the transformation from preimage
to postimage, we record the postimage (on "tree" header) and
preimage (by the way of "parent" header).  We (as the core and
Porcelain that do not use "note") do not even need to look at
what 'note' says.  The Porcelains that _do_ look at the note may
try to take advantage of it, and if they make better result that
would be a good thing.  I suspect such 'note rename' provided by
the end user is not trustworthy at times, so a Porcelain that
relies on that may make silent mismerge.  You may claim that is
the reason why you do not want to pull from a tree managed with
such a Porcelain.

But at the end of the day what matters is the content, and
people.

You will not be using such a Porcelain yourself, but when you
fetch the above commit, which records its tree and its parents,
git barebone Porcelainish merge will just do what it has always
done, without even looking at 'note'.  It's not like use of
'note' on the other end is forcing you to take a note on them.

Refusing to merge from a tree that is managed with a Porcelain
that uses the information in 'note rename' for its own operation
(maybe because we believe such Porcelain tends to make silent
mismerges more often) does not make much more sense than
refusing to merge from a tree whose developer uses vi (because
it tends to lose "missing LF at the end of file").  The content
matters, so you would check the merge result; and 'note' thing
is opt-in, which we opt out.

Also you ultimately trust people -- "I will pull from his tree,
because I know he is careful and has good taste".  Now the tool
they use _may_ be part of their taste, but any tool can be
misused (remember you stayed away from pulling things that have
Octopus?)

I am less (a lot less) sure about the 'related' header now,
which will be the topic of a separate message.
