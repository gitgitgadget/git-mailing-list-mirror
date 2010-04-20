From: Jeff King <peff@peff.net>
Subject: Re: ghost refs
Date: Tue, 20 Apr 2010 07:51:24 -0400
Message-ID: <20100420115124.GB22907@coredump.intra.peff.net>
References: <89030B4A18ECCD45978A3A6B639D1F24032A074E1C@FL01EXMB01.trad.tradestation.com>
 <r2h32541b131004070958pa66bb7a3g6a1ecfaea0419965@mail.gmail.com>
 <20100407210010.GB27012@coredump.intra.peff.net>
 <loom.20100420T085842-887@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Yann Dirson <yann.dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Tue Apr 20 13:52:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4Bzk-0005iE-AJ
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 13:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754208Ab0DTLvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 07:51:55 -0400
Received: from peff.net ([208.65.91.99]:40048 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754081Ab0DTLvy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 07:51:54 -0400
Received: (qmail 1106 invoked by uid 107); 20 Apr 2010 11:52:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 20 Apr 2010 07:52:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Apr 2010 07:51:24 -0400
Content-Disposition: inline
In-Reply-To: <loom.20100420T085842-887@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145366>

On Tue, Apr 20, 2010 at 07:02:05AM +0000, Yann Dirson wrote:

> > You do have a reflog in the case of overwrite. Delete kills off any
> > associated reflog (it would be cool if we had a "graveyard" reflog that
> > kept deleted branch reflogs around for a while).
> 
> Wouldn't it jus be sufficient to keep reflogs on branch deletion, and
> let reflog entries subject be expired by gc just like for any branch,
> so that way we may only need to gc the reflog itself when it becomes
> empty ?

Almost. The complication is that a branch "foo" prevents any branch
"foo/bar" from being created. So if you leave the reflog in place, you
are blocking the creation of the reflog for a new branch.

So you need some solution to that problem. Things I thought of are:

  1. Leave the reflog in place until such a foo/bar branch is created.
     But that means branch creation unexpectedly kills off old unrelated
     reflog entries. Combingin user surprise and destruction of data is
     probably bad.

  2. Make a refs/dead hierarchy so that the reflogs don't interfere with
     new branches. This just pushes off the problem, though, for when
     you try to delete "foo/bar" and see that "refs/dead/foo" is already
     blocking its spot in the reflog graveyard.

  3. Stick everything in a big "graveyard" reflog. I think there are
     some complications here with the reflog format, though. Namely:

       - reflog entries don't actually name the ref they're on. We could
         munge the comment field to add the name of the ref as we put
         them in the graveyard ref.

       - entries just have a timestamp, and I think we assume they're in
         order. So I guess we can merge-sort the old graveyard ref with
         what we're adding to keep things in order. But it means you
         will have entries from various refs interspersed. I guess that
         is OK, though, as it's not unlike the HEAD reflog.

So (3) seems like the only viable option to me, but I would be happy to
hear alternatives.

-Peff
