From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: pack operation is thrashing my server
Date: Mon, 11 Aug 2008 12:22:08 -0700
Message-ID: <20080811192208.GK26363@spearce.org>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com> <20080811030444.GC27195@spearce.org> <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com> <87vdy71i6w.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ken Pratt <ken@kenpratt.net>, git@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Mon Aug 11 21:23:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KScz4-0001td-HJ
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 21:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbYHKTWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 15:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753066AbYHKTWK
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 15:22:10 -0400
Received: from george.spearce.org ([209.20.77.23]:34372 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108AbYHKTWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 15:22:09 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8D72C38375; Mon, 11 Aug 2008 19:22:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <87vdy71i6w.fsf@basil.nowhere.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91984>

Andi Kleen <andi@firstfloor.org> wrote:
> "Ken Pratt" <ken@kenpratt.net> writes:
> >
> > I'm starting to think repacking is just not feasible on a 64-bit
> > server with 256MB of RAM (which is a very popular configuration in the
> > VPS market).
> 
> I think the right fix would be to make git throttle itself (not 
> use mmap, use very small defaults etc.) on low memory systems.
> It could take a look a /proc/meminfo for this.

Well, we had thought it was already able to throttle itself, as
we did put code in to respond to mmap() and malloc() failures by
trying to release memory and retrying the failed operation again.

However what we don't do is try to limit our heap usage to some
limit that is smaller than physical memory.  We just assume that
whatever we need is available from the OS.  This fails when what
we need exceeds physical memory and the OS tries to use swap.
We can get better performance by reducing what we mmap instead.

:-|

Looking at /proc/meminfo only works on Linux, and maybe some other
OSes which support a /proc like design.  But even then we don't
really know how much we are competing with other active processes
and how much memory we can use.

-- 
Shawn.
