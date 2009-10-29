From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3 1/2] filter-branch: stop special-casing $filter_subdir
 argument
Date: Thu, 29 Oct 2009 08:35:44 +0100
Message-ID: <4AE945D0.5030403@viscovery.net>
References: <4AE0187C.4040608@viscovery.net> <6e01558f719f4bfcd12f3c6dc5657790e86c874d.1256770377.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Oct 29 08:36:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3PY9-0003at-5T
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 08:36:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756671AbZJ2Hfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 03:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756586AbZJ2Hfw
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 03:35:52 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:15172 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755067AbZJ2Hfv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 03:35:51 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N3PXs-00034g-Sz; Thu, 29 Oct 2009 08:35:52 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 9E0E74E4; Thu, 29 Oct 2009 08:35:44 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <6e01558f719f4bfcd12f3c6dc5657790e86c874d.1256770377.git.trast@student.ethz.ch>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131568>

Thomas Rast schrieb:
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index a480d6f..da23b99 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -257,15 +257,23 @@ git read-tree || die "Could not seed the index"
>  # map old->new commit ids for rewriting parents
>  mkdir ../map || die "Could not create map/ directory"
>  
> +dashdash=
> +test -z "$(git rev-parse --no-revs "$@")" && dashdash=--

Hmm, if the user runs

   $ git filter-branch does-not-exist

then this would be the first call to rev-parse that fails with "fatal:
ambiguous argument 'does-not-exist': unknown revision or path...", but
this code wouldn't catch the failure. I suggest this instead:

# we need "--" only if there are no path arguments in $@
nonrevs=$(git rev-parse --no-revs "$@") || exit
dashdash=${nonrevs+"--"}

(including the comment; you can drop the dquotes in the dashdash
assignment if you think the result is still readable.)

I was to suggest to move these lines into the case arm below that is the
only user of $dashdash. But since this is a good error check of the
user-supplied arguments, I now prefer to keep the lines outside the case
statement.

> +ref_args=$(git rev-parse --revs-only "$@")

"ref_args"? Shouldn't it be "rev_args"? It's about "revisions", not
"references".

>  case "$filter_subdir" in
>  "")
> -	git rev-list --reverse --topo-order --default HEAD \
> -		--parents --simplify-merges "$@"
> +	eval set -- "$(git rev-parse --sq --no-revs "$@")"
>  	;;
>  *)
> -	git rev-list --reverse --topo-order --default HEAD \
> -		--parents --simplify-merges "$@" -- "$filter_subdir"
> -esac > ../revs || die "Could not get the commits"
> +	eval set -- "$(git rev-parse --sq --no-revs "$@")" \
> +	    $dashdash "$filter_subdir"

This is not correct: $filter_subdir undergoes an extra level of
evaluation. You must write it like this:

	eval set -- "$(git rev-parse --sq --no-revs "$@" \
		$dashdash "$filter_subdir")"

> +	;;
> +esac
> +
> +git rev-list --reverse --topo-order --default HEAD \
> +	--parents --simplify-merges $ref_args "$@" \
> +	> ../revs || die "Could not get the commits"

Personally, I would prefer to write this as

git rev-list --reverse --topo-order --default HEAD \
	--parents --simplify-merges $ref_args "$@" > ../revs ||
	die "Could not get the commits"

to avoid one backslash.

> @@ -356,8 +364,7 @@ then
>  	do
>  		sha1=$(git rev-parse "$ref"^0)
>  		test -f "$workdir"/../map/$sha1 && continue
> -		ancestor=$(git rev-list --simplify-merges -1 \
> -				$ref -- "$filter_subdir")
> +		ancestor=$(git rev-list --simplify-merges -1 "$ref" "$@")

You added dquotes around $ref: while not absolutely necessary, I agree
with this change.

>  		test "$ancestor" && echo $(map $ancestor) >> "$workdir"/../map/$sha1
>  	done < "$tempdir"/heads
>  fi

-- Hannes
