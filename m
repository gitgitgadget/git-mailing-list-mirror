From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: jgit, MutableInteger vs AtomicInteger
Date: Tue, 25 Nov 2008 11:19:47 -0800
Message-ID: <20081125191947.GI2932@spearce.org>
References: <loom.20081125T134459-650@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vasyl Vavrychuk <vvavrychuk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 20:21:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L53T8-0002pa-7K
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 20:21:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbYKYTTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 14:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752119AbYKYTTs
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 14:19:48 -0500
Received: from george.spearce.org ([209.20.77.23]:41316 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788AbYKYTTs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 14:19:48 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2E66638200; Tue, 25 Nov 2008 19:19:47 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <loom.20081125T134459-650@post.gmane.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101677>

Vasyl Vavrychuk <vvavrychuk@gmail.com> wrote:
> I've just started browsing jgit sources and an obvious question arise.
> I didn't found such question in mail list and decided to ask the community.
> 
> I don't see reason behind creating own mutable integer container because we 
> have java.util.concurrent.atomic.AtomicInteger with methods
>     public final int get()
>     public final void set(int i)
> 
> And that is what we want.

Eh, its sort-of what we want.

The MutableInteger used in jgit is used instead of this C construct:

	int x;

	call_something(&x);
	call_something_else(&x);
	... now use x ...

In other words it is stack allocated, passed into methods for them
to read and/or update, and then later used in the caller.

AtomicInteger does in fact have get and set methods, providing what
would seem to be the same operation.  But if you read the source
code you'll see that the get and set methods operate against a
volatile int.  IIRC the volatile tag requires that the JRE must
not cache the value in a register.

If you look again at how MutableInteger is used, we never touch the
value outside of a single thread.  The volatile tag on the field
isn't necessary.  It may actually make it harder for the JIT to
produce tight machine code.  Where we use MutableInteger is the
depths of revision traversal and commit parsing, it *must* be fast.


Also, there's the simple fact that I forgot about AtomicInteger,
and it took me less time to code MutableInteger than it did to look
to see if the JRE had something already.  ;-)

-- 
Shawn.
