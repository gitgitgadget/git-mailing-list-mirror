From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] diff: allow turning on textconv explicitly for
	plumbing
Date: Mon, 8 Dec 2008 02:14:49 -0500
Message-ID: <20081208071449.GA24020@coredump.intra.peff.net>
References: <20081208025700.GB22072@coredump.intra.peff.net> <7vfxkz9v8f.fsf@gitster.siamese.dyndns.org> <20081208045924.GA22780@coredump.intra.peff.net> <7vskoz88g8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 08:16:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9aLj-00089k-NQ
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 08:16:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645AbYLHHOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 02:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752640AbYLHHOx
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 02:14:53 -0500
Received: from peff.net ([208.65.91.99]:4155 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607AbYLHHOw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 02:14:52 -0500
Received: (qmail 22398 invoked by uid 111); 8 Dec 2008 07:14:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 08 Dec 2008 02:14:50 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Dec 2008 02:14:49 -0500
Content-Disposition: inline
In-Reply-To: <7vskoz88g8.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102532>

On Sun, Dec 07, 2008 at 10:52:39PM -0800, Junio C Hamano wrote:

> > Right. _If_ it's a change that won't upset any plumbing consumers. If it
> > is, then it needs to be a separate option so that the plumbing consumers
> > who don't mind the change can start using it.
> 
> In the above argument, you are assuming that you can have a complete
> enumeration of "plumbing consumers", so that we can tell what kind of
> changes to textconv output do affect them in a negative way, and what kind
> of changes are safe.

No, I'm assuming we have an idea of what is a "reasonable" change to the
feature that won't break consumers, and what is a change that will
break them. And it's the same judgement we have to make all the time
when thinking about how changes will impact the scriptable interface.

And furthermore, I'm proposing to take the safest path, which is to
say that the scriptable interface _doesn't_ change unless each consumer
decides to ask it to do so. That is, the output of "git diff-tree" is
unchanged unless the caller explicitly allows textconv. So now we have
given a meaning to "--textconv". If you want a _new_ textconv variant
(let's say you want it to output the textconv patch with some "this
isn't a real patch" munging, and also include the binary patch -- which
would make it both human readable and applicable), then I think it is
safe to say that is an incompatible change. And it gets called
--textconv-with-patch or whatever, and porcelain can move to it by
default. But the plumbing consumers still get the same thing via
--textconv, and they can opt into the new format if that is useful to
them.

So uptake of the new feature is slower (you have to wait for the
maintainer of the script to support it) but you never break
compatibility.

> Yes, you can enumerate in-tree consumers, but that misses the whole point
> of having "plumbing", which can be used by any scripts out of tree and
> they can rely on stable output from the plumbing.  By giving --textconv to
> them to use with the plumbing, you are effecively casting textconv output
> in stone.  By definition we will never know what kind of changes to the
> output from the textconv filter out of tree consumers would mind.

Right. But we _have_ to cast it in stone if we want to make it available
to them at all. So I am proposing to give what exists now a name, and
further enhancements will have to have a different name.

If you want to argue that it is too early to cast in stone, since we
will have to carry around this implementation and the name "--textconv"
forever, then I can accept that. But it is a bit annoying, since I want
to use it in gitk _now_. :)

But I do run 'next' usually, so maybe it is worth pushing it off until
the next release cycle.

> In any case, I've applied the series for an entirely different reason.
> The patch is the most natural way to allow users of Porcelain to disable
> textconv with the --no-textconv option, just like --no-ext-diff can be
> used to disable the external diff.

Yes, I agree that is worthwhile and should have been there since the
beginning (and I think should definitely ship in 1.6.1).

> We _might_ want to add another patch to make the plumbing layer ignore (or
> error out) --textconv option given from the command line before 1.6.1
> ships, and after we gain confidence with the stability of the feature,
> revert that patch to allow use of --textconv freely from the plumbing.

If you want to do that, the simplest thing is to simply take the
"--no-textconv" part of 2/3 and drop the rest. There is not really any
point in supporting --textconv just for porcelain, which already has it
on by default.

-Peff
