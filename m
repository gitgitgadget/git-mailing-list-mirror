From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: visualizing Git's Git repo
Date: Tue, 27 May 2008 20:15:13 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805271957430.2958@woody.linux-foundation.org>
References: <CA563F5A-5E12-42F7-BDFD-04FE3A882028@reverberate.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Joshua Haberman <joshua@reverberate.org>
X-From: git-owner@vger.kernel.org Wed May 28 05:17:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1CA0-0001Rd-7m
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 05:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbYE1DPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 23:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752959AbYE1DPS
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 23:15:18 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45929 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752093AbYE1DPR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 May 2008 23:15:17 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4S3FDcY021447
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 27 May 2008 20:15:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4S3FD8L026462;
	Tue, 27 May 2008 20:15:13 -0700
In-Reply-To: <CA563F5A-5E12-42F7-BDFD-04FE3A882028@reverberate.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.398 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83068>



On Mon, 26 May 2008, Joshua Haberman wrote:
>
> I'm a casual Git user.  One thing that's been troubling me about Git is that
> when I look at Git's own Git repository, the revision history is not at all
> easy to understand.  I like to view my own Git repositories with:
> 
> $ gitk --all --date-order

I would seriously suggest avoiding "--date-order" unless you have some 
deep reason to see how the commits on different development paths relate 
to each other date-wise - something you should normally not have.

The thing is, --date-order strings out and mixes up the commits on the 
same development chain, and by doing so it makes the different chains of 
development much harder to see. It also ends up showing the development in 
a more "parallel" way, which in turn makes the view even harder to read.

So I would suggest not using --date-order by default. It doesn't add 
anything to any normal flow, and it makes the big picture harder to see.

The only time you really want --date-order (or "-d", which is shorthand 
for it for just gitk) is really

 - when the big picture is really really simple, and you actually want to 
   see more detail because the big picture is too trivial to even be 
   interesting otherwise.

   (In other words: --date-order is fine for really simple development 
   where there is only ever just a couple of branches or where you have 
   pruned away so much of the history that the remaining part is simple)

 - when you want to debug "git rev-list" behaviour itself, since the date 
   order actually matters for how git traverses the commit chains.

The second case is something that I suspect nobody but me and a few other 
people have ever done. I found it very useful together with --show-all 
when I was debugging the revision walker (see commits

	3131b713013f06285cad3ffdcc61f417ac4ba158
	7d004199d134c9d465e013064f72dbc04507f6c0

where the first implements --show-all, and the second one is the end 
result of my debugging).

In other words: never start out with "-d" or "--date-order" by default. 
Only if you have some reason to then think that the view is too simple or 
you need to drill down into the commit relationships should you use it.

> 1. what do you all do to get a high-level view of what's going on with Git
> development?  do you use gitk?  if so, what options?

I use "gitk" almost every time when I pull from anybody in the kernel. I 
tend to do it with git itself, when I update from Junio. The most common 
arguments I use is

	gitk ORIG_HEAD..

or

	gitk @{12.hours.ago}..

where the latter in particular is very nice to see an overview of "ok, 
what did I pull today".

And I basically *never* use --date-order, nor do I often look at more than 
one single branch.

The one special case is when merging, and there are conflicts. In that 
case, I often look at two branches, and I often do

	gitk MERGE_HEAD... <filenames>

to see the symmetric difference (actually, I usually just do "gitk 
--merge" which is just shorthand for the above). And in that case, I do 
occasionally add a "-d", because that shows what the relative timing were 
for the commits, which is sometimes interesting information (ie if there 
are clashes, which commit is the more recently committed one can actually 
be somewhat relevant - although it's rare).

So in that case I look at two branches (the one I'm on, and the one I'm 
merging), and the "..." format means that I ignore everything that is 
common to them.

> 2. as a project, why don't you rebase when merging long-running branches into
> master?

For the kernel, there's been a lot of discussion about why I prefer people 
to rebase vs merge (or often - *avoiding* merges entirely), see the kernel 
mailing list, and search for merging. There was a thread (subject: 
"[alsa-devel] HG -> GIT migration") about a week ago where I tried to 
explain my opinions about about some of this.

		Linus
