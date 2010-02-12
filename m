From: Jeff King <peff@peff.net>
Subject: Re: Separate default push/pull?
Date: Thu, 11 Feb 2010 19:14:17 -0500
Message-ID: <20100212001417.GC21930@coredump.intra.peff.net>
References: <m2zl3fg26j.fsf@boostpro.com>
 <a038bef51002111057l382ed55fy6b4042d1115a830c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Abrahams <dave@boostpro.com>, git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 01:14:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfjAt-0007ux-Eg
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 01:14:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757541Ab0BLAOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 19:14:18 -0500
Received: from peff.net ([208.65.91.99]:36611 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757340Ab0BLAOS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 19:14:18 -0500
Received: (qmail 23959 invoked by uid 107); 12 Feb 2010 00:14:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 11 Feb 2010 19:14:24 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Feb 2010 19:14:17 -0500
Content-Disposition: inline
In-Reply-To: <a038bef51002111057l382ed55fy6b4042d1115a830c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139646>

On Thu, Feb 11, 2010 at 01:57:34PM -0500, Chris Packham wrote:

> Taking a quick look at the git push --help you'll see the following
> snippet of configuration.
> 
>                    [remote "<name>"]
>                            url = <url>
>                            pushurl = <pushurl>
>                            push = <refspec>
>                            fetch = <refspec>
> 
> so I think if you just add the pushurl to your .git/config should do
> what you've asked
> 
> [remote "origin"]
>         fetch = +refs/heads/*:refs/remotes/origin/*
>         url = git://git.kernel.org/pub/scm/git/git.git
>         pushurl = git://git.example.com/yourrepo.git

That's not quite what David wants, I think. That is a good recipe if you
have two ways of accessing the same repo (usually git:// for reading and
ssh for pushing). But if the two URLs actually point to _different_
repos, you will get some confusing results. For example, pushing to your
private repo will update the tracking branches in refs/remotes/origin/*
with values that do not match what is in the actual origin repository.

>   git remote add yourrepo git://git.example.com/yourrepo.git
>   git push yourrepo master:refs/heads/master  # the first time
>   git push yourrepo # subsequent times
> 
> There probably is a way to tell push to use something other than
> "origin" by default but I don't know/can't find it.

I don't think there is currently a way to do what he wants. You can set
a default remote name by setting branch.*.remote, but that has two
problems:

  1. It is also used to determine the upstream remote for pulling and
     for calculating upstream tracking branches. So he probably wants to
     leave it set as origin.

  2. It would have to be set manually for every branch.

I think what he would need is a "push.defaultRemote" config option,
which universally overrides branch.*.remote for pushing.

-Peff
