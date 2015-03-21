From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/15] read-cache: Improve readability
Date: Fri, 20 Mar 2015 21:19:36 -0700
Message-ID: <xmqqbnjnaso7.fsf@gitster.dls.corp.google.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
	<1426897692-18322-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 05:19:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZAsy-0001Fw-AM
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 05:19:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbbCUETj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2015 00:19:39 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55698 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751582AbbCUETi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 00:19:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1EC0438216;
	Sat, 21 Mar 2015 00:19:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xsweWCaK78sNIqjlswtKFpDGwBI=; b=K4cRJS
	mPyzum8ktj0KZ8hNBYijTpMNu/MHc87gtwxkINb5K6CHlu+tZNEgac5x5qmQ3gc2
	knmZuoTPhJho5kJbVCwOwh9bBjPDpkTqr70zYW3NH3Bj2c2XiI624FHVpgoYS+ky
	sA7GO+fkAFzCrM21tpmBSzvsH1/lS+aeeCWls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qal0095cOHVyn9VN3iMF46Gl25u5gYSf
	re5zNdW5g+gIH9Zq2bA9pvcEvJaTHIVPbvd6XGJvU53HmT8R489R326BLzj0fNfk
	IwPErJULkSaxzn0+9aqN7WrGVFixEa59nXzgUliZKLh1XTAxrfdfLqP6PRIbEcyn
	LOhaULkApUU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 15D2638214;
	Sat, 21 Mar 2015 00:19:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 81B4D38213;
	Sat, 21 Mar 2015 00:19:37 -0400 (EDT)
In-Reply-To: <1426897692-18322-3-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 20 Mar 2015 17:27:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7C8F1282-CF81-11E4-A85B-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266007>

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  read-cache.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index f72ea9f..769897e 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -703,9 +703,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
>  		    !hashcmp(alias->sha1, ce->sha1) &&
>  		    ce->ce_mode == alias->ce_mode);
>  
> -	if (pretend)
> -		;
> -	else if (add_index_entry(istate, ce, add_option))
> +	if (!pretend && add_index_entry(istate, ce, add_option))
>  		return error("unable to add %s to index",path);
>  	if (verbose && !was_same)
>  		printf("add '%s'\n", path);

I have a moderately strong feeling against this change, as the code
was done this way quite deliberately to keep it readable, namely, to
avoid using && to concatenate two boolean expressions that are in
totally different class inside condition part of if/while, where A
is a precondition guard for B (i.e. you cannot evaluate B unless A
holds) and B is called primarily for its side effect.  The problem
is that, once you start liberally doing

	if (A && B && C && D ...)

with booleans with mixed semantics (guards and actions), it will
quickly get harder to tell which one is which.

I could have written it as

	if (!pretend) {
        	if (add_index_entry(...))
			return error(...);
	}

and that would have been just as readable as the original; it
clearly separates the guard (i.e. only do the add-index thing when
we are not pretending) and the operation that is done for the side
effect.

But I find the original tells you "if pretend mode, do *nothing*"
and "otherwise, try add_index_entry() and act on its error" very
clearly.  Of course, I am biased as the original is my code from
38ed1d89 ("git-add -n -u" should not add but just report,
2008-05-21).

FYI, between preference and taste, I'd say this one is much closer
to the latter than the former.

By the way, aren't we leaking ce when we are merely pretending?
