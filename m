From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git history order strange
Date: Sun, 9 Mar 2008 22:18:52 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803092208330.5896@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0803100306420.21961@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@computergmbh.de>
X-From: git-owner@vger.kernel.org Mon Mar 10 06:19:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYaQJ-0000bW-Ju
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 06:19:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbYCJFTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 01:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752057AbYCJFTD
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 01:19:03 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40179 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751782AbYCJFTB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2008 01:19:01 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2A5JUpE022926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 9 Mar 2008 22:19:31 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2A5Irs0001485;
	Sun, 9 Mar 2008 22:18:53 -0700
In-Reply-To: <Pine.LNX.4.64.0803100306420.21961@fbirervta.pbzchgretzou.qr>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.388 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76695>



On Mon, 10 Mar 2008, Jan Engelhardt wrote:
> 
> To be noted that it only happens with `git-rev-list`, but not with 
> `git-rev-list --date-order` or `git-rev-list --topo-order`.
> Is it a bug in git-rev-list w/o arguments, or do I have to expect
> commits in random reverse order?

They are not in "random" order, but if you have some use that requires 
strict topological order, then you do need --topo-order (or --date-order, 
which is just a specific case of --topo-order).

By "strict" topo order I mean that _all_ commits are properly sorted with 
_all_ children coming before their parents.

The regular "unordered" rev-list output does mean that at least _one_ 
child will have been printed out before its parent, but if a commit has 
multiple children, it's possible that it has been reached and printed 
through one of those children before all the other children have been 
parsed and output.

Put another way: say that the tree looks like

					HEAD
				      /
	--- f --- e --- c --- b --- a
	            \       /
	              - d -

where 'a' is the most recent head commit. In this case, git-rev-list with 
--topo-sort would guarantee that *both* 'c' and 'd' will be printed before 
'e', but without --topo-sort, it only guarantees that it will print _one_ 
way of reaching 'e', but not necessarily all ways.

IOW, you might see the sequence a, b, c, e, f, d (where 'd' is printed 
after not only its direct parent, but even after its grandparent), but if 
you gave 'a' as a starting point you would never see the sequence a, b, e, 
c, d, f (because there is no way to get to 'e' without going through 
either c or d).

Of course, if you give both 'a' and 'e' to git-rev-list as starting 
points, all bets are off (it doesn't have to go through 'c' or 'd' to get 
to 'e' in that case ;)

So there are _some_ ordering guarantees even without --topo-order or 
--date-order, but they are just much much weaker.

			Linus
