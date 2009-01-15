From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] checkout: implement "-" shortcut name for last
 branch
Date: Thu, 15 Jan 2009 15:09:32 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901151508540.3586@pacific.mpi-cbg.de>
References: <1231977976-8739-1-git-send-email-trast@student.ethz.ch> <496EE559.3060901@viscovery.net> <alpine.DEB.1.00.0901151413250.3586@pacific.mpi-cbg.de> <200901151500.01876.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <junio@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jan 15 15:10:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNSv9-0005xI-MM
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 15:10:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756695AbZAOOIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 09:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758661AbZAOOIl
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 09:08:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:48801 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754186AbZAOOIj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 09:08:39 -0500
Received: (qmail invoked by alias); 15 Jan 2009 14:08:38 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp040) with SMTP; 15 Jan 2009 15:08:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/7WM4c/bb7MGBJZ16UR0kR32SQTosLOMQ6LB/G1w
	FZHCpVujz7okg3
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200901151500.01876.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105815>

Hi,

On Thu, 15 Jan 2009, Thomas Rast wrote:

> Johannes Schindelin wrote:
> > On Thu, 15 Jan 2009, Johannes Sixt wrote:
> > > You must make sure that commits referenced by LAST_HEAD are not
> > > garbage-collected. (I don't know if this happens anyway for symrefs in .git.)
> > 
> > Note: if you used reflogs for that feature, the garbage collection could 
> > not have killed the commit.  However, it is quite possible that the 
> > branch was deleted.
> 
> Suddenly I'm not so sure about either behaviour any more.
> 
> Consider:
> 
>   $ git commit -m initial
>   [master (root-commit)]: created 812c476: "initial"
>    1 files changed, 1 insertions(+), 0 deletions(-)
>    create mode 100644 foo
>   $ git checkout $(git rev-parse HEAD)
>   Note: moving to "812c476ca23e25efa7e4d7081153ba657a127d95" which isn't a local branch
>   If you want to create a new branch from this checkout, you may do so
>   (now or later) by using -b with the checkout command again. Example:
>     git checkout -b <new_branch_name>
>   HEAD is now at 812c476... initial
>   $ git branch -D master
>   Deleted branch master (812c476).
>   $ git for-each-ref
>   $ git reflog expire --expire=now --all
>   $ git prune --expire now
>   $ git show
>   fatal: bad object HEAD
>   $ git show 812c476
>   fatal: ambiguous argument '812c476': unknown revision or path not in the working tree.
>   Use '--' to separate paths from revisions
> 
> Oops.
> 
> Some quick RTFS shows that it indeed "only" cares about refs and
> reflogs.

Maybe something like this would help (completely untested, though the 
idea should be clear)?

-- snipsnap --
[PATCH] pack-objects --all: include HEAD, which could be detached

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 builtin-pack-objects.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index cb51916..da55671 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -2219,6 +2219,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 						 rp_ac_alloc * sizeof(*rp_av));
 			}
 			rp_av[rp_ac++] = arg;
+			if (!strcmp("--all", arg)) {
+				ALLOC_GROW(rp_av, rp_ac + 1, rp_ac_alloc);
+				rp_av[rp_ac++] = "HEAD";
+			}
 			continue;
 		}
 		if (!strcmp("--thin", arg)) {
