From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 1/2] filter-branch: stop special-casing $filter_subdir
 argument
Date: Thu, 22 Oct 2009 08:06:39 +0200
Message-ID: <4ADFF66F.1080005@viscovery.net>
References: <95535b01e2181d321190c6d93b2834188612a389.1256148512.git.trast@student.ethz.ch> <95535b01e2181d321190c6d93b2834188612a389.1256149428.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Oct 22 08:06:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0qp2-0005yl-EF
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 08:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbZJVGGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 02:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbZJVGGk
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 02:06:40 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:22601 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbZJVGGj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 02:06:39 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N0qop-0006oB-MX; Thu, 22 Oct 2009 08:06:39 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 73E03A4A1; Thu, 22 Oct 2009 08:06:39 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <95535b01e2181d321190c6d93b2834188612a389.1256149428.git.trast@student.ethz.ch>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130993>

Thomas Rast schrieb:
> Handling $filter_subdir in the usual way requires a separate case at
> every use, because the variable is empty when unused.  Furthermore,
> the case for --subdirectory-filter supplies its own --, so the user
> cannot provide one himself (though there is also very little point in
> doing so).
> 
> Instead, tack the $filter_subdir onto $@ in the right place
> automatically, and only use a -- if it was not already provided by the
> user.

I understand that this is a preparatory patch, but you seem to argue that
even without the follow-up patch there is a problem. But from your
explanation I do not understand what it is. An example invocation that
shows the problem would be very helpful.

> @@ -257,15 +257,29 @@ git read-tree || die "Could not seed the index"
>  # map old->new commit ids for rewriting parents
>  mkdir ../map || die "Could not create map/ directory"
>  
> +non_ref_args=$(git rev-parse --no-revs --sq "$@")
> +dashdash=--
> +for arg in "$non_ref_args"; do

At this point $non_ref_args might contain one or more IFS-separatable
words, but if you say "$non_ref_args" here, this loop will be entered
exactly once. But even if you drop the dquotes, the --sq quoting that you
requested from rev-parse bought you nothing.

> +	if test arg = --; then

Did you mean $arg here? Even then this test will succeed only if
$non_ref_args contains exactly one word and that word is '--'. Is that
what you mean?

> +		dashdash=
> +		break
> +	fi
> +done
> +
>  case "$filter_subdir" in
>  "")
> -	git rev-list --reverse --topo-order --default HEAD \
> -		--parents --simplify-merges "$@"
> +	filter_subdir_sq=
>  	;;
>  *)
> -	git rev-list --reverse --topo-order --default HEAD \
> -		--parents --simplify-merges "$@" -- "$filter_subdir"
> -esac > ../revs || die "Could not get the commits"
> +	filter_subdir_sq=$(git rev-parse --sq-quote "$filter_subdir")
> +esac
> +
> +eval "set -- \"\$@\" $dashdash $filter_subdir_sq"
> +non_ref_args=$(git rev-parse --no-revs --sq "$@")
> +
> +git rev-list --reverse --topo-order --default HEAD \
> +	--parents --simplify-merges "$@" \
> +	> ../revs || die "Could not get the commits"
>  commits=$(wc -l <../revs | tr -d " ")
>  
>  test $commits -eq 0 && die "Found nothing to rewrite"
> @@ -356,8 +370,8 @@ then
>  	do
>  		sha1=$(git rev-parse "$ref"^0)
>  		test -f "$workdir"/../map/$sha1 && continue
> -		ancestor=$(git rev-list --simplify-merges -1 \
> -				$ref -- "$filter_subdir")
> +		ancestor=$(eval "git rev-list --simplify-merges " \
> +				"-1 \"$ref\" $non_ref_args")
>  		test "$ancestor" && echo $(map $ancestor) >> "$workdir"/../map/$sha1
>  	done < "$tempdir"/heads
>  fi

This looks so convoluted; there must be a simpler way to achieve your goal.

-- Hannes
