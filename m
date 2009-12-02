From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Add --track option to git clone
Date: Wed, 2 Dec 2009 17:37:29 -0500
Message-ID: <20091202223728.GB9691@coredump.intra.peff.net>
References: <1259707865-6561-1-git-send-email-sn_@gmx.net>
 <20091202192028.6117@nanako3.lavabit.com>
 <20091202190807.GB30778@coredump.intra.peff.net>
 <20091203060708.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Soria Parra <sn_@gmx.net>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 23:37:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFxpF-0003Rh-VW
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 23:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755747AbZLBWhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 17:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755722AbZLBWhX
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 17:37:23 -0500
Received: from peff.net ([208.65.91.99]:39328 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755494AbZLBWhW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 17:37:22 -0500
Received: (qmail 28395 invoked by uid 107); 2 Dec 2009 22:41:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 02 Dec 2009 17:41:56 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Dec 2009 17:37:29 -0500
Content-Disposition: inline
In-Reply-To: <20091203060708.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134412>

On Thu, Dec 03, 2009 at 06:07:08AM +0900, Nanako Shiraishi wrote:

> >   # most general case
> >   git clone -f 'refs/heads/subset/*:refs/remotes/origin/*' remote.git
> 
> Because this is only about branches and no other kinds of 
> references, I think this is an overkill.

Perhaps. I'm not sure this has to be only about branches. You could do:

  git clone -f tags/v1.6.1 git.git

though I admit I don't really have a burning desire to do so. I just
think it will be simple to make it flexible (since you have to build
such a refspec _anyway_), and there is no reason to restrict people who
might use it creatively.

The biggest argument against it would be that we are confusing the user
by giving too much rope, but I don't think that is the case here. If
you just use branches, you need never know that the full refspec exists
(just as some people use "git fetch origin master" without ever
understanding how "master" can be replaced by a full refspec).

> >   git clone -f 'subset/*' remote.git
> 
> But I think this is a good idea.

One question on this: does it fetch to "refs/remotes/origin/subset/*"
or to "refs/remotes/origin/*"?

I think the latter makes more sense (presumably you don't care that your
branches are in "subset/", since you by definition have asked for
nothing outside of that namespace).

> >   # choose your favorite branch
> >   git clone -f maint -f master -f next -f pu -b next git.git
> > ...
> > What do you think?
> 
> I think your rule to make first branch given by -f the default 
> for -b is a good idea. But I'm not very happy with the example 
> with four -f. Can we probably write it like this?
> 
>   git clone -f maint,master,next,pu git.git

Yeah, that is much nicer. I think "," is allowed in ref names, but I
am tempted not to care here. It is not as if this is a low-level
feature, and most people will not be crazy enough to use commas in their
branch-names. IOW, you will get into trouble only if you have crazy
names _and_ you want to use this particular feature. If we wanted to be
complete, we could provide a quoting mechanism, but that is perhaps
excessive.

> If it isn't a good idea to use comma, we can use colon to split 
> the list of branch names instead.

Colon would work (though of course it would imply not allowing full
refspecs with "-f"). However, I actually find

  git clone -f maint:master:next:pu git.git

to be a bit ugly and confusing.

-Peff
