From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] git-submodule: New subcommand 'summary' (2) - hard work
Date: Sat, 12 Jan 2008 00:32:15 -0800
Message-ID: <7vejcnv3zk.fsf@gitster.siamese.dyndns.org>
References: <1200123435-16722-1-git-send-email-pkufranky@gmail.com>
	<f67f45eeb9648bb7e5adaf53544443b79643914e.1200122041.git.pkufranky@gmail.com>
	<62a73e734832ad67e89be706f1f8b3dbc30cfcf4.1200122041.git.pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 09:32:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDbnU-00021z-V7
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 09:32:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759757AbYALIc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 03:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759669AbYALIc2
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 03:32:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46366 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758611AbYALIc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 03:32:27 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E7B614045;
	Sat, 12 Jan 2008 03:32:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CFF974044;
	Sat, 12 Jan 2008 03:32:21 -0500 (EST)
In-Reply-To: <62a73e734832ad67e89be706f1f8b3dbc30cfcf4.1200122041.git.pkufranky@gmail.com>
	(Ping Yin's message of "Sat, 12 Jan 2008 15:37:12 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70297>

Ping Yin <pkufranky@gmail.com> writes:

> +	git diff $cache_option --raw $head -- $modules |
> +	grep '^:160000\|:000000 160000' |
> +	cut -c2- |
> +	while read mod_src mod_dst sha1_src sha1_dst status name
> +	do
> +		sha1_dst=$(echo $sha1_dst | cut -c1-7)
> +		sha1_src=$(echo $sha1_src | cut -c1-7)

If you are willing to lose precision forever like this, I think
you can run "git diff" with --abbrev and lose this cut.

> +		check_dst=t
> +		check_src=t
> +		case $status in
> +		D)
> +			check_dst=
> +			;;
> +		A)
> +			check_src=
> +			;;

I'd loosen the above grep (see my comments to your 1/5) and also
add this:

		*)
			continue ;# punt
			;;

so that the rest of the code won't break when seeing a path that
was submodule in the HEAD but is a blob in the index.

> +		esac
> +
> +		(
> +			errmsg=
> +			unfound_src=
> +			unfound_dst=
> +
> +			test -z "$check_src" ||
> +			GIT_DIR="$name/.git" git-rev-parse $sha1_src >&/dev/null ||

And the precision of $sha1_src matter here.  Be it done with
"diff --abbrev" at the toplevel or your "cut", that may not be
unique enough in the submodule.

I think you would want to read full 40-char sha1_src and
sha1_dst with "while read", and keep that full 40-char in these
variables, and use them when calling rev-parse here.

If you are checking if that the object exists in the submodule,
use "rev-parse --verify", which was designed for exactly that
purpose.  If you also want to verify if the object is a commit,
which may be a good idea anyway, "rev-parse --verify $sha1_src^0".

To be portable, use traditional ">/dev/null 2>&1", not ">&/dev/null".

> +			case "$unfound_src,$unfound_dst" in
> +			t,)
> +				errmsg="  Warn: $name doesn't contain commit $sha1_src"
> +				;;
> +			,t)
> +				errmsg="  Warn: $name doesn't contain commit $sha1_dst"
> +				;;
> +			t,t)
> +				errmsg="  Warn: $name doesn't contain commits $sha1_src and $sha1_dst"
> +				;;

When reporting errors, you would want to give full 40-chars...

> +			*)
> +				left=
> +				right=
> +				test -n "$check_src" &&
> +				left=$(GIT_DIR="$name/.git" git log --pretty=format:"  <%s" \
> +				${check_dst:+$sha1_dst..}$sha1_src 2>/dev/null)
> +
> +				test -n "$check_dst" &&
> +				right=$(GIT_DIR="$name/.git" git log --reverse --pretty=format:"  >%s" \
> +				${check_src:+$sha1_src..}$sha1_dst 2>/dev/null)
> +				;;
> +			esac
> +
> +			echo "* $name $sha1_src...$sha1_dst:"

While reporting like this, you would want the shortened form,
perhaps produced your "cut -c1-7".

> +			if test -n "$errmsg"
> +			then
> +				echo "$errmsg"
> +			else
> +				test -n "$left" && echo "$left"
> +				test -n "$right" && echo "$right"
> +			fi
> +			echo
> +		) | sed 's/^/# /'
> +	done

I'd prefer to always have "-e" before the sed expression.

Any reason why you want separate invocation of sed inside the
while loop?  IOW, why isn't it like this?

	git diff --raw |
        while read ...
        do
        	...
	done | sed -e 's/^/# /'

> +
>  	cd "$cwd"

Hmmm.
