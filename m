From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] builtin-revert.c: Make use of merge_recursive()
Date: Mon, 11 Aug 2008 21:01:23 +0200
Message-ID: <20080811190123.GA14413@leksak.fem-net>
References: <cover.1218374062.git.vmiklos@frugalware.org> <1218467003-14591-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0808111737270.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 11 21:02:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KScf2-0001ZP-CJ
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 21:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753761AbYHKTBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 15:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753125AbYHKTB3
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 15:01:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:60186 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753761AbYHKTB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 15:01:29 -0400
Received: (qmail invoked by alias); 11 Aug 2008 19:01:26 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp009) with SMTP; 11 Aug 2008 21:01:26 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18nKQxNneonhTPnXbtFqmoyg7Lu44j1bBrtxc81rd
	lN99RyzRmYpjzF
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KScdv-0000YL-5U; Mon, 11 Aug 2008 21:01:23 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0808111737270.24820@pacific.mpi-cbg.de.mpi-cbg.de>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91976>

Hi,

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 11 Aug 2008, Stephan Beyer wrote:
> 
> > diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
> > index 09aa830..d8bd21f 100644
> > --- a/builtin-merge-recursive.c
> > +++ b/builtin-merge-recursive.c
> > @@ -1327,7 +1327,7 @@ static const char *better_branch_name(const char *branch)
> >  	return name ? name : branch;
> >  }
> >  
> > -static struct commit *get_ref(const char *ref)
> > +struct commit *get_ref(const char *ref)
> 
> The name get_ref() is way too generic to be non-static.

That's right.

> But I have a hunch that peel_to_type() does a lot of what we want here,
> if not all of it.

get_ref() has a big advantage over peel_to_type(): it can handle trees,
via "virtual commits" (make_virtual_commit()).
If you wonder where we need to handle trees on cherry-pick/revert:
With the -n (no commit) option you are allowed to have a dirty index.
So the recursive merge is not done using the HEAD commit but using the
uncommitted tree of the index.

Well, a good alternative could be to just make the really cool
make_virtual_commit() function non-static.
The name could be generic enough. Is it? :-)
Or perhaps: make_virtual_commit_from_tree().

Btw I also need get_ref() (or make_virtual_commit()) for threeway
fallback of the sequencer "patch -3" instruction ("git am -3"). ;)

> > +	h1 = get_ref(head_sha1);
> > +	h2 = get_ref(next_sha1);
> > +
> > +	index_fd = hold_locked_index(lock, 1);
> > +	clean = merge_recursive(h1, h2, head_name, next_name, ca, &result);
> 
> h1 and h2 are not expressive.  head_commit and next_commit would be.

This is also quite true.
Those names, also "ca", were taken from cmd_merge_recursive().
(This is no excuse, just an explanation.)

> Rest looks good to me -- even if I had to spend too much time (therefore 
> being not really thorough in the end) verifying that merge_recursive() 
> does not lock the index itself,

I can't help here.  Miklos has the same change in patch v2/2 and I
wonder if you really expect that I don't test my patches, because
a double lock wouldn't have worked.

> and that GITHEAD_* definitions are not necessary anymore, since merge_recursive()
> takes the arguments directly;

Ok, I hoped that would've been clear by using head_name/next_name
directly in the merge_recursive() arguments, but nevertheless
thanks for your comment, ...because: using get_ref() the GITHEAD_*
definitions *are* still needed, because it takes the GITHEAD_*
name for the virtual commits...

Under this additional circumstance, I really tend to make
make_virtual_commit() non-static.

Kind regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
