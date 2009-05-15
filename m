From: Jeff King <peff@peff.net>
Subject: Re: git-tag bug? confusing git fast-export with double tag objects
Date: Thu, 14 May 2009 22:02:06 -0400
Message-ID: <20090515020206.GA12451@coredump.intra.peff.net>
References: <op.utv93sdo1e62zd@merlin.emma.line.org> <op.utwdsutn1e62zd@merlin.emma.line.org> <7v8wl01iev.fsf@alter.siamese.dyndns.org> <op.utwyczlf1e62zd@merlin.emma.line.org> <20090514182249.GA11919@sigill.intra.peff.net> <op.utxydvnu1e62zd@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 15 04:02:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4mke-0001tU-KA
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 04:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754948AbZEOCCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 22:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754642AbZEOCCJ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 22:02:09 -0400
Received: from peff.net ([208.65.91.99]:35877 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751180AbZEOCCI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 22:02:08 -0400
Received: (qmail 30752 invoked by uid 107); 15 May 2009 02:02:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 14 May 2009 22:02:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 14 May 2009 22:02:06 -0400
Content-Disposition: inline
In-Reply-To: <op.utxydvnu1e62zd@merlin.emma.line.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119245>

On Fri, May 15, 2009 at 12:35:45AM +0200, Matthias Andree wrote:

> The semantic meaning however is missing. Let me take a different vantage  
> and look at the same situation, leaving the object graph aside.
>
> This "git tag -f -s same same" operation gives me a signed nothing, and  
> the ref indeed no longer points to the old tag.


It doesn't give you a signed nothing. It gives you a signed tag pointing
to the old signed tag (which in turn could point to another tag, a
commit, etc).

And yes, the ref no longer points to the old tag. That has nothing to do
with what you are pointing the tag out, but the fact that you are
_overwriting_ the old tag. And we already have a safety valve there: you
must specify "-f" to overwrite an existing tag.

> But what's the new signature or tag good for?

Tagging a tag is good for saying something about the original tag, as
opposed to saying something about the commit that the original tag
points to.

> I tagged & signed an object that was removed  in the process.  I have
> a tagged and signed nothing. (Yes, there is an  underlying object, but
> it takes lots of fiddling with the LL tools to get  at it.)

The object wasn't removed, any more than making a new commit that
advances a branch head removes the old history. Git objects form a DAG,
and refs are named objects in the DAG. But we only consider objects
"removed" when they are not reachable from any ref (and I say "removed"
because we call this "dangling", and then actually remove them after
they have been dangling for a period of time, assuming that nobody is
interested in them any longer). And it is not the case here that the
result is dangling.

I wouldn't be surprised if working with tags of tags is less convenient,
because people aren't using them as often as tags of commits, and there
may be some unexercised corner cases. But you can certainly see them via
"git show":

  $ git init && echo content > file && git add . && git commit -m one
  $ git tag -m two tag1
  $ git tag -m three tag2 tag1
  $ git show tag2

should show something like:

  tag tag2
  Tagger: Jeff King <peff@peff.net>
  Date:   Thu May 14 21:06:09 2009 -0400


  three
  tag tag1
  Tagger: Jeff King <peff@peff.net>
  Date:   Thu May 14 21:05:44 2009 -0400


  two
  commit 395553770322cbfc8326eb6edc9c3ab73334c541
  Author: Jeff King <peff@peff.net>
  Date:   Thu May 14 21:05:27 2009 -0400

      one

  diff...

Arguably the spacing could be more readable (one less blank line between
the tag header and its message, and an extra space between the message
and the start of the next header), but I wouldn't call the tag
inaccessible or removed.

And you can repeat the same exercise with

  $ git tag -f -m four tag2 tag2

which will show you the chain of tag2 -> old_tag2 -> tag1 -> commit.

>> Of course the _old_ tag1 is still there. It is referenced by tag2, which
>> still has a ref. Again you are confusing the right-hand side of "git
>> rev-list --objects" with actual ref names.
>
> Indeed it's not git show-ref...

Right. No ref points to it any more. But that doesn't mean it's not
there. Just like older commits have no ref pointing to them, and we have
to give them names based on the refs we do have, like HEAD~5. There is
not a shorthand syntax for saying "peel exactly N layers of this tag
chain", but I think that is because nobody has really needed one at this
point.

>> I am not ruling out the possibility that there is some piece of code
>> that will be confused by the situation you have created, but it has
>> nothing to do with graph walking. It would have to be a piece of code
>> which cares about the uniqueness of informative names inside tag
>> objects.
>
> That's true, and apparently git fast-export is one of those pieces of code.

Sorry, I thought from your last email ("I presume anything that walks
the object database and uses tags can fail") that you were just
speculating on fast-export mishandling.

Going back to your original message, though, it looks like you do have a
specific problem with fast-export. However, I think it has nothing to do
with a _renamed_ tag, but in general of tags pointing to tags. The
outermost tag ends up pointing to a bogus mark of ":0".

I would have thought that would be dealt with by 198246, but I can
replicate the problem even on the current 'next'. I think we just need
to be setting a mark for tag objects. The patch below makes your
fast-export example better, but it still looks like we end up printing
out one of the tag objects twice.

---
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 6731713..2349c8d 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -293,6 +293,9 @@ static void handle_tag(const char *name, struct tag *tag)
 	buf = read_sha1_file(tag->object.sha1, &type, &size);
 	if (!buf)
 		die ("Could not read tag %s", sha1_to_hex(tag->object.sha1));
+
+	mark_next_object(&tag->object);
+
 	message = memmem(buf, size, "\n\n", 2);
 	if (message) {
 		message += 2;
@@ -335,8 +338,8 @@ static void handle_tag(const char *name, struct tag *tag)
 
 	if (!prefixcmp(name, "refs/tags/"))
 		name += 10;
-	printf("tag %s\nfrom :%d\n%.*s%sdata %d\n%.*s\n",
-	       name, get_object_mark(tag->tagged),
+	printf("tag %s\nmark :%"PRIu32"\nfrom :%d\n%.*s%sdata %d\n%.*s\n",
+	       name, last_idnum, get_object_mark(tag->tagged),
 	       (int)(tagger_end - tagger), tagger,
 	       tagger == tagger_end ? "" : "\n",
 	       (int)message_size, (int)message_size, message ? message : "");
