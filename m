From: Jeff King <peff@peff.net>
Subject: Re: When Will We See Collisions for SHA-1? (An interesting analysis
 by Bruce Schneier)
Date: Tue, 16 Oct 2012 14:54:30 -0400
Message-ID: <20121016185430.GF27243@sigill.intra.peff.net>
References: <CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>
 <CACBZZX65Kbp8N9X9UtBfJca7U1T0m-VtKZeKM5q9mhyCR7dwGg@mail.gmail.com>
 <20121015183438.GB31658@sigill.intra.peff.net>
 <507D4651.6080207@lsrfire.ath.cx>
 <20121016173254.GD27243@sigill.intra.peff.net>
 <20121016175806.GB26650@thunk.org>
 <20121016182751.GA30010@sigill.intra.peff.net>
 <alpine.DEB.2.02.1210161131100.13407@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Theodore Ts'o <tytso@mit.edu>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Tue Oct 16 20:54:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOCHu-0004BG-0D
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 20:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755841Ab2JPSye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 14:54:34 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55231 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755681Ab2JPSye (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 14:54:34 -0400
Received: (qmail 18886 invoked by uid 107); 16 Oct 2012 18:55:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 16 Oct 2012 14:55:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Oct 2012 14:54:30 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1210161131100.13407@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207870>

On Tue, Oct 16, 2012 at 11:32:38AM -0700, david@lang.hm wrote:

> >I don't see much point in it. If we want to add new backup pointers to
> >commit objects, it is very easy to do so by adding new header fields.
> >
> >A much bigger problem is the other places we reference sha1s. The
> >obvious place is trees, which have no room for backup pointers (either
> >in headers, or with a NUL trick). But it also means that any time you
> >have a sha1 that you arrive at in some other way than traversal from a
> >signature, you are vulnerable to attack. E.g., if I record a sha1 in an
> >external system, today I can be sure that when I fetch the object for
> >that sha1, it is valid (or I can check that it is valid by hashing it).
> >With sha1 collisions, I am vulnerable to attack.
> 
> If you have two hashes of the same contents (SHA1 and SHA3) and they
> both agree that the file has not been tampered with, you should still
> be in good shape just using the SHA1 as a reference.

But tampering is only part of it. We care about a chain of authenticity
from some known point (either a gpg signature, or a sha1 that you know
to be good because you recorded it from a trusted source). The
references between objects are the links in that chain.

Whether an internal hash would help you would depend on the exact
details of the collision attack. Let's imagine you have a signed tag
that points to commit sha1 X. The pointed-to commit contains a trailer
that says "btw, my sha-3 is Y". An attacker doing a brute-force birthday
attack would do:

  1. Generate some potential contents for the object (generally, take a good
     and malicious version of the object, and add some random bits at
     the end).

  2. Generate the sha-3 trailer for each object and tack it on.

  3. Generate the sha1 for object+trailer.

  4. Remember the sha1 and contents of each object. If the sha1 matches
     something we generated before, we have a collision. Otherwise, goto
     step 1.

So each object, good or malicious, remains consistent with respect to
the sha-3 hash. We know it has not been tampered with since its
generation, but do we not know if it is the same object that the tagger
originally referenced.  We had to compute the sha-3 as part of
generating the object, but it was not actually part of the collision
attack; it just makes it a little more expensive to compute each
iteration. We still have to do only 2^80 iterations.

But nobody is worried about this 2^80 brute force attack. The problem
with sha-1 (as I understand it) is that there are tricks you can do when
making the modifications in step 1 that will make the sha1 from step 3
more likely to find a collision with something you've already generated.
The modifications you make in step 1 will affect the sha-3 hash in step
2, which ultimately impacts the sha1 hash in step 3. Whether and how
that affects your attack would depend on the exact details of the
tricks.

I don't keep up on the state of the art in sha-1 cracking, so maybe the
techniques happen in such a way that the extra hash would be a
significant impediment. Even if it is sufficient to stop current (or
whatever is "current" when sha1 is broken enough to worry about)
attacks, it is a weak point for future attacks.

-Peff
