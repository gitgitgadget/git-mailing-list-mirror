From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
 other commit links ideas)
Date: Tue, 25 Apr 2006 10:04:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604250952490.3701@g5.osdl.org>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
 <e2kgga$d7q$1@sea.gmane.org> <7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604250811230.3701@g5.osdl.org> <Pine.LNX.4.64.0604250833540.3701@g5.osdl.org>
 <BAYC1-PASMTP086A906CFB378AB229C2D8AEBF0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, git@vger.kernel.org, jnareb@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 25 19:05:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYQxn-0002ai-VZ
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 19:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWDYREd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 13:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbWDYREd
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 13:04:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50333 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932264AbWDYREb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Apr 2006 13:04:31 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3PH4MtH014765
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 25 Apr 2006 10:04:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3PH4L7J030340;
	Tue, 25 Apr 2006 10:04:21 -0700
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP086A906CFB378AB229C2D8AEBF0@CEZ.ICE>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19153>



On Tue, 25 Apr 2006, sean wrote:
> 
> It's a fair point.  But adding a separate database to augment the core 
> information has some downsides.  That is, that information isn't pulled, 
> cloned, or pushed automatically; it doesn't get to ride for free on top 
> of the core.

But the point is, we don't generally _want_ to pull, push, or clone this 
crud.

I for one would literally have to add code to say "if any commit we poll 
has this random field, I refuse to pull". 

There's two ways to have true interoperability (and in a distributed 
system, that's the thing that matters):

 - keep on piling on the sh*t
 - keep it simple so that people know exactly what the rules are.

Guess which one I am religiously in favour of.

That's my whole point: the "rules" for this suggested "prior" or "related" 
field simply don't exist, and it doesn't even seem to be the case that 
people can agree what it _means_ in that nobody has actually explained 
what the thing would do and why you would use it.

If you cannot explain to the other side what a field is used for, then 
that field - by definition - is not useful for the other side. It will 
just result in confusion, because different users will have different 
notions of what to do with the field (if anything).

So some users might consider it to have meaning, and actually do different 
things when it exists. Others would ignore it entirely. Yet thirds would 
ignore it, but consider it a link that must exist - which would break 
whenever those people would interact with the people who ignore it, and 
think that it's superfluous.

This is why it has to have real meaning. If there are no rules, things 
will break. Some things will pull them, others won't, yet third things 
will do random things.

If you just want to have something that "follows" an archive, it's easy 
enough to do: have a totally separate ref, that is a real branch, but may 
not even contain any files at all. You can - perfectly validly - have a 
chain of commits where all the information is in the "free-form" text area 
as far as git is concerned, but where the trees are all empty.

You'll find that all git users can pull such a commit, and you can use all 
the normal git ops on them, and you can hide your own metadata in there. 
And it would still be a valid git tree - your metadata would be your 
private thing, and you can keep it along-side the "normal" git data, and 
you can have your own "extended fsck", and "git pull/push" still continues 
to work. 

Junio does something like that with the "todo" branch, for example (it's 
human-readable, not automated, but that doesn't really change anything). 
You can do

	git ls-tree todo
	git cat-file blob todo:Porcelainistas | less -S

and in general do anything you damn well please there. WITHOUT making 
up any new (and unnecessary) format semantics that nobody else cares 
about and that don't have very well-specified meaning.

		Linus
