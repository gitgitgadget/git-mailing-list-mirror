From: Jeff King <peff@peff.net>
Subject: Re: A generalization of git notes from blobs to trees - git
 metadata?
Date: Sun, 7 Feb 2010 14:33:20 -0500
Message-ID: <20100207193320.GB3185@coredump.intra.peff.net>
References: <2cfc40321002060532g4d22dd4dx403bf312708e1424@mail.gmail.com>
 <201002070236.12711.johan@herland.net>
 <7v1vgxlr9q.fsf@alter.siamese.dyndns.org>
 <20100207050255.GA17049@coredump.intra.peff.net>
 <2cfc40321002062136q64f832aesd979c9cb22f3612@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 20:33:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeCsr-0006FX-O8
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 20:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756716Ab0BGTdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 14:33:20 -0500
Received: from peff.net ([208.65.91.99]:48100 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754467Ab0BGTdT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 14:33:19 -0500
Received: (qmail 22906 invoked by uid 107); 7 Feb 2010 19:33:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 07 Feb 2010 14:33:25 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Feb 2010 14:33:20 -0500
Content-Disposition: inline
In-Reply-To: <2cfc40321002062136q64f832aesd979c9cb22f3612@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139249>

On Sun, Feb 07, 2010 at 04:36:59PM +1100, Jon Seymour wrote:

> As I see it, the existing use of notes is a special instance of a more
> general metadata capability in which the metadata is constrained to be
> a single blob. If notes continued to be constrained in this way, there
> is no reason to change anything with respect to its current userspace
> behaviour. That said, most of the plumbing which enabled notes could
> be generalized to enable the arbitrary tree case [ which admittedly, I
> have yet to sell successfully !]

I do agree that storing trees is a natural generalization of the current
notes implementation. Callers have to be made aware that they may see
trees, of course, but you could probably "demote" trees into their
representative sha1s for callers who were interested only in a blob
form.

But what I am concerned with is that generalizing may violate some
assumptions made about how notes work. Notes trees can re-balance
themselves to some degree, I thought (though I am pretty out of the loop
on current notes developments). So during merges we need to normalize
tree representations (though we probably already need to do that for the
blob case). We would also need to do some magic with rename detection
during merges.  You would probably want rename detection _within_ a tree
stored as a note for a particular commit, but not between notes stored
for different commits.

Or perhaps you would not even want to do a tree-merge between notes at
all, and would rather see a conflict if two people noted two different
trees. This would make sense to me if you were doing something like
noting a build setup. If I note that commit X builds with a tree
pointing to version Y of the build tools, and you note that it builds
with version Z of the build tools, what should happen when we merge our
notes? I can imagine wanting a conflict, and resolving it to Y or Z
(perhaps whichever is more desirable). I can also see resolving it to Y
_and_ Z (iow, treating it like a list). But doing a merge on the two
trees of build tools (which are presumably somewhat immutable) is
probably not helpful.

Which to me argues in favor of adding the extra level of indirection.
The note should store the tree sha1, and those who want to treat it as a
tree can do so. Rename and merge issues just go away, as they operate on
the tree sha1 and not on the tree itself. And of course the
representation is just an implementation detail; you could still make a
"git metadata" wrapper to transparently store trees from the user's
perspective.

The only complication is that git doesn't know to follow those sha1s for
reachability analysis. In some cases that won't matter (like Junio's
html/man example), but I suspect in some it will. Perhaps there is some
way to flag the note entry as "this stores a sha1 that should be
followed by fsck, but not otherwise dereferenced".

I dunno. That is all just thinking out loud. It would help if we had
some really detailed concrete examples of notes being used in practice.

-Peff
