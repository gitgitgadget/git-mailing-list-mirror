From: Jeff King <peff@peff.net>
Subject: Re: git-tag bug? confusing git fast-export with double tag objects
Date: Sat, 16 May 2009 01:07:36 -0400
Message-ID: <20090516050736.GB7330@sigio.peff.net>
References: <op.utv93sdo1e62zd@merlin.emma.line.org> <op.utwdsutn1e62zd@merlin.emma.line.org> <7v8wl01iev.fsf@alter.siamese.dyndns.org> <op.utwyczlf1e62zd@merlin.emma.line.org> <20090514182249.GA11919@sigill.intra.peff.net> <op.utxydvnu1e62zd@merlin.emma.line.org> <20090515020206.GA12451@coredump.intra.peff.net> <op.uty0pjb51e62zd@balu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 16 07:11:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5CBf-0004ly-Fd
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 07:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbZEPFHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 01:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbZEPFHe
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 01:07:34 -0400
Received: from peff.net ([208.65.91.99]:35870 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751687AbZEPFHd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 01:07:33 -0400
Received: (qmail 7354 invoked by uid 1000); 16 May 2009 05:07:36 -0000
Content-Disposition: inline
In-Reply-To: <op.uty0pjb51e62zd@balu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119335>

On Fri, May 15, 2009 at 02:23:33PM +0200, Matthias Andree wrote:

> Clear reminder up front: this thread is *not* about tagging tagA with  
> another tagB (I'll see if git fast-export has issues with that and perhaps 
> concoct a test script), but this thread *is* about replacing tagA with  
> itself.

I'm pretty sure git fast-export does have a problem just with tags of
tags; that was what I was looking at fixing with the patch in my
previous mail.

> If I do "git tag -f -s -m three tag1 tag1" (as opposed to... tag2 tag1),  
> then I'll have trouble seeing or explaning the meaning or use cases of the 
> result:
>
> 	commit <-- signed-by-- NIL (removed) <--signed-by-- tag1.

I think this is where we diverge. Removing a ref to an object (in my
mental model) doesn't make it "NIL" or "removed". It simply does not
have a direct name anymore.

Now, you _will_ have problems rewriting your tags all of the time,
because (IIRC) git does not fetch tags that it already has. So anybody
fetching from you will not ever see the new tag. But that is a problem
with _any_ tag overwriting, not just overwriting with a tag chain. And
that is why such overwriting is protected by "-f".

> In this particular corner case (replacing a heaviweight tag object with  
> itself), tag1 has no meaning, because the tag "destination" gets deleted.  
> It's as though your luggage trolley disappeared the very moment that you  
> moved your address label from one handle to the other (presuming it has  
> one side handle to carry it and one top handle to haul it while on its  
> wheels). That's just useless. Why do I want to sign the phantom?

Again, I disagree that it is a phantom. It is now a link in a chain of
signatures. The head of the chain has a name, but that doesn't mean
every link needs to.

So I think the reason that you are seeing "there is no bug, it is a
feature" responses from git people is that we have a different mental
model of what is going on. I don't know whether that means your model is
_wrong_, or simply _different_.

> For this particular corner case, "git tag -f tag tag" (where I really use  
> the same tag name twice) could warn along the lines
>
> "Warning: you are trying to replace a tag to [old reference] by a tag to  
> itself.
> However, [old reference] will be removed as per your request,  
> consequentially, the new tag will reference a deleted [type of old  
> reference].
> If you just want to relocate the tag and want the new tag to point to the  
> original [type , use git tag -f tagname tagname^{}.
> If you really want to create a tag of a tag, add another -f."

I am torn on whether such a warning is a good idea. Yes, it can prevent
a user from shooting themselves in the foot. But it also is something
you may legitimately want to be doing, and having git yell at you is a
bad thing (and I actually do disagree with some of the wording, but I
think the real point in contention is whether this should be flagged as
a dangerous and potentially wrong operation).

Your original problem seemed to come from thinking that "git tag -f tag
tag" would "redo" the tagging (when what you really wanted was "git tag
-f tag tag^{commit}"). I wonder if it would be helpful to provide a more
obvious and constructive way of doing that, like

  git tag --amend tag

The benefits would be:

  - it is a more natural way of saying what you want to do, and it
    mirrors the "git commit --amend" command

  - it could also populate the editor with the original tag message,
    which is probably useful if you are trying to fix up any issues.

The obvious drawback to me is that it might encourage rewriting commits,
which is something that it is not really sane to do after they have been
published (of course, we already encourage rewriting _commits_ via
--amend, which have similar if somewhat lesser problems).

And of course it doesn't actually _solve_ the problem you mentioned, it
merely makes it more likely that the user will see our handy safe
version and not use the error-prone "git tag -f" version. So maybe that
is good enough and maybe not.

> Similarly, git tag -d could complain if the tag I'm removing is a tag  
> object and has children (usually other tags, I believe).

I'm not sure what you mean here. Why would removing a tag to a tag to a
commit be any more or less dangerous than removing a tag to a commit?

>> Arguably the spacing could be more readable (one less blank line between
>> the tag header and its message, and an extra space between the message
>> and the start of the next header), but I wouldn't call the tag
>> inaccessible or removed.
>
> I'd describe the current output as irritating.

Agreed, though it really has nothing to do with the issue at hand. Even
a tag to a commit looks ugly (try, e.g., "git show v1.6.2.1" in the git
repo -- extra space before the tag text, no space between the PGP
signature and the commit).

>> And you can repeat the same exercise with
>>
>>   $ git tag -f -m four tag2 tag2
>>
>> which will show you the chain of tag2 -> old_tag2 -> tag1 -> commit.
>
> That's the object tree, but not the semantic meaning: semantically,  
> old_tag2 was supposed to be removed/replaced (tag -d/-f respectively). But 
> it has to remain in place for syntactic reasons, i. e. to guarantee the  
> object graph (= syntax) integrity.
> And that's what is confusing.

Again, I think "semantic meaning" here is in the eye of the beholder.
The intended semantics are not "make tag2 a tag to tag2" but
"dereference what is currently named tag2, and make tag2 a tag to that".
So what happens makes sense under that mental model.

>> I would have thought that would be dealt with by 198246, but I can
>> replicate the problem even on the current 'next'. I think we just need
>> to be setting a mark for tag objects. The patch below makes your
>> fast-export example better, but it still looks like we end up printing
>> out one of the tag objects twice.
>
> If fast-import knows how to handle that (by forcibly moving the tag), that 
> might work.

I don't think it needs to forcibly move the tag. The fast-export output
contains two "tag" stanzas, but those are only about creating the tag
objects themselves. The actual ref is set only once with lines like:

  reset refs/tags/foo
  from :2

At least that is my quick reading of the output; I admit I am not much
of a fast-export/import person, so there may be something subtle I am
missing.

> Also thanks for keeping the discussion constructive, rather than fetching  
> the "troll" punch and dismiss. :-)

Well, I _do_ like a good flamefest... ;)

-Peff
