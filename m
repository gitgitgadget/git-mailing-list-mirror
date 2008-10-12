From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fetch: refuse to fetch into the current branch in a
	non-bare repository
Date: Sun, 12 Oct 2008 11:47:27 -0700
Message-ID: <20081012184727.GE4856@spearce.org>
References: <alpine.DEB.1.00.0810111336350.22125@pacific.mpi-cbg.de.mpi-cbg.de> <7vprm6iz6z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 12 20:48:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp5zj-0004gK-6s
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 20:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755479AbYJLSra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 14:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755410AbYJLSr3
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 14:47:29 -0400
Received: from george.spearce.org ([209.20.77.23]:35393 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755270AbYJLSr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 14:47:28 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A5F023835F; Sun, 12 Oct 2008 18:47:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vprm6iz6z.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98047>

Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Some confusing tutorials suggest that it would be a good idea to call
> > something like this:
> >
> > 	git pull origin master:master
> >
> > While it might make sense to store what you want to merge, it typically
> > is plain wrong.
> 
> I am somewhat confused.

The description is confusing, yes.  It should be about git fetch,
not git pull.
 
> This "confusion" has been there for very long time and (at least the
> scripted version of) git-pull/git-fetch pair has supported a workaround in
> the form of --update-head-ok option.

I think "git fetch url side:master" when master is the current branch
and we have omitted --update-head-ok is broken.  Specifically Dscho's
last hunk which adds this test.  The test fails on current master.

Looking at the code in builtin-fetch.c, the only usage of
update_head_ok is for output about the current branch.  I think
it should have been used in at least one other spot, to decide if
the RHS of a refspec is valid for storage.  Dscho's patch tries to
address that.

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 9aae496..cd8b550 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -323,4 +323,10 @@ test_expect_success 'auto tag following fetches minimum' '
        )
 '

+test_expect_success 'refuse to fetch into the current branch' '
+
+	test_must_fail git fetch . side:master
+
+'
+
 test_done


-- 
Shawn.
