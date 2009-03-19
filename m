From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git am from scratch
Date: Thu, 19 Mar 2009 14:57:52 -0700
Message-ID: <7vzlfh6uqn.fsf@gitster.siamese.dyndns.org>
References: <200903191609.24812.agruen@suse.de>
 <20090319201817.GE17028@coredump.intra.peff.net>
 <200903192142.49754.agruen@suse.de>
 <20090319210214.GA17589@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 23:01:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkQIa-00029I-0s
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 23:01:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758916AbZCSV6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 17:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759264AbZCSV6E
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 17:58:04 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40741 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757670AbZCSV6D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 17:58:03 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2789D75F0;
	Thu, 19 Mar 2009 17:57:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5253A75EF; Thu,
 19 Mar 2009 17:57:54 -0400 (EDT)
In-Reply-To: <20090319210214.GA17589@coredump.intra.peff.net> (Jeff King's
 message of "Thu, 19 Mar 2009 17:02:14 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 01F92DB2-14D1-11DE-B101-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113843>

Jeff King <peff@peff.net> writes:

> Anyway, here is a not-very-well-tested patch to get "git am" to apply on
> top of an empty repository (i.e., it worked on my utterly simplistic
> test case and I didn't think too hard about what else might have been
> broken). Maybe it will give a good start to somebody who wants to work
> on this.

The patch gets the ball rolling in a right direction, I think.  In
addition, you need to audit --abort and --skip codepaths carefully,
though.

> diff --git a/git-am.sh b/git-am.sh
> index d339075..bcc600d 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -290,17 +290,23 @@ else
>  		: >"$dotest/rebasing"
>  	else
>  		: >"$dotest/applying"
> -		git update-ref ORIG_HEAD HEAD
> +		if git rev-parse --quiet --verify HEAD; then
> +			git update-ref ORIG_HEAD HEAD
> +		else
> +			rm -f "$GIT_DIR/ORIG_HEAD"
> +		fi
>  	fi
>  fi
>  
>  case "$resolved" in
>  '')
> -	files=$(git diff-index --cached --name-only HEAD --) || exit
> -	if test "$files"
> -	then
> -		: >"$dotest/dirtyindex"
> -		die "Dirty index: cannot apply patches (dirty: $files)"
> +	if git rev-parse --quiet --verify HEAD; then
> +		files=$(git diff-index --cached --name-only HEAD --) || exit
> +		if test "$files"
> +		then
> +			: >"$dotest/dirtyindex"
> +			die "Dirty index: cannot apply patches (dirty: $files)"
> +		fi
>  	fi
>  esac
>  
> @@ -541,7 +547,7 @@ do
>  	fi
>  
>  	tree=$(git write-tree) &&
> -	parent=$(git rev-parse --verify HEAD) &&
> +	parent=$(git rev-parse --quiet --verify HEAD)
>  	commit=$(
>  		if test -n "$ignore_date"
>  		then
> @@ -552,7 +558,7 @@ do
>  			GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"
>  			export GIT_COMMITTER_DATE
>  		fi &&
> -		git commit-tree $tree -p $parent <"$dotest/final-commit"
> +		git commit-tree $tree ${parent:+-p $parent} <"$dotest/final-commit"
>  	) &&
>  	git update-ref -m "$GIT_REFLOG_ACTION: $FIRSTLINE" HEAD $commit $parent ||
>  	stop_here $this
