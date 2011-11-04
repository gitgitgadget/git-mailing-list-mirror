From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-push: don't always prompt for password
Date: Fri, 04 Nov 2011 09:48:17 -0700
Message-ID: <7vlirvdeb2.fsf@alter.siamese.dyndns.org>
References: <7vfwi6jucg.fsf@alter.siamese.dyndns.org>
 <1320390188-24334-1-git-send-email-stefan.naewe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net
To: Stefan Naewe <stefan.naewe@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 04 17:48:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMMwM-00011u-Lp
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 17:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755998Ab1KDQsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 12:48:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44098 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754798Ab1KDQsV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 12:48:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADB52582A;
	Fri,  4 Nov 2011 12:48:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AiiCmuxA2H7sMaxy7t7SvzMEhAs=; b=AoAf8z
	G9KPkSUMRCgbJJtFJYLRB+wYcJj0892It2gwwNAEtmq1N6j8fyI3+r7soCrI9S7t
	BApqqAjK9dwuqjmmrruU1ZzwXC/yxB9bGsZDTc06N4r5aGIj7gb1jQ7KUWsmvSO+
	SNlu5bjYOSCUyWRWn1/j7dBoepNW/cBXr+tGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S+mvwhwu7GYEPpEg2cVp+AyCCXLvr6gR
	zhkPq4YvEV9UZUH11RAnIYQ9gvr//39Ml2xXB7oXO/TAoqfwJpY53lgMIq/Msi3e
	WLnzyK64rgUm+AAKP1dTlbwQJnNgJCy9tBp8Tg6Cn3CetKAQ+PlcagGggEfeBIPo
	7COadCw3gG4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C5785828;
	Fri,  4 Nov 2011 12:48:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB6FC5827; Fri,  4 Nov 2011
 12:48:18 -0400 (EDT)
In-Reply-To: <1320390188-24334-1-git-send-email-stefan.naewe@gmail.com>
 (Stefan Naewe's message of "Fri, 4 Nov 2011 08:03:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CC7BB6AE-0704-11E1-8133-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184786>

Stefan Naewe <stefan.naewe@gmail.com> writes:

> http-push prompts for a password when the URL is set as
> 'https://user@host/repo' even though there is one set
> in ~/.netrc. Pressing ENTER at the password prompt succeeds
> then, but is a annoying and makes it almost useless
> in a shell script, e.g.
>
> Signed-off-by: Stefan Naewe <stefan.naewe@gmail.com>
> ---

Thanks.

With this the only callsite of init_curl_http_auth() becomes the one after
we get the 401 response, and this caller makes sure that user_name is not
NULL.

Do we still want "if (user_name)" inside init_curl_http_auth()?

I tried to rewrite the proposed commit log message to describe the real
issue, and here is what I came up with:

Author: Stefan Naewe <stefan.naewe@gmail.com>
Date:   Fri Nov 4 08:03:08 2011 +0100

    http: don't always prompt for password
    
    When a username is already specified at the beginning of any HTTP
    transaction (e.g. "git push https://user@hosting.example.com/project.git"
    or "git ls-remote https://user@hosting.example.com/project.git"), the code
    interactively asks for a password before calling into the libcurl library.
    It is very likely that the reason why user included the username in the
    URL is because the user knows that it would require authentication to
    access the resource. Asking for the password upfront would save one
    roundtrip to get a 401 response, getting the password and then retrying
    the request. This is a reasonable optimization.
    
    HOWEVER.
    
    This is done even when $HOME/.netrc might have a corresponding entry to
    access the site, or the site does not require authentication to access the
    resource after all. But neither condition can be determined until we call
    into libcurl library (we do not read and parse $HOME/.netrc ourselves). In
    these cases, the user is forced to respond to the password prompt, only to
    give a password that is not used in the HTTP transaction. If the password
    is in $HOME/.netrc, an empty input would later let the libcurl layer to
    pick up the password from there, and if the resource does not require
    authentication, any input would be taken and then discarded without
    getting used. It is wasteful to ask this unused information to the end
    user.
    
    Reduce the confusion by not trying to optimize for this case and always
    incur roundtrip penalty. An alternative might be to document this and keep
    this round-trip optimization as-is.
    
    Signed-off-by: Stefan Naewe <stefan.naewe@gmail.com>
    Helped-by: Jeff King <peff@peff.net>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

What is somewhat troubling is that after analyzing the root cause of the
issue, I am wondering if a more correct fix is to remove the user@ part
from the URL (in other words, document that a URL with an embedded
username will ask for password upfront, and tell the users that if they
have netrc entries or if they are accessing a resource that does not
require authentication, they should omit the username from the URL).
