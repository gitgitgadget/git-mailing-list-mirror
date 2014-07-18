From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v1] rebase --root: sentinel commit cloaks empty commits
Date: Fri, 18 Jul 2014 14:10:43 +0200
Message-ID: <871tti50l8.fsf@thomasrast.ch>
References: <53A18198.7070301@gmail.com>
	<8d5cf2e1ff45e2e60072bf6c6e05371e4b265709.1405539123.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, Chris Webb <chris@arachsys.com>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 14:19:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X878D-0002xk-Me
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 14:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761546AbaGRMTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 08:19:15 -0400
Received: from ip1.thgersdorf.net ([148.251.9.194]:44547 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756922AbaGRMTO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 08:19:14 -0400
X-Greylist: delayed 496 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Jul 2014 08:19:14 EDT
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 07AAE4D667A;
	Fri, 18 Jul 2014 14:10:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id b0JyhGHd5yQx; Fri, 18 Jul 2014 14:10:44 +0200 (CEST)
Received: from hexa.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 07DB24D6572;
	Fri, 18 Jul 2014 14:10:43 +0200 (CEST)
In-Reply-To: <8d5cf2e1ff45e2e60072bf6c6e05371e4b265709.1405539123.git.bafain@gmail.com>
	(Fabian Ruch's message of "Wed, 16 Jul 2014 21:32:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253815>

Hi Fabian

Impressive analysis!

> Concerning the bugfix: Obviously, the patch misuses the `squash_onto`
> flag because it assumes that the new base is empty except for the
> sentinel commit. The variable name does not imply anything close to
> that. An additional flag to disable the use of the git-rev-list
> option `--cherry-pick` would work and make sense again (for instance,
> `keep_redundant`).

Seeing as there are only two existing uses of the variable, you could
also rename it to make it more obvious what is going on.  I think either
way is fine.

[...]
> Please take a closer look at the last two test cases that specify the
> expected behaviour of rebasing a branch that tracks the empty tree.
> At this point they expect the "Nothing to do" error (aborts with
> untouched history). This is consistent with rebasing only empty
> commits without `--root`, which also doesn't just delete them from
> the history. Furthermore, I think the two alternatives adding a note
> that all commits in the range were empty, and removing the empty
> commits (thus making the branch empty) are better discussed in a
> separate bug report.

Makes sense to me, though I have never thought much about rebasing empty
commits.  Maybe Chris has a more informed opinion?

>  is_empty_commit() {
> -	tree=$(git rev-parse -q --verify "$1"^{tree} 2>/dev/null ||
> -		die "$1: not a commit that can be picked")
> -	ptree=$(git rev-parse -q --verify "$1"^^{tree} 2>/dev/null ||
> -		ptree=4b825dc642cb6eb9a060e54bf8d69288fbee4904)
> +	tree=$(git rev-parse -q --verify "$1"^{tree} 2>/dev/null) ||
> +		die "$1: not a commit that can be picked"
> +	ptree=$(git rev-parse -q --verify "$1"^^{tree} 2>/dev/null) ||
> +		ptree=4b825dc642cb6eb9a060e54bf8d69288fbee4904
>  	test "$tree" = "$ptree"
>  }

Nice catch!

> @@ -958,7 +958,17 @@ then
>  	revisions=$upstream...$orig_head
>  	shortrevisions=$shortupstream..$shorthead
>  else
> -	revisions=$onto...$orig_head
> +	if test -n "$squash_onto"
> +	then
> +		# $onto points to an empty commit (the sentinel
> +		# commit) which was not created by the user.
> +		# Exclude it from the rev list to avoid skipping
> +		# empty user commits prematurely, i. e. before
> +		# --keep-empty can take effect.
> +		revisions=$orig_head
> +	else
> +		revisions=$onto...$orig_head
> +	fi
>  	shortrevisions=$shorthead

Nit: I think this would be clearer if you phrased it using an 'elif',
instead of nesting (but keep the comment!).

-- 
Thomas Rast
tr@thomasrast.ch
