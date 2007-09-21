From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 4/4] t6000lib: workaround a possible dash bug
Date: Fri, 21 Sep 2007 13:45:11 -0700
Message-ID: <20070921204511.GA10079@muzzle>
References: <11486091793385-git-send-email-normalperson@yhbt.net> <11486091792604-git-send-email-normalperson@yhbt.net> <20070921132808.GB9778@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
X-From: git-owner@vger.kernel.org Fri Sep 21 22:45:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYpNi-00077D-7H
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 22:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763313AbXIUUpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 16:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763360AbXIUUpO
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 16:45:14 -0400
Received: from hand.yhbt.net ([66.150.188.102]:54843 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763238AbXIUUpM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 16:45:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 7040B7DC029;
	Fri, 21 Sep 2007 13:45:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070921132808.GB9778@gondor.apana.org.au>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58879>

Herbert Xu <herbert@gondor.apana.org.au> wrote:
> Hi Eric:

Hi Herbert,

> On Thu, May 25, 2006 at 07:06:18PM -0700, Eric Wong wrote:
> > pdksh doesn't need this patch, of course bash works fine since
> > that what most users use.
> > 
> > Normally, 'var=val command' seems to work fine with dash, but
> > perhaps there's something weird going on with "$@".  dash is
> > pretty widespread, so it'll be good to support this even though
> > it does seem like a bug in dash.
> 
> Just going through dash issues right now.  Do you recall
> what the bug is in this case? Doing a quick test doesn't
> seem to show much:
> 
> dash -c 'set -- env; a=b "$@"'

I tried to reproduce it on a quick script using shell functions,
multiple arguments, spaces in the $a variable.., but haven't
been successful.  However, reverting the below patch still
causes errors in the latest git test suite.

> > diff --git a/t/t6000lib.sh b/t/t6000lib.sh
> > index c6752af..d402621 100755
> > --- a/t/t6000lib.sh
> > +++ b/t/t6000lib.sh
> > @@ -69,7 +69,9 @@ on_committer_date()
> >  {
> >      _date=$1
> >      shift 1
> > -    GIT_COMMITTER_DATE=$_date "$@"
> > +    export GIT_COMMITTER_DATE="$_date"
> > +    "$@"
> > +    unset GIT_COMMITTER_DATE
> >  }
> >  
> >  # Execute a command and suppress any error output.
> > -- 
> > 1.3.2.g7d11
> 
> Thanks,

I'm using dash 0.5.3-7 from Debian Etch on x86-32.
(git @ 17ed158021ead9cb056f692fc35ff3fcde96a747)

*** t6003-rev-list-topo-order.sh ***
*   ok 1: rev-list has correct number of entries
*   ok 2: simple topo order
*   ok 3: two diamonds topo order (g6)
* FAIL 4: multiple heads
	check_output multiple-heads "git rev-list --topo-order a3 b3 c3"
* FAIL 5: multiple heads, prune at a1
	check_output multiple-heads-prune-at-a1 "git rev-list --topo-order a3 b3 c3 ^a1"
* FAIL 6: multiple heads, prune at l1
	check_output multiple-heads-prune-at-l1 "git rev-list --topo-order a3 b3 c3 ^l1"
*   ok 7: cross-epoch, head at l5, prune at l1
*   ok 8: duplicated head arguments
*   ok 9: prune near topo
*   ok 10: head has no parent
*   ok 11: two nodes - one head, one base
*   ok 12: three nodes one head, one internal, one base
*   ok 13: linear prune l2 ^root
*   ok 14: linear prune l2 ^l0
*   ok 15: linear prune l2 ^l1
*   ok 16: linear prune l5 ^a4
*   ok 17: linear prune l5 ^l3
*   ok 18: linear prune l5 ^l4
*   ok 19: max-count 10 - topo order
* FAIL 20: max-count 10 - non topo order
	check_output max-count-10-non-topo-order "git rev-list --max-count=10 l5"
* FAIL 21: --max-age=c3, no --topo-order
	check_output max-age-c3-no-topo-order "git rev-list --max-age=1190407285 l5"
*   ok 22: one specified head reachable from another a4, c3, --topo-order
*   ok 23: one specified head reachable from another c3, a4, --topo-order
*   ok 24: one specified head reachable from another a4, c3, no --topo-order
*   ok 25: one specified head reachable from another c3, a4, no --topo-order
*   ok 26: graph with c3 and a4 parents of head
*   ok 27: graph with a4 and c3 parents of head
*   ok 28: head ^head --topo-order
*   ok 29: head ^head no --topo-order
*   ok 30: simple topo order (l5r1)
*   ok 31: simple topo order (r1l5)
*   ok 32: don't print things unreachable from one branch
*   ok 33: --topo-order a4 l3
* failed 5 among 33 test(s)
make: *** [t6003-rev-list-topo-order.sh] Error 1

-- 
Eric Wong
