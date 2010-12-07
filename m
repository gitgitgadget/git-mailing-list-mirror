From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] logging branch deletion to help recovering from mistakes
Date: Tue, 7 Dec 2010 13:20:40 -0500
Message-ID: <20101207182040.GA26770@sigill.intra.peff.net>
References: <7vlj42siu5.fsf@alter.siamese.dyndns.org>
 <AANLkTikbsyFUzZeu8R6yAND6spV6OnvYL08gYZ+ZgJCh@mail.gmail.com>
 <7vmxoiqeoq.fsf@alter.siamese.dyndns.org>
 <20101207170623.GB21749@sigill.intra.peff.net>
 <AANLkTimnp3xCHp_3E7ry-5OQL3PFnYh=H8PhfzMN307C@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 07 19:20:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ29g-0003ho-JE
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 19:20:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216Ab0LGSUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 13:20:44 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:33083 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752070Ab0LGSUn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 13:20:43 -0500
Received: (qmail 26541 invoked by uid 111); 7 Dec 2010 18:20:42 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 07 Dec 2010 18:20:42 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Dec 2010 13:20:40 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimnp3xCHp_3E7ry-5OQL3PFnYh=H8PhfzMN307C@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163102>

On Tue, Dec 07, 2010 at 10:14:19AM -0800, Shawn O. Pearce wrote:

> Per check-ref-format, ref names cannot contain two dots.  We could
> archive ref logs by renaming them, $GIT_DIR/logs/refs/heads/foo
> becomes $GIT_DIR/logs/refs/heads/foo..deleted-1.  If foo is created
> and deleted again, it becomes foo..deleted-2.
> 
> This still causes problems for git reflog show / git log -g because
> they want a current ref to enumerate the log of.

That seems reasonable to me. The "reflog show" limitation is just a
matter of a simple code fix, though, isn't it? Is there a good reason
for this restriction to exist? And even if there is, it would be simple
to special case it for ..deleted-* branches.

> A different approach might be to have $GIT_DIR/logs/refs/REF_ATTIC,
> and special case that in git reflog show / git log -g.  When a
> ref is deleted, append its entire log onto REF_ATTIC, between two
> specially formatted marker lines.  When recovering a branch, copy
> out the region from the REF_ATTIC log.

That seems a lot less efficient, as we have to linearly search all of
REF_ATTIC to get:

  1. the reflog for one deleted branch

  2. the list of deleted branches

Neither of those is probably particularly performance critical, but it
just seems like keeping the logs in files indexed by the original ref
names is a more natural fit.

-Peff
