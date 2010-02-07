From: Jeff King <peff@peff.net>
Subject: Re: A generalization of git notes from blobs to trees - git
 metadata?
Date: Sun, 7 Feb 2010 00:02:55 -0500
Message-ID: <20100207050255.GA17049@coredump.intra.peff.net>
References: <2cfc40321002060532g4d22dd4dx403bf312708e1424@mail.gmail.com>
 <201002070236.12711.johan@herland.net>
 <7v1vgxlr9q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>,
	Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 06:03:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdzIU-0002Ey-5F
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 06:03:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842Ab0BGFC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 00:02:56 -0500
Received: from peff.net ([208.65.91.99]:56664 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750739Ab0BGFC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 00:02:56 -0500
Received: (qmail 14340 invoked by uid 107); 7 Feb 2010 05:03:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 07 Feb 2010 00:03:00 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Feb 2010 00:02:55 -0500
Content-Disposition: inline
In-Reply-To: <7v1vgxlr9q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139218>

On Sat, Feb 06, 2010 at 06:21:37PM -0800, Junio C Hamano wrote:

> Johan Herland <johan@herland.net> writes:
> 
> > Furthermore, although we currently assume that all note objects are blobs, 
> > someone (who?) has already suggested (as mentioned in the notes TODO list) 
> > that a note object could also be a _tree_ object that can be unpacked/read 
> > to reveal further "sub-notes".
> 
> I would advice you not to go there.  How would you even _merge_ such a
> thing with other notes attached to the same object?  What determines the
> path in that tree object?
> 
> Clueless ones can freely make misguided suggestions without thinking
> things through and make things unnecessarily complex without real gain.
> You do not have to listen to every one of them.

I think I may have been the one to suggest trees or notes at one point.
But let me clarify that this is not exactly what the OP is proposing in
this thread.

My suggestion was that some use cases may have many key/value pairs of
notes for a single sha1. We basically have two options:

  1. store each in a separate notes ref, with each sha1 mapping to
     a blob. The note "name" is the name of the ref.

  2. store notes in a single notes ref, with each sha1 mapping to a
     tree with named sub-notes. The note "name" is the combination of
     ref-name and tree entry name.

The advantage of (1) is that notes are not bound tightly to each other.
I can distribute the notes tree for one "name" independent of the
others.  The advantage of (2) is that it is faster and smaller. In (1),
each note has a separate index, and we must traverse each note index
separately.

In practice, I would expect to use (1) for logically separate datasets.
For example, automatic bug-tracking notes would go in a different ref
from human annotations. But I would expect to use (2) if I had, say, 5
different pieces of bug tracking information and I wanted an easy way to
refer to them individually.

And a specialized merge for that is straightforward. In the simplest
case, you simply say "notes of this ref are tree-type, or they are
blob-type" and then you have no merge problems. But if you want to get
fancy, you can say that a conflict between "sha1/blob" and
"sha1/tree/key" should automatically "promote" the first one into
"sha1/tree/default" or some other canonical name.

Note that all of this is my pie-in-the-sky "here is what I was thinking
of when I looked at notes a long time ago". I don't care strongly if it
gets implemented or not at this point; I just wanted to add some context
to what Johan had in his notes todo list (or maybe I am wrong, and what
is in his todo list was based on something totally different said by
somebody else, and I have just confused the issue more. :) ).

With respect to the idea of storing an arbitrary tree, I agree it is
probably too complex with respect to merging. In addition, it makes
things like "git log --format=%N" confusing. I think you would do better
to simply store a tree sha1 inside the note blob, and callers who were
interested in the tree contents could then dereference it and examine as
they saw fit.  The only caveat is that you need some way of telling git
that the referenced trees are reachable and not to be pruned.

-Peff
