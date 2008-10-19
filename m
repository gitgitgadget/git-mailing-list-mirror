From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Add command line option --chdir/-C to allow setting
	git process work directory.
Date: Sun, 19 Oct 2008 17:02:41 -0400
Message-ID: <20081019210241.GA32589@coredump.intra.peff.net>
References: <20081019161819.GA12495@charybdis.dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Maciej Pasternacki <maciej@pasternacki.net>
X-From: git-owner@vger.kernel.org Mon Oct 20 11:44:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrfRM-0001vJ-Hv
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 23:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbYJSVCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 17:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbYJSVCo
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 17:02:44 -0400
Received: from peff.net ([208.65.91.99]:3565 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751779AbYJSVCn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 17:02:43 -0400
Received: (qmail 9313 invoked by uid 111); 19 Oct 2008 21:02:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 19 Oct 2008 17:02:42 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 19 Oct 2008 17:02:41 -0400
Content-Disposition: inline
In-Reply-To: <20081019161819.GA12495@charybdis.dreamhost.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98636>

On Sun, Oct 19, 2008 at 09:18:19AM -0700, Maciej Pasternacki wrote:

> When "git pull" is ran outside of work tree, it is unable to update work tree
> with pulled changes; specifying --git-dir and --work-tree does not help here
> because "cd_to_toplevel" call in git-pull occurs after "require_work_tree";
> changing order may break the commend if there is no working tree.  Some more
> commands behave in a similar way.

I took a closer look at this. I'm not sure that there is actually a
problem with moving the cd_to_toplevel before require_work_tree.
cd_to_toplevel makes sure there is actually something to cdup to. In my
test without a work-tree, "git rev-parse --show-cdup" simply printed
nothing, causing no "cd" to occur.

Moreover, git-pull is not the only script with this problem. There are
quite a few with

  require_work_tree
  cd_to_toplevel

which will break in the same way with --work-tree. And there are even
more with just require_work_tree that don't cd_to_toplevel at all. So I
suspect that --work-tree is largely broken in our scripts and nobody has
actually tried it.

So:

  1. I think we can fix this breakage by swapping the two.

  2. There is still breakage in other scripts, some of which may need
     quite in-depth fixes (e.g., git-bisect requires a work tree but
     does not chdir at all. For the require_work_tree test to work, it
     needs to be inside the work tree, and the script will need a
     careful looking over to see what ramifications that has).

  3. I think your -C option has some merit independent of this, since
     it allows you to chdir and still use the usual lookup rules (e.g.,
     see if it is bare vs a regular repository). But I don't feel
     strongly about it one way or the other.

-Peff
