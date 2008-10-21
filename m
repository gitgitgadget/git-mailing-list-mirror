From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rehabilitate 'git index-pack' inside the object store
Date: Tue, 21 Oct 2008 13:43:04 -0400
Message-ID: <20081021174303.GA25827@coredump.intra.peff.net>
References: <alpine.LFD.2.00.0810202110380.26244@xanadu.home> <fcaeb9bf0810210757w1c14e0a3x1eb61a589a089f10@mail.gmail.com> <alpine.DEB.1.00.0810211856090.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 21 19:44:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsLHL-0007MA-OF
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 19:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128AbYJURnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 13:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751587AbYJURnI
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 13:43:08 -0400
Received: from peff.net ([208.65.91.99]:3804 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751707AbYJURnH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 13:43:07 -0400
Received: (qmail 23609 invoked by uid 111); 21 Oct 2008 17:43:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 21 Oct 2008 13:43:05 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Oct 2008 13:43:04 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0810211856090.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98798>

On Tue, Oct 21, 2008 at 07:02:48PM +0200, Johannes Schindelin wrote:

> So I propose this change in semantics:
> 
> - setup_git_directory_gently(): rename to discover_git_directory(), 
>   and avoid any chdir() at all.
> - setup_git_directory(): keep the semantics that it chdir()s to the
>   worktree, or to the git directory for bare repositories.
> 
> Using _gently() even for RUN_SETUP builtins should solve the long standing 
> pager problem, too.

I'm not sure there aren't hidden problems lurking in that strategy
(every time I look at this area of code, something unexpected prevents
what I think should Just Work from Just Working), but I think that is a
promising direction to go for clearing up some of the long-standing
issues.

I think you will need to do something for a few commands which use
_gently() but then, if we _are_ in a git repo, assume we are chdir'd
properly.

We may also be able to just call setup_git_directory_gently() as the
first thing in the wrapper, which should help us more consistently find
config before the 'exec' stage (see 4e10738a for a discussion of some of
the issues).

-Peff
