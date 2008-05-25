From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: rev-list --parents --full-history + path: something's fishy
Date: Sun, 25 May 2008 14:23:48 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805251359290.3081@woody.linux-foundation.org>
References: <e1dab3980805230808s59798351r9ed702c7d0dedd2a@mail.gmail.com> <1211660214.483877b69a107@webmail.nextra.at> <alpine.LFD.1.10.0805241817500.3081@woody.linux-foundation.org> <200805251426.54755.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, David Tweed <david.tweed@gmail.com>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun May 25 23:25:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0Nig-0001aQ-7N
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 23:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbYEYVY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2008 17:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbYEYVY2
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 17:24:28 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54555 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751036AbYEYVY1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 May 2008 17:24:27 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4PLNnwI016182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 25 May 2008 14:23:50 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4PLNm0W009110;
	Sun, 25 May 2008 14:23:48 -0700
In-Reply-To: <200805251426.54755.johannes.sixt@telecom.at>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.408 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82879>



On Sun, 25 May 2008, Johannes Sixt wrote:
> 
> The history was this:
> 
>    C--M
>   /  /
>  A--B
> 
> Now assume that both B and C change a, but so that it is identical in both B 
> and C. I thought that --full-history makes a difference *only* for this case, 
> because without --full-history the revision walk would choose either B or C 
> (not quite at random, but in an unspecified manner), but not both; but 
> with --full-history the revision walk would go both paths.

You mis-understood what --full history does.

It literally just means "walk all paths". The fact that *also* means that 
it often cannot simplify away merges at all is unfortunate, but there you 
have it.

In other words, it will now leave the merge alone, even if it can see that 
everything we care about (file 'a') came from just one side.

> This makes a difference in git-filter-branch --subdirectory-filter: We do want 
> to simplify history to those commits that touch a path, but we don't want to 
> simplify away the case outlined in the previous paragraph.

If so, you need to expand on the history simplification a *lot*. 

It currently does two things:

 - simplify away merges when it can see that one parent is identical in 
   content to the end result - it then removes the merge entirely, and 
   replaces it with the identical parent.

   This is the thing that would normally take the merge 'M', and just 
   replace it with 'B', because it sees that the contents all come from B. 
   But if 'C' _also_ changed the file, and 'M' was actually a data merge, 
   then it will be left alone (because the merge 'M' really is meaningful 
   as far as the data is concerned)

   This is what "--full-history" disables.

   So when you say "--full-history", all merges are left alone.

 - The *other* simplification is the non-merge case, where it simplifies 
   away commits that don't change the files. This is the one that then 
   removes 'C' in your original example.

   You can disable this simplification with "--sparse". Not that anybody 
   ever wants to.

What you seem to want in a *third* level of simplification, which is to 
remove merges that turn out to be pointless, because all parents end up 
being directly related. We don't do that simplification, and we never 
have.

I'd love to do it, but it's somewhat costly and very much more complicated 
than the simplifications we do do.

> What shall we do in git-filter-branch --subdirectory-filter?

See above. I can tell you _where_ you'd need to add the logic. See the 
file revision.c: remove_duplicate_parents(). You'd could "just" extend 
that to remove not just 100% duplicates, but also remove parents that are 
direct ancestors of each other. I say "just" in quotes, because that's not 
trivial to do efficiently.

But it gets worse. If that removal of parents then turns the commit into a 
regular one, *and* it didn't actually change the files you are interested 
in, you'd need to remove it entirely, which in turn means that you'd also 
need to rewrite the parent information of the children. Which means that 
simplify_commit() is actually too late, because that one happens when you 
print things out, and the children have already been returned (with what 
now is stale parenthood!).

So the _obvious_ place to do that simplification is actually too late. 

But doing it earlier is also hard, because that "simplify_commit()" is 
what removes the trivial linear ones.

So you'd actually need to add a whole new phase that removes the trivial 
linear cases *before* we are in the whole get_revision() phase, and then 
does the commit simplification. It's nasty and quite complicated. Which is 
why we don't do it.

The "revision.c" commit history simplification is already arguably some of 
the most complicated and subtle code in all of git. The code needs to be 
able to handle the "normal" case (which is to stream the commits without 
pre-computing the whole DAG) efficiently, but then there are those 
complicated cases that need the whole DAG. And they have to live 
side-by-side.

			Linus
