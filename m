From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-lib.sh: do tests for color support after changing HOME
Date: Tue, 06 Jan 2015 11:06:31 -0800
Message-ID: <xmqq8uhfpw3s.fsf@gitster.dls.corp.google.com>
References: <1420484054-15948-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 20:07:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8ZSh-0006bR-A0
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 20:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755463AbbAFTGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 14:06:35 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50599 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752047AbbAFTGe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 14:06:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C60E42CDDB;
	Tue,  6 Jan 2015 14:06:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D/P+TDoD6KleYoRiDW39pTe10CU=; b=bG7T8N
	AC28jdw56/GtESTkg7FN0T0NUri959XEI9hxbf3aGYhtY2ofXus+Mgo5+o4JtSZ6
	RFoNg5rC+PGCnc6RHp0wEFDy97yHbyYAHi25i41B3k0Eg7HvyhxyDTrUjZwHSdER
	6qFhF1hGotix/Q9mTWqcLlYw1h/Cg/1mvokOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NWNhcDlBnzSFza2XrZLaEOwIgmqnUUMZ
	z2oK4kyrfUJSqia2rc735iX47n2DAJ/+TRCWnZVF+lH9t8mffdAMdpP+kXO8D1uZ
	4GH0FRBcvGELaJGXmFNd9WfMPL6JOrCcLnamROEuoVaJQyIMsz4NLlwCA9tm43ul
	18PuZtEMr0I=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BE2FB2CDD9;
	Tue,  6 Jan 2015 14:06:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2F7392CDD8;
	Tue,  6 Jan 2015 14:06:33 -0500 (EST)
In-Reply-To: <1420484054-15948-1-git-send-email-rhansen@bbn.com> (Richard
	Hansen's message of "Mon, 5 Jan 2015 13:54:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 20FED198-95D7-11E4-90EC-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262088>

Richard Hansen <rhansen@bbn.com> writes:

> If ncurses needs ~/.terminfo for the current $TERM, then tput will
> succeed before changing HOME to $TRASH_DIRECTORY but fail afterward.
> Move the tests that determine whether there is color support after
> changing HOME so that color=t is set if and only if tput would succeed
> when say_color() is run.
>
> This disables color support for those that need ~/.terminfo for their
> TERM, but it's better than filling the screen with:
>
>     tput: unknown terminal "custom-terminal-name-here"
>
> An alternative would be to symlink or copy the user's terminfo
> database into $TRASH_DIRECTORY, but this is tricky due to the lack of
> a standard name for the terminfo database (for example, instead of a
> ~/.terminfo directory, NetBSD uses a ~/.terminfo.cdb database file).

Sounds like a very sensible design trade-off.

> +unset color
>  while test "$#" -ne 0
>  do
>  	case "$1" in
> @@ -258,40 +250,6 @@ then
>  	verbose=t
>  fi
>  
> -if test -n "$color"
> ...
> @@ -857,6 +815,52 @@ HOME="$TRASH_DIRECTORY"
>  GNUPGHOME="$HOME/gnupg-home-not-used"
>  export HOME GNUPGHOME
>  
> +# run the tput tests *after* changing HOME (in case ncurses needs
> +# ~/.terminfo for $TERM)
> +test -n "${color+set}" || [ "x$ORIGINAL_TERM" != "xdumb" ] && (

OK, $color used to be boolean between '' (unset included) and 't',
but now we do this after possibly processing the --no-color
argument, so this is guarded slightly differently from the original.

Makes sense.

> +		TERM=$ORIGINAL_TERM &&
> +		export TERM &&
> +		[ -t 1 ] &&
> +		tput bold >/dev/null 2>&1 &&
> +		tput setaf 1 >/dev/null 2>&1 &&
> +		tput sgr0 >/dev/null 2>&1
> +	) &&

Thanks.

This is a tangent but this patch shows 2 places out of the only
three places we use [ ... ] construct (as opposed to a more
traditionalist "test").  Perhaps we may want to fix them with a
follow-up patch?

> +	color=t
> +
> +if test -n "$color"
> +then
> +	say_color () {
> +		(
> +		TERM=$ORIGINAL_TERM
> +		export TERM
> +		case "$1" in
> +		error)
> +			tput bold; tput setaf 1;; # bold red
> +		skip)
> +			tput setaf 4;; # blue
> +		warn)
> +			tput setaf 3;; # brown/yellow
> +		pass)
> +			tput setaf 2;; # green
> +		info)
> +			tput setaf 6;; # cyan
> +		*)
> +			test -n "$quiet" && return;;
> +		esac
> +		shift
> +		printf "%s" "$*"
> +		tput sgr0
> +		echo
> +		)
> +	}
> +else
> +	say_color() {
> +		test -z "$1" && test -n "$quiet" && return
> +		shift
> +		printf "%s\n" "$*"
> +	}
> +fi
> +
>  if test -z "$TEST_NO_CREATE_REPO"
>  then
>  	test_create_repo "$TRASH_DIRECTORY"
