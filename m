From: Jeff King <peff@peff.net>
Subject: Re: Creating own hierarchies under $GITDIR/refs ?
Date: Sun, 2 Feb 2014 18:26:52 -0500
Message-ID: <20140202232652.GD16196@sigill.intra.peff.net>
References: <87a9e92424.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Feb 03 00:27:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WA6Rk-0006wg-8l
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 00:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526AbaBBX04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 18:26:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:43366 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752495AbaBBX0z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 18:26:55 -0500
Received: (qmail 32510 invoked by uid 102); 2 Feb 2014 23:26:54 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 02 Feb 2014 17:26:54 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Feb 2014 18:26:52 -0500
Content-Disposition: inline
In-Reply-To: <87a9e92424.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241390>

On Sun, Feb 02, 2014 at 11:37:39AM +0100, David Kastrup wrote:

> So I mused: refs/heads contains branches, refs/tags contains tags.  The
> respective information would likely easily enough be stored in refs/bzr
> and refs/bugs and in that manner would not pollute the "ordinary" tag
> and branch spaces, rendering "git tag" and/or "git branch" output mostly
> unusable.  I tested creating such a directory and entries and indeed
> references like bzr/39005 then worked.

Yes. The names "refs/tags" and "refs/heads" are special by convention,
and there is no reason you cannot have other hierarchies (and indeed, we
already have "refs/notes" and "refs/remotes" as common hierarchies).

> However, cloning from the repository did not copy those directories and
> references, so without modification, this scheme would not work for
> cloned repositories.

Correct. Anyone who wants them will have to ask for them manually, like:

  git config --add remote.origin.fetch '+refs/bzr/*:refs/bzr/*'

after which any "git fetch" will retrieve them.

> Are there some measures one can take/configure in the parent repository
> such that (named or all) additional directories inside of $GITDIR/refs
> would get cloned along with the rest?

No. It is up to the client to decide which parts of the ref namespace
they want to fetch. The server only advertises what it has, and the
client selects from that.


Others mentioned that refs were never really intended to scale to
one-per-commit. We serve some repositories with tens of thousands of
refs from GitHub, and it does work. On the backend, we even have some
repos in the hundreds of thousands (but these are not client facing).
Most of the pain points (like O(n^2) loops) have been ironed out, but
the two big ones are still:

  - server ref advertisement lists _all_ refs at the start of the
    conversation. So, e.g.,

        git fetch git://github.com/Homebrew/homebrew.git

    sends 2MB of advertisement just so a client can find out "nope,
    nothing to fetch".

  - the packed-refs storage is rather monolithic. Reading a value from
    it currently requires parsing the whole file. Likewise, deleting a
    ref requires rewriting the whole file.

So what you are proposing will work, but do note that there is a cost.

-Peff
