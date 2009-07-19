From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH 1/3] push: add --current
Date: Mon, 20 Jul 2009 06:32:44 +0900
Message-ID: <20090720063244.6117@nanako3.lavabit.com>
References: <1247526462-17584-1-git-send-email-bonzini@gnu.org>
	<1247526462-17584-2-git-send-email-bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Sun Jul 19 23:34:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSe1E-0004Lu-Pi
	for gcvg-git-2@gmane.org; Sun, 19 Jul 2009 23:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbZGSVd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2009 17:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbZGSVd5
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jul 2009 17:33:57 -0400
Received: from karen.lavabit.com ([72.249.41.33]:59522 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751419AbZGSVd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2009 17:33:56 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 68C6A11B8B0;
	Sun, 19 Jul 2009 16:33:56 -0500 (CDT)
Received: from 7477.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id BN60IGYZUH39; Sun, 19 Jul 2009 16:33:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=tpeCpMMIZDxk7jX3UnQO4ArPTfHcUyHOyTvL53i66y6ciZm/OndXqBGa77ykbByxG3uadtEyMhe2NkAaolfdr88DZqJHj3NWdHpZHNm6qhnAmYYu80Y7XFe9Jti8RQ4Tij8gm+t6BAansyPL0iSzUKSfDtm60vesCuwhGMVuZRs=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <1247526462-17584-2-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123560>

Quoting Paolo Bonzini <bonzini@gnu.org>:

> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 2653388..0d6fcaa 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -9,7 +9,7 @@ git-push - Update remote refs along with associated objects
>  SYNOPSIS
>  --------
>  [verse]
> -'git push' [--all | --mirror | --tags] [--dry-run] [--receive-pack=<git-receive-pack>]
> +'git push' [--all | --mirror | --tags] [--current] [--dry-run] [--receive-pack=<git-receive-pack>]

Shouldn't this be "[--all | --mirror | --tags | --current]" instead? In other words, does it make sense to say "git push --all --current"?

> @@ -71,6 +71,15 @@ nor in any Push line of the corresponding remotes file---see below).
>  	Instead of naming each ref to push, specifies that all
>  	refs under `$GIT_DIR/refs/heads/` be pushed.
>  
> +--current::
> +	Independent of the other options, restrict pushing to the current
> +	HEAD.
> +
> +	Refspecs given in the configuration is still used to find the
> +	destination name of the current branch.  However, this option
> +	cannot be specified if an explicit refspec is given on the
> +	command line, because it would be useless and possibly confusing.
> +

The second and subsequent paragraphs must be dedented, and the blank line between paragraphs should be replaced by a single line with '+' on it. You can find examples in the same file (e.g. description of <refspec>).

Instead of correcting a grammatical error you made here in patch 1/3 with a later patch 2/3, please fix it here.

> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 2d2633f..3333ce9 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -586,4 +586,56 @@ test_expect_success 'push with branches containing #' '
>  	git checkout master
>  '
>  
> +test_expect_success 'push --current fails on empty repository' '
> +	git init &&
> +	mkdir b.git &&
> +	(cd b.git && git init --bare) &&
> +	echo a > b &&
> +	git add b &&
> +	git commit -m a &&
> +	git checkout -b branch &&
> +	echo bb > b &&
> +	git add b &&
> +	git commit -m branch &&
> +	git checkout master &&
> +	! git push --current b.git
> +'

If your final belief (which I happen to agree) is that

% git push --current
% git push --current origin
% git push --current over.there.example.com:project.git

should work as expected (that is, they should push the current branch to the same name) from a repository without any special configuration, don't say "push --current fails" on the title as if you think it is the right thing to do.

Instead, mark clearly that the code after this patch is still broken, like this:

	test_expect_failure 'push --current into an empty repository' '
		...
                git push --current b.git
	'

and change expect_failure to expect_success in the later patch that fixes the breakage.

> +test_expect_success 'push --current succeeds when push is configured' '
> +	git config remote.bremote.url b.git &&
> +	git config remote.bremote.push refs/heads/master:refs/heads/master &&
> +	git push --current bremote &&
> +	test `git rev-parse master` = `cd b.git && git rev-parse master`
> +'

The style of the existing tests in the script isn't

	test `git rev-parse master` = `cd b.git && git rev-parse master`

but is

	test "$(git rev-parse master)" = "$(cd b.git && git rev-parse master)"

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
