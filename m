From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Change set based shallow clone
Date: Sun, 10 Sep 2006 20:03:06 -0400
Message-ID: <20060911000306.GA28927@spearce.org>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com> <20060908184215.31789.qmail@science.horizon.com> <9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com> <Pine.LNX.4.64.0609081600530.27779@g5.osdl.org> <9e4733910609081628w2a59551foc28c689d0538a984@mail.gmail.com> <17668.2019.732961.855446@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>, Linus Torvalds <torvalds@osdl.org>,
	"linux@horizon.com" <linux@horizon.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 11 02:03:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMZGp-0007d1-RJ
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 02:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWIKADU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 20:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWIKADU
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 20:03:20 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:22454 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S964837AbWIKADT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 20:03:19 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GMZGN-0004S5-HO; Sun, 10 Sep 2006 20:02:59 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BB90920FB33; Sun, 10 Sep 2006 20:03:06 -0400 (EDT)
To: Paul Mackerras <paulus@samba.org>
Content-Disposition: inline
In-Reply-To: <17668.2019.732961.855446@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26822>

Paul Mackerras <paulus@samba.org> wrote:
[snip]
> The bottom line is that I can speed up the startup for the hot-cache
> case quite a lot.  The cold-cache case is going to take about 20-30
> seconds whatever I do unless Linus or Junio can come up with a way to
> pack the heads and tags.  I could read the refs asynchronously but
> there will still be a long delay in git rev-parse if you give
> arguments such as --all.

I've been thinking about implementing ref storage within a Git tree
object.  Just store the commit/tag/object IDs in a tree (or graph
of trees) with a mode of '0'.  Anchor that under '.git/refs-tree'.
Any edit of a ref would "lock" .git/refs-tree, create a new tree
containing the update, then replace .git/refs-tree.

But it would put additional stress on the objects directory by
creating a lot of trees which would never get pulled into pack
files and thus would need to be pruned away on a regular basis.

It also would make parallel updates more difficult on the server
side as everyone would need to wait for the lock to .git/refs-tree
before they can change any ref; today users only need to wait for
the ref they are trying to change.

It also doesn't help looking up a ref quickly; although trees are
sorted they are variable length entries which forces the application
to read the entire tree to find its entry.


Given those three downsides I haven't put anything to code yet.

-- 
Shawn.
