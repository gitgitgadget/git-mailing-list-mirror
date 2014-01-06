From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/17] safe_create_leading_directories(): add explicit "slash" pointer
Date: Mon, 06 Jan 2014 10:32:58 -0800
Message-ID: <xmqqppo5hsf9.fsf@gitster.dls.corp.google.com>
References: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
	<1389015935-21936-4-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jan 06 19:33:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0Ez8-0007aR-UW
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 19:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755370AbaAFSdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 13:33:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45492 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754709AbaAFSdE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 13:33:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 469525F7A5;
	Mon,  6 Jan 2014 13:33:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ymgprn5wGJiZ2ovMZbIlILYrdto=; b=I4YvQ4
	qdTnL52jJv34lK5O/dZiF4yqNpyNjJur8xfok8/hyAmfqJAjrVJ7l2gKEqR+T9Ft
	A4AWiFZiYGGN5ST20E12NLIQ8cUl/9KaUZnaWcwJ4quHLvgJOpaT9XrNJtj6Y1i8
	edkPo2WP66CdtrvHXp58ulZ7hJSSG8BvNsc8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=usdJKt5FYqxO+e3JJDW1QkdS6FQwJGUQ
	e5ub5sJijjbzAA/zR5S7yxp1Qg0XJ9BEaropYUr/jzun27STkrjOSlE2X8Lbfxzd
	RFLf/TkOIwfl/1Bny/INspgPWO42g77mrb6+isL577QQFXSBGhDYx5tixLnRsiWQ
	9hQbN42qQXU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F0C95F7A3;
	Mon,  6 Jan 2014 13:33:03 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0EB915F79A;
	Mon,  6 Jan 2014 13:33:01 -0500 (EST)
In-Reply-To: <1389015935-21936-4-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Mon, 6 Jan 2014 14:45:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F97E59F4-7700-11E3-B971-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240043>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Keep track of the position of the slash character independently of
> "pos", thereby making the purpose of each variable clearer and
> working towards other upcoming changes.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---

This step has an interaction with $gmane/239878 where Windows folks
want it to pay attention to is_dir_sep()---over there, a backslash
could separate directory path components.

AFAIK, the function was meant to be used only on paths we internally
generate, and the paths we internally generate all are slash
separated, so it could be argued that feeding a path, whose path
components are separated by backslashes, that we obtained from the
end user without converting it to the internal form in some
codepaths (e.g. "$there" in "git clone $url $there") are bugs we
acquired over time that need to be fixed, but it is easy enough to
use is_dir_sep() here to work it around, and doing so will
not negatively affect

 1. UNIX-only projects by forbidding use of a byte with backslash in
    it as a path component character (yes, I am imagining using
    Shift-JIS that can use a backslash as the second byte of
    two-byte character in the pathname on UNIX); and

 2. UNIX-and-Windows mixed projects, as you cannot sanely use such a
    pathname with backslash as part of a path component if its tree
    needs to be checked out on Windows.


>  sha1_file.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index cc9957e..197766d 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -111,19 +111,21 @@ int safe_create_leading_directories(char *path)
>  
>  	while (pos) {
>  		struct stat st;
> +		char *slash = strchr(pos, '/');
>  
> -		pos = strchr(pos, '/');
> -		if (!pos)
> +		if (!slash)
>  			break;
> -		while (*++pos == '/')
> -			;
> +		while (*(slash + 1) == '/')
> +			slash++;
> +		pos = slash + 1;
>  		if (!*pos)
>  			break;
> -		*--pos = '\0';
> +
> +		*slash = '\0';
>  		if (!stat(path, &st)) {
>  			/* path exists */
>  			if (!S_ISDIR(st.st_mode)) {
> -				*pos = '/';
> +				*slash = '/';
>  				return -3;
>  			}
>  		} else if (mkdir(path, 0777)) {
> @@ -131,14 +133,14 @@ int safe_create_leading_directories(char *path)
>  			    !stat(path, &st) && S_ISDIR(st.st_mode)) {
>  				; /* somebody created it since we checked */
>  			} else {
> -				*pos = '/';
> +				*slash = '/';
>  				return -1;
>  			}
>  		} else if (adjust_shared_perm(path)) {
> -			*pos = '/';
> +			*slash = '/';
>  			return -2;
>  		}
> -		*pos++ = '/';
> +		*slash = '/';
>  	}
>  	return 0;
>  }
