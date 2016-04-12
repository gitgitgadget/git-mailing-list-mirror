From: Jeff King <peff@peff.net>
Subject: Re: Migrating away from SHA-1?
Date: Tue, 12 Apr 2016 19:42:52 -0400
Message-ID: <20160412234251.GB2210@sigill.intra.peff.net>
References: <570D78CC.9030807@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 01:43:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq7xX-00012B-81
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 01:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965071AbcDLXm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 19:42:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:48309 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932781AbcDLXmz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 19:42:55 -0400
Received: (qmail 15348 invoked by uid 102); 12 Apr 2016 23:42:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Apr 2016 19:42:54 -0400
Received: (qmail 12208 invoked by uid 107); 12 Apr 2016 23:42:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Apr 2016 19:42:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Apr 2016 19:42:52 -0400
Content-Disposition: inline
In-Reply-To: <570D78CC.9030807@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291327>

On Tue, Apr 12, 2016 at 03:38:04PM -0700, H. Peter Anvin wrote:

> For existing repositories we will need to have a migration mechanism. Since
> we can't modify objects without completely invalidating the cryptographic
> properties, what I would suggest is that we leave the existing objects as
> is, with a persistent lookup table from SHA-1 to <new hash>, and have that
> lookup table signed (e.g. GPG) by the person responsible for converting the
> repository.  This freezes the cryptographic status of the existing SHA-1
> objects at the time the conversion happens.  This is a very good reason to
> do this before SHA-1 is actually broken  In contrast. SHA-2 has been
> surprisingly resistant to cryptoanalysis, to the point that SHA-3 was
> motivated by performance and the desire to have a well-tested function based
> on entirely different principles should a generic attack against the common
> structure of MD5/SHA-1/SHA-2 would ever be found.

There are a few threads in the list archive discussing options, if you
search.

A conversion table like you mention seems like a "step 2". I think the
first step is figuring out what the new format looks like, and how
objects refer to each other.

The absolute simplest thing that could work is literally replacing sha1
with a 160-bit truncation of sha-256, telling everybody to convert their
repos, and accepting that existing gpg signatures and external sha1
references are all obsolete. Old versions of git are obsolete, but the
code changes are very minor.

That sucks for a lot of reasons, obviously.

So a slightly nicer thing is to parameterize the algorithm for every
object name reference. So commits look like:

  tree sha256:1234abcd...
  parent sha256:1234abcd...

and so on. Of course trees don't have any space for this; they have a
fixed-length for the hash part of each record, which is basically:

  <mode> <name> NUL <20-byte-sha1>

So we'd probably need a "treev2" object type that gives room for an
algorithm byte (or we'd have to try to shove it into the mode, but since
old versions won't know the new algorithm anyway, I don't think it
solves that much...). Or you can just define for the whole tree object
(either implicit in its type, or in a header) that it always uses
algorithm X.

And then the "new" objects can refer to the older sha1 objects directly
(either via "sha1:1234abcd", or we'd probably define a parameter-less
reference to mean "sha1:"), and that essentially grafts the old history
to the new. You can always walk the old history. And because we're
really talk about collision attacks and not pre-image attacks, it
probably remains fairly trustworthy for chaining (because nobody is
making _new_ objects and referring to them via sha1).

And then if you buy into the collision vs pre-image thing above, there's
not much point in caring about the mapping between sha1 and the new
algorithm. The old ones are set in stone and probably fine. You might
want such a mapping for performance (e.g., so that you can immediately
tell that an old sha-1 tree and a new sha-2 tree have an empty diff,
even though they have different ids), but that's purely a local thing.

So perhaps you were thinking of something in between, or an alternative
plan altogether.  I haven't been able to think of a scheme that is
secure, convenient, and involves less work than the one above.

Transitioning to that would be something like:

  0. Overhaul all of the git code to handle arbitrary-sized object ids.

  1. Decide on the new algorithm and implement it in git.

  2. Recognize parameterized object ids in commits and tags (designing
     format, implementing the reading side).

  3. Recognize parameterized object ids somehow in trees (designing
     format, implementing the reading side).

  4. Teach the object database to index objects by the new algorithm (or
     possibly both algorithms).

  5. Add a protocol extension so that both sides can decide which
     algorithm is being used when they talk about oids.

  6. Add a config option to write references in objects using the new
     algorithm.

  7. After a while, flip the config option on. Hopefully the readers
     from steps 1-5 have percolated to the masses by then, and it's not
     a horrible flag day.

We're basically on step 0 right now. I'm sure I'm missing some
subtleties in there, too.

Things get simpler if you don't fully parameterize (e.g., just assume
everything is moved to the new algorithm, and provide a "legacy" parent
pointer for connecting to sha1 history). But part of this would be
future-proofing for a day when sha-2 fails.

-Peff
