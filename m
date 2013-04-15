From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] bisect: Store first bad commit as comment in log file
Date: Mon, 15 Apr 2013 06:38:09 +0200 (CEST)
Message-ID: <20130415.063809.1055555229072260139.chriscool@tuxfamily.org>
References: <20130413152257.GB16040@pvv.ntnu.no>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: hegge@resisty.net
X-From: git-owner@vger.kernel.org Mon Apr 15 07:05:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URbbz-0004Ri-JX
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 07:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601Ab3DOFFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 01:05:47 -0400
Received: from delay-2d.bbox.fr ([194.158.122.62]:34470 "EHLO delay-2d.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932513Ab3DOFFq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 01:05:46 -0400
X-Greylist: delayed 1653 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Apr 2013 01:05:46 EDT
Received: from mail-4d.bbox.fr (bt8ssscb.cs.dolmen.bouyguestelecom.fr [10.119.71.135])
	by delay-2d.bbox.fr (Postfix) with ESMTP id 7A03823323E
	for <git@vger.kernel.org>; Mon, 15 Apr 2013 06:41:13 +0200 (CEST)
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-4d.bbox.fr (Postfix) with ESMTP id F0A6246;
	Mon, 15 Apr 2013 06:38:09 +0200 (CEST)
In-Reply-To: <20130413152257.GB16040@pvv.ntnu.no>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221191>

From: Torstein Hegge <hegge@resisty.net>
Subject: [PATCH] bisect: Store first bad commit as comment in log file
Date: Sat, 13 Apr 2013 17:22:57 +0200

> When bisect successfully finds a single revision, the first bad commit
> should be shown to human readers of 'git bisect log'.
> 
> This resolves the apparent disconnect between the bisection result and
> the log when a bug reporter says "I know that the first bad commit is
> $rev, as you can see from $(git bisect log)".

I agree that it's a good idea to do that.

I wonder if we should also write something into the bisect log if for
example the bisection stopped because there are only 'skip'ped commits
left to test. But maybe this could go into another patch after this
one.
 
> Signed-off-by: Torstein Hegge <hegge@resisty.net>
> ---
> I don't know how useful the added test is, I didn't find any existing
> tests that looks at the comment parts of bisect log.

Thanks for adding a test. It's always appreciated.

>  git-bisect.sh               |    8 +++++++-
>  t/t6030-bisect-porcelain.sh |   18 ++++++++++++++++++
>  2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 99efbe8..c58eea7 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -311,7 +311,13 @@ bisect_next() {
>  	res=$?
>  
>  	# Check if we should exit because bisection is finished
> -	test $res -eq 10 && exit 0
> +	if test $res -eq 10
> +	then
> +		bad_rev=$(git show-ref --hash --verify refs/bisect/bad)

I had a look to make sure that refs/bisect/bad always refered to the
first bad commit at this point, and it is true indeed.

Maybe you could have used "git rev-parse --verify" instead of "git
show-ref --hash --verify". It looks simpler to me.

And maybe, just in case, you could have added: || die "$(gettext "Bad rev: refs/bisect/bad")"

Otherwise this patch looks good to me.

> +		bad_commit=$(git show-branch $bad_rev)
> +		echo "# first bad commit: $bad_commit" >>"$GIT_DIR/BISECT_LOG"
> +		exit 0
> +	fi

Thanks,
Christian.
