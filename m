From: Stephen Bash <bash@genarts.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Tue, 19 Oct 2010 09:33:16 -0400 (EDT)
Message-ID: <6831849.526935.1287495195964.JavaMail.root@mail.hq.genarts.com>
References: <20101019064210.GA14309@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 15:33:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8CJq-0008Eb-Qu
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 15:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758657Ab0JSNdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 09:33:24 -0400
Received: from hq.genarts.com ([173.9.65.1]:17995 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758542Ab0JSNdX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 09:33:23 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 875CE1E26351;
	Tue, 19 Oct 2010 09:33:22 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jnaOk1V8vuOa; Tue, 19 Oct 2010 09:33:16 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 1760E1E2635D;
	Tue, 19 Oct 2010 09:33:16 -0400 (EDT)
In-Reply-To: <20101019064210.GA14309@kytes>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159326>

----- Original Message -----
> From: "Ramkumar Ramachandra" <artagnon@gmail.com>
> To: "Stephen Bash" <bash@genarts.com>
> Sent: Tuesday, October 19, 2010 2:42:15 AM
> Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial git-svn fetch)
> 
> Stephen Bash writes:
> > I'm going to collapse all these comments because I think we're
> > coming at this from different angles. I agree, discovering the
> > copies in git is "easy" (albeit an n^2 operation), and git will
> > correctly identify file content. But when I was asked to preserve
> > the SVN history, I decided to extract a DAG from SVN and migrate
> > that DAG to Git. Thus the history itself is preserved (sans
> > merges), not just the contents of the files. This is the purpose of
> > buildSVNTree. I can elaborate further if requested.
> 
> Yep, they're certainly two different ways to approach the problem: I'd
> be interested in investigating why it will produce different
> results. Since we both agree that it's easier (and faster) to do it in
> Git-land, I'm looking into the the areas where it falls short.

Ack!  I left my example at home this morning... I'll explain it here, but perhaps I can actually send out a test script tonight or tomorrow (if there's need).  The basic premise is git's copy detection finds files with the same content, not necessarily the source of an SVN copy.

It's also possible you can do this in svn-fe or in fast-import -- there may be more information there.  I was looking strictly pre-svn-fe or post-fast-import...

Here's how I created a discrepancy between SVN and Git:
  1) Create a new svn repo
  2) Create the standard layout (trunk, branches, tags)
  3) Create multiple files on the trunk
  4) Create a branch (svn cp trunk branches/branchName)
  5) Edit a file on the branch (leave some of the others alone)
  6) (optional) edit a file on the trunk
  7) Merge the branch back to the trunk
  8) Create a tag from the trunk (svn cp trunk tags/tagName)
  9) git fast-import the repo

Now "svn log -v svn://svnrepo/tags/tagName" will show something like
  A /tags/tagName (from /trunk:rev)
OTOH "git log --name-status --find-copies-harder" will show something like
  C100 /tags/tagName/foo (from /trunk/foo)
  C100 /tags/tagName/bar (from /branches/branchName/bar)
  C100 /tags/tagName/baz (from /trunk/baz)
assuming bar is the file edited on the branch and then merged back to the trunk (this is all from memory, so please forgive me if the output isn't quite right).  I think from Git's point-of-view, this copy information is correct, but it doesn't describe SVN's history -- and I'm not entirely sure how a Git-only solution could identify precisely what's going on there... (hopefully I'm just being naive)

> > I found a 'db-svn-filter-root' branch, but it was not entirely
> > obvious to me what code I should be looking at...
> 
> Um, there's just one commit that deviates from the branch it's based
> on (but you don't know that, and I should have been clearer): look at
> contrib/svn-fe/svn-filter-root.py
> 
> It's just a minimalistic mapper, but it's fast and done nicely. You
> can use ideas from it when you're building yours.

Okay, David pointed me to that earlier, but I haven't dug into it yet.  I'll take a look.

> > I'm glad it's stimulating conversation. I'm beginning to wonder if
> > there might be competing design goals for one-way vs. two-way
> > compatibility... Performance is one place where opinions probably
> > greatly differ (I didn't mind taking an extra 30 minutes to mirror
> > my SVN repo because it probably saved more than that in
> > communication overhead later in the process, but that mirror
> > operation is very taxing on your timeline); my exhaustive search of
> > all SVN copies is another (I wanted to be *extremely* certain I knew
> > about all the misplaced branches/tags, but it's inefficient for a
> > casual developer who just wants to interact with an SVN server).
> > It's all just food for thought, and I'm happy to carry on the
> > conversation from my different point-of-view :)
> 
> Ok, I still don't get this part- why mirror at all? Can't all the
> information be mined out of the in-memory tree that svn-fe builds
> while parsing the dumpfile? From the SVN-side, all that's required is
> a streaming dumpfile like the one that `svnrdump dump` produces.

Oh, from that point of view the svn mirror is a bystander.  I was developing these tools at the same time as svnrdump (or at least prior to a stable version of svnrdump).  So when I found that running "svnadmin dump | svn-fe | git fast-import" on the server was taxing the system, I decided it was better to create a dump file, copy it to my local machine, and run svn-fe and fast-import locally.  Once I had the dump file, the local mirror sped up the SVN::Ra calls in buildSVNTree, and made any "did that really happen in svn?!" questions a little easier to answer.

Thanks,
Stephen
