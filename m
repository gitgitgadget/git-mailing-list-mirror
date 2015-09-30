From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH] clone --dissociate: avoid locking pack files
Date: Wed, 30 Sep 2015 22:28:14 +0300
Message-ID: <20150930192814.GA26154@wheezy.local>
References: <682991036f1e8e974ed8ecd7d20dbcc6fb86c344.1443469464.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 30 21:28:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhN3D-0003CO-2I
	for gcvg-git-2@plane.gmane.org; Wed, 30 Sep 2015 21:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbbI3T2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 15:28:23 -0400
Received: from p3plsmtpa06-06.prod.phx3.secureserver.net ([173.201.192.107]:42204
	"EHLO p3plsmtpa06-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932433AbbI3T2W (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Sep 2015 15:28:22 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa06-06.prod.phx3.secureserver.net with 
	id PXUF1r0075B68XE01XUL43; Wed, 30 Sep 2015 12:28:21 -0700
Content-Disposition: inline
In-Reply-To: <682991036f1e8e974ed8ecd7d20dbcc6fb86c344.1443469464.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278859>

On Mon, Sep 28, 2015 at 09:44:57PM +0200, Johannes Schindelin wrote:
> When `git clone` is asked to dissociate the repository from the
> reference repository whose objects were used, it is quite possible that
> the pack files need to be repacked. In that case, the pack files need to
> be deleted that were originally hard-links to the reference repository's
> pack files.

Hello. For 1.9.* I used to have some hack for closing files
also. The case was to allow scheduled git gc to remove packs
even if I forgot to quit some less in some console.

> On platforms where a file cannot be deleted if another process still
> holds a handle on it, we therefore need to take pains to release all
> pack files and indexes before dissociating.
> 
> This fixes https://github.com/git-for-windows/git/issues/446
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/clone.c            |  9 ++++++++-
>  t/t5700-clone-reference.sh | 21 +++++++++++++++++++++
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 578da85..223adc4 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1064,8 +1064,15 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	transport_unlock_pack(transport);
>  	transport_disconnect(transport);
>  
> -	if (option_dissociate)
> +	if (option_dissociate) {
> +		struct packed_git *p;
> +
> +		for (p = packed_git; p; p = p->next) {
> +			close_pack_windows(p);
> +			close_pack_index(p);
> +		}
>  		dissociate_from_references();
> +	}

This does not seem to close handles to the pack files
themseves, does Windows still allow removing the files? I
probably did not tried that, because I started from handles,
and discovered mapped files only later.

>  	junk_mode = JUNK_LEAVE_REPO;
>  	err = checkout();
> diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
> index ef1779f..2250ef4 100755
> --- a/t/t5700-clone-reference.sh
> +++ b/t/t5700-clone-reference.sh
> @@ -188,5 +188,26 @@ test_expect_success 'clone and dissociate from reference' '
>  	test_must_fail git -C R fsck &&
>  	git -C S fsck
>  '
> +test_expect_success 'clone, dissociate from partial reference and repack' '
> +	rm -fr P Q R &&
> +	git init P &&
> +	(
> +		cd P &&
> +		test_commit one &&
> +		git repack &&
> +		test_commit two &&
> +		git repack
> +	) &&
> +	git clone --bare P Q &&
> +	(
> +		cd P &&
> +		git checkout -b second &&
> +		test_commit three &&
> +		git repack
> +	) &&
> +	git clone --bare --dissociate --reference=P Q R &&
> +	ls R/objects/pack/*.pack >packs.txt &&
> +	test_line_count = 1 packs.txt
> +'

Unless it goes very lowlevel like running lsof of readin
proc testing this should always pass on Linux, even if the
issue is not fixed, maybe should be a conditional for
Windows only?

>  test_done
> -- 
> 2.5.3.windows.1.3.gc322723
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
