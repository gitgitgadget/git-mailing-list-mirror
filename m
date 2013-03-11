From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/23] contrib/subtree: Teach push and pull to use
 .gittrees for defaults
Date: Sun, 10 Mar 2013 20:35:44 -0700
Message-ID: <7vobeqbobz.fsf@alter.siamese.dyndns.org>
References: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
 <1362958891-26941-5-git-send-email-pcampbell@kemitix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, David Greene <greened@obbligato.org>,
	bibendi <bibendi@bk.ru>, "Avery Pennarun" <apenwarr@gmail.com>,
	"Wayne Walter" <wayne@tickzoom.com>
To: Paul Campbell <pcampbell@kemitix.net>
X-From: git-owner@vger.kernel.org Mon Mar 11 04:36:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEtX4-0001Rl-N4
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 04:36:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753753Ab3CKDfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 23:35:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33773 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753697Ab3CKDfr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 23:35:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79B30B418;
	Sun, 10 Mar 2013 23:35:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BbskggHEPidKXwO7znGgkiLBpTc=; b=Va4mBE
	M4z17JjFlycuw0TXuCVzkTHlgm5UX850ZVN53EL7JGTAQHLyDEdU/Hpy4OcdZ5ew
	ztmWWnu7as5ChstLRjPy0LTCBdM77s2KH6e9FafrCDx1jGZhd3cX82vGsaO2Usic
	dQhLuAZUHtVWskD7kT7h+4IxSRt2m5PbMTsWE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WS2cZYzoD53Tu6C+7euA0uHSh4snK4R1
	rR5vAEXyy87J2HAqb81x1c83J+v6CdK+Hholy3cFuxzUJYgccSqBCwy7BQR1C+zQ
	1XIFLESLV5IMJXS0SqiXI95Kkf27iuWLIEy0pwSriLSSPUDcY9Cyv4Ld8kO+5J4D
	KjXJ0wV4svc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E047B416;
	Sun, 10 Mar 2013 23:35:46 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9862B411; Sun, 10 Mar 2013
 23:35:45 -0400 (EDT)
In-Reply-To: <1362958891-26941-5-git-send-email-pcampbell@kemitix.net> (Paul
 Campbell's message of "Sun, 10 Mar 2013 23:41:12 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C2370BFE-89FC-11E2-BCA2-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217851>

> From: bibendi <bibendi@bk.ru>
>
> Look in the config file .gittrees for a default repository and
> refspec or commit when they are not provided on the command line.
>
> Uses the .gittrees config file in a similar way to how git-submodule
> uses the .gitmodules file.

What the patch does can be read from the code, but what benefit
would users get by the extra file?

>  cmd_pull()
>  {
> -	ensure_clean
> -	git fetch "$@" || exit $?
> -	revs=FETCH_HEAD
> -	set -- $revs
> -	cmd_merge "$@"
> +    if [ $# -ne 1 ]; then

Broken indentation?

> +	    die "You must provide <branch>"
> +	fi

It used to allow "git fetch $there" and let the configured
remote.$there.fetch refspec to decide what gets fetched, and also it
used to allow "git fetch $there $that_branch" to explicitly fetch
the named branch.  But this change insists that the user has to give
what gets fetched from the command line and forbids the user from
giving where to fetch from, it seems.  Isn't it a regression?  Why
is it a good idea to forbid such uses that the script used to
accept?

The proposed log message does not explain why it is not a
regression, or why accepting some use patterns that the script used
to allow was a bug that needs to be diagnosed with this new
conditional.

> +	if [ -e "$dir" ]; then
> +	    ensure_clean
> +	    repository=$(git config -f .gittrees subtree.$prefix.url)
> +	    refspec=$1
> +	    git fetch $repository $refspec || exit $?
> +	    echo "git fetch using: " $repository $refspec

Why are these variable references outside the dq pair?
