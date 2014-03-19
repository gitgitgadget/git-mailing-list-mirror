From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-lib.sh: use printf instead of echo
Date: Wed, 19 Mar 2014 10:17:54 -0700
Message-ID: <xmqqfvme5cql.fsf@gitster.dls.corp.google.com>
References: <20140314235735.GA6959@ibr.ch> <20140315001855.GK15625@google.com>
	<xmqq61nceidp.fsf@gitster.dls.corp.google.com>
	<20140318221844.GA828@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe Storbeck <uwe@ibr.ch>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 18:18:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQK8D-0005Zo-Ls
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 18:18:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759386AbaCSRSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 13:18:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40919 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751277AbaCSRR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 13:17:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BDEA74304;
	Wed, 19 Mar 2014 13:17:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=revfiCLdWPfHJOChtLFU33bp7KU=; b=gEDZYq
	4QFtQWgTKZBkxetPmfseem4YyMqk7o5BPDc4VAQDVXI4+SFzLFwkTNOPBYLzXx2X
	GvUj2puX12iF/+aESVEBHAnmfLCuSiPxjrQugQImlQkr756XGP85RhHzKAfESDN1
	V7TIBNgDCFSnKL5Z0Gh6QZ94e8VsMs0OccedY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eLES8cuj33DeWtaON4yVd5fbUpkLHUeD
	/a6rAQgtpiXtgCcfsOALUnXM8DiuKOld/O6D6fqIYuk83EUycciu8tosMyTogf2j
	CeGr5Uy0SFsgBcPOAbRjpRa/h1DqqJIbV+rmx6er2fZRg7cqqQFl0F1+56tesWVj
	99+0kpFASc0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBCFB74303;
	Wed, 19 Mar 2014 13:17:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B083742FF;
	Wed, 19 Mar 2014 13:17:57 -0400 (EDT)
In-Reply-To: <20140318221844.GA828@google.com> (Jonathan Nieder's message of
	"Tue, 18 Mar 2014 15:18:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6A1CD246-AF8A-11E3-BB6F-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244461>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>>> Uwe Storbeck wrote:
>
>>>> +	printf '%s\n' "$@" | sed -e 's/^/#	/'
>>
>> This is wrong, isn't it?  Why do we want one line per item here?
>
> Yes, Hannes caught the same, too.  Sorry for the sloppiness.
>
> We currently use "echo" all over the place (e.g., 'echo "$path"' in
> git-sh-setup), and every time we fix it there is a chance of making
> mistakes.  I wonder if it would make sense to add a helper to make the
> echo calls easier to replace:

I agree that we would benefit from having a helper to print a single
line, which we very often do, without having to worry about the
boilerplate '%s\n' of printf or the portability gotcha of echo.

I am a bit reluctant to name the helper "sane_echo" to declare "echo
that interprets backslashes in the string is insane", though.  For
these "print a single line" uses, we are only interested in using a
subset of the features offered by 'echo', but that does not mean the
other features we do not want to trigger in our use is of no use to
any sane person.  It very different from "sane_unset" that works
around "unset" on an unset variable that can trigger an error when
nobody sane is interested in that error condition.  If somebody is
interested if a variable is not yet set and behave differently,
there are more direct ways to see the "set-ness" of a variable, and
asking "unset" for that information is insane, hence I think the
name "sane_unset" is justified.  I do not feel the same way for
"sane_echo".

I would have called it "say" if the name weren't taken.

> -- >8 --
> Subject: git-sh-setup: introduce sane_echo helper
>
> Using 'echo' with arguments that might contain backslashes or "-e" or
> "-n" can produce confusing results that vary from platform to platform
> (e.g., dash always interprets \ escape sequences and echoes "-e"
> verbatim, whereas bash does not interpret \ escapes unless "-e" is
> passed as an argument to echo and suppresses the "-e" from its
> output).
>
> Instead, we should use printf, which is more predictable:
>
> 	printf '%s\n' "$foo"; # Just prints $foo, on all platforms.
>
> Blindly replacing echo with "printf '%s\n'" would not be good enough
> because that printf prints each argument on its own line.  Provide a
> sane_echo helper that prints its arguments, space-delimited, on a
> single line, to make this easier to remember, and tweak 'say'
> and 'die_with_status' to illustrate how it is used.
>
> No functional change intended.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  git-sh-setup.sh | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git i/git-sh-setup.sh w/git-sh-setup.sh
> index 256c89a..f35b5b9 100644
> --- i/git-sh-setup.sh
> +++ w/git-sh-setup.sh
> @@ -43,6 +43,10 @@ git_broken_path_fix () {
>  
>  # @@BROKEN_PATH_FIX@@
>  
> +sane_echo () {
> +	printf '%s\n' "$*"
> +}
> +
>  die () {
>  	die_with_status 1 "$@"
>  }
> @@ -50,7 +54,7 @@ die () {
>  die_with_status () {
>  	status=$1
>  	shift
> -	printf >&2 '%s\n' "$*"
> +	sane_echo >&2 "$*"
>  	exit "$status"
>  }
>  
> @@ -59,7 +63,7 @@ GIT_QUIET=
>  say () {
>  	if test -z "$GIT_QUIET"
>  	then
> -		printf '%s\n' "$*"
> +		sane_echo "$*"
>  	fi
>  }
>  
