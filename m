From: Matt Mackall <mpm@selenic.com>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Fri, 29 Apr 2005 13:23:41 -0700
Message-ID: <20050429202341.GB21897@waste.org>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org> <20050429060157.GS21897@waste.org> <3817.10.10.10.24.1114756831.squirrel@linux1> <20050429074043.GT21897@waste.org> <Pine.LNX.4.58.0504290728090.18901@ppc970.osdl.org> <20050429163705.GU21897@waste.org> <Pine.LNX.4.58.0504291006450.18901@ppc970.osdl.org> <20050429191207.GX21897@waste.org> <Pine.LNX.4.58.0504291248210.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 22:20:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRbxd-0006Q9-7N
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 22:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbVD2UZC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 16:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262959AbVD2UYp
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 16:24:45 -0400
Received: from waste.org ([216.27.176.166]:23448 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262950AbVD2UXq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 16:23:46 -0400
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-1) with ESMTP id j3TKNfgC018537
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 29 Apr 2005 15:23:41 -0500
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id j3TKNfu2018534;
	Fri, 29 Apr 2005 15:23:41 -0500
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504291248210.18901@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 29, 2005 at 12:50:55PM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 29 Apr 2005, Matt Mackall wrote:
> > 
> > Here's an excerpt from http://selenic.com/mercurial/notes.txt on how
> > the back-end works.
> 
> Any notes on how you maintain repository-level information?
> 
> For example, the expense in BK wasn't the single-file history, it was the
> _repository_ history, ie the "ChangeSet" file. Which grows quite slowly,
> but because it _always_ grows, it ends up being quite big and expensive to
> parse after three years.
> 
> Ie do you have the git kind of "independent trees/commits", or do you 
> create a revision history of those too?

The changeset log (and everything else) has an external index. The
index is basically an array of (base, offset, length, parent1-hash,
parent2-hash, my-hash). This has everything you need to reconstruct a
given file revision with one seek/read into the data stream itself,
and also everything you need for doing graph merging.

This is small enough (68 bytes, currently) that the index for a
million changesets can be read into memory in a couple seconds or so,
even in Python. It can also be mmapped and random accessed since the
index entries are fixed-sized. (And it's already stored big-endian.)

So you never have to read all the data. You also never need more than
a few indices in memory at once. And you never have to rewrite the
data (it's all append-only), except to do a bulk copy when you break a
hardlink.

-- 
Mathematics is the supreme nostalgia of our time.
