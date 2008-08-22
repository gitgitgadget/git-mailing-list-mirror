From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Linux 2.6.27-rc3: kernel BUG at mm/vmalloc.c - bisected
Date: Fri, 22 Aug 2008 09:25:49 -0700
Message-ID: <20080822092549.ddcb7e79.akpm@linux-foundation.org>
References: <48A36838.3050309@hp.com>
	<20080819124602.9e8e69f7.akpm@linux-foundation.org>
	<48AEDD3D.4060507@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org
To: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 18:27:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWZTV-000783-N5
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 18:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbYHVQZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 12:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbYHVQZx
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 12:25:53 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52082 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750897AbYHVQZw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Aug 2008 12:25:52 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7MGPnX6012640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 22 Aug 2008 09:25:50 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m7MGPnOJ004943;
	Fri, 22 Aug 2008 09:25:49 -0700
In-Reply-To: <48AEDD3D.4060507@hp.com>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
X-Spam-Status: No, hits=-2.837 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 22 Aug 2008 11:37:33 -0400 "Alan D. Brunelle" <Alan.Brunelle@hp.com> wrote:

> Andrew Morton wrote:
> 
> > 
> > You could confirm/debug it with something along the lines of this:
> > 
> > --- a/mm/vmalloc.c~a
> > +++ a/mm/vmalloc.c
> > @@ -214,7 +214,9 @@ __get_vm_area_node(unsigned long size, u
> >  	unsigned long align = 1;
> >  	unsigned long addr;
> >  
> > -	BUG_ON(in_interrupt());
> > +	if (preempt_count() > 10)
> > +		printk("%s: preempt_count()=%d\n", __func__, preempt_count());
> > +	WARN_ON(in_interrupt());
> >  	if (flags & VM_IOREMAP) {
> >  		int bit = fls(size);
> >  
> > _
> > 
> > 
> > But this bug could be in practically anywhere in the kernel and
> > bisection is by far the best way to find it.  It's sad and odd that
> > bisection landed you on a merge commit.  I'd suggest that you persist
> > with the bisection (please). 
> > http://www.kernel.org/doc/local/git-quick.html#example might be useful.
> 
> Sorry, was off on other things for the last couple of days:
> 
> I /did/ bisect it down to the aforementioned merge, the question is: How
> to crack open that merge into it's composite pieces? (Where do I go to
> bisect within that?)

urgh, it's irritating when git-bisect directs you to a merge commit - it
hasn't done it for me for ages.

One (probably wrong) approach is to run

	gitk 1c89ac55017f982355c7761e1c912c88c941483d

then peer at the output, work out which real commits were in that
merge.

It looks like the merge ended with
b1b135c8d619cb2c7045d6ee4e48375882518bb5 and started with
40c42076ebd362dc69210cccea101ac80b6d4bd4, so perhaps you can do

	git bisect bad b1b135c8d619cb2c7045d6ee4e48375882518bb5
	git bisect good 40c42076ebd362dc69210cccea101ac80b6d4bd4

That has an off-by-one error, in that it assumes that
40c42076ebd362dc69210cccea101ac80b6d4bd4 is good, which we don't know. 
Perhaps one can pick the preceding commit in the `git log' output to
fix that.

Anyway, I've sent sufficient wrongness to the right list for us to work
out how to do this for real ;)
