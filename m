From: Michal Vitecek <fuf@mageo.cz>
Subject: Re: [RFH] git cherry-pick takes forever
Date: Thu, 11 Sep 2008 09:56:16 +0200
Message-ID: <20080911075616.GB3144@mageo.cz>
References: <20080910082610.GA3144@mageo.cz> <7vk5dkxqvf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 11 09:58:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdh3O-00035V-KQ
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 09:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbYIKH4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 03:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751943AbYIKH4T
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 03:56:19 -0400
Received: from interactive-1.com ([193.85.232.82]:47811 "EHLO
	interactive-1.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720AbYIKH4T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 03:56:19 -0400
Received: from interactive-1.com (localhost.localdomain [127.0.0.1])
	by interactive-1.com (Postfix) with ESMTP id 5F98B2D3C21;
	Thu, 11 Sep 2008 09:56:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vk5dkxqvf.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95590>

 Hello,

Junio C Hamano wrote:
>Michal Vitecek <fuf@mageo.cz> writes:
>>  I have two git repositories: one is the origin of the other. However no
>>  merging is being done as the projects in the repositories quite differ
>>  but still use the same core. So to propagate changes I cherry-pick
>>  those which are useful from one repository to another.
>>
>>  however 'git cherry-pick' has lately started to last almost forever:
>
>Can you define "lately"?  Is it a function of your git version, or is it a
>function of the age of your repositories?

 It's a function a cherry-picking some commits - afterwards
 cherry-picking crawls. One of the commits removes a number of files
 (614) and also renames some (303).

>>  $ time git cherry-pick b42b77e66a83f1298d9900a9bb1078b9b42e8618
>>  Finished one cherry-pick.
>>  Created commit 7caef83: - removed some superfluous newlines
>>  2 files changed, 0 insertions(+), 2 deletions(-)
>>  git cherry-pick b42b77e66a83f1298d9900a9bb1078b9b42e8618  282.97s user 34.69s system 100% cpu 5:17.63 total
>>
>>  Both repositories have approximately 16k commits and their forking
>>  point (merge base) is 250 to 490 commits far away.
>
>When talking about cherry-pick, the size of the history (unless the
>repository has too many objects and badly packed) does not matter; the
>operation is purely about your current state, the cherry-picked commit
>itself, and the parent commit of the cherry-picked one.

 I too thought so but after cherry-picking starting taking so long I
 began to doubt my thoughts :)

>Taking 5 minutes to cherry-pick a change to only two paths, one line
>deletion each, is plain ridiculous, but if the tree state of cherry-picked
>commit and the tree state of the target is vastly different (e.g. almost
>no common pathnames), the behaviour is certainly understandable.  Ancient
>git used straight three-way merge for cherry-pick, but recent ones use
>more expensive "recursive-merge", which tries to detect renames.  If the
>states of trees are very dissimilar, you can end up wasting a lot of time.
>
>    $ H=$(git rev-parse 7caef83^) ;# the commit before cherry-pick
>    $ C=b42b77e6 ;# the cherry-picked one
>
>cherry-pick operation roughly runs these two diffs:
>
>    $ time git diff --shortstat -M $H $C

 $ time git diff --shortstat -M $H $C
 2 files changed, 0 insertions(+), 2 deletions(-)
 git diff --shortstat -M $H $C  0.00s user 0.00s system 72% cpu 0.006 total

>    $ time git diff --shortstat -M $H $C^1

 $ time git diff --shortstat -M $H $C\^1
 git diff --shortstat -M $H $C\^1  0.00s user 0.00s system 0% cpu 0.003 total

>and uses the result to perform its work.  Can you clock these?
>
>If you rarely have renames, it may be much more efficient to run "git
>format-patch -1 --stdout $C | git am -3" instead of cherry-pick.

 Turning off renames detection in diff (via 'git config --add diff.renames
 false') helped and 'git cherry-pick' is instant now.

 Maybe my repositories are "strange" in some way. I would be more than
 happy to provide more information if needed.

        Thank you,
-- 
		Michal Vitecek		(fuf@mageo.cz)
