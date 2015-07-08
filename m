From: Jeff King <peff@peff.net>
Subject: Re: Git force push fails after a rejected push (unpack failed)?
Date: Wed, 8 Jul 2015 14:05:39 -0400
Message-ID: <20150708180539.GA12353@peff.net>
References: <DUB120-W5049F72955243F44BB2511F6920@phx.gbl>
 <20150707141305.GA629@peff.net>
 <DUB120-W36B78FEE6DC80BDCB05D7FF6920@phx.gbl>
 <20150707194956.GA13792@peff.net>
 <559D60DC.4010304@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: X H <music_is_live_lg@hotmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Jul 08 20:05:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCtjB-0007NS-8V
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 20:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933182AbbGHSFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 14:05:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:57690 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758367AbbGHSFn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 14:05:43 -0400
Received: (qmail 25255 invoked by uid 102); 8 Jul 2015 18:05:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Jul 2015 13:05:43 -0500
Received: (qmail 23067 invoked by uid 107); 8 Jul 2015 18:05:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Jul 2015 14:05:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jul 2015 14:05:39 -0400
Content-Disposition: inline
In-Reply-To: <559D60DC.4010304@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273699>

On Wed, Jul 08, 2015 at 07:41:48PM +0200, Johannes Sixt wrote:

> >Yes, but remember that git stores all of the objects for all of the
> >commits. So for some reason your push is perhaps trying to send an
> >object that the other side already has. Usually this does not happen
> >(the receiver says "I already have these commits, do not bother sending
> >their objects"), but it's possible that you have an object that is not
> >referenced by any commit, or a similar situation. It's hard to say
> >without looking at the repository.
> 
> After a non-fast-forward push fails, a subsequent forced push sends the same
> set of objects, which are already present at the server side, but are
> dangling objects.
> 
> Apparently, Git for Windows fails to replace the read-only files that live
> on the network file system.

I left one bit out from my original explanation, which is that
we generally prefer existing objects to new ones. So we would generally
want to throw out the new object rather than try to write it out. I'm
not sure why unpack-objects would try to write an object we already
have.

We also don't write objects directly, of course; we write to a temporary
file and try to link them into place. It really sounds more like the
"objects/d9" directory is where the permission problems are. But, hmm...

The code path should be unpack-objects.c:write_object, which calls
sha1_file.cwrite_sha1_file, which then checks has_sha1_file(). These
days it uses the freshen_* functions instead of the latter, which does a
similar check.  But it does report failure if we cannot call utime() on
the file, preferring to write it out instead (this is the safer choice
from a preventing-prune-corruption perspective).

So it's possible that the sequence is:

  - unpack-objects tries to write object 1234abcd...

  - write_sha1_file calls freshen_loose_object

  - we call access("12/34abcd...", F_OK) and see that it does indeed
    exist

  - we call utime("12/34abcd...") which fails (presumably due to EPERM);
    we return failure and assume we must write out the object

  - write_sha1_file then writes to a temporary file, and tries to link
    it into place. Now what? If we get EEXIST, we say "OK, somebody else
    beat us here", and we consider that a success. But presumably we get
    some other error here (which may even be a Windows-ism), fall back
    to rename(), and that fails with EPERM, which we then report.

If that's the case, then one solution is to have the
timestamp-freshening code silently report success, and skip writing out
the object. I'm not entirely comfortable with that, just because it is
loosening a safety mechanism. But perhaps we could loosen it _only_ in
the case of checking the loose object, and when we get EPERM. We know
that the next step is going to be writing out that same loose object,
which is almost certainly going to fail for the same reason.

I dunno. The whole concept of trying to write to an object database for
which you do not have permissions seems a little bit weird. This would
definitely be a workaround. But I suspect it did work prior to v2.2.0.

-Peff
