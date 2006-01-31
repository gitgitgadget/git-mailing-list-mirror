From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Bottlenecks in git merge
Date: Tue, 31 Jan 2006 15:45:27 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601311533040.7301@g5.osdl.org>
References: <20060131213314.GA32131@ebar091.ebar.dtu.dk>
 <7vk6cgq9ny.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Eriksen <s022018@student.dtu.dk>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 01 00:45:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F45Bq-0000ll-K9
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 00:45:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWAaXpg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 18:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbWAaXpg
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 18:45:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13247 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750841AbWAaXpf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 18:45:35 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0VNjSDZ014656
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 31 Jan 2006 15:45:29 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0VNjRwZ007302;
	Tue, 31 Jan 2006 15:45:28 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6cgq9ny.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15366>



On Tue, 31 Jan 2006, Junio C Hamano wrote:
> 
> I am actually surprised that recursive is not much slower than
> resolve.  I expected to see bigger difference for a merge like
> this.

Well, if most of the cost is just the trivial single-file merges and the 
fact that we have to update a ton of files from an old version (and it 
probably is), the difference between the trivial and the recursive merge 
is not going to be huge.

> With an up-to-date index that has small changes from v2.6.12,
> merging these two revisions using read-tree -m to do the trivial
> merge (the part that comes before recursive/resolve) leaves
> about 850 files to be resolved in the working tree.  For these
> files, you need to do an equivalent of merge-one-file to merge
> the differences (in this particular case, most of them are
> "removed in one but unchanged in the other" kind).  In addition,
> you have to checkout the result of the merge, which means you
> need to update at least 10,723 files.

It would be interesting to see how big the "resolve 850 files" part is vs 
the "check out 10k+ files" is.

In particular, if the "resolve 850 files" is a noticeable portion of it, 
then the right thing to do may be to just re-write git-merge-one-file.sh 
in C. Right now, almost _all_ of the expense of that thing is just the 
shell interpreter startup. The actual actions it does are usually fairly 
cheap.

(yes, a real three-way merge is more expensive, but I suspect that even 
that isn't much more expensive than starting up an invocation of "bash". 
The other actions that merge-one-file does are _really_ trivial).

In fact, we could hardcode the "git-merge-one-file" behaviour inside 
"git-merge-index". 

Now, that won't help "recursive" (which doesn't use git-merge-one-file at 
all, and does it all by hand), but it would be an interesting test to 
make, becuase if it makes the simpler "-s resolve" merge even faster, then 
we know that this is likely a large portion of the time.

Then, somebody would have to consider what to do about 
git-merge-recursive. For example, if the _common_ case is "modified in 
both, but differently", and they merge cleanly, maybe the recursive merge 
could handle those separately and fast with a special "git-merge-one-file" 
invocation (just to cut down the number of files that it needs to think 
more about).

		Linus
