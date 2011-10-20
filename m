From: Jeff King <peff@peff.net>
Subject: Re: [IGNORETHIS/PATCH] Choosing the sha1 prefix of your commits
Date: Thu, 20 Oct 2011 11:56:11 -0400
Message-ID: <20111020155611.GB16114@sigill.intra.peff.net>
References: <CACBZZX5PqYa0uWiGgs952rk2cy+QRCU95kF63qzSi3fKK-YrCQ@mail.gmail.com>
 <20111019190114.GA4670@sigill.intra.peff.net>
 <20111019193834.GA14168@sigill.intra.peff.net>
 <7vvcrk9td7.fsf@alter.siamese.dyndns.org>
 <20111020043448.GA7628@sigill.intra.peff.net>
 <7vr5289mlu.fsf@alter.siamese.dyndns.org>
 <20111020071356.GA14945@sigill.intra.peff.net>
 <20111020131454.GB7464@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ted Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Oct 20 17:56:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGuyk-0002iH-HB
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 17:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756664Ab1JTP4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 11:56:14 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36226
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756613Ab1JTP4O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2011 11:56:14 -0400
Received: (qmail 10422 invoked by uid 107); 20 Oct 2011 15:56:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Oct 2011 11:56:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Oct 2011 11:56:11 -0400
Content-Disposition: inline
In-Reply-To: <20111020131454.GB7464@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184027>

On Thu, Oct 20, 2011 at 09:14:55AM -0400, Ted Ts'o wrote:

> Another possibility is to warn if the commit messages are not NULL
> terminated.

A minor nit, but it's not whether they are terminated with NUL, but
rather whether they have embedded NUL. But yeah, this could maybe just
be something fsck looks for.

> Note though that if we're really worried about a bad guy trying to
> attack us with a hash collision, he/she could always use "invisible"
> non-printing characters in the commit message, and/or just mess with
> one or both of the timestamps.  The more bits and more degrees of
> flexibility the attacker has, the easier it would be, of course.  In
> the grand scheme of things it's not clear to me how big of a deal this
> would be.

Good point. Append-only attacks are cheaper, because you can avoid doing
most of the hash computation on each iteration (like my patch does). But
that's not a big-O speedup, it just makes the constant smaller.  So you
could assume that any feasible appending attack would probably become
feasible for recomputing the full hash eventually.

> If people were really concerned it would probably be easier to use
> backup crypto checksum using something stronger (say, SHA-2 or the
> eventual SHA-3).  Just store the backup checksums of the parent
> commitments in some backwardly compatible place that old git
> implementations wouldn't look (say, after the NULL in the commit
> message if there isn't a better place :-), and new implementations
> would know to generate the checksums, and old implementations would
> ignore it.

Yeah, if birthday attacks against sha1 become possible, the sensible
thing is probably not to worry too much about the file format, but to
use a better hash.

Commits can hide extra hashes in a header pretty easily. But what about
trees and blobs? I don't think there's any "ignored" space in either
one.

-Peff
