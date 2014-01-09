From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/5] get_sha1: speed up ambiguous 40-hex test
Date: Thu, 09 Jan 2014 10:25:44 -0800
Message-ID: <xmqq61ptau6v.fsf@gitster.dls.corp.google.com>
References: <20140107235631.GA10503@sigill.intra.peff.net>
	<20140107235953.GD10657@sigill.intra.peff.net>
	<52CD7835.2020708@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Brodie Rao <brodie@sf.io>,
	git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jan 09 19:25:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1KIi-0003Uj-PY
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 19:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756516AbaAISZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 13:25:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43332 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754446AbaAISZr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jan 2014 13:25:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33EF061537;
	Thu,  9 Jan 2014 13:25:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2S8zgrFjwPaYQRO4itHvT8GT0QA=; b=LHHinr
	WYhM0uBtUp2iuFkh2qq6uFqWhe4+j8AxMhtrUjtourUwd9/xvPcpmFzShHRmeMoR
	5LnfQExBVRELlqEoCvXnhm7rBa/7jHXYwef4GZdazznJB2QJqIdSgVYmGsLJk7sp
	7skp2woIkUV8f9+TvVCRp18BrsJCEfgFlpBmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ce+hAO6RqQ9pppksA1BXfkXWRCxyTabx
	e4zl+2vos6teg+RQwmWw7VTMVK2w2jGc9NdjuSW1F/0ZPV228prKjDnh+fjjOkV5
	O/SPzgsYA8J87c5n1ptaUxMzerPI5P860Bwc2nLGVlr+E1ZINHm9w/mhhrBqj1OC
	KXIaooFmMkw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 211DB61535;
	Thu,  9 Jan 2014 13:25:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 28A4C61533;
	Thu,  9 Jan 2014 13:25:46 -0500 (EST)
In-Reply-To: <52CD7835.2020708@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 08 Jan 2014 17:09:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 74EA9484-795B-11E3-8C98-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240263>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> It's not only racy WRT other processes.  If the current git process
> would create a new reference, it wouldn't be reflected in the cache.
>
> It's true that the main ref_cache doesn't invalidate itself
> automatically either when a new reference is created, so it's not really
> a fair complaint.  However, as we add places where the cache is
> invalidated, it is easy to overlook this cache that is stuck in static
> variables within a function definition and it is impossible to
> invalidate it.  Might it not be better to attach the cache to the
> ref_cache structure instead, and couple its lifetime to that object?
>
> Alternatively, the cache could be created and managed on the caller
> side, since the caller would know when the cache would have to be
> invalidated.  Also, different callers are likely to have different
> performance characteristics.  It is unlikely that the time to initialize
> the cache will be amortized in most cases; in fact, "rev-list --stdin"
> might be the *only* plausible use case.

True.

> Regarding the overall strategy: you gather all refnames that could be
> confused with an SHA-1 into a sha1_array, then later look up SHA-1s in
> the array to see if they are ambiguous.  This is a very special-case
> optimization for SHA-1s.
>
> I wonder whether another approach would gain almost the same amount of
> performance but be more general.  We could change dwim_ref() (or a
> version of it?) to read its data out of a ref_cache instead of going to
> disk every time.  Then, at the cost of populating the relevant parts of
> the ref_cache once, we would have fast dwim_ref() calls for all strings.

If opendir-readdir to grab only the names (but not values) of many
refs is a lot faster than stat-open-read a handful of dwim-ref
locations for a given name, that optimization might be worthwhile,
but I think that requires an update to read_loose_refs() not to
read_ref_full() and the users of refs API to instead lazily resolve
the refs, no?

If I ask for five names (say 'maint', 'master', 'next', 'pu',
'jch'), the current code will do 5 dwim_ref()s, each of which will
consult 6 locations with resolve_ref_unsafe(), totalling 30 calls to
resolve_ref_unsafe(), each of which in turn is essentially an open
followed by either an return on ENOENT or a read.  So 30 opens and 5
reads in total.

With your lazy ref_cache scheme, instead we would enumerate all the
loose ones in the same 6 directories (e.g. refs/tags/, refs/heads),
so 6 opendir()s with as many readdir()s as I have loose refs, plus
we open-read them in read_loose_refs() called from get_ref_dir()
with the current ref_cache code.  For me, "find .git/refs/heads"
gives 500+ lines of output, which suggests that using the ref_cache
mechanism for dwim_ref() may not be a huge win, unless it is updated
to be extremely lazy, and readdir()s turns out to be extremely less
heavier than open-read.  Also it is unlikely that the cost to
initialize the cache is amortized to be a net win unless we are
dealing with tons of dwim_ref()s.
