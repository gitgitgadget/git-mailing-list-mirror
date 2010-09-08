From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: git log for a merged branch
Date: Thu, 9 Sep 2010 01:17:05 +0200
Message-ID: <201009090117.06555.barra_cuda@katamail.com>
References: <14267801.230161.1283954674012.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Thu Sep 09 01:27:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtU2j-0006uk-HY
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 01:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756677Ab0IHX07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 19:26:59 -0400
Received: from smtp225-pc.aruba.it ([62.149.157.225]:39917 "HELO
	smtp2-pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1756679Ab0IHX06 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 19:26:58 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Sep 2010 19:26:57 EDT
Received: (qmail 30652 invoked by uid 89); 8 Sep 2010 23:20:08 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on smtp2-pc.ad.aruba.it
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=6.0 tests=BAYES_50,RDNS_NONE
	autolearn=no version=3.2.5
Received: from unknown (HELO darkstar.localnet) (barra?cuda@katamail.com@78.134.95.128)
  by smtp2-pc.ad.aruba.it with SMTP; 8 Sep 2010 23:20:06 -0000
User-Agent: KMail/1.13.5 (Linux/2.6.35.4-mike-1mike; KDE/4.4.5; i686; ; )
In-Reply-To: <14267801.230161.1283954674012.JavaMail.root@mail.hq.genarts.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155823>

On Wednesday 08 September 2010, Stephen Bash wrote:
> Assume I have a release branch with bug fixes that is tagged at the end of
> the release cycle (let's call the tag tagFoo).  The release branch then
> gets merged back into mainline development (call the branch mainline), and
> the release branch is deleted.  If I want to see the commits (bug fixes)
> performed on the release branch, how do I do it?
> 
> I don't think
>    git log mainline..tagFoo
> works because all the commits of tagFoo are now reachable by mainline
> thanks to the merge.  Is there a simple way to express this concept?
> 
> Obviously in a pinch a simple
>    git log tagFoo
> will give you everything back to the beginning of time, but I think that's
> suboptimal...

Let's call the merge commit "mergecmt". The commit where the "release" branch
branched off is

	git merge-base mergecmt^1 mergecmt^2

... where mergecmt^1 is the first parent of the merge (usually on the
"mainline" branch) and mergecmt^2 is the second parent, which usually(*)
refers to the "release" branch (in this case, tagFoo).

So

	git log $(git merge-base mergecmt^1 mergecmt^2)..mergecmt^2

is what you want.

> To complicate things a bit more, in the real world there may be multiple
> merges from the release branch to mainline during the life of the release
> branch, so any solution that also deals with that would be outstanding
> (probably at the cost of additional complexity?)

Maybe something like:

	for i in $(git rev-list --merges last_interesting_tag..mainline)
	do
		git log $(git merge-base $i^1 $i^2)..$i^2
	done

... or maybe using GIT_PAGER='':

	for i in $(git rev-list --merges last_interesting_tag..mainline)
	do
		GIT_PAGER='' git log $(git merge-base $i^1 $i^2)..$i^2
	done

(*) I don't remember the details, but if you do the standard "git pull"
or "git merge" and don't use the plumbing commands in a weird way to badly
reimplement "merge" or "pull", you should be safe. Others may want to
comment on this, though.
