From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Change set based shallow clone
Date: Sat, 9 Sep 2006 13:05:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609091256110.27779@g5.osdl.org>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com> 
 <20060908184215.31789.qmail@science.horizon.com> 
 <9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com> 
 <Pine.LNX.4.64.0609081600530.27779@g5.osdl.org>  <17666.4936.894588.825011@cargo.ozlabs.ibm.com>
  <Pine.LNX.4.64.0609081944060.27779@g5.osdl.org>  <17666.13716.401727.601933@cargo.ozlabs.ibm.com>
  <Pine.LNX.4.64.0609082054560.27779@g5.osdl.org> 
 <e5bfff550609090147q37d61f37j9c3e8ae6d3a0cf35@mail.gmail.com> 
 <Pine.LNX.4.64.0609091022360.27779@g5.osdl.org>
 <e5bfff550609091104s3709b82fld3057a07a84ae857@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, Jon Smirl <jonsmirl@gmail.com>,
	"linux@horizon.com" <linux@horizon.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 09 22:06:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GM95N-0007s0-3p
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 22:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWIIUFu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 16:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbWIIUFu
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 16:05:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41883 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964817AbWIIUFt (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Sep 2006 16:05:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k89K5hnW012566
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 9 Sep 2006 13:05:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k89K5gZe018744;
	Sat, 9 Sep 2006 13:05:42 -0700
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550609091104s3709b82fld3057a07a84ae857@mail.gmail.com>
X-Spam-Status: No, hits=-0.526 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26763>



On Sat, 9 Sep 2006, Marco Costalba wrote:
> 
> Sorry, but I don't understand why  you should restart the whole thing
> instead of store away the FIXME commit  and continue.
> 
> If you read my previous e-mail in this thread perhaps it is better
> explained the whole idea.
> 
> Anyhow the basic is:
> 
> -git-rev-list starts outputting the data early (order is not guaranteed)
> 
> -before to mark for output a revision check if it breaks --topo-order
> 
> -if the above is true store the revision away and *do not send*

You don't seem to understand.

It's not that individual new commits might be "out of order", and you can 
suppress them.

It's that individual commits end up showing that OTHER COMMITS, THAT YOU 
HAVE ALREADY SEEN AND SHOWN, can now be shown to be "out of order".

So you're _not_ just suppressing and delaying the few commits that didn't 
conform to the topological sorting. What you're asking for is impossible. 
You can't just delay those to the end, because they implicitly are telling 
you that the earlier commits were already shown in the wrong order.

The example is

		    A		<--- tip of branch
		   / \
		  B   E
                  |   |
		  |   F
		  | /
		  C 
		  |
		  D
		...

where the lettering is in "date order" (ie "A" is more recent than "B" 
etc). In this situation, we'd start following the branch A->B->C->D->.. 
before we even start looking at E and F, because they all _look_ more 
recent.

But then, at some point, we see E and F, and suddenly when looking at F we 
realize that C was printed out much much earlier, and was already shown as 
having only one child. We can't just say "delay F to the end", because 
we'd then have to draw the line _backwards_ to C, which we haven't even 
left room for in the graph, not to mention that the end result would look 
absolutely disgusting even if we had.

So we started out painting this as

		  A
		 / \
		B   |
		|   |
		C   |
		|   |
		D   |
		|   |
		|   E
		|   |
		|   F
		|   |

before we notice how wrong it was, and now we have to go _back_, and 
repaint both E and F as being above C, because only once we hit F do we 
suddenly realize that yeah, it really _was_ younger than C, despite the 
timestamp (which was off, because somebody had set his clock to be a week 
in the past by mistake).

So we can't just delay F and "fix it up" at the end.

		Linus
