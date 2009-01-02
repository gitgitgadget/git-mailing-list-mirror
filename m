From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3 v2] Implement the patience diff algorithm
Date: Fri, 2 Jan 2009 22:59:36 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901022221140.27818@racer>
References: <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp> <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp>
 <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain> <alpine.LFD.2.00.0901011151440.5086@localhost.localdomain> <alpine.DEB.1.00.0901022220380.27818@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>, davidel@xmailserver.org,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 02 23:00:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIs4U-00083y-46
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 23:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758808AbZABV7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 16:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758781AbZABV7M
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 16:59:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:60215 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758759AbZABV7K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 16:59:10 -0500
Received: (qmail invoked by alias); 02 Jan 2009 21:59:06 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp021) with SMTP; 02 Jan 2009 22:59:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/H9f4wkYPHYTWCANgDLMoUxBxV4dpQnB0ZJARQgp
	yjWlisx+PuU+yn
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901022220380.27818@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104426>

Hi,

The interdiff between v1 and v2 of PATCH 1/3.  As you can see, I also 
added a cleanup of an intermediate xdlenv.

Ciao,
Dscho

 xdiff/xpatience.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index 6687940..d01cbdd 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -309,6 +309,8 @@ static int fall_back_to_classic_diff(struct hashmap *map,
 	memcpy(map->env->xdf1.rchg + line1 - 1, env.xdf1.rchg, count1);
 	memcpy(map->env->xdf2.rchg + line2 - 1, env.xdf2.rchg, count2);
 
+	xdl_free_env(&env);
+
 	return 0;
 }
 
@@ -368,6 +370,15 @@ int xdl_do_patience_diff(mmfile_t *file1, mmfile_t *file2,
 	if (xdl_prepare_env(file1, file2, xpp, env) < 0)
 		return -1;
 
+	/*
+	 * It is a pity that xdl_cleanup_records() not only marks those
+	 * lines as changes that are only present in one file, but also
+	 * lines that have multiple matches and happen to be in a "run
+	 * of discardable lines" that patience diff happens to split
+	 * differently.
+	 */
+	memset(env->xdf1.rchg, 0, env->xdf1.nrec);
+	memset(env->xdf2.rchg, 0, env->xdf2.nrec);
 	/* environment is cleaned up in xdl_diff() */
 	return patience_diff(file1, file2, xpp, env,
 			1, env->xdf1.nrec, 1, env->xdf2.nrec);
-- 
1.6.1.rc3.224.g95ac9
