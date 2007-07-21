From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: gitk problems: can't unset "idinlist(...)"
Date: Fri, 20 Jul 2007 23:47:24 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707202335570.27249@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0707201554540.27249@woody.linux-foundation.org>
 <20070721050912.GB20622@coredump.intra.peff.net>
 <alpine.LFD.0.999.0707202226130.27249@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707202304350.27249@woody.linux-foundation.org>
 <20070721061857.GB29820@coredump.intra.peff.net>
 <20070721062448.GA8722@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <junkio@cox.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 21 08:47:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC8kn-0002L4-W8
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 08:47:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755690AbXGUGrg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 02:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753613AbXGUGrg
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 02:47:36 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34314 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753264AbXGUGrf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jul 2007 02:47:35 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6L6lUhb025699
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Jul 2007 23:47:31 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6L6lOWO004822;
	Fri, 20 Jul 2007 23:47:25 -0700
In-Reply-To: <20070721062448.GA8722@coredump.intra.peff.net>
X-Spam-Status: No, hits=-2.713 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53148>



On Sat, 21 Jul 2007, Jeff King wrote:
> 
> By which I mean you can keep the 'for' loop, since in either case we are
> always reading p->next (if we skip, then we set *pp to p->next anyway,
> and if we don't, then pp becomes a pointer to p->next).
> 
> So this is a more readable patch which I believe is equivalent.

Fair enough, that also works.

Anyway, just because this is actually something I've noticed a lot of 
people do wrong, I actually do tend to think that when you traverse a 
singly-linked list and remove entries, you should *never* traverse the 
list itself, you should only ever traverse the "pointer to the pointer".

So the difference between your version and mine is that the

	while ((p = *pp) != NULL)

model really only has one single "iterator variable": "pp". Which makes it 
a lot easier to think about and avoid problems.

In contrast, your for-loop actually keeps track of *two* independent 
variables, the "tail pointer of the list we're building up" (pp) and the 
"head pointer of the old list we're traversing" (p).

Does it work? Yes. But I tend to prefer the "there's a single list" model, 
where you just remove entries as you traverse it through a single indirect 
pointer.

They're certainly equivalent, but slightly different mindsets. I at least 
personally find the "single pointer" less likely to have problems, because 
you can never get out of sync (which was basically exactly the problem 
that Junio's code had), because there is nothing to get out of sync _with_ 
when you just have a single main iterator variable.

			Linus
