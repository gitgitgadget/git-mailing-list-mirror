From: Olaf Dabrunz <Olaf.Dabrunz@gmx.net>
Subject: Re: [TopGit PATCH] t/depend-add-using-export
Date: Sat, 9 Oct 2010 12:54:56 +0200
Message-ID: <20101009105456.GA7328@santana.dyndns.org>
References: <1286588598-4005-1-git-send-email-odabrunz@gmx.net>
 <AANLkTik6R89vPhwKyWOheHPkxQ9JPpmrQVmXon8Vn4+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Olaf Dabrunz <odabrunz@gmx.net>, git@vger.kernel.org,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, Petr Baudis <pasky@suse.cz>,
	martin f krafft <madduck@madduck.net>,
	Per Cederqvist <ceder@lysator.liu.se>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Oct 09 12:55:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4X5J-0005bm-9m
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 12:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708Ab0JIKzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 06:55:06 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:38502 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754497Ab0JIKzF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 06:55:05 -0400
Received: (qmail invoked by alias); 09 Oct 2010 10:54:54 -0000
Received: from unknown (EHLO santana.dyndns.org) [109.250.241.189]
  by mail.gmx.net (mp025) with SMTP; 09 Oct 2010 12:54:54 +0200
X-Authenticated: #20497841
X-Provags-ID: V01U2FsdGVkX18Fp/1gdQAFd70UXvSAG6esppLXhR2/jeaOZSc7pX
	7D63FEtMBql2m6
Received: by santana.dyndns.org (Postfix, from userid 1000)
	id AACB427D84; Sat,  9 Oct 2010 12:54:56 +0200 (CEST)
Mail-Followup-To: Bert Wesarg <bert.wesarg@googlemail.com>,
	Olaf Dabrunz <odabrunz@gmx.net>, git@vger.kernel.org,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Petr Baudis <pasky@suse.cz>, martin f krafft <madduck@madduck.net>,
	Per Cederqvist <ceder@lysator.liu.se>
Content-Disposition: inline
In-Reply-To: <AANLkTik6R89vPhwKyWOheHPkxQ9JPpmrQVmXon8Vn4+A@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158580>

On 09-Oct-10, Bert Wesarg wrote:
> On Sat, Oct 9, 2010 at 03:43, Olaf Dabrunz <odabrunz@gmx.net> wrote:
> > When dependencies can be removed as well as added, tg depend add
> > needs to make sure that the new dependency can bring in changes
> > from a branch that has previously been removed as a dependency
> > from the current TopGit branch.
> >
> > This implementation uses an exported branch set up by tg export,
> > and merges the new dependency into the commit that corresponds to
> > the current base. Using the exported branch in the merge has the
> > advantage that removed dependencies do not appear as parents, and
> > the merge base selected by git merge does not include changes from
> > a removed dependency. As a result, these changes can be merged in
> > again if the new dependency brings in these changes.
> >
> > The tree of the merge commit is then used to create the next
> > commit on the TopGit base branch.
> 
> I'm really not an expert, but history comes from the commits not from
> the trees. Just using an hand made tree and commit this to the base
> doesn't change anything, because somewhere in the parent commits is
> still the information, that we merged in a branch that we just tried
> to remove (i'm speaking for tg depend remove). But maybe I don't

When the hand made tree is committed (as a hand made merge) on top of
the base, we have a correct merge on top of the base.

This actually should change everything. After such a "tg depend add", we
have either brought in some removed dependency as well, or we did not.
If we didn't, the removed deps in the base's history do not matter for
subsequent merges done by "tg update". But if we did bring in a
previously removed dep, the removed deps in the base's history _would_
matter. But since we already made a successful merge on top of the
base's history with a correct tree, and this merge also brings in the
removed dep through the history from the new dep's side, subsequent "tg
update" merges will use this hand made merge as the merge base, which is
fine for future merges.

> understand what this patch changes. The only idea is, that we don't
> use merge commits for the base any more! Is this what this patch does?

Maybe I addressed this above already. But just to clarify, I left the
following description of the patch in this mail, because it describes
the patch with different words.

What the patch does is the following: it still creates a merge commit on
the base to bring in a new dependency, but this merge commit is crafted
to contain the "correctly" merged tree. So there are three steps:

    - use tg export to create a completely separate history (the "temp
      export branch") which _does not_ reference removed dependencies as
      parents
    - use git merge to merge in the new dependency on top of this
      temp export branch -- as none of the removed dependencies are
      referenced by the temp export branch, this merge is not influenced
      by them and will do the right thing
    - then take the tree (!) from that merge and hand-craft a new merge
      commit with that tree and use the old base and the new dependency
      as parents of this hand-crafted merge commit

Olaf

-- 
Olaf Dabrunz (Olaf.Dabrunz <at> gmx.net)
