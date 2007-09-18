From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 0/3] the return of the strbuf
Date: Mon, 17 Sep 2007 23:57:21 -0400
Message-ID: <20070918035721.GL3099@spearce.org>
References: <20070917125211.GA18176@artemis.corp> <20070917133522.GD18176@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 05:57:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXUDY-0006x2-OX
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 05:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142AbXIRD51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 23:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754105AbXIRD51
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 23:57:27 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43896 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396AbXIRD50 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 23:57:26 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IXUD1-0000JC-5a; Mon, 17 Sep 2007 23:57:11 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7DEA920FBAE; Mon, 17 Sep 2007 23:57:22 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070917133522.GD18176@artemis.corp>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58526>

Pierre Habouzit <madcoder@debian.org> wrote:
> On lun, sep 17, 2007 at 12:52:11 +0000, Pierre Habouzit wrote:
> >   While getting rid of ->eof in strbuf (as it was somehow tasteless). It
> > made me aware of the fact that fast-import.c was using a custom buffer
> > implementation (I think that was the fourth if not the fifth). So here
> > is the series that eradicates it.
> 
> Shawn: Johannes makes me remark that you are git-fast-import author,
> hence may want to be Cc-ed of that series, so here is a mail so that you
> don't miss the thread.

Thanks.  The subject caught my attention.  The patches look good and
fast-import is usually maintained by me applying them and Junio pulling
from my fast-import tree.  I'm doing that now.

BTW, I haven't thanked you for doing this cleanup work.  It really
is appreciated.  The code is definately more readable in the end.
Thanks.
 
> The list: it's often hard to know who you should Cc on a given change,
> I use format.headers to force Junio and git@, but sometimes you want a
> different set of persons. I wonder if this could not be wired in the
> repository, as a .gitattribute extension ?

The Linux kernel folks were talking about this not too long ago
and the discussion spilled onto the git list when someone CC'd it
in the middle of the thread.  If I recall correctly it ended off with
this is probably something that a build script should be doing, not
something Git should do natively, as the data is readily available
from tools like git-log.

Indeed in this case if you do:

 $ git log --pretty=format:%an --since=6.months.ago -- fast-import.c \
      | sort | uniq -c | sort -nr
  14 Shawn O. Pearce
   3 Pierre Habouzit
   3 Junio C Hamano
   2 Simon Hausmann
   2 Alex Riesen
   1 Theodore Ts'o
   1 Sven Verdoolaege
   1 Sami Farin
   1 Nicolas Pitre
   1 Luiz Fernando N. Capitulino
   1 Dana L. How
 
So you'd probably want to CC me on stuff in that file.  On the other hand
looking at something else that's much more important to Git:

  $ git log --pretty=format:%an --since=6.months.ago -- builtin-pack-objects.c \
       | sort | uniq -c | sort -nr
  38 Nicolas Pitre
  12 Junio C Hamano
   4 Dana L. How
   3 Martin Koegler
   3 Linus Torvalds
   3 Brian Downing
   2 Theodore Ts'o
   2 Dana How
   1 Luiz Fernando N. Capitulino
   1 Geert Bosch
   1 Alex Riesen

I don't think anyone would argue that CC'ing Nico and Junio on all
sizeable pack-objects changes would be prudent.  Dana too actually
as he has been active in here recently.  Meanwhile I don't make
the 6 month cut.  ;-)

The other alternative that men with real computing horsepower at
their disposal can ask is through git-blame:

  $ git blame -C -C -w --porcelain builtin-pack-objects.c | grep 'author ' \
       | sort | uniq -c | sort -nr
  52 author Nicolas Pitre
  39 author Junio C Hamano
  22 author Linus Torvalds
   6 author Shawn O. Pearce
   6 author Dana L. How
   3 author Martin Koegler
  ...

Again Nico scores very high (52 commits surviving in current `next`)
but so does Junio and Linus.  The output of git-blame may actually
be a better indicator of who Junio likes to CC when changes are
made in this module.

Doing something like this automatically based on the filepaths shown
by `git diff --name-only $cmit^ $cmt` could be expensive in terms
of CPU time, and might offer little gain for an old hand who knows
where the maintainer boundaries tend to be, but it does really help
someone who is newer to the project and might not know who is the
best person to talk to.

-- 
Shawn.
