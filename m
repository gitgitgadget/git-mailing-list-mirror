From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Add a 'source' decorator for commits
Date: Tue, 28 Oct 2008 10:21:39 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0810281016150.3386@nehalem.linux-foundation.org>
References: <alpine.LFD.2.00.0810271256470.3386@nehalem.linux-foundation.org> <alpine.LFD.2.00.0810271305500.3386@nehalem.linux-foundation.org> <alpine.LFD.2.00.0810271306230.3386@nehalem.linux-foundation.org> <20081028054539.GA23195@sigill.intra.peff.net>
 <alpine.LFD.2.00.0810280755570.3386@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 28 18:24:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KusIt-0001AU-7e
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 18:24:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424AbYJ1RXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 13:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752307AbYJ1RXN
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 13:23:13 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36398 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751092AbYJ1RXM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Oct 2008 13:23:12 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9SHLeG3025391
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 28 Oct 2008 10:21:41 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9SHLdE6018354;
	Tue, 28 Oct 2008 10:21:39 -0700
In-Reply-To: <alpine.LFD.2.00.0810280755570.3386@nehalem.linux-foundation.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.941 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99306>



On Tue, 28 Oct 2008, Linus Torvalds wrote:
> 
> I could imagine doing it as not a single string: you could make it be a 
> pointer to a list of (alphabetically sorted) strings, and then you don't 
> have to make an allocation for each commit, you'd only need to do 
> something like
> 
> 	void add_source(struct commit *commit, struct strin_list *list)

Actually, no. That would be wrong.

Why? Becuase we might be printing out the commit before we see it for the 
second time, so if we were to print out anything but the "first reached 
data", we'd now have really nasty _unreliable_ data that would actually 
change depending on whether we also do things like --topo-sort and/or do 
commit limiting.

So suddenly --source would have to do the full tree just to make sure that 
it's reliably giving the same information, and that makes it much less 
useful.

In contrast, the thing I sent out is not only really simple and has 
basically zero peformance impact, but it's actually "more reliable" in 
that what it gives you is meaningful and clear. It might pick one 
particular name over another in random ways that depend on internal 
choices and the exact order that you gave your arguments in, but it 
doesn't even _try_ to claim anything else.

The source "name" is unambiguous only if there is a single source, and it 
doesn't really even try to claim anything else - for other cases, it will 
give answers that "make sense" but they won't necessarily be the _whole_ 
truth. But it won't ever be really misleading either, and it will never 
cause any slowdowns.

		Linus
