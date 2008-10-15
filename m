From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: [PATCH 1/3] Prepare for non-interactive merge-preserving rebase
Date: Wed, 15 Oct 2008 03:07:06 -0500
Organization: Exigence
Message-ID: <20081015030706.f876bfff.stephen@exigencecorp.com>
References: <48D95836.6040200@op5.se>
	<20080923162211.d4b15373.stephen@exigencecorp.com>
	<48D95FE1.30200@op5.se>
	<20080924001027.GA19264@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder@fzi.de>
X-From: git-owner@vger.kernel.org Wed Oct 15 10:08:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq1Qd-0007YO-7h
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 10:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbYJOIHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 04:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbYJOIHL
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 04:07:11 -0400
Received: from smtp132.sat.emailsrvr.com ([66.216.121.132]:39268 "EHLO
	smtp132.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbYJOIHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 04:07:09 -0400
Received: from relay3.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay3.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 30D9925A956;
	Wed, 15 Oct 2008 04:07:09 -0400 (EDT)
Received: by relay3.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id DC85125A799;
	Wed, 15 Oct 2008 04:07:08 -0400 (EDT)
In-Reply-To: <20080924001027.GA19264@neumann>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98257>


> The following DAG is created by the commands below:
> 
>   -A---B      master
>     \
>      C---M    topic
>       \ /
>        D
> 
>   git init
>   echo 1 >foo
>   git add foo
>   git commit -m 'first on master'       # A
>   echo 2 >>foo
>   git commit -m 'second on master' foo  # B
>   git checkout -b topic HEAD^
>   echo 1 >bar
>   git add bar
>   git commit -m 'first on topic'        # C
>   git checkout -b subtopic
>   echo 1 >baz
>   git add baz
>   git commit -m 'first on subtopic'     # D
>   git checkout topic
>   git merge --no-ff subtopic            # M
> 
> If I now execute 'git rebase -p master topic', I get the following:
> 
>   -A---B            master
>     \   \
>      \   C'---M'    topic
>       \      /
>        C----D

Following up on this old thread, I can't get M' to have the old parent
D. I always see D change to D' and then topic is fast fowarded to D'
instead of an M' showing up. (I've tried 1.6.0.2, my rebase-i-p changes,
and sp/maint.)

> But I would rather like to have the following:
> 
>   -A---B            master
>         \
>          C'---M'    topic
>           \  /
>            D'
> 
> Would such a behaviour possible at all?

Yes, I think it just takes the following patch:

--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -251,7 +251,7 @@ pick_one_preserving_merges () {
                                GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
                                GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
                                output git merge $STRATEGY -m "$msg" \
-                                       $new_parents
+                                       --no-ff $new_parents

Applying this to either sp/maint or my rebase-i-p changes gets your
desired output.

With the only caveat being that the subtopic branch stays pointing at
the old D--since you are rebasing topic, it does not change where
subtopic points when rewriting D -> D'.

Musing, I could see moving subtopic being possible, definitely with git
sequencer, but also with a --other-branches-follow-rewrites flag of some
sort that, after rewriting hash1->hash2, just finds any local branches
pointing at hash1 and updates their refs to be hash2. Not that I'm
really suggesting it, but I don't think it would be that hard.

Anyway, subtopic still pointing at D aside, I think your desired output
makes sense, given you've explicitly told rebase to preserve merges. If
you wanted a non-ff M in the first place, I think passing along a
--no-ff to keep M' around is reasonable. And would otherwise be harmless.

I can write a test/patch for this unless you beat me to it or other
think it is unreasonable.

- Stephen
