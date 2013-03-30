From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in "git rev-parse --verify"
Date: Fri, 29 Mar 2013 21:09:05 -0700
Message-ID: <7vk3opr0ke.fsf@alter.siamese.dyndns.org>
References: <51543FDB.9010109@alum.mit.edu>
 <CAPc5daUqzz=9TBmj2Q0MHqEc6gMHxXoGr9+JV3hq76zDKJAyCw@mail.gmail.com>
 <515462FB.9040605@alum.mit.edu> <20130328153808.GB3337@sigill.intra.peff.net>
 <7vli97v558.fsf@alter.siamese.dyndns.org> <51565F96.1020203@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <junio@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Mar 30 05:09:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULn6z-0006Bc-Rg
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 05:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814Ab3C3EJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Mar 2013 00:09:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35651 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707Ab3C3EJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Mar 2013 00:09:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39D7DFE4A;
	Sat, 30 Mar 2013 04:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YD8wLq8E0dkdxQRovqvahSuVrzQ=; b=pev6jd
	Fn9/qdDM7HWzhBH1bZt4He4kW4P14qDu19dSfUHYLZiwCoK/wO7dv6gVK5uY2GFt
	Zb4+POLr6PoAxzpXCakG/2z+hBPsUkl+ek1Zgdk5TLG4Paf/I6wAP++yjK7QC+w8
	maqB7cvMevDrmsZO5T9e7Dtsrnx6sIlZ8dj3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C8Zez6+E5pME32OCEqyoWqqpDiJZ4+3E
	2Dpd/iyqhEwJ5I7wE1goMUMnp4BAL8WbUr4npmy703VtXqOZeVCoajOwbU2doUiC
	sGwYcG7jC1UnOmHHMU3qDtL4mhrICtxND9lzyXDYP8PGw7oit04bpXpr9bg/a0cA
	pqOEqMNviIA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E1F4FE49;
	Sat, 30 Mar 2013 04:09:08 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 864F8FE47; Sat, 30 Mar 2013
 04:09:07 +0000 (UTC)
In-Reply-To: <51565F96.1020203@alum.mit.edu> (Michael Haggerty's message of
 "Sat, 30 Mar 2013 04:44:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9139BF22-98EF-11E2-B152-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219553>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> 1. An SHA1 is a canonical representation of the argument, useful for
> example as the key in a hash map for for looking for the presence of a
> commit in a rev-list output.
>
> 2. An SHA1 is persistent.  For example, I use them when caching
> benchmark results across versions.  Moreover, they are safe for use in
> filenames.  The persistence also makes scripts more robust against
> simultaneous changes to the repo by other processes, whereas if I use a
> string like "branch^" multiple times, there is no guarantee that it
> always refers to the same commit.

These two are half-irrelevant; they only call for use of the current
"rev-parse --verify" that always gives you 40-hex.  The more
important one is the next one.

> 3. Verifying arguments at one spot centralizes error-checking at the
> start of a script and eliminates one reason for random git commands to
> fail later (when error recovery is perhaps more difficult).

Not necessarily, unless your script is a very narrow corner case
that is satisfied with "any kind of object goes".  When a parameter
has to be commit for some purpose and another parameter can be any
tree-ish, you would want to validate them _with_ type requirement.

If you are using the "object name persistency" to create a cache of
"how many times the word 'gogopuff' appears in the entire tree?",
you want to cache the result keyed with the object name of the tree,
whether your user gives you v1.8.0 (tag), v1.8.0^0 (commit), or
v1.8.0^{tree} (tree), and you want to unwrap the user input down to
tree object name to look up the pre-computed result for the cache to
be any useful.

> 4. Converting once avoids the overhead of repeated conversion from a
> free-form committish into an object name if the argument needs to be
> passed to multiple git commands (though presumably the overhead is
> insignificant in most cases).

True.

So why not verify arguments while making sure of their type early
with 'rev-parse --verify "$userinput^{desiredtype}"?
