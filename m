From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel.org and GIT tree rebuilding
Date: Fri, 24 Jun 2005 23:16:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506242257450.11175@ppc970.osdl.org>
References: <20050624.212009.92584730.davem@davemloft.net> <42BCE026.8050405@pobox.com>
 <Pine.LNX.4.58.0506242208210.11175@ppc970.osdl.org> <42BCF02B.5090706@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "David S. Miller" <davem@davemloft.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 25 08:12:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dm3tU-0001H8-BC
	for gcvg-git@gmane.org; Sat, 25 Jun 2005 08:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263354AbVFYGSI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Jun 2005 02:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263349AbVFYGO3
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jun 2005 02:14:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8890 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263345AbVFYGOP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Jun 2005 02:14:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5P6E8jA004422
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 24 Jun 2005 23:14:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5P6E7j7003064;
	Fri, 24 Jun 2005 23:14:07 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42BCF02B.5090706@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 25 Jun 2005, Jeff Garzik wrote:
> 
> The problem is kernel.org mirroring, not individual pushes and pulls, 
> really.
> 
> Would git-pack be the best solution for mirroring a bunch of git trees?

No guarantees, but here's a rough plan:

 - I just committed a fairly trivial change to add a "--objects" flag to 
   git-rev-list, which allows you to basically say "I want to see the 
   difference not just in commit ID's, but also trees and blobs"

   What does that mean? It means that in a mirroring schenario, you can, 
   for each git tree, do:

	(a) On the slave:
		cat .git/refs/*/* | sort | uniq > slave-ref-list

	(b) On the master:
		cat .git/refs/*/* | sort | uniq > master-ref-list

	(c) On the master:

		cmp $master-ref-list $slave-ref-list && exit 1
		list=$(cat master-ref-list)
		for i in $(cat slave-ref-list)
		do
			list=$list ^$i
		done
		git-rev-list --objects $list

   and now that "git-rev-list" will list every object that needs to be 
   copied from the master to the slave. No need to read huge directories 
   etc, you get the list computed for you.

yeah, it clearly needs some refining to be useful, but I think you can
kind of see how it would work.

Now, the secondary advantage of this is that once you don't use rsync as
the mirroring method, you can now change the filesystem object database
layout. In particular, the packing thing that Chris Mason was working on
at some point suddenly becomes a lot more viable.

(In fact, more than that. You can make a single packed blob for all
"historical" objects, and that also gives you an efficient archive format
- if you're not required to have the full filesystem layout, you could
have a much more efficient packing that you basically do once a week or
something, so that you only keep the last week in the regular "one file
per object" format).

		Linus
