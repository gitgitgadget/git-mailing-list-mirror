From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Remove restriction on notes ref base
Date: Fri, 05 Nov 2010 02:29:15 +0100
Message-ID: <201011050229.15941.johan@herland.net>
References: <1288657003-17802-1-git-send-email-kroot@google.com>
 <201011040149.47968.johan@herland.net>
 <20101104145817.GA27580@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Kenny Root <kroot@google.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 05 02:29:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEB7r-0005oy-MW
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 02:29:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611Ab0KEB3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 21:29:20 -0400
Received: from smtp.getmail.no ([84.208.15.66]:46002 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752559Ab0KEB3T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 21:29:19 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBE00F101GTT310@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 05 Nov 2010 02:29:17 +0100 (MET)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id D041317994BA_CD35DEDB	for <git@vger.kernel.org>; Fri,
 05 Nov 2010 01:29:17 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id D104517994B0_CD35DECF	for <git@vger.kernel.org>; Fri,
 05 Nov 2010 01:29:16 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBE004A91GS1F10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 05 Nov 2010 02:29:16 +0100 (MET)
User-Agent: KMail/1.13.5 (Linux/2.6.35-ARCH; KDE/4.5.3; x86_64; ; )
In-reply-to: <20101104145817.GA27580@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160795>

On Thursday 04 November 2010, Jeff King wrote:
> On Thu, Nov 04, 2010 at 01:49:47AM +0100, Johan Herland wrote:
> > I'd probably suggest a more straightforward (and hopefully less
> > confusing)
> > 
> > setup like this:
> >   Remote repo    ->   Local repo
> >   ------------------------------------------------
> >   refs/heads/*        refs/remotes/$remote/heads/*
> >   refs/tags/*         refs/remotes/$remote/tags/*
> >   refs/notes/*        refs/remotes/$remote/notes/*
> > 
> > ...and these would all be set in the config, i.e. no implicit/magic
> > refspecs.
> 
> I have often considered that something like that would be simpler, too.
> But just specifying
> 
>   fetch = refs/tags/*:refs/remotes/$remote/tags/*
> 
> would pull down _all_ tags from the remote. Right now we only pull down
> tags for things that we are actually fetching (i.e., auto-follow).
> 
> Now you could argue that auto-follow is not worth the effort. It is
> somewhat confusing, and I can't think of a time when it ever actually
> reduced the set of objects I was fetching (as opposed to just fetching
> all tags). But maybe others have use cases where it matters.

Actually, I don't have anything against auto-follow per se, and we could 
easily enough extend the refspec to specify auto-follow behaviour: There is 
currently the "+" prefix for specifying a forced (non-fast-forward) update. 
We could for example add a "~" prefix for specifying that the refs matched 
by this refspec should only be fetched if they are part of the history 
fetched by other refspecs. We could then reproduce the current auto-follow 
behaviour with the following pair of refspecs:

  +refs/heads/*:refs/remotes/origin/*
  ~+refs/tags/*:refs/tags/*

or in my above proposal:

  +refs/heads/*:refs/remotes/$remote/heads/*
  ~+refs/tags/*:refs/remotes/$remote/tags/*
  +refs/notes/*:refs/remotes/$remote/notes/*

> > We would, for example, extend the ref disambiguation of <name> (as
> > documented in the "SPECIFYING REVISIONS" section of git-rev-parse(1)),
> > so that in the cases where <name> is of the form "<foo>/<bar>" AND
> > <foo> is an existing remote, we also check for the following refs
> > (after none of the
> > 
> > existing checks have returned a match):
> >   7. refs/remotes/<foo>/tags/<bar>
> >   8. refs/remotes/<foo>/heads/<bar>
> 
> This codifies that refs for remote $foo are in refs/remotes/$foo, which
> is something we have avoided so far. For example, when finding the
> "upstream" branch, we have the name of the remote and the merge branch,
> look up the fetch refspecs in the config, and then figure out where that
> branch would be fetched to. Which of course turns out as you say (as
> remotes/$remote_name/$branch) in the default config, but we don't
> restrict people to that.

We can do the same for "foo/bar" as well, although things become slightly 
more fiddly:

When "foo" exists as a remote, look up its fetch refspec(s), and determine 
possible mappings for name "bar". I.e. given the following (non-default) 
refspecs for remote "foo":

  +refs/heads/*:refs/remotes/spam/heads/*
  +refs/tags/*:refs/remotes/eggs/tags/*
  +refs/notes/*:refs/remotes/bacon/notes/*

we know that the intersection between the left side of these refspec and the 
ref disambiguation rules consists of "refs/tags/bar" and "refs/heads/bar" 
(in that order). We can then map these to the right side of the refspec to 
get "refs/remotes/eggs/tags/bar" and "refs/remotes/spam/heads/bar" (in that 
order). We would then use the first match from these alternatives.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
