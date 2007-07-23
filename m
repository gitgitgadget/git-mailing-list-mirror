From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Teach revision machinery about --no-walk
Date: Tue, 24 Jul 2007 00:38:40 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707240011500.14781@racer.site>
References: <17929.37382.984339.742025@lisa.zopyra.com>
 <Pine.LNX.4.63.0703280056140.4045@wbgn013.biozentrum.uni-wuerzburg.de>
 <17929.44659.574482.637805@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 01:39:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID7Ud-0005Ms-PX
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 01:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758008AbXGWXjI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 19:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757958AbXGWXjH
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 19:39:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:37666 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751132AbXGWXjE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 19:39:04 -0400
Received: (qmail invoked by alias); 23 Jul 2007 23:39:02 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 24 Jul 2007 01:39:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+1yNY6bcu1SDDaNwk2JvcD+8IAj9WMM73wq0mTA2
	5TXlPj8F06+sbG
X-X-Sender: gene099@racer.site
In-Reply-To: <17929.44659.574482.637805@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53504>


The flag "no_walk" is present in struct rev_info since a long time, but
so far has been in use exclusively by "git show".

With this flag, you can see all your refs, ordered by date of the last
commit:

$ git log --abbrev-commit --pretty=oneline --decorate --all --no-walk

which is extremely helpful if you have to juggle with a lot topic
branches, and do not remember in which one you introduced that uber
debug option, or simply want to get an overview what is cooking.

(Note that the "git log" invocation above does not output the same as

 $ git show --abbrev-commit --pretty=oneline --decorate --all --quiet

 since "git show" keeps the alphabetic order that "--all" returns the
 refs in, even if the option "--date-order" was passed.)

For good measure, this also adds the "--do-walk" option which overrides 
"--no-walk".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Tue, 27 Mar 2007, Bill Lear wrote:

	> On Wednesday, March 28, 2007 at 01:03:57 (+0200) Johannes Schindelin writes:
	> >...
	> >	This is only lightly tested, and I will not have time to work any 
	> >	more on this. So, if this does not what you want, you will have to
	> >	fix it yourself.
	> 
	> Well, thank you kindly for your quick reply.  I will patch this in to my 
	> git source tree, test it out and see if I can fix anything that comes 
	> up.

	Actually, I tested this a lot in recent times, especially since I 
	started to use topic branches a lot more, to keep Junio happy.

	And then I had an idea: Much better to let "git log" do the work, 
	since it already sorts the commits it shows by date.  There is a 
	flag in the revision machinery, named "no_walk" which would tell 
	it to not traverse all ancestors.

	Since I can make this an alias, it does not matter very much that 
	the command line is so long.  However, since you can use different 
	pretty formats, this might be much more useful than the 
	--sort-by-date option for "git branch".

 Documentation/git-rev-list.txt |    9 +++++++++
 revision.c                     |    8 ++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 0430139..1c19781 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -37,6 +37,7 @@ SYNOPSIS
 	     [ \--merge ]
 	     [ \--reverse ]
 	     [ \--walk-reflogs ]
+	     [ \--no-walk ] [ \--do-walk ]
 	     <commit>... [ \-- <paths>... ]
 
 DESCRIPTION
@@ -398,6 +399,14 @@ These options are mostly targeted for packing of git repositories.
 	Only useful with '--objects'; print the object IDs that are not
 	in packs.
 
+--no-walk::
+
+	Only show the given revs, but do not traverse their ancestors.
+
+--do-walk::
+
+	Overrides a previous --no-walk.
+
 
 include::pretty-formats.txt[]
 
diff --git a/revision.c b/revision.c
index 00b75bc..16f35c7 100644
--- a/revision.c
+++ b/revision.c
@@ -1191,6 +1191,14 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				revs->reverse ^= 1;
 				continue;
 			}
+			if (!strcmp(arg, "--no-walk")) {
+				revs->no_walk = 1;
+				continue;
+			}
+			if (!strcmp(arg, "--do-walk")) {
+				revs->no_walk = 0;
+				continue;
+			}
 
 			opts = diff_opt_parse(&revs->diffopt, argv+i, argc-i);
 			if (opts > 0) {
-- 
1.5.3.rc2.31.gf7d7-dirty
