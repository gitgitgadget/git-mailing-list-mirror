From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Question: Is it possible to host a writable git repo over both
	http and ssh?
Date: Thu, 26 Mar 2009 09:57:32 -0700
Message-ID: <20090326165732.GD23521@spearce.org>
References: <49CA6A17.6050903@gmail.com> <49CB0AC1.2070006@gmail.com> <20090326045650.GA13628@coredump.intra.peff.net> <200903260618.33019.robin.rosenberg.lists@dewire.com> <49CB4EF1.6050902@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Rogan Dawes <lists@dawes.za.net>, Mike Gaffney <mr.gaffo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 17:59:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmsv3-0006MD-Ck
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 17:59:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755645AbZCZQ5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 12:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755310AbZCZQ5e
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 12:57:34 -0400
Received: from george.spearce.org ([209.20.77.23]:58464 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754935AbZCZQ5d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 12:57:33 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2E97538211; Thu, 26 Mar 2009 16:57:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49CB4EF1.6050902@dawes.za.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114803>

Rogan Dawes <lists@dawes.za.net> wrote:
> Robin Rosenberg wrote:
> > torsdag 26 mars 2009 05:56:51 skrev Jeff King <peff@peff.net>:
> >> On Wed, Mar 25, 2009 at 11:55:29PM -0500, Mike Gaffney wrote:
> >>
> >>> I'm actually trying to take what Sean did with gerrit and extract a
> >>> full Java/MinaSSHD based server that doesn't require a real user
> >>> account and is configurable by spring. So yes, I'm using JGit on the
> >>> server.
> >> Ah. In that case, I don't know whether JGit respects all hooks. You
> >> should ask Shawn (Shawn, we are talking about a post-update to run
> >> update-server-info). :)

JGit already has the native code needed for update-server-info. 
Look at WalkPushConnection:

  line 185-187 calls refWriter.writeInfoRefs() to update the
  GIT_DIR/info/refs for dumb transports.  We just need to call
  that in the end of the receive code.

  line 236 calls WalkRemoteObjectDatabase.writeInfoPacks() to
  update the GIT_DIR/objects/info/packs file.  This needs to
  be abstracted out so we can more easily reuse it.

> > Arguably it should. but it doesn't. Then there is a question as to what
> > format those hooks should be. Shell scripts would run into platform
> > issues and jgit based stuff should have as little as possible of that, but
> > a similar mechanism should exist.

Yup, I agree.

At the very least we should suppot doing the update-server-info
logic from pure Java, as it is probably the most common operation
people would want in a post receive hook.

> Maybe support executing scripts via Bean Scripting Framework?
> 
> That would allow scripts to be written in any of the supported
> languages, as long as the appropriate interpreter is present.
> 
> e.g. BeanShell, Groovy, Jython, etc
> 
> See http://jakarta.apache.org/bsf/
> 
> If you define an interface for each hook, the scripts could implement
> the interface, and execute that way.

Yes, that is one option.  I'd like to get a reasonable binding to
BSF for JGit, but its more of a wish than a real need for me, so
I just don't bother.  I think many people who want to script Git
from Python would be reasonably happy with executing that script
through Jython if there was a decent binding.
 
-- 
Shawn.
