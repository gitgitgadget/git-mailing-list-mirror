From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: performance on repack
Date: Sat, 11 Aug 2007 15:34:31 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708111529310.30176@woody.linux-foundation.org>
References: <9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com>
 <85ps1tsozb.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 12 00:35:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJzXy-0002gJ-40
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 00:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762042AbXHKWeq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 18:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760375AbXHKWeq
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 18:34:46 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33411 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759200AbXHKWep (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Aug 2007 18:34:45 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7BMYbmd022492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 11 Aug 2007 15:34:38 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7BMYVAg028062;
	Sat, 11 Aug 2007 15:34:31 -0700
In-Reply-To: <85ps1tsozb.fsf@lola.goethe.zz>
X-Spam-Status: No, hits=-2.723 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.24__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55644>



On Sun, 12 Aug 2007, David Kastrup wrote:

> "Jon Smirl" <jonsmirl@gmail.com> writes:
> 
> > If anyone is bored and looking for something to do, making the delta
> > code in git repack multithreaded would help.
> 
> I severely doubt that.  It is like the "coding stuff in assembly
> language will make it faster" myth.  The problem is that of manageable
> complexity.  Making the stuff multithreaded or coded in assembly means
> that it becomes inaccessible for a sound algorithmic redesign.

I have to admit that I'm not a huge fan of threading: the complexity and 
locking often kills you, if memory bandwidth constraints do not, and the 
end result is often really really hard to debug.

That said, I suspect we could some some *simple* form of this by just 
partitioning the problem space up - we could have a MT repack that 
generates four *different* packs on four different CPU's: each thread 
taking one quarter of the objects. At that point, you wouldn't even need 
threads, you could do it with regular processes, since the problem set is 
fully partitioned ocne you've generated the list of objects!

Then, after you've generated four different packs, doing a "git gc" 
(without any threading) will repack them into one big pack, and mostly 
just re-use the existing deltas.

So this would not be a generic thing, but it could be somethign that is 
useful for the forced full-repack after importing a large repository with 
fast-import, for example.

So while I agree with David in general about the problem of threading, I 
think that we can possibly simplify the special case of repacking into 
something less complicated than a "real" multi-threading problem.

		Linus
