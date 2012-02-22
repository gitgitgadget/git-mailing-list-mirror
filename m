From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] contrib: added git-diffall
Date: Wed, 22 Feb 2012 15:48:33 -0800
Message-ID: <7vipiy8m5q.fsf@alter.siamese.dyndns.org>
References: <1329948749-5908-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, davvid@gmail.com, stefano.lattarini@gmail.com
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 00:48:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0LvO-0000LB-UW
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 00:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900Ab2BVXsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 18:48:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53951 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751207Ab2BVXsh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 18:48:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95DB7781C;
	Wed, 22 Feb 2012 18:48:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HJ5yNVccB08un1onSVYccEod7fI=; b=L20oZA
	ZAxTrKis2/DY4rM/YKnSetjTJKJE2cVB2nx2e8qYljcYbh5TzAFpQq//1zqUXBbO
	INT9pAnIyEy0b+VxvGmNImYXTisl8LUoFlWUMrfgY+h/kQ2DmaWv2bclVnveQQke
	nG1gQyAAQ6rTbF7/cAfYuY48bUQk3uz/h5BN4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qJ0QTE2K2/6WgavNVb8Df+RAsmF3awML
	LVxKW6Ke8hVonD/ZGIOFpznppFbjeIYFHN4E8m3VotNtcT8DyjcWHkPXei1KyDxF
	CtGW0nXtpKzjynk0dfXbul249z6CJhYxM+0P0xs7U9JKzSGUoaVEmcbY/R2zICZZ
	t06BUPGh6F4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D21B781A;
	Wed, 22 Feb 2012 18:48:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 75D9C7818; Wed, 22 Feb 2012
 18:48:35 -0500 (EST)
In-Reply-To: <1329948749-5908-1-git-send-email-tim.henigan@gmail.com> (Tim
 Henigan's message of "Wed, 22 Feb 2012 17:12:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BC23AF12-5DAF-11E1-96B4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191311>

Tim Henigan <tim.henigan@gmail.com> writes:

> This script adds directory diff support to git.  It launches a single
> instance of the user-configured external diff tool and performs a
> directory diff between the specified revisions. The before/after files
> are copied to a tmp directory to do this.  Either 'diff.tool' or
> 'merge.tool' must be set before running the script.
>
> The existing 'git difftool' command already allows the user to view diffs
> using an external tool.  However if multiple files have changed, a
> separate instance of the tool is launched for each one.  This can be
> tedious when many files are involved.

We encourage our log messages to describe the problem first and then
present solution to the problem, so I would update the above perhaps like
this:

	The 'git difftool' command lets the user to use an external tool
	to view diffs, but it runs the tool for one file at the time. This
	makes it tedious to review a change that spans multiple files.

        The "git-diffall" script instead prepares temporary directories
        with preimage and postimage files, and launches a single instance
        of an external diff tool to view the differences in them.
        diff.tool or merge.tool configuration variable is used to specify
        what external tool is used.

I am wondering if reusing "diff.tool" or "merge.tool" is a good idea,
though.

I guess that it is OK to assume that any external tool that can compare
two directories MUST be able to compare two individual files, and if that
is true, it is perfectly fine to reuse the configuration.  But if an
external tool "frobdiff" that can compare two directories cannot compare
two individual files, it will make it impossible for the user to run "git
difftool" if diff.tool is set to "frobdiff" to use with "diffall".

Another thing that comes to my mind is if a user has an external tool that
can use "diffall", is there ever a situation where the user chooses to use
"difftool" instead, to go files one by one.  I cannot offhand imagine any.

Perhaps a longer term integration plan may be to lift the logic from this
script and make it part of "difftool", and then add a boolean variable
"difftool.<tool>.canCompareDirectory", without adding "git diffall" as a
subcommand.  The user can still run "git difftool", and when the external
tool can compare two directories, the code to populate temporary directory
(and to set the trap to clean after itself) taken from this tool will run
inside "git difftool" frontend and then the external tool to compare the
two directories is spawned.

I also think that in a yet longer term, if this mode of "instantiate two
directories to be compared, and let the external tool do the comparison"
proves useful, almost all the "interesting" work done in this script
should be made unnecessary by adding an updated "external diff interface"
on the core side, so that nobody has to hurt his brain to implement an
error-prone command line parsing logic.

In other words, this statement cannot stay true:

> +This script is compatible with all the forms used to specify a
> +range of revisions to diff:

without updating the script every time underlying "git diff" gains new way
of comparing things.  If we move the "prepare two directories, and point
an external tool at them" logic to the core, we do not have to worry about
it at all.

Besides, I do not think the script covers all the forms; "git diff -R"
support is totally missing.

But that is all two steps in the future.

> +# mktemp is not available on all platforms (missing from msysgit)
> +# Use a hard-coded tmp dir if it is not available
> +tmp="$(mktemp -d -t tmp.XXXXXX 2>/dev/null)" || {
> +	tmp=/tmp/git-diffall-tmp
> +}

It would not withstand malicious attacks, but doing

	tmp=/tmp/git-diffall-tmp.$$

would at least protect you from accidental name crashes better in the
fallback codepath.

> +
> +trap 'rm -rf "$tmp" 2>/dev/null' EXIT

Do you need to suppress errors, especially when you are running "rm -rf"
with the 'f' option?

> +mkdir -p "$tmp"
> +
> +left=
> +right=
> +paths=
> +path_sep=
> +compare_staged=
> +common_ancestor=
> +left_dir=
> +right_dir=
> +diff_tool=
> +copy_back=

You can write multiple assignment on a line to save vertical space if you
want to, and the initialization sequence like this is a good place to do
so.

> +while test $# != 0
> +do
> +	case "$1" in
> +	-h|--h|--he|--hel|--help)
> +		usage
> +		;;
> +	--cached)
> +		compare_staged=1
> +		;;
> +	--copy-back)
> +		copy_back=1
> +		;;
> +	-x|--e|--ex|--ext|--extc|--extcm|--extcmd)
> +		diff_tool=$2
> +		shift
> +		;;

