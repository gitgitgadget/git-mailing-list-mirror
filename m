From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/16] make prune mtime-checking more careful
Date: Wed, 8 Oct 2014 04:31:09 -0400
Message-ID: <20141008083109.GA3767@peff.net>
References: <20141003202045.GA15205@peff.net>
 <xmqqbnprjx0t.fsf@gitster.dls.corp.google.com>
 <20141006014249.GA11495@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 08 10:31:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbmeW-00067H-Fe
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 10:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670AbaJHIbO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Oct 2014 04:31:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:56120 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753329AbaJHIbL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 04:31:11 -0400
Received: (qmail 6119 invoked by uid 102); 8 Oct 2014 08:31:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Oct 2014 03:31:11 -0500
Received: (qmail 13068 invoked by uid 107); 8 Oct 2014 08:31:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Oct 2014 04:31:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Oct 2014 04:31:09 -0400
Content-Disposition: inline
In-Reply-To: <20141006014249.GA11495@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 05, 2014 at 09:42:49PM -0400, Jeff King wrote:

> On Sat, Oct 04, 2014 at 03:22:10PM -0700, Junio C Hamano wrote:
>=20
> > This applied on top of 'maint' (which does have c40fdd01) makes the
> > test #9 (prune: do not prune detached HEAD with no reflog) fail.
>=20
> I'll fix the bone-headed error returns that Ren=C3=A9 noticed and dou=
ble
> check that they were the complete culprit in the test failure you saw
> (and not just masking some other problem).

OK, I figured out what is going on. The short of it is that yes, it's
the return-value bug Ren=C3=A9 noticed. Read on only if you are really
interested.  :)

The test runs "git prune" and intends to check that the detached HEAD
commit is not in the list. It does so by checking the whole output of
"git prune -n", which it expects to be empty (and it generally is,
because we've gc'd in previous tests and all objects were either packed
or pruned).

However, when the test fails, there is a pruned object. But it is not
the HEAD commit that we just wrote, but rather the tree that it points
to. When we run "git commit", it tries to write out the tree with
write_sha1_file. This in turn calls freshen_packed_object to check
whether we have the object packed. We do, but the return-value bug make=
s
us think we do not. As a result, we write out an extra copy of the tree
as a loose object, and that is what gets pruned (and not by prune's
normal is-it-old-and-unreachable code, but by its call to prune_packed)=
=2E

So that explains that bug (as a side note, you might think that if we
are flipping return values, lots of things would fail when they ask "do
we have this packed object" and it erroneously says "yes". But that doe=
s
not happen. The wrong return value comes from freshening the file, so w=
e
only flip "yes" to "no", and never the opposite).

> > If we merge 'dt/cache-tree-repair' (which in turn needs
> > 'jc/reopen-lock-file') to 'maint' and then apply these on top, the
> > said test passes.  But I do not see an apparent reason why X-<.

When dt/cache-tree-repair is merged, we have a valid cache tree when we
run "git commit", and we realize that we do not need to write out the
tree object at all. Thus we never hit the buggy code, the object isn't
created, and the subsequent prune reports that there is nothing to
prune.

-Peff
