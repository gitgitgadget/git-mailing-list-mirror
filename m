From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: git-tag bug? confusing git fast-export with double tag objects
Date: Fri, 15 May 2009 14:23:33 +0200
Message-ID: <op.uty0pjb51e62zd@balu>
References: <op.utv93sdo1e62zd@merlin.emma.line.org>
 <op.utwdsutn1e62zd@merlin.emma.line.org>
 <7v8wl01iev.fsf@alter.siamese.dyndns.org>
 <op.utwyczlf1e62zd@merlin.emma.line.org>
 <20090514182249.GA11919@sigill.intra.peff.net>
 <op.utxydvnu1e62zd@merlin.emma.line.org>
 <20090515020206.GA12451@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Brandon Casey" <casey@nrlssc.navy.mil>,
	"Sverre Rabbelier" <srabbelier@gmail.com>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 15 14:26:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4wUb-0004Tj-8L
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 14:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762985AbZEOMXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 08:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763139AbZEOMXh
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 08:23:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:44817 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763004AbZEOMXf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 08:23:35 -0400
Received: (qmail invoked by alias); 15 May 2009 12:23:35 -0000
Received: from balu.cs.uni-paderborn.de (EHLO balu.cs.uni-paderborn.de) [131.234.21.37]
  by mail.gmx.net (mp064) with SMTP; 15 May 2009 14:23:35 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX189J8l3kk49m48vWhfDMObL3Iys8O9QzNIMYI3kOO
	YcE98VutCk71yZ
Received: from [127.0.0.1] (helo=balu)
	by balu.cs.uni-paderborn.de with esmtp (Exim 4.69)
	(envelope-from <matthias.andree@gmx.de>)
	id KJOQFA-0004OS-20; Fri, 15 May 2009 14:23:34 +0200
In-Reply-To: <20090515020206.GA12451@coredump.intra.peff.net>
User-Agent: Opera Mail/9.64 (Win32)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119255>

Am 15.05.2009, 04:02 Uhr, schrieb Jeff King <peff@peff.net>:

>> But what's the new signature or tag good for?
>
> Tagging a tag is good for saying something about the original tag, as
> opposed to saying something about the commit that the original tag
> points to.

Yes, I agree to that since Junio's first reply.

Clear reminder up front: this thread is *not* about tagging tagA with  
another tagB (I'll see if git fast-export has issues with that and perhaps  
concoct a test script), but this thread *is* about replacing tagA with  
itself.

This raises semantic and hence usability concerns.

So let's shift object relations aside for a while, no need to discuss what  
we agree about.

Let's narrow down the discussion to signed tag objects (git tag -s/git tag  
-u GPG-ID). They are a bit different as there's some extended *meaning*  
that lies in the signature. I have no trouble with this. A <--signed-by--  
B is implemented by "git tag -s B A."

Your example is:

	commit <--signed-by-- tag1 <--signed-by-- tag2.

Tag2 is useful in an "approved by me, too" meaning or similar. Point taken.

If I do "git tag -f -s -m three tag1 tag1" (as opposed to... tag2 tag1),  
then I'll have trouble seeing or explaning the meaning or use cases of the  
result:

	commit <-- signed-by-- NIL (removed) <--signed-by-- tag1.

In this particular corner case (replacing a heaviweight tag object with  
itself), tag1 has no meaning, because the tag "destination" gets deleted.  
It's as though your luggage trolley disappeared the very moment that you  
moved your address label from one handle to the other (presuming it has  
one side handle to carry it and one top handle to haul it while on its  
wheels). That's just useless. Why do I want to sign the phantom?

For this particular corner case, "git tag -f tag tag" (where I really use  
the same tag name twice) could warn along the lines

"Warning: you are trying to replace a tag to [old reference] by a tag to  
itself.
However, [old reference] will be removed as per your request,  
consequentially, the new tag will reference a deleted [type of old  
reference].
If you just want to relocate the tag and want the new tag to point to the  
original [type , use git tag -f tagname tagname^{}.
If you really want to create a tag of a tag, add another -f."

Similarly, git tag -d could complain if the tag I'm removing is a tag  
object and has children (usually other tags, I believe).

> Arguably the spacing could be more readable (one less blank line between
> the tag header and its message, and an extra space between the message
> and the start of the next header), but I wouldn't call the tag
> inaccessible or removed.

I'd describe the current output as irritating.

> And you can repeat the same exercise with
>
>   $ git tag -f -m four tag2 tag2
>
> which will show you the chain of tag2 -> old_tag2 -> tag1 -> commit.

That's the object tree, but not the semantic meaning: semantically,  
old_tag2 was supposed to be removed/replaced (tag -d/-f respectively). But  
it has to remain in place for syntactic reasons, i. e. to guarantee the  
object graph (= syntax) integrity.
And that's what is confusing.

> Right. No ref points to it any more. But that doesn't mean it's not
> there. Just like older commits have no ref pointing to them, and we have
> to give them names based on the refs we do have, like HEAD~5. There is
> not a shorthand syntax for saying "peel exactly N layers of this tag
> chain", but I think that is because nobody has really needed one at this
> point.

That's plausible.

> Going back to your original message, though, it looks like you do have a
> specific problem with fast-export. However, I think it has nothing to do
> with a _renamed_ tag, but in general of tags pointing to tags. The
> outermost tag ends up pointing to a bogus mark of ":0".
>
> I would have thought that would be dealt with by 198246, but I can
> replicate the problem even on the current 'next'. I think we just need
> to be setting a mark for tag objects. The patch below makes your
> fast-export example better, but it still looks like we end up printing
> out one of the tag objects twice.

If fast-import knows how to handle that (by forcibly moving the tag), that  
might work.

Thanks for the patch, I'll try it tomorrow and see what I get.

Also thanks for keeping the discussion constructive, rather than fetching  
the "troll" punch and dismiss. :-)

> ---
> diff --git a/builtin-fast-export.c b/builtin-fast-export.c
> index 6731713..2349c8d 100644
> --- a/builtin-fast-export.c
> +++ b/builtin-fast-export.c
> @@ -293,6 +293,9 @@ static void handle_tag(const char *name, struct tag  
> *tag)
>  	buf = read_sha1_file(tag->object.sha1, &type, &size);
>  	if (!buf)
>  		die ("Could not read tag %s", sha1_to_hex(tag->object.sha1));
> +
> +	mark_next_object(&tag->object);
> +
>  	message = memmem(buf, size, "\n\n", 2);
>  	if (message) {
>  		message += 2;
> @@ -335,8 +338,8 @@ static void handle_tag(const char *name, struct tag  
> *tag)
> 	if (!prefixcmp(name, "refs/tags/"))
>  		name += 10;
> -	printf("tag %s\nfrom :%d\n%.*s%sdata %d\n%.*s\n",
> -	       name, get_object_mark(tag->tagged),
> +	printf("tag %s\nmark :%"PRIu32"\nfrom :%d\n%.*s%sdata %d\n%.*s\n",
> +	       name, last_idnum, get_object_mark(tag->tagged),
>  	       (int)(tagger_end - tagger), tagger,
>  	       tagger == tagger_end ? "" : "\n",
>  	       (int)message_size, (int)message_size, message ? message : "");



-- 
Matthias Andree