What if your command line ends with -x without $2?

Don't you want to match "-t/--tool" that "difftool" already uses?

> +	--)
> +		path_sep=1
> +		;;
> +	-*)
> +		echo Invalid option: "$1"
> +		usage
> +		;;
> +	*)
> +		# could be commit, commit range or path limiter
> +		case "$1" in
> +		*...*)
> +			left=${1%...*}
> +			right=${1#*...}
> +			common_ancestor=1
> +			;;

Strictly speaking, that is not just a common_ancestor but is a merge_base,
which is a common ancestor none of whose children is a common ancestor.

> +		*..*)
> +			left=${1%..*}
> +			right=${1#*..}
> +			;;
> +		*)
> +			if test -n "$path_sep"
> +			then
> +				paths="$paths$1 "
> +			elif test -z "$left"
> +			then
> +				left=$1
> +			elif test -z "$right"
> +			then
> +				right=$1
> +			else
> +				paths="$paths$1 "
> +			fi
> +			;;
> +		esac

Hrm, so "diffall HEAD~2 Documentation/" is not the way to compare the
contents of the Documentation/ directory between the named commit and
the working tree, like "diff HEAD~2 Documentation/" does.

That is not a show-stopper (a double-dash is an easy workaround), but
it is worth pointing out.

> +		;;
> +	esac
> +	shift
> +done
> +
> +# Determine the set of files which changed
> +if test -n "$left" && test -n "$right"
> +then
> +	left_dir="cmt-$(git rev-parse --short $left)"
> +	right_dir="cmt-$(git rev-parse --short $right)"
> +
> +	if test -n "$compare_staged"
> +	then
> +		usage
> +	elif test -n "$common_ancestor"
> +	then
> +		git diff --name-only "$left"..."$right" -- $paths > "$tmp/filelist"
> +	else
> +		git diff --name-only "$left" "$right" -- $paths > "$tmp/filelist"
> +	fi

And this will not work with pathspec that have $IFS characters.  If we
really wanted to we could do that by properly quoting "$1" when you build
$paths and then use eval when you run "git diff" here (look for 'sq' and
'eval' in existing scripts, e.g. "git-am.sh", if you are interested).

Also you may want to write filelist using -z format to protect yourself
from paths that contain LF, but that would require the loop "while read
name" to be rewritten.

> +# Exit immediately if there are no diffs
> +if test ! -s "$tmp/filelist"
> +then
> +	exit 0
> +fi

Ok, you have trap set already so $tmp will disappear with this exit ;-)

> +if test -n "$copy_back" && test "$right_dir" != "working_tree"
> +then
> +	echo "--copy-back is only valid when diff includes the working tree."
> +	exit 1
> +fi

I actually wondered why $right_dir needs to be populated with a copy in
the first place (if you do not copy but give the working tree itself to
the external tool, you do not even have to copy back).

I know the answer to the question, namely, "because the external tool
thinks files that are not in $left_dir are added files", but if you can
find a way to tell the external tool to ignore new files (similar to how
"diff -r" without -N works), running the tool with temporary left_dir and
the true workdir as right_dir would be a lot cleaner solution to the
problem.

> +# Create the named tmp directories that will hold the files to be compared
> +mkdir -p "$tmp/$left_dir" "$tmp/$right_dir"
> +
> +# Populate the tmp/right_dir directory with the files to be compared
> +if test -n "$right"
> +then
> +	while read name
> +	do
> +		ls_list=$(git ls-tree $right $name)
> +		if test -n "$ls_list"
> +		then
> +			mkdir -p "$tmp/$right_dir/$(dirname "$name")"
> +			git show "$right":"$name" > "$tmp/$right_dir/$name" || true
> +		fi
> +	done < "$tmp/filelist"

"while read -r name" might make this slightly more robust; even though
this loses leading and trailing whitespaces in filenames, we probably
can get away without worrying about them.

> +else
> +	# Mac users have gnutar rather than tar
> +	(tar --ignore-failed-read -c -T "$tmp/filelist" | (cd "$tmp/$right_dir" && tar -x)) || {
> +		gnutar --ignore-failed-read -c -T "$tmp/filelist" | (cd "$tmp/$right_dir" && gnutar -x)
> +	}

What is this "--ignore-failed-read" about?  Not reporting unreadable as an
error smells really bad.

If you require GNUism in your tar usage, this should be made configurable
so that people can use alternative names (some systems come with "tar"
that is POSIX and "gtar" that is GNU).

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
> +# Copy files back to the working dir, if requested
> +if test -n "$copy_back" && test "$right_dir" = "working_tree"
> +then
> +	cd "$start_dir"
> +	git_top_dir=$(git rev-parse --show-toplevel)
> +	find "$tmp/$right_dir" -type f |
> +	while read file
> +	do
> +		cp "$file" "$git_top_dir/${file#$tmp/$right_dir/}"
> +	done
> +fi

This will copy new files created in $right_dir.  Is that intended?
