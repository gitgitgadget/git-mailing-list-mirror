From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] logging branch deletion to help recovering from mistakes
Date: Tue, 7 Dec 2010 14:38:05 -0500
Message-ID: <20101207193804.GA27685@sigill.intra.peff.net>
References: <7vlj42siu5.fsf@alter.siamese.dyndns.org>
 <AANLkTikbsyFUzZeu8R6yAND6spV6OnvYL08gYZ+ZgJCh@mail.gmail.com>
 <7vmxoiqeoq.fsf@alter.siamese.dyndns.org>
 <20101207170623.GB21749@sigill.intra.peff.net>
 <7v7hflqth1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 20:38:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ3Mc-0003Lo-LP
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 20:38:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753997Ab0LGTiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 14:38:08 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:48899 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753190Ab0LGTiH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 14:38:07 -0500
Received: (qmail 27675 invoked by uid 111); 7 Dec 2010 19:38:07 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 07 Dec 2010 19:38:07 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Dec 2010 14:38:05 -0500
Content-Disposition: inline
In-Reply-To: <7v7hflqth1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163119>

On Tue, Dec 07, 2010 at 11:21:46AM -0800, Junio C Hamano wrote:

> I am more worried about stuff in branch.<name>.* that are discarded upon
> "branch -d".  Without the config items, you won't have a working:
> 
>     $ branch -d frotz
>     $ branch --undelete frotz
>     $ git checkout frotz
>     $ git pull

Hmm, yeah, I didn't think about that. Two possible solutions:

  1. Just leave it in .git/config. It is not hurting anything if the
     branch does not exist, but it is cruft in a file the user might
     look at.

  2. Drop it into .git/config.dead/<branch_name>. When resurrecting a
     branch, copy it back into .git/config.

In both cases, when the reflog for the deleted branch is pruned to
nothing, we delete the relevant config, too.

In the second case, I think you would have to take special care for
something like:

  $ git branch frotz origin/master
  $ git branch -d frotz
  $ git remote rename origin foo
  $ git branch --undelete frotz

In the non-deleted case, this transparently renames branch.frotz.remote
from "origin" to "foo". In the deleted case, we would need to make sure
the dead config is updated, too.


To be honest, I have never been that interested in a "branch --undelete"
feature. I much more care about leaving the reflogs of deleted branches
around, so I can "git checkout -b foo bar@{1}" later on[1]. That is, to
me branch undeletion is not about bringing a branch back wholesale, but
rather remembering commits so I can start a new branch there.

But I guess others might disagree.

-Peff

[1] Well, that and just piece of mind from knowing that "branch -d" is
    not totally unrecoverable. Specifically, if we kept deleted reflogs
    around, it would be safe(r) to turn on auto-prune on fetch, the lack
    of which is something that seems to confuse new users.
