From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] rebase: implement --[no-]autostash and rebase.autostash
Date: Tue, 23 Apr 2013 10:07:42 -0700
Message-ID: <7vr4i1i3a9.fsf@alter.siamese.dyndns.org>
References: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
	<1366725724-1016-8-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 19:07:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUgh5-0002m1-2s
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 19:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756340Ab3DWRHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 13:07:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48615 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756248Ab3DWRHp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 13:07:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E813F18185;
	Tue, 23 Apr 2013 17:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+6OirdzYYIkCy3feQiKEgMB+wWU=; b=qimX2X
	QAL/j2gy9oOTgncjC/+k20O5APM5LU7hjLubejbrT7uNQaiua69bfTLzPj3xhJup
	tM+QDyo80Q/I7zBsHDlE8o+5Ac1ZJyKmJcDytQ5B6hYmCKNTc12M+FDZ2WHuaOnu
	RSFMfFtFNjP2OQqpF+EO4NTIaV+qBYj+qtPLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hlzo0T2nU+3Ue2SUDyQPm0uIg16VQXoo
	K9hJImDDEj19x0LdRHFftSLE7zlngEFRa3nCDhBuBAwyvkSveDH0k0rcBYY2C/jL
	wKKuThfNIdRdEDoAJoTrZ4H9b9Z7fCujPl+K/dobOxG4rXndV/Zi5QQ/JtfFFkPP
	vf3BX7RXTY0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D93CC18184;
	Tue, 23 Apr 2013 17:07:44 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 272C518183;
	Tue, 23 Apr 2013 17:07:44 +0000 (UTC)
In-Reply-To: <1366725724-1016-8-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Tue, 23 Apr 2013 19:32:04 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 50680F42-AC38-11E2-AAAD-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222196>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> +apply_autostash () {
> +	if test -f "$state_dir/autostash"
> +	then
> +		stash_sha1=$(cat "$state_dir/autostash")
> +		git stash apply $stash_sha1 2>&1 >/dev/null ||
> +		die "
> +$(eval_gettext 'Applying autostash resulted in conflicts.
> +Either fix the conflicts now, or run
> +	git reset --hard
> +and apply the stash on your desired branch:
> +	git stash apply $stash_sha1
> +at any time.')" &&
> +		echo "Applied autostash"

That && looks funny.  What does it even mean for die to succeed and
give control back to you for a chance to say "Applied"?

	stash apply || die
	echo applied

would be far more logical.

> +	fi
> +	git gc --auto &&
> +	rm -rf "$state_dir"
> +}

This is somewhat worrysome.  After getting the "oops, we cannot
apply" message, the "$stash_sha1" in the message on the terminal is
the ONLY indication of where the (presumably precious) local change
the user used to have can be recovered from.

You do not "rm -fr $state_dir" in such a case, so perhaps telling
the user the location of that "autostash" file may help her
somewhat.

For that matter, wouldn't it be a lot simpler to put the autostash
ref somewhere in refs/ hierarchy, instead of storing an object name
of the stash that keeps (presumably precious) local change of the
user in a plain-text file that is not at all known by "gc"?

> +
>  run_specific_rebase () {
>  	if [ "$interactive_rebase" = implied ]; then
>  		GIT_EDITOR=:
> @@ -153,8 +173,7 @@ run_specific_rebase () {
>  	ret=$?
>  	if test $ret = 0
>  	then
> -		git gc --auto &&
> -		rm -rf "$state_dir"
> +		apply_autostash
>  	fi
>  	exit $ret
>  }
> @@ -248,6 +267,9 @@ do
>  	--stat)
>  		diffstat=t
>  		;;
> +	--autostash)
> +		autostash=true
> +		;;
>  	-v)
>  		verbose=t
>  		diffstat=t
> @@ -348,7 +370,7 @@ abort)
>  		;;
>  	esac
>  	output git reset --hard $orig_head
> -	rm -r "$state_dir"
> +	apply_autostash
>  	exit
>  	;;
>  edit-todo)
> @@ -487,6 +509,16 @@ case "$#" in
>  	;;
>  esac
>  
> +if test "$autostash" = true && ! require_clean_work_tree --quiet
> +then
> +	stash_sha1=$(git stash create) || die "$(gettext "Cannot autostash")" &&
> +	mkdir -p "$state_dir" &&
> +	echo $stash_sha1 >"$state_dir/autostash" &&
> +	stash_abbrev=$(git rev-parse --short $stash_sha1) &&
> +	echo "$(gettext "Created autostash: $stash_abbrev")" &&
> +	git reset --hard
> +fi
> +
>  require_clean_work_tree "rebase" "$(gettext "Please commit or stash them.")"
>  
>  # Now we are rebasing commits $upstream..$orig_head (or with --root,
