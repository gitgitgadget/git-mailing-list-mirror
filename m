From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] rev-list: new --cherry-pick=loose option
Date: Mon, 21 Feb 2011 16:16:26 -0800
Message-ID: <7vfwrghqjp.fsf@alter.siamese.dyndns.org>
References: <1298317769-65830-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 01:16:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Prfvm-0002ld-RB
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 01:16:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528Ab1BVAQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 19:16:37 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57458 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322Ab1BVAQh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 19:16:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6720043CD;
	Mon, 21 Feb 2011 19:17:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Oof+0Cj9XzdJVjbe0SSGui3T4Kc=; b=X6m54R
	BfA7XWMDzWIViD/7d9qtL8Xk1E2Ubu2NWUh/HmfvIYEZho0vmudsgbkMQYSz0d3K
	u++uEHst4wXVfBbN/SBvB2ONsnSWcRVlIT43of7OPG6aUjQ1+yasq7ZBfWR/NtMH
	dLCA6pUUjF4Y+WwUXb2sBF4S+4jFL8D+Lhr34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LwQ6taIICTqNDqkTpAA1YhgMoAHNFzy6
	pifa+umqLLJxdNGYuCQx6CjE72jAgbzjXyLErCoEQ/zYagqwbe8lKkua7c/W+6Gb
	x9Pnl7+vjWUq/DqnOlhX9HYxBx2noXZPIIqdV8Mh5+dLHkqa6A8YVjEQWwOK9ZFs
	E7ieRZvfFGc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 458CB43CC;
	Mon, 21 Feb 2011 19:17:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 392C243CA; Mon, 21 Feb 2011
 19:17:39 -0500 (EST)
In-Reply-To: <1298317769-65830-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Mon\, 21 Feb 2011 14\:49\:29 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2AAF4B42-3E19-11E0-A8EF-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167516>

Jay Soffian <jaysoffian@gmail.com> writes:

> Thoughts?

I am personally not very interested in this particular "author, timestamp,
title and nothing else" implementation, as that is probably too loose (in
many projects, title by itself is not descriptive enough) to be safe.
Also people would probably want other loose modes with varying degree
(e.g. throwing in the list of touched paths to your mix might make it a
bit safer), so "loose" feels a bit too broad a word to give to this
particular implementation (iow, it does not say in what way it is loose).

> @@ -65,8 +79,13 @@ static struct patch_id *add_commit(struct commit *commit,
>  	unsigned char sha1[20];
>  	int pos;
>  
> -	if (commit_patch_id(commit, &ids->diffopts, sha1))
> -		return NULL;
> +	if (ids->loose) {
> +		if (commit_patch_id_loose(commit, sha1))
> +			return NULL;
> +	} else {
> +		if (commit_patch_id(commit, &ids->diffopts, sha1))
> +			return NULL;
> +	}

If the purpose of the patch is to stir the discussion, it is fine to have
any crappy "here is a strawman" algorithm as an example of an alternative
patch ID computation, but one thing it _should_ do well is to show where
the necessary change should be hooked into, and I think the above "if"
statement is placed in a wrong function.  If you change commit_patch_id()
to take a pointer to the whole ids instead of just &ids->diffopts, it can
decide how the "commit patch ID" is computed without affecting the
callers, no?

And then we could instead introduce patch-id-algo=<foo>, and instead of
"loose" call this particular algorithm "authorship-subject" or something.
Coming up with a pluggable interface to let the end user compute patch
equivalence might be a plus.

Certain patch equivalence might not be easy to define by "do they hash to
the same small value" but by "here are two patches---compare them and tell
me if they are equivalent".  If we can update the code to support that
kind of patch equivalence it would be great, but it is not within the
reach/scope of this patch (not a complaint, but something you may want to
tackle next).
