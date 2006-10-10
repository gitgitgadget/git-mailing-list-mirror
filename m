From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] repack: allow simultaneous packing and pruning
Date: Wed, 11 Oct 2006 00:04:25 +1300
Message-ID: <452B7E39.8040707@vilain.net>
References: <20061010102210.568341380D6@magnus.utsl.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Oct 10 13:05:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXFPp-0007Hq-MK
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 13:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWJJLEl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 07:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932623AbWJJLEl
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 07:04:41 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:170 "EHLO magnus.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S932224AbWJJLEk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Oct 2006 07:04:40 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 500841380D8; Wed, 11 Oct 2006 00:04:37 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.magnus.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id B486B1380C2
	for <git@vger.kernel.org>; Wed, 11 Oct 2006 00:04:32 +1300 (NZDT)
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
To: git@vger.kernel.org
In-Reply-To: <20061010102210.568341380D6@magnus.utsl.gen.nz>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28626>

er, I guess I assumed that the critique about the behaviour was true
rather than checking it myself... this patch is mostly a null-op.  *and*
it's not whitespace clean!

Sam.

Sam Vilain wrote:
> If using git-repack -a, unreferenced objects are kept behind in the
> pack.  This might be the best default, but there are no good ways
> to clean up the packfiles if a lot of rebasing is happening, or
> branches have been deleted.
> ---
> see also http://colabti.de/irclogger/irclogger_log/git?date=2006-10-10,Tue&sel=27#l75
> 
>  Documentation/git-repack.txt |    7 ++++++-
>  git-repack.sh                |   14 +++++++++++++-
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
> index 9516227..63ee7cb 100644
> --- a/Documentation/git-repack.txt
> +++ b/Documentation/git-repack.txt
> @@ -9,7 +9,7 @@ objects into pack files.
>  
>  SYNOPSIS
>  --------
> -'git-repack' [-a] [-d] [-f] [-l] [-n] [-q]
> +'git-repack' [-a] [-d] [-f] [-l] [-n] [-q] [-p]
>  
>  DESCRIPTION
>  -----------
> @@ -40,6 +40,11 @@ OPTIONS
>  	existing packs redundant, remove the redundant packs.
>  	Also runs gitlink:git-prune-packed[1].
>  
> +-p::
> +	Before packing, remove any unreferenced objects with
> +	gitlink:git-prune[1].  When used with '-a', unreferenced
> +	objects in the old packs are not taken across.
> +
>  -l::
>          Pass the `--local` option to `git pack-objects`, see
>          gitlink:git-pack-objects[1].
> diff --git a/git-repack.sh b/git-repack.sh
> index 640ad8d..a2ad955 100755
> --- a/git-repack.sh
> +++ b/git-repack.sh
> @@ -7,13 +7,14 @@ USAGE='[-a] [-d] [-f] [-l] [-n] [-q]'
>  . git-sh-setup
>  
>  no_update_info= all_into_one= remove_redundant=
> -local= quiet= no_reuse_delta= extra=
> +local= quiet= no_reuse_delta= extra= prune=
>  while case "$#" in 0) break ;; esac
>  do
>  	case "$1" in
>  	-n)	no_update_info=t ;;
>  	-a)	all_into_one=t ;;
>  	-d)	remove_redundant=t ;;
> +	-p)     prune=t ;;
>  	-q)	quiet=-q ;;
>  	-f)	no_reuse_delta=--no-reuse-delta ;;
>  	-l)	local=--local ;;
> @@ -32,6 +33,11 @@ case ",$all_into_one," in
>  ,,)
>  	rev_list='--unpacked'
>  	pack_objects='--incremental'
> +	if [ -n "$prune" ]
> +	then
> +	    # prune junk first
> +	    git-prune
> +	fi
>  	;;
>  ,t,)
>  	rev_list=
> @@ -40,8 +46,14 @@ case ",$all_into_one," in
>  	# Redundancy check in all-into-one case is trivial.
>  	existing=`cd "$PACKDIR" && \
>  	    find . -type f \( -name '*.pack' -o -name '*.idx' \) -print`
> +
> +	if [ -n "$prune" ]
> +	then
> +	    rev_list=`cd "$GIT_DIR" && find refs -type f -print`
> +	fi
>  	;;
>  esac
> +
>  pack_objects="$pack_objects $local $quiet $no_reuse_delta$extra"
>  name=$(git-rev-list --objects --all $rev_list 2>&1 |
>  	git-pack-objects --non-empty $pack_objects .tmp-pack) ||
