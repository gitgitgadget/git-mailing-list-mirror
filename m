From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/6] RFC - Notes merge: die when asked to merge a
 non-existent ref.
Date: Mon, 20 Jun 2011 03:16:07 -0400
Message-ID: <20110620071607.GB15246@sigill.intra.peff.net>
References: <201106151253.57908.johan@herland.net>
 <1308431208-13353-1-git-send-email-ydirson@free.fr>
 <1308431208-13353-7-git-send-email-ydirson@free.fr>
 <201106200003.46490.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yann Dirson <ydirson@free.fr>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jun 20 09:16:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYYif-00005y-4y
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 09:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265Ab1FTHQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 03:16:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53987
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753166Ab1FTHQK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 03:16:10 -0400
Received: (qmail 18723 invoked by uid 107); 20 Jun 2011 07:16:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Jun 2011 03:16:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jun 2011 03:16:07 -0400
Content-Disposition: inline
In-Reply-To: <201106200003.46490.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176053>

On Mon, Jun 20, 2011 at 12:03:46AM +0200, Johan Herland wrote:

> > +	if (!peel_to_type(o.remote_ref, 0, NULL, OBJ_COMMIT))
> > +		die("'%s' does not point to a commit", o.remote_ref);
> 
> Hmm. I'm not sure requiring the remote ref to always point to a _commit_ is 
> the right solution here. In previous discussions on the notes topic, some 
> people (Peff?) expressed a need/interest for history-less notes refs (i.e. a 
> notes tree where we don't keep track of its development, but only refer to 
> the latest/current version). Obviously, there are two ways to implement 
> history-less notes refs: (a) making the notes ref point to a notes commit 
> without any parents (i.e. each notes commit is a root commit), or (b) making 
> the notes ref point directly at the notes _tree_ object (i.e. no commit 
> object at all).
> 
> I can't remember off the top of my head whether our earlier discussions on 
> this topic resulted in us excluding support for option (b), but if we 
> didn't, it should be possible to merge notes refs where one or both refs 
> point directly at a tree object, and your above line would break this.

The notes-cache.[ch] implementation uses history-less notes for textconv
caching. Since it's just a cache, we don't care about history or
merging. And keeping a history would just mean useless old versions of
the cache are kept longer than necessary.

I ended up using a commit with no parents to store the cache. I don't
recall offhand whether there were any complications with using a raw
tree, but I realized that I needed some place to put extra metadata like
the cache validity. Wrapping the tree object in a commit provided that
place.

I don't think there is any real reason for somebody to need a bare tree
of notes. There is a certain elegance that refs can point directly to
trees in git, but the overhead of a single commit object to wrap it is
just not a big deal[1].

I didn't test, but I doubt that "git merge" will handle bare trees; this
would provide analagous behavior for notes-merging.  But maybe I'm
wrong.

-Peff

[1] The only other time I recall seeing a bare tree is linux-2.6's
v2.6.11 tag. And even there it is wrapped by a tag object, so that Linus
could include metadata (a comment and a GPG signature). There's really
no reason that couldn't have had a commit, except that doing it as a
tree shows off how cool git is. :)
