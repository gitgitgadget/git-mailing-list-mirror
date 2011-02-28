From: Jeff King <peff@peff.net>
Subject: Re: git diff: add option for omitting the contents of deletes
Date: Mon, 28 Feb 2011 17:23:52 -0500
Message-ID: <20110228222352.GC5854@sigill.intra.peff.net>
References: <AANLkTi=++gcw5CDQnTRbhUGkvWc9Zm+Ct4Zm5oGGYKUh@mail.gmail.com>
 <7vk4gm7dz3.fsf@alter.siamese.dyndns.org>
 <4D6A6291.8050206@drmicha.warpmail.net>
 <7v7hclulz0.fsf@alter.siamese.dyndns.org>
 <7v39n9uldp.fsf@alter.siamese.dyndns.org>
 <4D6B4F6B.1040209@drmicha.warpmail.net>
 <20110228121726.GA5197@sigill.intra.peff.net>
 <20110228122335.GB5197@sigill.intra.peff.net>
 <7vy650hvwa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Mart =?utf-8?B?U8O1bWVybWFh?= <mrts.pydev@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 23:23:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuBVV-00007F-QK
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 23:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537Ab1B1WXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 17:23:52 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:44639 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752190Ab1B1WXw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 17:23:52 -0500
Received: (qmail 29106 invoked by uid 111); 28 Feb 2011 22:23:51 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 28 Feb 2011 22:23:51 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Feb 2011 17:23:52 -0500
Content-Disposition: inline
In-Reply-To: <7vy650hvwa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168155>

On Mon, Feb 28, 2011 at 10:11:17AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Actually, thinking on this a bit more, I guess "-M" and "-C" are usable
> > without the sha1. In fact, we don't even provide it for a strict 100%
> > rename, and for a rename-with-patch, you can apply the patch, assuming
> > you have the original file in any form.
> 
> Yes, you got it correctly.  A patch is about giving you an ability to
> propagate a change to a similar tree, that does not have to be identical
> to yours (otherwise you can just send tarball of the whole thing ;-)).

Yeah, I guess I am just curious whether "similar enough" is really
relevant with file deletion. Obviously if you have the sha1 then
everything applies, no problem. But if you don't, how useful is the
patch text? The patch application will error out with a conflict. You
know in either case that the person wanted the file deleted. The patch
text shows you what _their_ version of the file looked like. But that's
not likely to be useful; what you really care about is what's in _your_
version of the file, and whether that should be deleted or not.

If you did really care about what was in their file, the giant deletion
diff is almost certainly not interesting. What you really care about is
what's different in their version versus yours. Which we don't provide a
simple way to access. But more likely, you're just going to email them
back and say "what is this based on?".

So yeah, the patch gives more information, but I am skeptical that
anybody uses it in practice.

> And a patch is not purely technical; it has human component in that the
> recipient needs to know enough about the context of the patch to be able
> to judge if the change is applicable to his tree.  By seeing some context
> lines in -M/-C (many of them are not pure renames), the recipient can be
> sure that the patch is being applied to his tree that is "similar enough"
> to what the patch was originally produced against.

But we don't provide context lines for pure renames. Yet the sender
might have a different version of the file than the recipient, and the
recipient has no idea. We don't even detect that situation, let alone
give the user any clue about what might be different.

> It would certainly help to have git-apply that understands the rename
> patches to apply such a patch mechanically, but that is not a strict
> requirement; the recipient can move or copy the original file to
> manually create the target and apply the patch by hand to produce the
> desired result, so "do you have git?" is mostly irrelevant.

Isn't that the same for a delete? I can see you wanted the file deleted.
It didn't match up with my sha1, but I can go ahead and do the delete
manually if I want.

> The proposed -D would apply to any tree that happens to have the path
> being mentioned in the patch regardless of how similar the target tree is
> to the original.  Pure renaming -M/-C patch shares the same risk, but
> unlike these modes, -D goes one step too far by making it impossible to
> recover from lossage without having a backup.

I'm not quite sure what lossage you mean. On the recipient's end? They
can just "git revert", no? Or do you mean somebody who gets a conflict
and manually does the deletion anyway? If they have the patch text, then
yes, they have something, but it is _not_ what they deleted. Otherwise
they would not have had a conflict.

> But all of the above is only about principles.  As I said, I am not
> strongly opposed to have an output mode that is primarily for reviewing,
> just like we have --color-words, that are not suitable for patch
> application, as long as users understand the implications.

I am not sure I agree about the danger, but certainly I agree that for
viewing it is not a problem at all. I have to admit to not caring all
_that_ much about the topic. I do find deletion diffs unnecessarily
spammy, but they just don't happen enough for me to be really annoyed.

> It may make sense to show such a patch still with a bit of context,
> perhaps like this:
> 
>      README |   54 ------------------------------------------------------
>      1 files changed, 0 insertions(+), 54 deletions(-)
> 
>     diff --git -D a/README b/README
>     deleted file mode 100644
>     index 67cfeb2..0000000
>     --- a/README
>     +++ /dev/null
>     @@ -1,54 +0,0 @@
>     -////////////////////////////////////////////////////////////////
>     -
>     -	GIT - the stupid content tracker
>     -...
>     -the discussion following them on the mailing list give a good
>     -reference for project status, development direction and
>     -remaining tasks.
> 
> so that the reader can have some warm and fuzzy feeling that the correct
> file is being deleted, though.

Hmm. I think that is even worse. It's _still_ spammy, and it's broken as
a diff (the sha1 in the index line doesn't match the preimage that the
diff text shows). Yeah, it gives you warm fuzzy feelings that the file
they were thinking about deleting is at least vaguely related to what
you wanted to delete. But how often do you get a deletion patch where
seeing the first 10 lines is actually useful? That is, what is the case
where you see the first 10 lines and immediately say "Wait, this
deletion is totally bogus!" and _didn't_ just see that there was a
conflicting deletion, read the commit message or email and say "Wait,
why are we deleting this file?"

-Peff
