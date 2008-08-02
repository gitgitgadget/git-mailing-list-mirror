From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: More on git over HTTP POST
Date: Sat, 2 Aug 2008 13:57:02 -0700
Message-ID: <20080802205702.GA24723@spearce.org>
References: <48938539.9060003@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 22:58:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPOB0-0006XW-S8
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 22:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbYHBU5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 16:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbYHBU5G
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 16:57:06 -0400
Received: from george.spearce.org ([209.20.77.23]:54329 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbYHBU5F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 16:57:05 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id CBF2838419; Sat,  2 Aug 2008 20:57:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48938539.9060003@zytor.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91176>

"H. Peter Anvin" <hpa@zytor.com> wrote:
> I have investigated a bit what it would take to support git protocol  
> (smart transport) over HTTP POST transactions.

I have started to think about this more myself, not just for POST
put also for some form of GET that can return an efficient pack,
rather than making the client walk the object chains itself.

Have you looked at the Mecurial wire protocol?  It runs over HTTP
and uses a relatively efficient means of deciding where to cut the
transfer at.

  http://www.selenic.com/mercurial/wiki/index.cgi/WireProtocol

Most of their smarts are in the branches() and between() operations.

Unfortunately this documentation isn't very complete and/or there
are some simplifications that the Mecurial team took due to their
repository format not initially supporting multiple branches like
the Git format does.

> The current proxy system is broken, for a very simple reason: it doesn't  
> convey information about when the channel should be turned around.

Well, over git:// (or any protocol that wraps git:// like ssh)
we assume a full-duplex channel.  Some proxy systems are able to
do such a channel.  HTTP however does not offer it.

> I started to hack on a variant which would embed a VFS-style interface  
> in git itself, looking something like:
>
> struct transactor;
>
> struct transact_ops {
> 	ssize_t (*read)(struct transactor *, void *, size_t);
> 	ssize_t (*write)(struct transactor *, const void *, size_t);
> 	int (*close)(struct transactor *);
> };

No, the git:// protocol implementation in fetch-pack/upload-pack
runs more efficient than that by keeping a sliding window of stuff
that is in-flight.  Its I guess two async RPCs running in parallel,
but from the client and server perspective both RPCs go into the
same computation.

HTTP POST is actually trivial if you don't want to support the new
tell-me-more extension that was added to git-push.  Hell, I could
write the CGI in a few minutes I think.  Its really just a small
wrapper around git-receive-pack.

What's a bitch is the efficient fetch, and getting tell-me-more to
work on push.

-- 
Shawn.
