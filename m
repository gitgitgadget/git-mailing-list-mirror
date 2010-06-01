From: Jeff King <peff@peff.net>
Subject: Re: Best way to apply textconv to a working tree file
Date: Tue, 1 Jun 2010 13:14:00 -0400
Message-ID: <20100601171359.GD9702@sigill.intra.peff.net>
References: <a1ace6b77167a2ad4b4995e8c4d09761@ensimag.fr>
 <vpqd3walot1.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: clement.poulain@ensimag.imag.fr, git@vger.kernel.org,
	diane.gasselin@ensimag.imag.fr, axel.bonnet@ensimag.imag.fr
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 01 19:14:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJV2j-0005fw-Om
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 19:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757131Ab0FAROL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 13:14:11 -0400
Received: from peff.net ([208.65.91.99]:51127 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756661Ab0FAROI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 13:14:08 -0400
Received: (qmail 32719 invoked by uid 107); 1 Jun 2010 17:14:14 -0000
Received: from adsl-99-133-187-56.dsl.bltnin.sbcglobal.net (HELO sigill.intra.peff.net) (99.133.187.56)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 01 Jun 2010 13:14:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Jun 2010 13:14:00 -0400
Content-Disposition: inline
In-Reply-To: <vpqd3walot1.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148141>

On Tue, Jun 01, 2010 at 06:07:06PM +0200, Matthieu Moy wrote:

> After thinking about it, I think a mix of these solutions would be
> OK:
> 
> git cat-file --textconv <blob-sha1>            # Run textconv on blob

This wouldn't work. The textconv is defined by the diff driver, which is
associated with a pathname, not a blob. You don't have a pathname here
(and in fact the same blob could potentially even be represented by
different textconvs if it appeared in different contexts).

> git cat-file --textconv <tree-sha1>:<filename> # Run textconv on file
>                                                # (in object database)

This could work in theory, but will not be as easy to implement as you
hope. The code to parse <tree-ish>:<filename> will give you only a blob
sha1, and you will have to look up the tree manually (which you will
have to split at the ":" manually, remembering that it may be as complex
as "HEAD@{12:00 yesterday}:foo.c", then check the diff attr manually for
that filename.

It would be nice if there was some way in the get_sha1* functions to
save some context, like tree context and filename. This would be helpful
for something like "git show HEAD:foo.txt", which probably should be
respecting autocrlf and smudge/clean filters.

> git cat-file --textconv ./<filename>           # Run textconv on file
>                                                # (in worktree)

FWIW, I think this combination is the best of the possible syntaxes
outlined in the original mail.

-Peff
