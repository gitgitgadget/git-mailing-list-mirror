From: Jeff King <peff@peff.net>
Subject: Re: disallowing push to currently checked-out branch
Date: Mon, 16 Feb 2009 17:52:26 -0500
Message-ID: <20090216225226.GB23764@sigill.intra.peff.net>
References: <7veixybw7u.fsf@gitster.siamese.dyndns.org> <loom.20090216T101457-231@post.gmane.org> <20090216135812.GA20377@coredump.intra.peff.net> <49999ED6.7010608@gmail.com> <alpine.DEB.1.00.0902161839120.6289@intel-tinevez-2-302> <76718490902161048i3c19bb43h30b1cfc62dd9a61e@mail.gmail.com> <alpine.DEB.1.00.0902162102180.6289@intel-tinevez-2-302> <76718490902161312j2aee999bga00d95231fa85647@mail.gmail.com> <alpine.DEB.1.00.0902162215200.6289@intel-tinevez-2-302> <76718490902161428k7d252a02i3e79e4f197608891@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sergio Callegari <sergio.callegari@gmail.com>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 23:54:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZCLm-0006v1-Jd
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 23:54:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862AbZBPWwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 17:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752868AbZBPWwc
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 17:52:32 -0500
Received: from peff.net ([208.65.91.99]:37411 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752815AbZBPWwc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 17:52:32 -0500
Received: (qmail 23404 invoked by uid 107); 16 Feb 2009 22:52:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 16 Feb 2009 17:52:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Feb 2009 17:52:26 -0500
Content-Disposition: inline
In-Reply-To: <76718490902161428k7d252a02i3e79e4f197608891@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110258>

On Mon, Feb 16, 2009 at 05:28:38PM -0500, Jay Soffian wrote:

> On Mon, Feb 16, 2009 at 4:15 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >> Not consistent with what?
> >
> > With pushing into bare repositories.  And worse, with the existing mode of
> > operation.
> 
> I don't understand why pushing into a bare repo should have the same
> behavior as pushing into a non-bare repo. They are different workflows
> after-all.

Actually, I think it is pulling from the non-bare repo that will get
confusing.

You are proposing to push, when pushing into a non-bare repo, into a
push refspec like refs/incoming/ (for example). But what is your fetch
refspec?

If it fetches as usual from refs/heads/, then you have an asymmetry.
That is, if I do "git push" on one client, then "git pull" on another
won't fetch the changes. I have to wait for the non-bare repo to pull
them into its refs/heads/ hierarchy (one by one, if there are multiple
branches).

So you can try putting refs/incoming into your fetch refspec if it is a
non-bare repo. But there are two issues there:

  - how do you know the remote is non-bare?

  - now you have to "push" in the non-bare upstream in order to make
    commits available. So it no longer works to do:

       workstation$ cd repo && hack hack hack && commit commit commit
       laptop$ git clone workstation:repo

    since you will silently end up with stale results.

    In some ways, this is nicely rigorous: non-bare repos become
    essentially "uncontactable" remotely, and you have a de facto bare
    repo in the form of refs/incoming sitting in between. But I'm not
    sure it matches what most users want to do, and certainly it causes
    more breakage to their workflows than receive.denyCurrentBranch.

-Peff
