From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Permit refspec source side to parse as a sha1
Date: Fri, 21 Mar 2008 01:09:24 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803210014100.19665@iabervon.org>
References: <alpine.LNX.1.00.0803202049090.19665@iabervon.org> <7v4pb0vhrg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Samuel Tardieu <sam@rfc1149.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 06:10:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcZWD-0004U6-Bw
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 06:10:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656AbYCUFJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 01:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbYCUFJ1
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 01:09:27 -0400
Received: from iabervon.org ([66.92.72.58]:44393 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751442AbYCUFJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 01:09:26 -0400
Received: (qmail 22251 invoked by uid 1000); 21 Mar 2008 05:09:24 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Mar 2008 05:09:24 -0000
In-Reply-To: <7v4pb0vhrg.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77714>

On Thu, 20 Mar 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > This fixes "git push origin HEAD~1:foo". "git fetch origin HEAD~1:foo"
> > will report "Couldn't find remote ref HEAD~1", while
> > "git fetch origin HEAD**1:foo" reports "Invalid refspec 'HEAD**1:foo'"
> >
> > That is, HEAD~1 is something you're not allowed to ask the remote for, 
> > while HEAD**1 doesn't mean anything.
> >
> > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> > ---
> > Note that this actually tries to look up the source side, so "git 
> > fetch origin HEAD^3:foo" usually gives a wrongish error message.
> 
> This is very wrong.  When you do not have anything on your own (i.e. HEAD
> points at an unborn branch), "git fetch origin HEAD:master" would barf?

No, HEAD is syntactically valid as a ref, so it's accepted regardless of 
anything else.

> We should _never_ look at the refs we have; the check is about the syntax.

Unfortunately, there's not (so far as I know) a handy way to check the 
syntax of a sha1 name.

> Why are fetch and push refspec parsing code share the same function and
> enforce exactly the same error checking to begin with?  Is it because we
> are too lazy to implement two semantics that has to be different and try
> to "share" code by only implementing checks for "common denominator"?

We enforce additional, purpose-specific error-checking after parsing, when 
we're actually trying to use the refspecs. The problem is that we can't 
make the syntactic check sufficient lenient to cover all valid syntax, but 
tight enough to prohibit any syntax errors, without getting tangled in a 
bit of semantics.

> I think that is the root of the problem, because their syntax are designed
> to look similar, but their semantics are different [*1*].

The syntax is identical. The semantics is not the parser's problem, and is 
more appropriate for the callers to handle.

> For a fetch refspec, LHS is the remote end and you do not even know what
> refs are available over there; the _only_ thing you care about is that it
> is well formed.
> 
> On the other hand, for a push refspec, LHS is the local end and _must_
> name a valid commit you are pushing (unless you are pushing empty to
> delete the ref).

Not really. If you're fetching, and you have a push refspec configured for 
the same ref, and that refspec has a LHS which, for the current HEAD, 
doesn't refer to a valid commit at the moment, that's fine. It's only a 
problem if you try to use it while it doesn't point at a valid commit, or 
if it isn't valid syntax for a sha1 name (like HEAD*2).

> I really think we cannot afford piling hacks on top of hacks to hide the
> broken interface forever.  We have two different things to validate, and
> the callers all know what they have when calling us to validate.  We
> should not have a single loose validation that only catches "it cannot be
> either fetch nor push refspec" breakage.

So we should call the same code to parse the string, have that code do no 
validation at all, and have the caller validate the return as appropriate. 
The parsing doesn't depend at all on whether it's for fetching or pushing.

>         As a side note, I have a vague recollection that we used to treat
>         a refspec from the command line and a refspec from the config
>         differently in some contexts, and rules applied to them might have
>         been different.  I do not think of what the context was offhand,
>         but we might need to further split the implementation of the
>         rules.

I think it was that we used to break "push = HEAD", but we support it now.

	-Daniel
*This .sig left intentionally blank*
