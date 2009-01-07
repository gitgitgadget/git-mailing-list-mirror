From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Wed, 7 Jan 2009 21:38:36 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901072121260.7496@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de>  <20081104152351.GA21842@artemis.corp>  <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de>  <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain>  <20081104004001.GB29458@artemis.corp>
  <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de>  <20081104083042.GB3788@artemis.corp>  <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de>  <20081104152351.GA21842@artemis.corp>  <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> 
 <20090106111712.GB30766@artemis.corp>  <alpine.DEB.1.00.0901062037250.30769@pacific.mpi-cbg.de> <1231359317.6011.12.camel@maia.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	davidel@xmailserver.org, Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Jan 07 21:40:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKfCA-00029K-GV
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 21:40:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661AbZAGUin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 15:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754541AbZAGUin
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 15:38:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:45165 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754530AbZAGUim (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 15:38:42 -0500
Received: (qmail invoked by alias); 07 Jan 2009 20:38:39 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp006) with SMTP; 07 Jan 2009 21:38:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19dfOJtOnhddDGu+Rc4zx0t8OZQDns+QSX9YjImSH
	btaI54y4Ntfwm5
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1231359317.6011.12.camel@maia.lan>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104830>

Hi,

On Thu, 8 Jan 2009, Sam Vilain wrote:

> On Tue, 2009-01-06 at 20:40 +0100, Johannes Schindelin wrote:
> > Although I would like to see it in once it is fleshed out -- even if it 
> > does not meet our usefulness standard -- because people said Git is 
> > inferior for not providing a patience diff.  If we have --patience, we can 
> > say "but we have it, it's just not useful, check for yourself".
> 
> Whatever happens, the current deterministic diff algorithm needs to stay
> for generating patch-id's... those really can't be allowed to change.

Oh, there is no discussion about replacing the diff algorithm we have 
right now.

Even if we never output patch-ids anywhere, so we always recalculate them, 
and therefore would be free to replace the diff algorithm with something 
else.

The thing why I do not want patience diff to replace the existing code 
is:

- patience diff is slower,
- patience diff is often not worth it (produces the same, maybe even 
  worse output), and
- patience diff needs the existing code as a fallback anyway.

Where it could possibly help to change existing behavior is with merging.

So maybe somebody has some time to play with, and can apply this patch:

-- snip --
diff --git a/ll-merge.c b/ll-merge.c
index fa2ca52..f731026 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -79,6 +79,8 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 	memset(&xpp, 0, sizeof(xpp));
 	if (git_xmerge_style >= 0)
 		style = git_xmerge_style;
+	if (getenv("GIT_PATIENCE_MERGE"))
+		xpp.flags |= XDF_PATIENCE_DIFF;
 	return xdl_merge(orig,
 			 src1, name1,
 			 src2, name2,
-- snap --

After compiling and installing, something like this should be fun to 
watch:

	$ git rev-list --all --parents | \
	  grep " .* " | \
	  while read commit parent1 parent2 otherparents
	  do
		test -z "$otherparents" || continue
		git checkout $parent1 &&
		git merge $parent2 &&
		git diff > without-patience.txt &&
		git reset --hard $parent1 &&
		GIT_PATIENCE_MERGE=1 git merge $parent2 &&
		git diff > with-patience.txt &&
		if ! cmp without-patience.txt with-patience.txt
		then
			echo '==============================='
			echo "differences found in merge $commit"
			echo "without patience: $(wc -l < without-patience.txt)"
			echo "with patience: $(wc -l < with-patience.txt)"
			echo '-------------------------------'
			echo 'without patience:'
			cat without-patience.txt
			echo '-------------------------------'
			echo 'with patience:'
			cat with-patience.txt
		fi ||
		exit
	  done | tee patience-merge.out

Ciao,
Dscho
