From: Josef Wolf <jw@raven.inka.de>
Subject: Re: Trying to sync two svn repositories with git-svn (repost)
Date: Wed, 13 May 2009 14:09:22 +0200
Message-ID: <20090513120922.GP15420@raven.wolf.lan>
References: <20090501142811.GI15420@raven.wolf.lan> <32541b130905011217x7f339d41x696fedee7298e3a4@mail.gmail.com> <20090502215852.GJ15420@raven.wolf.lan> <32541b130905040858v2a0b7a6br5b056a365fcb6855@mail.gmail.com> <20090504211423.GK15420@raven.wolf.lan> <20090506185224.GM15420@raven.wolf.lan> <32541b130905061223h7efddeecvcc52a369093a6b50@mail.gmail.com> <20090506225042.GN15420@raven.wolf.lan> <32541b130905081344m634a78d5l984f4903ec1515eb@mail.gmail.com> <20090508235821.GO15420@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 14:10:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4DIN-0005Cc-Ua
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 14:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759836AbZEMMKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 08:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759026AbZEMMKT
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 08:10:19 -0400
Received: from quechua.inka.de ([193.197.184.2]:47758 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758115AbZEMMKR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 08:10:17 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1M4DHt-0005fR-7U; Wed, 13 May 2009 14:10:17 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id DDAD52CCEA; Wed, 13 May 2009 14:09:22 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@gmail.com>
Content-Disposition: inline
In-Reply-To: <20090508235821.GO15420@raven.wolf.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119041>

On Sat, May 09, 2009 at 01:58:22AM +0200, Josef Wolf wrote:

After lots of trial-and-error, I guess I've located the reason of
one of the failures.  Please see below: 

>   # Create tags so we can see later what we have done
>   #
>   git tag svn-1-orig svn-1
>   git tag svn-2-orig svn-2
> 
>   # move cherries from svn-1 to svn-2
>   #
>   git svn fetch svn-1
>   git checkout svn-2
>   [ cherry-picking, creates 67446..0a742 ]
>   git merge --no-ff -s ours svn-1 -m 'merge ours svn-1 to svn-2' # 5d9a0
>   git checkout svn-2/trunk
>   git merge --no-ff svn-2 -m 'merge svn-1 to svn-2'              # f80d2
>   git svn dcommit
> 
>   # check the results
>   #
>   git diff svn-2-orig svn-2/trunk
>   git diff svn-2-orig svn-2
> 
>   # move cherries from svn-1 to svn-2
>   #
>   git svn fetch svn-2
>   git checkout svn-1
>   [ cherry-picking, creates a5cf3..c3ff2 ]
>   git merge --no-ff -s ours svn-2 -m 'merge ours svn-2 to svn-1' # 2379d
>   git checkout -q svn-1/trunk
>   git merge --no-ff svn-1 -m 'merge svn-2 to svn-1'              # 693fa
>   git svn dcommit --no-rebase
> 
>   # again, check the results
>   #
>   git diff svn-1-orig svn-1/trunk
>   git diff svn-1-orig svn-1
> 
> At this time, I made the graph attached below.  Two things are
> interesting in this graph:
> - svn-1 has all the imported commits and all the cherries as parent
>   svn-2 does _not_ have a5cf3..c3ff2 as parent
> - same thing happens for remotes/svn-2/trunk vs. remotes/svn-2/trunk

So, in order to mark a5cf3..c3ff2 as ancestors of svn-2, I've inserted
following step at this place:

  git checkout svn-2
  git merge --no-ff -s ours svn-1

This works fine, a5cf3..c3ff2 are now recorded as ancestors of svn-2 and
will no longer be picked on future merges.

  git checkout svn-2/trunk
  git merge --no-ff -s ours svn-1
  git svn dcommit

Now here's the problem:  This last dcommit does simply a reset, because
nothing has changed since the last dcommit.  So a5cf3..c3ff2 are _not_
marked as ancestors of svn-2/trunk, causing those cherries to be rebased
at the next dcommit with real changes.

Unfortunately, dcommit doesn't seem to have an option to force rebase
instead of resetting.

Any ideas how to mark those commits as ancestors of svn-2/trunk?

> Here is an overview of the created commits:
> 
> # b8bf1, 8536f..09393, d0f29   imported from svn-1 repository
> # 7b397, 17156..e0772, 05eb1   imported from svn-2 repository
> # a5cf3..c3ff2                 cherries from svn-2 to svn-1
> # 67446..0a742                 cherries from svn-1 to svn-2
> # 5d9a0     merge ours svn-1 to svn-2
> # 693fa     merge svn-2 to svn-1
> # 2379d     merge ours svn-2 to svn-1
> # f80d2     merge svn-1 to svn-2
> 
> And here's the .dot graph.  Please pipe it through "dot -Tps" to create
> a postscript file of the graph.
> 
> strict digraph G {
>   size = "7,10"
>   "8536f" [label="8536f"] ;
>   "b8bf1"->"8536f"  ;
>   "693fa" [label="693fa\nremotes/svn-1/trunk"] ;
>   "d0f29"->"693fa"  ;
>   "2379d"->"693fa"  ;
>   "5d9a0" [label="5d9a0\nsvn-2"] ;
>   "d0f29"->"5d9a0"  ;
>   "0a742"->"5d9a0"  ;
>   "f80d2" [label="f80d2\nremotes/svn-2/trunk"] ;
>   "05eb1"->"f80d2"  ;
>   "5d9a0"->"f80d2"  ;
>   "b8bf1" [label="b8bf1"] ;
>   "09393" [label="09393"] ;
>   "8536f"->"09393" [style="dotted"] ;
>   "05eb1" [label="05eb1\nsvn-2-orig"] ;
>   "e0772"->"05eb1"  ;
>   "67446" [label="67446"] ;
>   "05eb1"->"67446"  ;
>   "d0f29" [label="d0f29\nmaster\nsvn-1-orig"] ;
>   "09393"->"d0f29"  ;
>   "a5cf3" [label="a5cf3"] ;
>   "d0f29"->"a5cf3"  ;
>   "17156" [label="17156"] ;
>   "7b397"->"17156"  ;
>   "2379d" [label="2379d\nsvn-1"] ;
>   "c3ff2"->"2379d"  ;
>   "5d9a0"->"2379d"  ;
>   "0a742" [label="0a742"] ;
>   "67446"->"0a742" [style="dotted"] ;
>   "c3ff2" [label="c3ff2"] ;
>   "a5cf3"->"c3ff2" [style="dotted"] ;
>   "7b397" [label="7b397"] ;
>   "e0772" [label="e0772"] ;
>   "17156"->"e0772" [style="dotted"] ;
> }
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
