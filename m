From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] shortstatus v1
Date: Tue, 10 Feb 2009 06:45:06 -0500
Message-ID: <20090210114506.GF12089@coredump.intra.peff.net>
References: <1234227067-56666-1-git-send-email-tuncer.ayaz@gmail.com> <20090210110330.GB12089@coredump.intra.peff.net> <49916524.4000400@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tuncer Ayaz <tuncer.ayaz@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Feb 10 12:46:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWr4X-0004nT-V7
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 12:46:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbZBJLpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 06:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753237AbZBJLpK
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 06:45:10 -0500
Received: from peff.net ([208.65.91.99]:40080 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753213AbZBJLpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 06:45:09 -0500
Received: (qmail 12797 invoked by uid 107); 10 Feb 2009 11:45:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 10 Feb 2009 06:45:24 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Feb 2009 06:45:06 -0500
Content-Disposition: inline
In-Reply-To: <49916524.4000400@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109213>

On Tue, Feb 10, 2009 at 12:29:40PM +0100, Michael J Gruber wrote:

> >   3. What advantage does this have over just doing:
> > 
> >        (git diff --name-status;
> >         git diff --cached --name-status) | sort -k2
> 
> That is fine, except that it can't list untracked files.

Well, neither does this patch:

  $ echo content >tracked &&
  > echo content >untracked &&
  > git add tracked &&
  > git shortstatus
  A           tracked

but you could easily include that:

  (git diff --name-status;
   git diff --cached --name-status;
   git ls-files --exclude-standard -o | sed 's/^/? /') | sort -k2

which is really more or less what the wt-status code does.

Note that I am not _against_ a convenient command for doing this. But I
have to wonder why such a large patch is necessary when I can do it in
three lines. I don't mind the C version being a little longer, but I
wonder what advantage there is in using wt_status for this.

> Right now, "git status" is basically "git commit --dry-run", which may
> or may not be good, but certainly is not what people coming from other
> vcs expect. I would suggest having "git commit -n" replace "git status"
> if I hadn't done so already or if I dared to (I can't remember ;) ).

I would much prefer that, if it had been done that way from the
beginning. But I think we are stuck with "git status" due to hysterical
raisins.

> "git ls-files" may do but has a different set of mode characters. I
> think that sums up what preceeded Junio's patch from October.

But you only need to use it here to get the untracked files, so it
doesn't matter what it says about modified files.

The big downside with the snippet I posted above is that it runs three
separate commands that go through the index. In theory, you could do it
in one pass. But wt-status _doesn't_ do that, since the diff
infrastructure isn't there (a long time ago, Junio had an experimental
parallel diff walker patch, but it never made it out of next).

-Peff
