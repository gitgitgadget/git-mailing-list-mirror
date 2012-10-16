From: Jeff King <peff@peff.net>
Subject: Re: When Will We See Collisions for SHA-1? (An interesting analysis
 by Bruce Schneier)
Date: Tue, 16 Oct 2012 14:27:51 -0400
Message-ID: <20121016182751.GA30010@sigill.intra.peff.net>
References: <CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>
 <CACBZZX65Kbp8N9X9UtBfJca7U1T0m-VtKZeKM5q9mhyCR7dwGg@mail.gmail.com>
 <20121015183438.GB31658@sigill.intra.peff.net>
 <507D4651.6080207@lsrfire.ath.cx>
 <20121016173254.GD27243@sigill.intra.peff.net>
 <20121016175806.GB26650@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 16 20:28:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOBs7-0004e1-74
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 20:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132Ab2JPS14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 14:27:56 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55198 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932120Ab2JPS1z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 14:27:55 -0400
Received: (qmail 18661 invoked by uid 107); 16 Oct 2012 18:28:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 16 Oct 2012 14:28:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Oct 2012 14:27:51 -0400
Content-Disposition: inline
In-Reply-To: <20121016175806.GB26650@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207866>

On Tue, Oct 16, 2012 at 01:58:06PM -0400, Theodore Ts'o wrote:

> I seem to recall that there was at least some discussion at one point
> about adding some extra fields to the commit object in a backwards
> compatible way by adding it after the trailing NUL.  We didn't end up
> doing it, but I could see it being a useful thing nonetheless (for
> example, we could potentially put the backup SHA-2/SHA-3 pointer there).

I don't see much point in it. If we want to add new backup pointers to
commit objects, it is very easy to do so by adding new header fields.

A much bigger problem is the other places we reference sha1s. The
obvious place is trees, which have no room for backup pointers (either
in headers, or with a NUL trick). But it also means that any time you
have a sha1 that you arrive at in some other way than traversal from a
signature, you are vulnerable to attack. E.g., if I record a sha1 in an
external system, today I can be sure that when I fetch the object for
that sha1, it is valid (or I can check that it is valid by hashing it).
With sha1 collisions, I am vulnerable to attack.

> What if we explicitly allow a length plus SHA-2/3 hash of the commit
> plus the fields after the SHA-2/3 hash as an extension?  This would
> allow a secure way of adding an extension, including perhaps adding
> backup SHA-2/3 parent pointers, which is something that would be
> useful to do from a security perspective if we really are worried
> about a catastrophic hash failure.

I'm not sure exactly what you mean. Extended parent pointers make sense,
but I don't see what you mean in your first sentence. It sounds like we
are SHA-2/3 hashing something internal to the object, but that doesn't
help. If the pointers are sha1, then I can always replace the whole
object with a colliding one, even if that object is internally
consistent with respect to sha-2.

> The one reason why we *might* want to use SHA-3, BTW, is that it is a
> radically different design from SHA-1 and SHA-2.  And if there is a
> crypto hash failure which is bad enough that the security of git would
> be affected, there's a chance that the same attack could significantly
> affect SHA-2 as well.  The fact that SHA-3 is fundamentally different
> from a cryptographic design perspective means that an attack that
> impacts SHA-1/SHA-2 will not likely impact SHA-3, and vice versa.

Right. The point of having the SHA-3 contest was that we thought SHA-1's
breakage meant that SHA-2 was going to fall next. But Schneier's
comments before the winners were announced were basically "it turns out
that SHA-2 is not broken like we thought, so there's no reason to ditch
it, and the fact that it is well-studied and well-deployed may mean it's
a good choice".

So I could go either way. This is not a decision we should make today,
though, so we can wait and see which direction the world goes before
picking an algorithm.

-Peff
