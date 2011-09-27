From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6] A handful of "branch description" patches
Date: Tue, 27 Sep 2011 17:58:43 -0400
Message-ID: <20110927215843.GE5176@sigill.intra.peff.net>
References: <7vy5xi4y3m.fsf@alter.siamese.dyndns.org>
 <1316729362-7714-1-git-send-email-gitster@pobox.com>
 <4E7C49CF.60508@drmicha.warpmail.net>
 <20110923201824.GA27999@sigill.intra.peff.net>
 <4E7DEC4A.3050900@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 27 23:58:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8ffu-0001hO-CA
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 23:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871Ab1I0V6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 17:58:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45533
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751572Ab1I0V6p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 17:58:45 -0400
Received: (qmail 29001 invoked by uid 107); 27 Sep 2011 22:03:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Sep 2011 18:03:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Sep 2011 17:58:43 -0400
Content-Disposition: inline
In-Reply-To: <4E7DEC4A.3050900@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182270>

On Sat, Sep 24, 2011 at 04:42:18PM +0200, Michael J Gruber wrote:

> > This seems like a clever solution to making git-notes store a ref as a
> > key instead of an arbitrary sha1. But I wonder if the end result is
> > really waht the user wants. The resulting notes tree is good for doing
> > lookups, but the entries are completely obfuscated. So I can't easily do
> > something like "list all of the refs which have descriptions". I can
> > only list the _hashes_ of the refs which have descriptions. And if I am
> > lucky, I can hash the refs I have and correlate them. But unknown ones
> > will simply be a mystery.
> 
> [mjg@localhost git]$ git rev-parse ref:mjg/vob/virtual-objects
> 3f8aa9bb80fe241306aafd3d76af50739ba88268
> [mjg@localhost git]$ git show 3f8aa9bb80fe241306aafd3d76af50739ba88268
> refs/heads/mjg/vob/virtual-objects

Sure, but what about:

  git notes list

which is just filled with meaningless nonsense.

> > Wouldn't it be much more friendly to have a separate tree of refnames
> > that stores:
> > 
> >   refs/heads/foo -> (some blob with the "foo" description)
> >   refs/heads/bar -> (some blob with the "bar" description)
> 
> Given the above, I don't think it's more friendly.
> 
> In fact, in my first attempt, I wrote out the blobs, and referenced them
> just like above from a different subtree within the notes tree, in order
> to keep them from being pruned. So the virtual approach is pretty
> equivalent, though leaner.

Hmm. So your mapping of $ref to $desc is:

  sha1($ref) -> sha1(blob($desc))

>From what you wrote there, I think maybe you think I meant to store:

  sha1(blob($ref)) -> sha1(blob($desc))

But what I meant was actually:

  $ref -> sha1(blob($desc))

I.e., not to use "notes" at all, but rather a tree that mirrors the
refs/ hierarchy in its names.

> > Yeah, you have to build another git-notes-like interface around it. But
> > the data structure is pleasant and flexible. You could even "git
> > checkout" the whole tree and edit the notes with your editor, without
> > having to deal with some obfuscated name.
> 
> Well, "git branch --edit-description" and such should be the way to edit
> them, shouldn't it?

It's one way. I assume that if we store things in a reasonable,
readable state, then people like that because they can hack on the data
structure using more flexible tools.

> I really think the only issue is remote refnames. As Junio points out,
> they are local by nature. OTOH, you typically use a non-renaming refspec
> which puts them under refs/remotes/foo/bar with "bar" being the same
> name as the local one on the remote, foo something you have chosen. So,
> teaching the code that the note for

If they are local by nature, is it worth putting them into a notes tree
at all? That provides versioning and backup. But I wonder if it is worth
the hassle, when one could just put them in the config.

-Peff
