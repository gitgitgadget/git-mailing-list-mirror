From: Linus Torvalds <torvalds@osdl.org>
Subject: Optimize common case of git-rev-list (was Re: gitweb.cgi)
Date: Tue, 18 Oct 2005 17:53:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510181742070.3369@g5.osdl.org>
References: <43546492.3020401@zytor.com> <20051018110725.GB6929@vrfy.org>
 <43552FC2.3000000@zytor.com> <Pine.LNX.4.64.0510181645200.3369@g5.osdl.org>
 <43559399.2030903@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 02:54:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES2Co-0000U1-A8
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 02:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbVJSAxT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 20:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbVJSAxT
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 20:53:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48799 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932389AbVJSAxS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Oct 2005 20:53:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9J0rCFC020194
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 18 Oct 2005 17:53:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9J0rB1j008856;
	Tue, 18 Oct 2005 17:53:12 -0700
To: "H. Peter Anvin" <hpa@zytor.com>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <43559399.2030903@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10249>



On Tue, 18 Oct 2005, H. Peter Anvin wrote:
> 
> > Considering that apparently the load is enough that it takes 45 seconds to
> > generate (scary in itself), is should clearly be cached for more than one
> > minute. More like ten minutes or half an hour, especially since mirroring
> > any content changes takes longer than that anyway.
> 
> The latency for an I/O operation on the kernel.org servers is positively
> scary.

I took a look at webgit, and it looks like at least for the "projects" 
page, the most common operation ends up being basically

	git-rev-list --header --parents --max-count=1 HEAD

Now, the thing is, the way "git-rev-list" works, it always keeps on 
popping the parents and parsing them in order to build the list of 
parents, and it turns out that even though we just want a single commit, 
git-rev-list will invariably look up _three_ generations of commits.

It will parse:
 - the commit we want (it obviously needs this)
 - it's parent(s) as part of the "pop_most_recent_commit()" logic
 - it will then pop one of the parents before it notices that it doesn't 
   need any more
 - and as part of popping the parent, it will parse the grandparent (again 
   due to "pop_most_recent_commit()".

Now, I've strace'd it, and it really is pretty efficient on the whole, but 
if things aren't nicely cached, and with long-latency IO, doing those two 
extra objects (at a minimum - if the parent is a merge it will be more) is 
just wasted time, and potentially a lot of it.

So here's a quick special-case for the trivial case of "just one commit, 
and no date-limits or other special rules".

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

I've actually tried to test it (but hey, "exhaustive" is hard with all the 
different options), and I tried to be very careful to only do the 
special-case when really nothing can go wrong, and this all looks obvious.

But buyer beware.

Btw, doing an "strace" on git-rev-list shows that most of the system calls 
by far are the dynamic loader. Now, those accesses _should_ all be cached, 
so they should be fast and low-latency, but it's entirely possible that 
for a server configuration you might want to actually link things 
statically. Or not. Just a thought.

diff --git a/rev-list.c b/rev-list.c
index c60aa72..d4da1bd 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -624,6 +624,10 @@ int main(int argc, char **argv)
 
 	if (!merge_order) {		
 		sort_by_date(&list);
+		if (list && !limited && max_count == 1) {
+			show_commit(list->item);
+			return 0;
+		}
 	        if (limited)
 			list = limit_list(list);
 		if (topo_order)
