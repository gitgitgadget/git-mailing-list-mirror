From: John Keeping <john@keeping.me.uk>
Subject: Re: [BUG] rebase no longer omits local commits
Date: Thu, 3 Jul 2014 23:25:02 +0100
Message-ID: <20140703222501.GF13153@serenity.lan>
References: <53B57352.50202@tedfelix.com>
 <20140703190917.GE13153@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ted Felix <ted@tedfelix.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 00:25:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2pRL-0000Ab-D3
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jul 2014 00:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbaGCWZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2014 18:25:09 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:39412 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbaGCWZI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2014 18:25:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id A10D91FF72;
	Thu,  3 Jul 2014 23:25:07 +0100 (BST)
X-Quarantine-ID: <4ggtvTc-mJFl>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4ggtvTc-mJFl; Thu,  3 Jul 2014 23:25:07 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 2EDC91FEBD;
	Thu,  3 Jul 2014 23:25:03 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20140703190917.GE13153@serenity.lan>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252887>

On Thu, Jul 03, 2014 at 08:09:17PM +0100, John Keeping wrote:
> On Thu, Jul 03, 2014 at 11:14:26AM -0400, Ted Felix wrote:
> > Starting with git 1.9.0, rebase no longer omits local commits that 
> > appear in both the upstream and local branches.
> 
> It is the problem that bb3f458 fixes.  The change in behaviour is
> actually introduced by ad8261d (rebase: use reflog to find common base
> with upstream).
> 
> In your example, I think this is working as designed.  You can restore
> the previous behaviour either with `git rebase --no-fork-point` or with
> `git rebase @{u}`.
> 
> The change is designed to help users recover from an upstream rebase, as
> described in the "DISCUSSION ON FORK-POINT MODE" section of
> git-merge-base(1).

Having thought about this a bit more, I think the case you've identified
is an unexpected side effect of that commit.

Perhaps we shuld do something like this (which passes the test suite):

-- >8 --
diff --git a/git-rebase.sh b/git-rebase.sh
index 06c810b..0c6c5d3 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -544,7 +544,8 @@ if test "$fork_point" = t
 then
 	new_upstream=$(git merge-base --fork-point "$upstream_name" \
 			"${switch_to:-HEAD}")
-	if test -n "$new_upstream"
+	if test -n "$new_upstream" &&
+	   ! git merge-base --is-ancestor "$new_upstream" "$upstream_name"
 	then
 		upstream=$new_upstream
 	fi
-- 8< --

Since the intent of `--fork-point` is to find the best starting point
for the "$upstream...$orig_head" range, if the fork point is behind the
new location of the upstream then should we leave the upstream as it
was?

I haven't thought through this completely, but it seems like we should
be doing a check like the above, at least when we're in
"$fork_point=auto" mode.
