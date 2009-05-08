From: Josef Wolf <jw@raven.inka.de>
Subject: Re: Trying to sync two svn repositories with git-svn (repost)
Date: Sat, 9 May 2009 01:58:22 +0200
Message-ID: <20090508235821.GO15420@raven.wolf.lan>
References: <32541b130904301559w329bdd4bo6f2736a505b7235f@mail.gmail.com> <20090501142811.GI15420@raven.wolf.lan> <32541b130905011217x7f339d41x696fedee7298e3a4@mail.gmail.com> <20090502215852.GJ15420@raven.wolf.lan> <32541b130905040858v2a0b7a6br5b056a365fcb6855@mail.gmail.com> <20090504211423.GK15420@raven.wolf.lan> <20090506185224.GM15420@raven.wolf.lan> <32541b130905061223h7efddeecvcc52a369093a6b50@mail.gmail.com> <20090506225042.GN15420@raven.wolf.lan> <32541b130905081344m634a78d5l984f4903ec1515eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 09 03:16:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2bBJ-00064D-NE
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 03:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753722AbZEIBQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 21:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753573AbZEIBQj
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 21:16:39 -0400
Received: from quechua.inka.de ([193.197.184.2]:56381 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752409AbZEIBQi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 21:16:38 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1M2ZzM-0005zr-D9; Sat, 09 May 2009 02:00:24 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id 37D372CCC2; Sat,  9 May 2009 01:58:22 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <32541b130905081344m634a78d5l984f4903ec1515eb@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118642>

On Fri, May 08, 2009 at 04:44:39PM -0400, Avery Pennarun wrote:
> I agree that gitk's lane-changing can be a bit confusing.  Could you
> try making a slightly modified version of your script, where you only
> cherry-pick one or two commits in each direction?  That should be
> functionally identical, but a much simpler diagram.

Somehow I can't keep git-svn from fetching all the svn revisions, thus
it's still split over a long distance.

But in the meantime, I've hacked a quick-n-dirty script to show only
the 'interesting' commits with an optional context.  This helped me a
lot to get a better understanding what's going on.  I have appended the
result at the end of this mail.  Please convert it with "dot -Tps" to
postscript to view the result.

So here I go again with my attempt to analyze what happens.  I attach
the sha1 of created commits as a comment to the command that creates the
commit.

  # Create tags so we can see later what we have done
  #
  git tag svn-1-orig svn-1
  git tag svn-2-orig svn-2

  # move cherries from svn-1 to svn-2
  #
  git svn fetch svn-1
  git checkout svn-2
  [ cherry-picking, creates 67446..0a742 ]
  git merge --no-ff -s ours svn-1 -m 'merge ours svn-1 to svn-2' # 5d9a0
  git checkout svn-2/trunk
  git merge --no-ff svn-2 -m 'merge svn-1 to svn-2'              # f80d2
  git svn dcommit

  # check the results
  #
  git diff svn-2-orig svn-2/trunk
  git diff svn-2-orig svn-2

  # move cherries from svn-1 to svn-2
  #
  git svn fetch svn-2
  git checkout svn-1
  [ cherry-picking, creates a5cf3..c3ff2 ]
  git merge --no-ff -s ours svn-2 -m 'merge ours svn-2 to svn-1' # 2379d
  git checkout -q svn-1/trunk
  git merge --no-ff svn-1 -m 'merge svn-2 to svn-1'              # 693fa
  git svn dcommit --no-rebase

  # again, check the results
  #
  git diff svn-1-orig svn-1/trunk
  git diff svn-1-orig svn-1

At this time, I made the graph attached below.  Two things are
interesting in this graph:
- svn-1 has all the imported commits and all the cherries as parent
  svn-2 does _not_ have a5cf3..c3ff2 as parent
- same thing happens for remotes/svn-2/trunk vs. remotes/svn-2/trunk


Now, when I do

  git checkout svn-2       # same thing happens when svn-2/trunk is used
  git merge --no-ff svn-1

And here I'm completely barfed.  The tree is set _identical_ to the tree
in 2379d.  All the differences which should be kept are lost here.
I can easily see (although I don't know how to avoid it) why a5cf3..c3ff2
might be applied to svn-2 and svn-2/trunk though it should not be applied.

But I completely fail to see why the tree is set identical to 2379d.


Here is an overview of the created commits:

# b8bf1, 8536f..09393, d0f29   imported from svn-1 repository
# 7b397, 17156..e0772, 05eb1   imported from svn-2 repository
# a5cf3..c3ff2                 cherries from svn-2 to svn-1
# 67446..0a742                 cherries from svn-1 to svn-2
# 5d9a0     merge ours svn-1 to svn-2
# 693fa     merge svn-2 to svn-1
# 2379d     merge ours svn-2 to svn-1
# f80d2     merge svn-1 to svn-2

And here's the .dot graph.  Please pipe it through "dot -Tps" to create
a postscript file of the graph.

strict digraph G {
  size = "7,10"
  "8536f" [label="8536f"] ;
  "b8bf1"->"8536f"  ;
  "693fa" [label="693fa\nremotes/svn-1/trunk"] ;
  "d0f29"->"693fa"  ;
  "2379d"->"693fa"  ;
  "5d9a0" [label="5d9a0\nsvn-2"] ;
  "d0f29"->"5d9a0"  ;
  "0a742"->"5d9a0"  ;
  "f80d2" [label="f80d2\nremotes/svn-2/trunk"] ;
  "05eb1"->"f80d2"  ;
  "5d9a0"->"f80d2"  ;
  "b8bf1" [label="b8bf1"] ;
  "09393" [label="09393"] ;
  "8536f"->"09393" [style="dotted"] ;
  "05eb1" [label="05eb1\nsvn-2-orig"] ;
  "e0772"->"05eb1"  ;
  "67446" [label="67446"] ;
  "05eb1"->"67446"  ;
  "d0f29" [label="d0f29\nmaster\nsvn-1-orig"] ;
  "09393"->"d0f29"  ;
  "a5cf3" [label="a5cf3"] ;
  "d0f29"->"a5cf3"  ;
  "17156" [label="17156"] ;
  "7b397"->"17156"  ;
  "2379d" [label="2379d\nsvn-1"] ;
  "c3ff2"->"2379d"  ;
  "5d9a0"->"2379d"  ;
  "0a742" [label="0a742"] ;
  "67446"->"0a742" [style="dotted"] ;
  "c3ff2" [label="c3ff2"] ;
  "a5cf3"->"c3ff2" [style="dotted"] ;
  "7b397" [label="7b397"] ;
  "e0772" [label="e0772"] ;
  "17156"->"e0772" [style="dotted"] ;
}
