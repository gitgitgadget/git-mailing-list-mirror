From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] -C/--chdir command line option
Date: Sun, 19 Oct 2008 10:16:34 -0400
Message-ID: <20081019141634.GA8997@coredump.intra.peff.net>
References: <20081019000227.GA9423@charybdis.dreamhost.com> <20081019131745.GA8643@coredump.intra.peff.net> <86685067-021C-4DC5-A462-AA6834208BDE@pasternacki.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Maciej Pasternacki <maciej@pasternacki.net>
X-From: git-owner@vger.kernel.org Mon Oct 20 06:04:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrZ6n-0005nF-HV
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 16:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbYJSOQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 10:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbYJSOQk
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 10:16:40 -0400
Received: from peff.net ([208.65.91.99]:1704 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752167AbYJSOQg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 10:16:36 -0400
Received: (qmail 7663 invoked by uid 111); 19 Oct 2008 14:16:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 19 Oct 2008 10:16:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 19 Oct 2008 10:16:34 -0400
Content-Disposition: inline
In-Reply-To: <86685067-021C-4DC5-A462-AA6834208BDE@pasternacki.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98608>

On Sun, Oct 19, 2008 at 03:47:04PM +0200, Maciej Pasternacki wrote:

> As for -C being superfluous: --git-dir and --work-tree seem to support  
> weird usage patterns (like work tree separate from git-dir), but it seems 

Hmm. Yeah, thinking about it more, -C is not really superfluous with
respect to those options. You don't want to say "here is the work-tree,
and here is the git-dir". You want to say "find the work-tree and
git-dir for me using the usual rules, as if I were in this directory."

So you couldn't just say:

  git --work-tree=/chdir/path

since that would assume your current directory was the git-dir. You
would need:

  git --work-tree=/chdir/path --git-dir=/chdir/path/.git

but then you are overriding any usual lookup rules (e.g., somebody
having set GIT_DIR in the environment).

Though I am not clear from your original description if that is even
what you want. It sounds like you might be doing:

  git -C /chdir/path --git-dir=/back/to/where/I/was

in which case I think work-tree _is_ a better fit.

> to me that --work-tree could be just made a synonym of -C, and it would 
> behave as expected without creating chicken-and-egg problem that doener on 
> #git found (which I don't really understand, but I also can't see what 
> --work-tree allows that -C would not -- except creating more fragility).  

--work-tree allows you say "I'm _already_ in the git-dir, but please use
this other place for the work-tree". So you can, for example, checkout
files from a bare repository.

>> Also, the envchanged flag should probably be set, as for the git-dir
>> and work-tree options.
>
> OK.  I thought it means literally environment change, as in setenv().

It is really used to tell the options parser for aliases that some
options which change the operating environment should not be used in an
alias. I.e., something like:

  git config alias.foo "--git-dir=/path/to/whatever log"

isn't allowed, because we have already done some work on setting up the
git-dir at this point. IMHO, this is a limitation of the current
approach to setting up the environment, but fixing it would be
nontrivial.

I'm not 100% sure that doing a chdir should be disallowed in this
instance, but I suspect it would cause problems. I think it is better in
this instance to be conservative and disallow it in aliases.

-Peff
