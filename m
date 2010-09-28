From: Zbyszek Szmek <zbyszek@in.waw.pl>
Subject: Re: [PATCH] builtin/revert.c: don't dereference a NULL pointer
Date: Tue, 28 Sep 2010 12:03:40 +0200
Message-ID: <20100928100340.GC6756@in.waw.pl>
References: <E2A2pg3JJJ3HO95lSjieK3cGmuaKW6JyYGAV6A_XDmFJCJGyAYa00A@cipher.nrlssc.navy.mil> <op5xt5mU5aQhqmO9a_49Hhsxhtg2iW_beFHkzibXMWI534-yRKsOVCvL_25O3xS3R6hTEbD06Kc@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Sep 28 12:03:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0X2R-0007uf-DM
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 12:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758515Ab0I1KDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 06:03:50 -0400
Received: from cwm83.internetdsl.tpnet.pl ([83.19.120.83]:3827 "EHLO
	cwm83.internetdsl.tpnet.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754059Ab0I1KDt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 06:03:49 -0400
Received: from zbyszek by cwm83.internetdsl.tpnet.pl with local (Exim 4.69)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1P0X2C-0005uA-6u; Tue, 28 Sep 2010 12:03:40 +0200
Content-Disposition: inline
In-Reply-To: <op5xt5mU5aQhqmO9a_49Hhsxhtg2iW_beFHkzibXMWI534-yRKsOVCvL_25O3xS3R6hTEbD06Kc@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157402>

Works as advertised. Tests also pass.

Thanks,
Zbyszek

On Mon, Sep 27, 2010 at 12:29:45PM -0500, Brandon Casey wrote:
> From: Brandon Casey <drafnel@gmail.com>
> 
> cherry-pick will segfault when transplanting a root commit if the --ff
> option is used.  This happens because the "parent" pointer is set to NULL
> when the commit being cherry-picked has no parents.  Later, when "parent"
> is dereferenced, the cherry-pick segfaults.
> 
> Fix this by checking whether "parent" is NULL before dereferencing it and
> add a test for this case of cherry-picking a root commit with --ff.
> 
> Reported-by: Zbyszek Szmek <zbyszek@in.waw.pl>
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
>  builtin/revert.c          |    2 +-
>  t/t3506-cherry-pick-ff.sh |   10 ++++++++++
>  2 files changed, 11 insertions(+), 1 deletions(-)
> 
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 4b47ace..57b51e4 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -442,7 +442,7 @@ static int do_pick_commit(void)
>  	else
>  		parent = commit->parents->item;
>  
> -	if (allow_ff && !hashcmp(parent->object.sha1, head))
> +	if (allow_ff && parent && !hashcmp(parent->object.sha1, head))
>  		return fast_forward_to(commit->object.sha1, head);
>  
>  	if (parent && parse_commit(parent) < 0)
> diff --git a/t/t3506-cherry-pick-ff.sh b/t/t3506-cherry-pick-ff.sh
> index e17ae71..51ca391 100755
> --- a/t/t3506-cherry-pick-ff.sh
> +++ b/t/t3506-cherry-pick-ff.sh
> @@ -95,4 +95,14 @@ test_expect_success 'cherry pick a merge relative to nonexistent parent with --f
>  	test_must_fail git cherry-pick --ff -m 3 C
>  '
>  
> +test_expect_success 'cherry pick a root commit with --ff' '
> +	git reset --hard first -- &&
> +	git rm file1 &&
> +	echo first >file2 &&
> +	git add file2 &&
> +	git commit --amend -m "file2" &&
> +	git cherry-pick --ff first &&
> +	test "$(git rev-parse --verify HEAD)" = "1df192cd8bc58a2b275d842cede4d221ad9000d1"
> +'
> +
>  test_done
> -- 
> 1.7.3
