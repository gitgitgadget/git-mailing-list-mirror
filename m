From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib: added git-diffall
Date: Tue, 21 Feb 2012 13:51:39 -0800
Message-ID: <7vd397g8ic.fsf@alter.siamese.dyndns.org>
References: <1329785969-828-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 22:51:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzxci-0004mm-Le
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 22:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755476Ab2BUVvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 16:51:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61785 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755165Ab2BUVvm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 16:51:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A83D876E1;
	Tue, 21 Feb 2012 16:51:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=582zd6kqzY06jeyYsHjD2LmJGV0=; b=V4VLQI
	yUL2I777gI8/OCCuO26RUdoldfpUPYd1vxqFfkegGuhP82us/WVW6xCaiqddwoHN
	tZILt/OqylUIduF6ZTxrXsL/ArL+sp7RRfwXWX1eO/+IULO9CrU1NvD4LQCvUMV+
	bm/bftdYkMKSfy66x/nQsfq7amzItqcJ+OpSM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MdjkuT3jYQNZyYjwBButPQjG7x/k18x3
	+GdszfUs7+7tj1sgMJWFzTk/8t6zLuuM7OJjXzV5FzhsbsKeQBbCsh3e4cKnO+nL
	8pF8tZUazbZJ6rVos+PeeExisz+IfTSspIdgyr1eYP/bOZndtD/rlUyahNAvMPsW
	DNNMFC1rZ9g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EBDB76E0;
	Tue, 21 Feb 2012 16:51:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF22376DE; Tue, 21 Feb 2012
 16:51:40 -0500 (EST)
In-Reply-To: <1329785969-828-1-git-send-email-tim.henigan@gmail.com> (Tim
 Henigan's message of "Mon, 20 Feb 2012 19:59:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3CB7C8BE-5CD6-11E1-9CBD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191188>

Tim Henigan <tim.henigan@gmail.com> writes:

> diff --git a/contrib/diffall/git-diffall b/contrib/diffall/git-diffall
> new file mode 100755
> index 0000000..ef01eda
> --- /dev/null
> +++ b/contrib/diffall/git-diffall
> @@ -0,0 +1,275 @@
> +#!/bin/bash -e

Does this have to be bash-only (iow, infested with bash-isms beyond
repair), or is you wrote this merely from inertia?

The following is only after a cursory scanning, so there may be other
things that needs fixing, but anyway:

 - Don't use "which" in scripts.  Its output is not machine parseable, and
   exit code is not reliable, across platforms.  It is only meant for
   consumption by human who can read English (or natural language in the
   current locale).

> +				if test -z "$paths"
> +				then
> +					paths=$1
> +				else
> +					paths="$paths $1"
> +				fi

Just a style tip; if you are going to let shell $IFS split this list
anyway, it is customary to write the above as

	paths="$paths$1 "

> +		git diff --name-only "$left"..."$right" -- $paths > "$tmp"/filelist

	git diff ... -- $paths >"$tmp/filelist"

> +# Exit immediately if there are no diffs
> +if test ! -s "$tmp"/filelist
> +then
> +	exit 0
> +fi
> +
> +if test -n "$copy_back" && test "$right_dir" != "working_tree"
> +then
> +	echo "--copy-back is only valid when diff includes the working tree."
> +	exit 1
> +fi
> +
> +# Create the named tmp directories that will hold the files to be compared
> +mkdir -p "$tmp"/"$left_dir" "$tmp"/"$right_dir"

	mkdir -p "$tmp/$left_dir" "$tmp/$right_dir"

> +		if test -n "$compare_staged"
> +		then
> +			ls_list=$(git ls-tree HEAD $name)
> +			if test -n "$ls_list"
> +			then
> +				mkdir -p "$tmp"/"$left_dir"/"$(dirname "$name")"
> +				git show HEAD:"$name" > "$tmp"/"$left_dir"/"$name"
> +				fi
> +			else
> +				mkdir -p "$tmp"/"$left_dir"/"$(dirname "$name")"
> +				git show :"$name" > "$tmp"/"$left_dir"/"$name"
> +		fi

That's misleadingly indented.  First I thought "in what case would we want
to switch the LHS between HEAD:$path and :$path when doing diff --cached?"
but the overindented four lines starting from the funny "fi" is about non
cached case.

> +	fi
> +done < "$tmp"/filelist
> +
> +cd "$tmp"
> +LOCAL="$left_dir"
> +REMOTE="$right_dir"
> +
> +if test -n "$diff_tool"
> +then
> +	export BASE
> +	eval $diff_tool '"$LOCAL"' '"$REMOTE"'
> +else
> +	run_merge_tool "$merge_tool" false
> +fi
> +
> +# This function is called on exit
> +cleanup () {
> +	cd "$start_dir"
> +
> +	# Copy files back to the working dir, if requested
> +	if test -n "$copy_back" && test "$right_dir" = "working_tree"
> +	then
> +		git_top_dir=$(git rev-parse --show-toplevel)
> +		find "$tmp/$right_dir" -type f|while read file; do
> +			cp "$file" "$git_top_dir/${file#$tmp/$right_dir/}"
> +		done

Why is this loop written in such a dense way?  Everything else (except for
that misindented part) were almost to our CodingStyle and was fairly easy
to read, though.

> +	fi
> +
> +	# Remove the tmp directory
> +	rm -rf "$tmp"
> +}
> +
> +trap cleanup EXIT

Does this even trigger?  This is not Perl that parses and runs set-up code
before executing everything else, so I suspect this last line amounts to
the same thing as writing just

	cleanup

without trap nor signal names.

If you are to set up temporary files or directories that you want to clean
up, a good discipline is to follow this order:

  - define variable(s) to hold the temporary locations, e.g.
    tmpdir=$(mktemp ...)

  - set the trap before starting to use these temporary locations, e.g.
    trap 'rm -rf "$tmpdir' 0 1 2 3 15

  - and then start populating tmpdir and do whatever you want to do.
