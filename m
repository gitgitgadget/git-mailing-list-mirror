From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] TopGit v0.3
Date: Fri, 12 Sep 2008 15:15:30 +0200
Message-ID: <20080912131530.GZ10360@machine.or.cz>
References: <20080909231009.GD10544@machine.or.cz> <1221120192.8962.7.camel@heerbeest> <20080912110017.GW10360@machine.or.cz> <1221222433.29747.8.camel@heerbeest>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
X-From: git-owner@vger.kernel.org Fri Sep 12 15:16:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke8Vt-0006s7-SA
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 15:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbYILNPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 09:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbYILNPd
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 09:15:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50881 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676AbYILNPd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 09:15:33 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id DD809393A816; Fri, 12 Sep 2008 15:15:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1221222433.29747.8.camel@heerbeest>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95724>

On Fri, Sep 12, 2008 at 02:27:13PM +0200, Jan Nieuwenhuizen wrote:
> On vr, 2008-09-12 at 13:00 +0200, Petr Baudis wrote:
> 
> > But this is rewriting history, isn't it?
> 
> No (that would be useless), see 
> 
>     http://kerneltrap.org/mailarchive/git/2008/8/13/2925144 #first tg redepend idea

Huh. I can't see how that could ever work.

> 	$ git checkout -b P' P
> 	$ git rebase --onto B' B
> 	$ git checkout P
> 	$ git merge --no-ff --no-commit B'   (*)
> 	$ git read-tree -u P'
> 	$ git commit
> 	$ git branch -D P'

The read-tree step is broken, you can't do that. The dependencies
content will be gone from your base, but not from the actual head -
what's the point of removing them at all?

Actually, tg patch will then show diff not only of your patch, but the
removed dependencies as well!

There's plenty of other problems with this approach as well. And I can't
see how readding a removed dependency would work at all either.

> I've just implemented the second idea
> 
>     http://kerneltrap.org/mailarchive/git/2008/8/15/2954214
> 
> but haven't got any time to test it yet.  Then there's also 
> 
>     http://kerneltrap.org/mailarchive/git/2008/8/15/2952004
> 
> to consider.

That's good point, indirect dependencies problem did not occur to me
before. That's troublesome...

I'm beginning to wonder if it is worth the trouble to support changing
dependencies in existing branches at all, except in the case the
dependency got merged to upstream (then we don't hit any of these
troubles). I'm stopping to see any way how to sanely support dependency
removal without history rewriting, since we rely on Git for our all
changes propagation.

> > Currently, I'm thinking that something like .topundeps (or !-prefixing
> > dependencies in .topdeps) is the only way to implement this...
> 
> Yeah, i've been thinking that too.  It would be nice if we could
> hack around that.  It seems that the two redepend ideas get around
> it at the expense of creating the whole list of dependencies,
> which is much too expensive for my taste.

Actually, you would have to do this here as well for what we could call
"the evil Jonathan scenario":

> 	Make a topic branch t/foo depending on master.
> 	Change the dependency of t/foo to the older version maint.
> 	Make a new topic branch t/bar depending on t/foo and master.

When creating t/bar, you _need_ to look in t/foo dependencies to figure
out that you really do need the master stuff merged.

Even worse, these dependency removals act dominantly through merges.
Consider t/xyzzy and t/qux both depending on master. If you remove
master dependency from t/xyzzy and then merge them together, you'll lose
master from the result, even though t/qux needs it, because of the
dependency removal commit!

More and more worms turn up in the can.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
