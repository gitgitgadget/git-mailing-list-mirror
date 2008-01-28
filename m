From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: Re: [PATCH] Fix off by one error in prep_exclude.
Date: Sun, 27 Jan 2008 18:34:04 -0600
Message-ID: <20080128003404.GA18276@lintop>
References: <47975FE6.4050709@viscovery.net> <1201463731-1963-1-git-send-email-shawn.bohrer@gmail.com> <alpine.LSU.1.00.0801272043040.23907@racer.site> <7v3asiyk2i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, j.sixt@viscovery.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 01:36:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJHyn-00082V-Bc
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 01:36:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257AbYA1Afe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 19:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752953AbYA1Afe
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 19:35:34 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:53730 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbYA1Afd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 19:35:33 -0500
Received: by an-out-0708.google.com with SMTP id d31so322260and.103
        for <git@vger.kernel.org>; Sun, 27 Jan 2008 16:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=wHnvKTA/cnO+DhqzU89oBH6Qng41qPnF8DcShcn0K6k=;
        b=i4VH3MJCA3M3V3MOIrpBnCEDNvC3gM3tanCYSltPsH6QVk6lTZtOKr1BEEYhteuCKtYkIYVnlCVCs4t4x1ifuW/Bb9aKa6OC3YDHCjMjM3kExjfBrUnylZ2cLZMZ3iNFaWklTesYvs7Ejdi/EUeXhrnv1nTZWYQla2wQ9BDZezk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=WIAuM6YmJ48zwqip3Yx5R8LRSr1v+0n27x5PQcyJO5TODYFeeLfowMdNTht8oREQ2Whw65MddOLLLJTDxaHg3qRcgIWrH+OdxzzP6Xjj0UwzUlRDxpLXOESqUS9/8a7B9/4f05RhYjDy3SyJIwtD2Mrz163IXybPslNaqaWihIE=
Received: by 10.100.215.5 with SMTP id n5mr10585683ang.3.1201480531911;
        Sun, 27 Jan 2008 16:35:31 -0800 (PST)
Received: from @ ( [70.112.149.232])
        by mx.google.com with ESMTPS id m10sm8397091rnd.15.2008.01.27.16.35.29
        (version=SSLv3 cipher=OTHER);
        Sun, 27 Jan 2008 16:35:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v3asiyk2i.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71840>

On Sun, Jan 27, 2008 at 02:34:13PM -0800, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> but doesn't address the fact that we probably should remove files that 
> >> aren't a part of the repository at in the first place.
> >
> > I am sorry, but I cannot begin to see what this commit tries to 
> > accomplish.  Yes, sure, there is an off-by-one error, and your commit 
> > message says how that was fixed.  But I miss a description what usage it 
> > would affect, i.e. when this bug triggers.
> >
> > I imagine that you would be as lost as me, reading that commit message 6 
> > months from now, trying to understand why that change was made.
> 
> Likewise.  The message has somewhat to be desired...

Agreed I'll resend with a improved message.
 
> In "struct exclude_stack", prep_exclude() and excluded(), the
> convention for a path is to express the length of directory part
> including the trailing slash (e.g. "foo" and "bar/baz" will get
> baselen=0 and baselen=4 respectively).
> 
> The variable current and parameter baselen follow that
> convention in the codepath the patch touches.
> 
> 		else {
> 			cp = strchr(base + current + 1, '/');
> 			if (!cp)
> 				die("oops in prep_exclude");
> 			cp++;
> 		}
> 		stk->prev = dir->exclude_stack;
> 		stk->baselen = cp - base;
> 
> is about coming up with the next value for current (which is
> taken from stk->baselen) to dig one more level.
> 
> If base="foo/a/boo" and current=4 (i.e. we are looking at
> "foo/"), at the point, scanning from (base+current) as Shawn
> Bohrer's patch suggests means the scan begins at "a/boo" to find
> the next slash.  The existing code skips one letter ('a') and
> starts scanning from "/boo".
> 
> The only case this microoptimization makes difference is when an
> input is malformed and has double-slash (i.e. path component
> whose length is zero), like "foo//boo".

Good catch, I didn't think of this case but this indeed will cause
the same issue.
 
> Perhaps the "oops part of the issue Johannes found" had a caller
> that feeds such an incorrect input?

Nope the problem Johannes Sixt was having was that he mistakenly ran

git clean -n /*foo

Now that isn't what he meant to do, but I figured it might be possible
that someone has their whole filesystem in a git repository, or maybe
is using some sort of chroot on their repository.  Your malformed
paths guess is probably much more likely to occur.

--
Shawn
