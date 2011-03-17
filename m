From: Jeff King <peff@peff.net>
Subject: Re: Sharing a massive distributed merge
Date: Thu, 17 Mar 2011 15:15:17 -0400
Message-ID: <20110317191517.GC20508@sigill.intra.peff.net>
References: <4D8119BE.2090208@workspacewhiz.com>
 <AANLkTim0TL5X8rKoBceK3nLA4JrtuftqkJDkRi0Lok0A@mail.gmail.com>
 <20110317063816.GD11931@sigill.intra.peff.net>
 <AANLkTimTKbKWmf80u-kgnvQ2gT8hx2KTm6HGbWejt3eg@mail.gmail.com>
 <AANLkTi=25=99Gh9hGUxEuvB9Xvv=f8uJxThaMxaAQKbq@mail.gmail.com>
 <AANLkTikfp_d00zrtU8kuvyUk81gGMkOXEVDNXr-hRhBU@mail.gmail.com>
 <AANLkTinQYjq=NiHK6MK0tA5AEE7=NCg8kthJT9Xz=xNk@mail.gmail.com>
 <AANLkTi=Fnacc9JamGdOEYhHY8PJgaidSLmif_z5Qdfp0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 20:15:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0IfS-0005Vs-Gu
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 20:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754014Ab1CQTPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 15:15:25 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53961
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751572Ab1CQTPY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 15:15:24 -0400
Received: (qmail 26323 invoked by uid 107); 17 Mar 2011 19:15:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 17 Mar 2011 15:15:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Mar 2011 15:15:17 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=Fnacc9JamGdOEYhHY8PJgaidSLmif_z5Qdfp0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169258>

On Thu, Mar 17, 2011 at 07:48:54PM +0100, Alex Riesen wrote:

> How about not to record the merge as a merge commit, but
> just resolve as much as possible, commit _only_ what was
> resolved, and revert everything else. Including files merged
> cleanly, as the last merge by maintainer will have to clean
> merge them anyway. And of course, commit as normal:

But that still has the same problem. You've reverted unresolved files
back to the pre-merge state, which is the tip of one of the merged
branches. How does the integrator differentiate that from the case that
your resolution happened to take one side of a file?

For example, try this:

    git init repo && cd repo

    echo base >file1
    echo base >file2
    git add .
    git commit -m base

    echo master >>file1
    echo master >>file2
    git commit -a -m master

    git checkout -b topic HEAD^
    echo topic >>file1
    echo topic >>file2
    git commit -a -m topic

    git merge master

    # now we have a conflict. Both files are identically conflicted.
    # Let's resolve one in favor of topic.
    cat >file1 <<'EOF'
    base
    topic
    EOF
    git add file1

    # Now let's mark the other as unresolved. The proposal is to revert
    # it back to the pre-merge state.
    git checkout HEAD -- file2

    # And commit the partial result.
    git commit -m 'partial result'

It should be easy to see that the two cases are indistinguishable: both
files contain the exact same content in the reuslting partial result
(and obviously the fact that they are identical is contrived, but the
point is that for any given file, you don't know which thing happened
during the partial merge).

Which is why I suggested deletion as an option, but that also conflicts
with a possible resolution (it's just a less likely one). I think every
tree state that you could commit to mark "this isn't resolved" is going
to overlap with some possible actual resolution state. So you need an
external list.

It would be neat if the tree could somehow mark a bit for "this is
unresolved". I guess we could shove it into a mode bit. But that seems
like a waste of a mode bit for this one use case that doesn't come up
all that often, and which doesn't _need_ to represent that information
in-tree. The commit-message solution would work perfectly fine.

-Peff
