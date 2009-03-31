From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/2] speed up reflog unreachability pruning
Date: Tue, 31 Mar 2009 10:03:43 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0903310958000.4093@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 31 19:09:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LohQT-0002NB-4D
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 19:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756476AbZCaRF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 13:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753818AbZCaRF1
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 13:05:27 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55245 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753124AbZCaRF0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 13:05:26 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2VH3hn2015676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 31 Mar 2009 10:04:16 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2VH3h2x002390;
	Tue, 31 Mar 2009 10:03:43 -0700
X-X-Sender: torvalds@localhost.localdomain
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.94 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115286>


Ok, this is a two-patch series that first tries to clean things up a bit, 
and then applies Junio's approach to speed up the reachability test.

The reason I did it this way is that I think we can improve on the 
reachability logic a bit more, but in order to do that I refuse to work 
with the crazy duplicated complex logic inside 'expire_reflog_ent()', and 
I wanted to abstract it out.

Then, the first cut at speedup is just Junio's approach. Which is fairly 
hacky, but works.

I'd _like_ to do more of a "dynamically do 'mark_reachable()' only when 
necessary" thing, but that's a separate cleanup thing.

As is, this improves the reflog expire quite enormously for me:

 - before:

	[torvalds@nehalem linux]$ time git reflog expire --all
	real	0m37.193s
	user	0m37.174s
	sys	0m0.020s

 - after:

	[torvalds@nehalem linux]$ time ~/git/git reflog expire --all
	real	0m1.693s
	user	0m1.672s
	sys	0m0.020s

although I do suspect that the 'mark_reachable()' could slow things down 
in some less extreme cases. But probably never by a huge amount.

Total diffstat:

 builtin-reflog.c |   75 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 69 insertions(+), 6 deletions(-)

with the two individual patches coming up next.

			Linus
