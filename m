From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Can I have this, pretty please?
Date: Sun, 12 Aug 2007 11:48:57 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708121140190.30176@woody.linux-foundation.org>
References: <85ir7kq42k.fsf@lola.goethe.zz>
 <alpine.LFD.0.999.0708121135050.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 12 20:49:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKIUz-00023H-5K
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 20:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933673AbXHLStJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 14:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933482AbXHLStI
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 14:49:08 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:60953 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932753AbXHLStH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2007 14:49:07 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7CIn3W1003243
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 12 Aug 2007 11:49:04 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7CImvZV017054;
	Sun, 12 Aug 2007 11:48:57 -0700
In-Reply-To: <alpine.LFD.0.999.0708121135050.30176@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.744 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.24__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55700>



On Sun, 12 Aug 2007, Linus Torvalds wrote:
> 
> A newsreader is mis-designed for all the same reasons SVN is misdesigned: 
> it sees the messages (commits) as a _tree_.

Side note: the lack of this bug is what makes showing large histories 
graphically be expensive in the first place. 

In fact, in git, merges are "first-class" entities, and forking is 
something you have to infer from the history (by finding two commits with 
the same parent), and that's why calculating the graph is actually pretty 
expensive: when you do so, you have to keep all the commit relationships 
in memory, and you basically have to sort it topologically.

So even if you don't want to show the graph itself (and just add 
references to allow the user to walk to parents/children manually), you'd 
still have to calculate - and keep track of - the commit relationships. 
And I suspect that's what makes gitk and other visualizers take time.

I think one solution is to limit the size fo the visualization by date or 
number, ie if you want to see history, it's often useful to do things like

	gitk --since=10.weeks.ago

to see just the "recent" commits. That very fundamentally makes the 
problem much cheaper, because you simply have to generate the graph for a 
much smaller set of commits.

I used to think that we should just default to some reasonable value, but 
then we optimized the hell out of git-rev-list and Paul fixed a number of 
scalability issues in gitk too, so it kind of fell by the wayside because 
it wasn't as important any more. But if you have a huge project with lots 
of history, the right answer may well be to make gitk *default* to using 
something like "show only the last year unless some revision limiting has 
been done explicitly".

IOW, showing the whole history for a big project is simply pretty 
expensive. If you have a hundred thousand commits, just keeping track of 
the tree structure *is* going to take megabytes and megabytes of data. 
Limiting the size of the problem is usually a really good solution, 
especially since most people tend to care about what happened in the last 
few days, not what happened five months ago.

			Linus
