X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Thu, 26 Oct 2006 08:05:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org>
References: <45357CC3.4040507@utoronto.ca> <20061021130111.GL75501@over-yonder.net>
 <453F2FF8.2080903@op5.se> <200610251146.06116.jnareb@gmail.com>
 <a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>
 <87slhcz8zh.wl%cworth@cworth.org> <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>
 <7vu01ro20b.fsf@assigned-by-dhcp.cox.net> <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>
 <20061026101038.GA13310@coredump.intra.peff.net> <877iyne4dm.fsf@alplog.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 26 Oct 2006 15:07:01 +0000 (UTC)
Cc: Jeff King <peff@peff.net>, James Henstridge <james@jamesh.id.au>,
	Junio C Hamano <junkio@cox.net>,
	bazaar-ng@lists.canonical.com,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	Carl Worth <cworth@cworth.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <877iyne4dm.fsf@alplog.fr>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30223>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd6oZ-0001ji-RD for gcvg-git@gmane.org; Thu, 26 Oct
 2006 17:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423549AbWJZPGg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 11:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752152AbWJZPGg
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 11:06:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57833 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1752143AbWJZPGf (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 11:06:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9QF5fPo024361
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 26
 Oct 2006 08:05:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9QF5aoC017773; Thu, 26 Oct
 2006 08:05:40 -0700
To: Vincent Ladeuil <v.ladeuil@alplog.fr>
Sender: git-owner@vger.kernel.org



On Thu, 26 Oct 2006, Vincent Ladeuil wrote:
> 
> Ok, so git make a distinction between the commit (code created by
> someone) and the tree (code only).
> 
> Commits are defined by their parents.

Commits are defined by a _combination_ of:
 - the tree they commit (which is recursive, so the commit name indirectly 
   includes information EVERY SINGLE BIT in the whole tree, in every 
   single file)
 - the parent(s) if any (which is also recursive, so the commit name 
   indirectly includes information about EVERY SINGLE BIT in not just the 
   current tree, but every tree in the history, and every commit that is 
   reachable from it)
 - the author, committer, and dates of each (and committer is actually 
   very often different from author)
 - the actual commit message

So a commit really names - uniquely and authoratively - not just the 
commit itself, but everything ever associated with it.

> Trees are defined by their content only ?

Where "contents" does include names and permissions/types (eg execute bit 
and symlink etc).

> If that's the case, how do you proceed ? 

If you compare the commit name, and they are equal, you automatically know
 - the trees are 100% identical
 - the histories are 100% identical

If you only care about the actual tree, you compare the tree name for 
equality, ie you can do

	git-rev-parse commit1^{tree} commit2^{tree}

and compare the two: if and only if they are equal are the actual contents 
100% equal.

> Calculate a sha1 representing the content (or the content of the
> diff from parent) of all the files and dirs in the tree ?  Or
> from the sha1s of the files and dirs themselves recursively based
> on sha1s of the files and dirs they contain ?

The latter. 

> I ask because the later seems to provide some nice effects
> similar to what makes BDD
> (http://en.wikipedia.org/wiki/Binary_decision_diagram) so
> efficient: you can compare graphs of any complexity or size in
> O(1) by just comparing their signatures.

This is exactly what git does. You can compare entire trees (and 
subdirectories are just other trees) by just comparing 20 bytes of 
information.

How do you think we can do a diff between two arbitrary kernel revisions 
so fast? Why do you think we can afford to do a 

	git log drivers/usb include/linux/usb*

that literally picks out the history (by comparing state) for every commit 
in the tree?

I can do the above log-generation in less than ten _seconds_ for the last 
year and a half of the kernel. That's 20k+ lines of logs of commits that 
only touch those files and directories. And I _need_ it to be fast, 
because that's literally one of the most common operations I do.

And the reason it's fast is that we can compare 20,000 files (names, 
contents, permissions) by just comparing a _single_ 20-byte SHA1.

In git, revision names (and _everything_ has a revision name: commits, 
trees, blobs, tags) really have meaning. They're not just random noise.

