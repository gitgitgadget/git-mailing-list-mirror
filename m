From: Jeff King <peff@peff.net>
Subject: Re: disallowing push to currently checked-out branch
Date: Sun, 15 Feb 2009 23:01:44 -0500
Message-ID: <20090216040144.GB12689@coredump.intra.peff.net>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <20090215232013.GA11543@zakalwe.fi> <20090216000443.GB3503@coredump.intra.peff.net> <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm> <alpine.DEB.1.10.0902151738450.14911@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Heikki Orsila <shdl@zakalwe.fi>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Feb 16 05:03:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYuhO-0004aT-0v
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 05:03:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756047AbZBPEBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 23:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756034AbZBPEBq
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 23:01:46 -0500
Received: from peff.net ([208.65.91.99]:39890 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755994AbZBPEBq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 23:01:46 -0500
Received: (qmail 13086 invoked by uid 107); 16 Feb 2009 04:02:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 15 Feb 2009 23:02:05 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Feb 2009 23:01:44 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0902151738450.14911@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110132>

On Sun, Feb 15, 2009 at 05:47:37PM -0800, david@lang.hm wrote:

> as I think about this more I'm puzzled as to why this is an issue.

For background, see:

  http://thread.gmane.org/gmane.comp.version-control.git/100339

  http://thread.gmane.org/gmane.comp.version-control.git/107758

  http://article.gmane.org/gmane.comp.version-control.git/108918

> in both cases the new commits are added to the repository and the commit  
> pointed to by the branch changes, but if you do the fetch your HEAD and  
> the contents of the workdir and index aren't touched, why should a push do 
> something different?

The short answer to your confusion is that fetch stores the updates in
"remote tracking refs" (in refs/remotes/) but push pushes directly into
the refs/heads/ hierarchy.

Note that you could set up an alternate push refspec in your client that
pushes into refs/remotes/. But then people fetching from it would have
to know to fetch from their instead of the regular refs/heads/ portion.

> I believe that if you fetch into a repository and someone else fetches  
> from you, they will get the content that's newer that what's in your dirty 
> workdir/index (I haven't tried it, but my understanding of the git  
> internals lead me to expect this to be the behavior)

No, they won't. Because when you fetch, your "refs/heads/master" branch
(for example) is not updated. Your "refs/remotes/origin/master" branch
is.

> If there is some reason for the normal push to try and update the HEAD,  
> index, and workdir. instead of refusing the push, how about having it put  
> the commits in the repository and then fail to change the HEAD, index, and 
> workdir if any of them contain changes? (along with a warning that it's  
> doing so).

The question is where would it "put" the commits if not in the branch
you asked for, which is the one pointed to by "HEAD"?

> this should be safe to do because it will only flag on the particular  
> combination of events that will cause data loss rather than the broader  
> prohibition of "don't push if there is a workdir" that affects legitimate  
> uses as well

It's not "don't push if there is a workdir". It's "don't push into the
ref that is pointed to by HEAD". Which is the exact situation that
causes problems.

-Peff
