From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: "git reflog expire --all" very slow
Date: Mon, 30 Mar 2009 18:43:59 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0903301803190.4093@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 31 03:48:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoT5L-0003D5-6G
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 03:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511AbZCaBqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 21:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754089AbZCaBqm
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 21:46:42 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35311 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753923AbZCaBqm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 21:46:42 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2V1i0C0024265
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 30 Mar 2009 18:44:36 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2V1hxWs025660;
	Mon, 30 Mar 2009 18:43:59 -0700
X-X-Sender: torvalds@localhost.localdomain
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.441 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115205>


I haven't checked in detail what is up, but I just did a "git gc --prune", 
and it was quiet for about half a minute before anything seemed to happen.

Very irritating, as normally the expensive stuff at least gives you some 
kind of indication of what it's doing.

It turns out that it's the reflog expiration. On my crazy beefy 
Nehalem machine:

	[torvalds@nehalem linux]$ time git reflog expire --all

	real	0m37.596s
	user	0m37.554s
	sys	0m0.040s

and that really isn't good. 37 cpu-seconds on this machine is like half a 
decade on some laptops I could name.

The flat pgprof for this thing (user-land oprofile isn't doing Nehalem 
yet) looks like this:

      %   cumulative   self              self     total           
     time   seconds   seconds    calls   s/call   s/call  name    
     60.94     30.24    30.24 301120211     0.00     0.00  interesting
     12.37     36.38     6.14 301338513     0.00     0.00  insert_by_date
     11.35     42.01     5.63     8776     0.00     0.00  clear_commit_marks
      9.96     46.95     4.94     4388     0.00     0.01  merge_bases_many
      2.16     48.02     1.07 301486366     0.00     0.00  commit_list_insert
      1.21     48.62     0.60 301329737     0.00     0.00  parse_commit
      0.87     49.05     0.43 301637945     0.00     0.00  xmalloc
      0.34     49.22     0.17       24     0.01     0.01  xstrdup
      ...

Ok, so my reflog on this thing has 1583 entries on HEAD (yes, in the last 
90 days, the problem is _not_ that I have a long reflog and am pruning it, 
it _is_ already pruned). Add to that the reflogs for the branches (mainly 
master: 1294), and you end up with apparently a nice total of 4388 reflog 
entries.

And then it looks like for _each_ reflog entry we have:

  expire_reflog_ent()
    in_merge_bases()

which then calls 

  get_merge_bases()
    get_merge_bases_many()
      ..

each of which probably often traverses an appreciable part of the kernel 
tree, since my reflog entries are often merges, and the merge bases need 
easily thousands of commits to look up.

Which explains how you end up with 301 _million_ commits inserted into the 
lists and checked if they are interesting. Since the whole kernel tree has 
only something like 140k commits, and my revlog doesn't even go back more 
than three months, I guess that means that we'll be traversing the same 
commits tens of thousands of times each.

Even on this machine, that whole cluster-f*ck takes a little while. Oops.

I have not checked if there is anything really obvious going on that could 
change that whole logic that causes us to do merge-bases into something 
saner, since the reflog code is not a part of git I'm familiar with. 

Instead, I'm just sending this to Junio, Brandon, and Dscho, who are 
getting the main blame for 'builtin-reflog.c'. Although I'm pretty sure 
this is all Junio, but just in case..

			Linus
