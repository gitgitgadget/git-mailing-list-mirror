From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] git-split: Split the history of a git repository by
 subdirectories and ranges
Date: Mon, 23 Oct 2006 14:19:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610231411200.3962@g5.osdl.org>
References: <451A30E4.50801@freedesktop.org> <7vlko5d3bx.fsf@assigned-by-dhcp.cox.net>
 <453C96C9.4010005@freedesktop.org> <Pine.LNX.4.64.0610230846420.3962@g5.osdl.org>
 <453D17B5.6070203@freedesktop.org> <Pine.LNX.4.64.0610231237080.3962@g5.osdl.org>
 <453D2B98.8010903@freedesktop.org> <Pine.LNX.4.64.0610231402560.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 23:20:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc7DL-0002hz-Ia
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 23:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbWJWVT5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 17:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbWJWVT5
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 17:19:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21470 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752008AbWJWVTz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 17:19:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9NLJkaX007816
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 Oct 2006 14:19:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9NLJjjs006752;
	Mon, 23 Oct 2006 14:19:45 -0700
To: Josh Triplett <josh@freedesktop.org>
In-Reply-To: <Pine.LNX.4.64.0610231402560.3962@g5.osdl.org>
X-Spam-Status: No, hits=-0.98 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29886>



On Mon, 23 Oct 2006, Linus Torvalds wrote:
> 
> Try it. The default "extreme" simplification is a _hell_ of a lot faster 
> than doing the full history.
[ timings removed ]

Btw, the reason it is so much faster is that it can be done early, and 
allows us to prune out parts of the history that we don't care about.

For example, when we hit a merge, and the result of that merge is 
identical to one of the parents (in the set of filenames that we are 
interested in), we can simply choose to totally ignore the other parent, 
and we don't need to traverse that history at _all_. Because clearly, all 
the actual _data_ came from just the other one.

So the "extreme" simplification is way way faster, because in the presense 
of a lot of merges, it can select to go down just one of the paths, and 
totally ignore the other ones. In practice, for a fairly "bushy" history 
tree like the kernel, that can cut down the number of commits you need to 
compare by a factor of two or more.

In many ways, it is also actually a _better_ result, in that it's a 
"closer to minimal" way of reaching a particular state. So if you're just 
interested in how something came to be, and want to just cut through the 
crap, the result extreme simplification really _is_ better.

So the branches that were dismissed really _aren't_ important - they might 
contain real work, but from the point of the end result, that real work 
might as well not have happened, since the simpler history we chose _also_ 
explain the end result sufficiently.

So I think the default simplification is really a good default: not only 
because it's fundamentally cheaper, but because it is actually more likely 
to be distill what you actually care about if you wonder what happened to 
a file or a set of files.

But if you care about all the "side efforts" that didn't actually matter 
for the end result too, then you'd want the more expensive, and more 
complete graph. But it _will_ be a lot more expensive to compute.

		Linus
