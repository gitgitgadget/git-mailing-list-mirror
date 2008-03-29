From: Jeff King <peff@peff.net>
Subject: Re: why multiple password prompts?
Date: Sat, 29 Mar 2008 18:11:57 -0400
Message-ID: <20080329221156.GE30851@coredump.intra.peff.net>
References: <alpine.WNT.1.10.0803291141550.11992@znlsyl> <alpine.LNX.1.00.0803291241020.19665@iabervon.org> <46a038f90803291137l20244abcke54941dc92c2c8b4@mail.gmail.com> <20080329220543.GD30851@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>, Paul <lists@pote.com>,
	git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 29 23:12:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfjI4-0007pJ-Nn
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 23:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755579AbYC2WMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 18:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753090AbYC2WMB
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 18:12:01 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1412 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756526AbYC2WMB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 18:12:01 -0400
Received: (qmail 9187 invoked by uid 111); 29 Mar 2008 22:11:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 29 Mar 2008 18:11:58 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Mar 2008 18:11:57 -0400
Content-Disposition: inline
In-Reply-To: <20080329220543.GD30851@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78488>

On Sat, Mar 29, 2008 at 06:05:43PM -0400, Jeff King wrote:

> > That's cool - didn't know a rework of the ssh interactions had
> > happened. It would be really good if we could detect if there's an
> > existing "master" connection and piggyback over that (see options -M
> > and -O). Reading man ssh_config it looks like we may be able to say
> > something along the lines of " -o ControlMaster=auto ".
> 
> I have been using this for at least a year with git; just put
> "ControlMaster auto" into your .ssh/config.

Oh, and if you are trying to achieve "doing two back-to-back ssh's
should only need one connection because of ControlMaster", that doesn't
work.

The master is closely tied to the first session, so it exits when that
session finishes.

I think more useful semantics for something like git would be
an opportunistic short-lived server. That is, 'ssh foo' would try:

  - if .ssh/cache/foo does not exist, spawn "master"
  - repeatedly try to connect via .ssh/cache/foo (since it
    may take a while for the connection to be made, but
    eventually time out if we can't do it)

The "master" would:
  - listen on .ssh/cache/foo
  - connect to 'foo' via ssh
  - multiplex any incoming connections on .ssh/cache/foo on our session
  - after N seconds of no active connections, close the ssh session

But that is an ssh problem, not a git problem at all.

-Peff
