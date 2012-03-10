From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Maintaince script for l10n files and commits
Date: Fri, 09 Mar 2012 16:40:30 -0800
Message-ID: <7vhaxx2sqp.fsf@alter.siamese.dyndns.org>
References: <7v399iddw3.fsf@alter.siamese.dyndns.org>
 <1331273307-64598-1-git-send-email-worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, avarab@gmail.com
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 01:40:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6AMS-0003K7-DV
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 01:40:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757265Ab2CJAkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 19:40:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65008 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756028Ab2CJAke (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 19:40:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 351755CE9;
	Fri,  9 Mar 2012 19:40:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wrMooMOIx4BUhid0tX4hQzV8YqY=; b=I9Yfai
	J9mYMtxJoaoKqzSYbnJ1y1FeUS3I1456YdyT65FEsCbsS03h78lJ/4wEktAZpX1C
	gd8NEngX3wtfaQaFUqo6NXW59GtYcUxQdHysfoDKSV9YCK6aMV2VCOVik4QPrGnk
	X4YPQa8hgPIx2fBH+3bseDW8GrtEwvC9oqbrU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YCcGb3S1nq9YZBraSpgn0lVl3xIBobY+
	wO46YyoGmokw5Azyge2lnmKA0DfU0Lmbphjm08rc1WCFn3yHj4IFEmzo/zBF0DYH
	qkUXHSWRd9InLEdE/0D636UAZCu4zmzdkK0NylkdffGaXj3JB14MiXqwTU/Ugu9f
	RzTgCwh+nSs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AD805CE7;
	Fri,  9 Mar 2012 19:40:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1326E5CE6; Fri,  9 Mar 2012
 19:40:31 -0500 (EST)
In-Reply-To: <1331273307-64598-1-git-send-email-worldhello.net@gmail.com>
 (Jiang Xin's message of "Fri, 9 Mar 2012 14:08:27 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A4628FDC-6A49-11E1-B4DF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192760>

Jiang Xin <worldhello.net@gmail.com> writes:

> diff --git a/po/po-helper.sh b/po/po-helper.sh
> new file mode 100755
> index 0000000..166ebb7
> --- /dev/null
> +++ b/po/po-helper.sh
> @@ -0,0 +1,387 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2012 Jiang Xin
> +
> +GIT=git
> +PODIR=$($GIT rev-parse --show-cdup)po

David already pointed out that $GIT is a bad style.

> +POTFILE=$PODIR/git.pot
> +
> +usage() {

Style:

	usage () {

I won't repeat this anymore in this message but there are others.

> +# Init or update XX.po file from git.pot
> +update_po() {
> +	if test $# -eq 0
> +	then
> +		usage "init/update needs at least one argument"
> +	fi
> +	while test $# -gt 0
> +	do
> +		locale=$(basename $1)
> +		locale=${locale%.po}

This is bad for two reasons. (1) Your $1 that directly comes from
the end user's command line may have $IFS characters; (2) You do not
have to spawn a separate process to run basename.

But if I were writing this loop, I would probably avoided refering
to "$1" and shifting at the end by starting it like so:

	for locale
        do
                locale=${locale##*/}
                locale=${locale%.po}
		...
	done

> +		po=$PODIR/$locale.po
> +		mo=$PODIR/build/locale/$locale/LC_MESSAGES/git.mo
> +		if test -f $po

It is safer to say

	if test -f "$po"

here, even though it is not needed in the current form of this
script. Later somebody may change the definition of PODIR above to
something else that may contain $IFS.

> +		then
> +			msgmerge --add-location --backup=off -U $po $POTFILE

Likewise, both for "$po" and "$POTFILE" (I won't repeat this anymore
in this message but there are others).

> +}
> +
> +notes_for_l10n_team_leader() {
> +	locale=$(basename $1)
> +	locale=${locale%.po}

Likewise. I won't repeat this anymore in this message but there are others.

> +# Check po, pot, commits
> +check() {
> +	if test $# -eq 0
> +	then
> +		ls $PODIR/*.po |
> +		while read f
> +		do
> +			echo "============================================================"
> +			echo "Check $(basename $f)..."
> +			check $f
> +		done
> +
> +		echo "============================================================"
> +		echo "Check updates of git.pot..."
> +		check pot
> +
> +		echo "============================================================"
> +		echo "Check commits..."
> +		check commits
> +	fi
> +	while test $# -gt 0
> +	do
> +		case "$1" in
> +		*.po)
> +			check_po $1
> +			;;
> +		*pot)

This is yucky.

		pot | git.pot)

would have been easier to understand what is going on.  Either we
reached here from "check pot" when this function was called without
argument, or we were fed the git.pot from the command line.

> +			check_pot
> +			;;
> +		commit|commits)
> +			shift
> +			check_commits $@
> +			break
> +			;;

Perhaps you meant to say

	check_commits "$@"

> +		*)
> +			usage "Unkown task \"$1\" for check"
> +			;;

I think we tend to do

	usage "Unknown task '$1' for check"

> +# Syntax check on XX.po, or all .po files if nothing provided
> +check_po() {
> +	while test $# -gt 0
> +	do
> +		locale=$(basename $1)
> +		locale=${locale%.po}
> +		po=$PODIR/$locale.po
> +		mo=$PODIR/build/locale/$locale/LC_MESSAGES/git.mo
> +		if test -f $po
> +		then
> +			mkdir -p $(dirname $mo)
> +			msgfmt -o $mo --check --statistics $po
> +		else
> +			echo "Error: File $po does not exist." >&2

It would make it more obvious that this error message does go to
the standard error stream if you said it like this:

	echo >&2 "Error: File '$po' does not exist."

> +		fi
> +		shift
> +	done
> +}

Again,

	for locale
        do
        	...
	done

would have made the loop easier (less risk forgetting to shift or
to shift too many).

> +# Display summary of updates of git.pot
> +check_pot() {
> +	pnew="^.*:\([0-9]*\): this message is used but not defined in.*"
> +	pdel="^.*:\([0-9]*\): warning: this message is not used.*"
> +	new_count=0
> +	del_count=0
> +	new_lineno=""
> +	del_lineno=""
> +
> +	status=$(cd $PODIR; $GIT status --porcelain -- $(basename $POTFILE))
> +	if test -z "$status"
> +	then
> +		echo "Nothing changed."
> +	else
> +		tmpfile=$(mktemp /tmp/git.po.XXXX)

(optional) perhaps set a trap to remove this here, instead of an
explicit "rm" at the end?

> +		(cd $PODIR; LANGUAGE=C $GIT show HEAD:./$(basename $POTFILE) > $tmpfile )

		... show HEAD:./${POTFILE##*/} >"$tmpfile"

Look for "Redirection operators" in Documentation/CodingGuidelines.

> +		LANGUAGE=C msgcmp -N --use-untranslated $tmpfile $POTFILE 2>&1 | {
> +			while read line
> +			do
> +				m=$(echo $line | grep "$pnew" | sed -e "s/$pnew/\1/")

Make it a habit to suspect that you are using one process too many,
whenever you see grep and sed in the same pipe.

	... | sed -ne "s/$pnew/\1/"

would be sufficient, no?

> +				if test -n "$m"
> +				then
> +					new_count=$(( new_count + 1 ))
> +					if test -z "$new_lineno"
> +					then
> +						new_lineno="$m"
> +					else
> +						new_lineno="${new_lineno}, $m"
> +					fi
> +					continue
> +				fi
> +
> +				m=$(echo $line | grep "$pdel" | sed -e "s/$pdel/\1/")
> +				if test -n "$m"
> +				then
> +					del_count=$(( del_count + 1 ))
> +					if test -z "$del_lineno"
> +					then
> +						del_lineno="$m"
> +					else
> +						del_lineno="${del_lineno}, $m"
> +					fi
> +				fi
> +			done
> +			test $new_count -gt 1 && new_plur="s" || new_plur=""
> +			test $del_count -gt 1 && del_plur="s" || del_plur=""

Isn't plural forms "0 lines, 1 line, 2 lines,..."?  We have this in
our "gettext.h" that says "use singular form only when n is 1", not
"when n is less than 2":

	#define ngettext(s, p, n) ((n == 1) ? (s) : (p))

> +verify_commit_encoding() {
> +	c=$1
> +	subject=0
> +	non_ascii=""
> +	encoding=""
> +	log=""
> +
> +	$GIT cat-file commit $c | {
> +		while read line

At least, you should read with "read -r", if you were to write this
as a shell script.

> +		do
> +			log="$log - $line"
> +			# next line would be the commit log subject line,
> +			# if no previous empty line found.
> +			if test -z "$line"
> +			then
> +				subject=$((subject + 1))

Even though POSIX allows the above, this is preferred:

	subject=$(( $subject + 1 ))

as some shells were reported to barf without $ in front of the
variable names.

> +				continue
> +			fi
> +			if test $subject -eq 0
> +			then
> +				if echo $line | grep -q "^encoding "
> +				then
> +					encoding=${line#encoding }
> +				fi

	case "$line" in
        encoding' '*)
		encoding=${...}
		;;
	esac

> +			fi
> +			# non-ascii found in commit log
> +			m=$(echo $line | sed -e "s/\([[:alnum:][:space:][:punct:]]\)//g")
> +			if test -n "$m"
> +			then
> +				non_ascii="$m >> $line <<"
> +				if test $subject -eq 1
> +				then
> +					report_nonascii_in_subject $c "$non_ascii"
> +					return
> +				fi
> +			fi
> +			# subject has only one line
> +			test $subject -eq 1 && subject=$((subject += 1))

subject=$(( $subject + 1 ))

> +			# break if there are non-asciis and has already checked subject line
> +			if test -n "$non_ascii" && test $subject -gt 0
> +			then
> +				break

Is it OK for the body to have good line followed by a bad line?

> +			fi
> +		done
> +		if test -n "$non_ascii"
> +		then
> +			if test -z "$encoding"
> +			then
> +				echo $line | iconv -f UTF-8 -t UTF-8 -s >/dev/null ||
> +					report_bad_encoding "$c" "$non_ascii"
> +			else
> +				echo $line | iconv -f $encoding -t UTF-8 -s >/dev/null ||
> +					report_bad_encoding "$c" "$non_ascii" "$encoding"
> +			fi
> +		fi
> +	}
> +}
