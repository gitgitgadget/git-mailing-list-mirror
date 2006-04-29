From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
Date: Sat, 29 Apr 2006 10:35:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604291006270.3701@g5.osdl.org>
References: <20060429165151.2570.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 29 19:35:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZtMJ-0005cj-UY
	for gcvg-git@gmane.org; Sat, 29 Apr 2006 19:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWD2Rfn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Apr 2006 13:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWD2Rfn
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Apr 2006 13:35:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9191 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750766AbWD2Rfn (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Apr 2006 13:35:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3THZatH025019
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 29 Apr 2006 10:35:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3THZZZI016345;
	Sat, 29 Apr 2006 10:35:36 -0700
To: linux@horizon.com
In-Reply-To: <20060429165151.2570.qmail@science.horizon.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19311>



On Sat, 29 Apr 2006, linux@horizon.com wrote:
> 
> Well, the only reason that you need ANY commit in the repository is
> because it's part of history, and comparing it with other versions is
> meaningful.  So what trees, not already in the ancestry graph of a
> given commit, are useful to compare to?  In particular, useful for some
> automated process; manual comparisons can always be done manually.
> 
> Nothing's jumping out at me.  Any suggestions?

The only thing that I've ever wondered about is the "base commit of a 
merge".

Now, the thing is, we can always compute it. That's true _iff_ we've 
merged using the standard merge mechanism, but it wasn't always true 
historically (eg the original merges were computed with the original 
"git-merge-base" algorithm, which just picked the _first_ merge base it 
would find, while these days we use multiple ones for criss-cross merges).

So I would not totally object if a merge algorithm added a

	merge-base <sha1>

notation. But while it _could_ be just a "note merge-base <sha1>", it 
should _not_ be a "link <sha1> merge-base".

Let me explain why I think there are differences between those three 
options, and why I actually think that two of them are "valid" ideas, 
while the third one is not.

 - Case 1: the

	merge-base <sha1>

   is a "valid" idea (where there might of course be more than one <sha1>, 
   and possibly more than one "merge-base" line: you'd have to have some 
   rule for what happens for a recursive merge), although it has the 
   generally big down-side of being redundant information in all current 
   setups.

   It's redundant, but at the same time it's information that in _theory_ 
   might not be redundant, because I can see a situation where a merge was 
   forced by manually specifying a merge base (eg a special merge like the 
   original "gitk" merge, merging two initially unrelated projects 
   together).

   In theory. So it could be real information for a merge commit. And we'd 
   enforce some kind of real semantics for it - and it would have a really 
   solid technical meaning: assuming we define the multi-merge-base 
   semantics properly it would NEVER have any question about "what are 
   best practices?" or "what does this mean?".

   So this "case 1" actually has technical consequences, but you can, for 
   example, actually _check_ them. You can make fsck literally complain if 
   the merge base doesn't make sense. There's a clear "technical 
   violation", which might not be entirely trivial to figure out, but 
   thanks to it having a good meaning and a strict definition, it's 
   _there_.

Now, in all honesty, I don't think "case 1" is a _good_ thing to do. I'm 
just saying that I wouldn't be as upset about it as I've been over this 
"link" discussion. The reason I think "case 1" sucks is simply that I 
think you can in _practice_ get all the benefits much better with "case 
2", even if that one doesn't imply any actual git semantics:

 - Case 2: the

	note merge-base <sha1>

   thing is _also_ a perfectly valid idea, because now it's also very 
   well-defined: the "note" part tells you that git doesn't actually 
   impose any semantics what-so-ever on it, so it's really just a comment, 
   and as in case 1 above, once you see it as a comment, the _meaning_ of 
   it is immediately clear. It's literally just a note from the merge 
   algorithm saying "I used this as a merge base".

   The "note" syntax actually has a huge advantage. When you see it as a 
   comment from the merge algorithm, you immediately think it might also 
   be a good idea to add a few other notes. So a merge commit might 
   actually have

	note merge-algorithm recursive
	note merge-conflicts none
	note merge-base <sha1>

   all make total sense. It's telling you what the algorithm used was, and 
   that it didn't neen any manual fixups. It's also telling you that none 
   of this has _any_ impact what-so-ever from a "git semantics" angle, and 
   that this is nothing but a note for anybody who starts digging into it.

So now I've shown _two_ examples of some kind of header that I think 
actually makes sense, and that I would not argue against on those grounds. 
Especially the "note" thing I think is fine. So why, oh why, do I hate the 
"link" thing so much?

 - Case 3: the

	link <sha1> merge-base

   thing is a horrible and nasty thing that we should never ever support.

   Why? Because it's literally designed to both have some semantic meaning 
   ("git will fetch the <sha1> and use it for connectivity analysis") 
   _and_ at the same time the whole syntax it's designed to _not_ have any 
   real meaning ("you can have any kind of link, and I don't know what 
   it actually means from a conceptual standpoint").

   So it has a meaning from an _implementation_ angle, but at the same 
   time it does not have a "higher cause". That is EVIL. When they say 
   "The road to hell is paved with good intentions", the implication there 
   is not that good intentions is bad per se, but that you should 
   understand that there are "Unintended Consequences".

   And if you cannot limit the thing to a very _specific_ higher-level 
   meaning, you by definition will have those "unintended consequences".

In short, the difference between three headers that on the face of it say 
exactly the same thing: "merge-base <sha1>", "note merge-base <sha1>", and 
"link merge-base <sha1>" is not that they have different syntax (hey, even 
the syntax itself is almost identical), but exactly the fact that they 
have different implications and _meaning_.

Two of the three have no unintended consequences. One ("note") has no 
technical "consequences" at _all_, by definition. The other "merge-base" 
has no technical "unintended" at all, because it's throught through, and 
has been fully defined.

The third? "unintended consequences". It doesn't have a clear definition 
("It's cool. You can use it for any link you want"). So pretty much BY 
DESIGN, it's set up so that you don't know what the consequences of it 
will be for a project.

And that's why "case 3" it's bad. Even though it looks very much like the 
two other ones.

			Linus
