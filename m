From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/2] Have a filter_start/filter_end API.
Date: Sun, 7 Oct 2007 18:07:07 +0200
Message-ID: <20071007160707.GA3270@steel.home>
References: <1191615571-15946-1-git-send-email-madcoder@debian.org> <1191615571-15946-2-git-send-email-madcoder@debian.org> <20071006090621.GB2711@steel.home> <20071007145355.GC10024@artemis.corp>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 07 18:07:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeYfH-0000Pn-Eu
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 18:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbXJGQHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 12:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbXJGQHN
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 12:07:13 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:36181 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbXJGQHM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 12:07:12 -0400
Received: from tigra.home (Facde.f.strato-dslnet.de [195.4.172.222])
	by post.webmailer.de (mrclete mo19) (RZmta 13.4)
	with ESMTP id C00b94j97BVWJt ; Sun, 7 Oct 2007 18:07:08 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id DE081277AE;
	Sun,  7 Oct 2007 18:07:07 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 3C16BC502; Sun,  7 Oct 2007 18:07:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071007145355.GC10024@artemis.corp>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcF9oFqQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60188>

Pierre Habouzit, Sun, Oct 07, 2007 16:53:55 +0200:
> On Sat, Oct 06, 2007 at 09:06:21AM +0000, Alex Riesen wrote:
> > If you continue to insist the code is generic enough to justify its
> > residence in strbuf.c, continue reading.
> >
> > First off, what was wrong with dumb
> >
> >     void strbuf_make_room(struct strbuf *, size_t newsize);
> >
> > again?
> 
>   If newsize is >= sb->alloc then the area is reallocated, the pointer
> may move, and the "src" pointer would then be invalidated.

So what? You already _have_ to know it points inside the strbuf, so
you can't expect it to be valid after any serious strbuf operation.

> > what is that for? Why can't the caller just use strbuf_detach? (He
> > already has to pass negative hint somehow, which should be a concious
> > action).
> 
>   The idea is to have a unified API to deal with both the cases where
> the filtering is known not to work in place by the caller, or for the
> cases where it could if enough space is allocated but that a realloc is
> needed.

this just makes it convoluted and opaque (as in "not transparent")

> > > +	if ((size_t)hint >= sb->alloc) {
> > > +		void *tmp = strbuf_detach(sb, NULL);
> > > +		strbuf_grow(sb, hint);
> > > +		return tmp;
> > > +	}
> > > +
> > > +	return NULL;
> > > +}
> >
> > How can one know when it sb is safe to use after strbuf_end_filter?
> 
>   We could document it, that's not an issue.

The fact that you _have_to_ document is.

> > It is for the first "if", for example. free() wont free the buf in sb.
> > Oh, right, one can check if returned pointer !NULL. Which just adds
> > more code to handle your API.
> 
>   I don't get that part. free(NULL) is totally ok.

Not that. One have to store the result of start_filter and check it

> > What actually happens to sb? Is it detached? Is it reallocated?
> > When it is detached and when it is reallocated?
> 
>   It is detached if the filter does not works in place (caller says that
> with '-1' as a hint) or if it works in place but needs a buffer
> reallocation.

Too many if's. Ugly

>   Note that I did not created this semantics, it was how convert.c
> worked already, in a even more convoluted way before.

And why shouldn't these semantics kept to convert.c?
