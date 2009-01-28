From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Heads up: rebase -i -p will be made sane again
Date: Wed, 28 Jan 2009 02:53:55 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901280225240.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901271012550.14855@racer> <20090127085418.e113ad5a.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1756046810-1233107636=:3586"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 02:55:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRzdu-0007T1-TY
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 02:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbZA1Bxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 20:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbZA1Bxi
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 20:53:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:48165 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751190AbZA1Bxh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 20:53:37 -0500
Received: (qmail invoked by alias); 28 Jan 2009 01:53:35 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp015) with SMTP; 28 Jan 2009 02:53:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Ch5hDSt4CC/tqagqOv4ZbIQMjGvVOIvany+sN9r
	MdaT/8P7e3Ccur
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090127085418.e113ad5a.stephen@exigencecorp.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107449>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1756046810-1233107636=:3586
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 27 Jan 2009, Stephen Haberman wrote:
> 
> Dscho wroteÖ
> 
> > As for the design bug I want to fix: imagine this history:
> > 
> >   ------A
> >  /     /
> > /     /
> > ---- B
> > \     \
> >  \     \
> >   C-----D-----E = HEAD
> > 
> > A, C and D touch the same file, and A and D agree on the contents.
> > 
> > Now, rebase -p A does the following at the moment:
> > 
> >   ------A-----E' = HEAD
> >  /     /
> > /     /
> > ---- B
> > 
> > In other words, C is truly forgotten, and it is pretended that D never 
> > happened, either.  That is exactly what test case 2 in t3410 tests for 
> > [*1*].
> > 
> > This is insane.
> 
> Agreed.

Actually, I misread t3410 a great deal.  The situation is as follows:

    ... UPSTREAM
           \
... A - B - C -D

A is a patch the upstream does not have, B is a patch UPSTREAM has,
and "git diff C^!" (i.e. the diff of C to its first parent) is _also_ 
identical to a diff of a merge that is in UPSTREAM.

Basically, t3410 tests that after "git rebase -i -p UPSTREAM" and leaving 
the rebase script as-is, essentially, A and D are cherry-picked on top of 
UPSTREAM.

> Does this mean you're just getting rid of the code that calls "rev list 
> --cherry-pick"?

Only now do I understand.

I misread the code for --cherry-pick.  For merges, it adds the diff to the 
first parent!

I do not know if it really is desirable to have --cherry-pick handle 
merges at all; I tend to think it is not.

Unfortunately, a short blame session just points to 9c6efa36 done by a 
sloppy programmer: yours truly.

So I adapted my code to find the "dropped" merges in 
git-rebase--interactive, too, for now, but I guess the proper fix is 
something like this:

-- snipsnap --
[PATCH] --cherry-pick: do not skip merges, ever

Currently, --cherry-pick has no problem getting a patch id for merge 
commits: it calculated as the patch id of the patch between the first 
parent and the merge commit.

Of course, this is bogus, as it completely misses the fact that the
merge commit has other parents, too, and therefore a single patch id
would be wrong.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 patch-ids.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/patch-ids.c b/patch-ids.c
index 3be5d31..808a7f0 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -6,9 +6,12 @@
 static int commit_patch_id(struct commit *commit, struct diff_options *options,
 		    unsigned char *sha1)
 {
-	if (commit->parents)
+	if (commit->parents) {
+		if (commit->parents->next)
+			return 0; /* merges do not have a patch id */
 		diff_tree_sha1(commit->parents->item->object.sha1,
 		               commit->object.sha1, "", options);
+	}
 	else
 		diff_root_tree_sha1(commit->object.sha1, "", options);
 	diffcore_std(options);
--8323328-1756046810-1233107636=:3586--
