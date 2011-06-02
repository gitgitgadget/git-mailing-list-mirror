From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 1/4] Refactor for_each_ref variants to use
 for_each_ref_in and avoid magic numbers
Date: Thu, 02 Jun 2011 13:36:23 -0700
Message-ID: <7vk4d4c6ns.fsf@alter.siamese.dyndns.org>
References: <1306887870-3875-1-git-send-email-jamey@minilop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Jeff King <peff@peff.net>,
	Josh Triplett <josh@joshtriplett.org>
To: Jamey Sharp <jamey@minilop.net>
X-From: git-owner@vger.kernel.org Thu Jun 02 22:36:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSEdM-0002Rr-D3
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 22:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317Ab1FBUgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 16:36:43 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50111 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194Ab1FBUgm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 16:36:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F053A5459;
	Thu,  2 Jun 2011 16:38:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=frAml3pY4pVR1OidqsM6qyM7hyo=; b=PaHjhi
	ukcPV6szEd9zj1IaK+60NoSEPpNmhXbPyCnzKD+qv8hSWm8Uis6Bi0kSyxZafJo/
	YjbLwHGIu0oiD7FJpUtlk+Sup1icn8c1gwMs53vDDdZ61PrQdlwu+J4kBpGmCLMn
	dPpexnBUOdmhbXol06tWZXtdNdstumSB1YcJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WC7k7mmjnaNag0uSp2t90iiFT8T2SWqk
	wvVH85TQIncD00i3Pv1BExE5G8Nj97ah8WUvdckzjf3FRDwId151bcTRw34yGdFG
	8dOfi1l07Yiz3oJCVDT46DtVnAd6MdVAmWuMz0mjYKoKHYMAE6O2I2s0ziwIf1zb
	ug2KMAcv4ro=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7F77C5458;
	Thu,  2 Jun 2011 16:38:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 75B425457; Thu,  2 Jun 2011
 16:38:33 -0400 (EDT)
In-Reply-To: <1306887870-3875-1-git-send-email-jamey@minilop.net> (Jamey
 Sharp's message of "Tue, 31 May 2011 17:24:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4DE0D5AC-8D58-11E0-9464-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174977>

Jamey Sharp <jamey@minilop.net> writes:

> Furthermore, for_each_ref and for_each_ref_submodule passed "refs/" but
> a length of 0, which caused do_for_each_ref to ignore the "refs/".

I had to read, stop, think for two days, until finally get to the point
that I _think_ I understand what you wanted to say.

As we use the same "trim" (meant to say "strip this many bytes from the
beginning of the full refname when calling the callback") to reject refs
outside the area we are interested in with the strncmp() at the beginning
of do_one_ref(), if do_for_each_ref() that is called by for_each_ref() fed
something outside "refs/" hierarchy to the function, the garbage ref that
is not a ref (as it is outside "refs/") will _not_ get filtered, which I
think is what you are trying to say by 'ignore the "refs/"'.

Which is technically a bug (we should be rejecting anything outside
"refs/", even when trim is set to 0) that dates as far back as e1e22e3
(Start handling references internally as a sorted in-memory list,
2006-09-11), but it didn't matter an iota because everything we read from
either loose or packed refs have "refs/" prefix.

Am I following your train of thought correctly so far?

> diff --git a/refs.c b/refs.c
> index e3c0511..60cebe6 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -584,7 +584,7 @@ int read_ref(const char *ref, unsigned char *sha1)
>  static int do_one_ref(const char *base, each_ref_fn fn, int trim,
>  		      int flags, void *cb_data, struct ref_list *entry)
>  {
> -	if (strncmp(base, entry->name, trim))
> +	if (prefixcmp(entry->name, base))
>  		return 0;
>  
>  	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN)) {
> ...
>  int for_each_ref(each_ref_fn fn, void *cb_data)
>  {
> -	return do_for_each_ref(NULL, "refs/", fn, 0, 0, cb_data);
> +	return for_each_ref_in("", fn, cb_data);
>  }

But then this looks like a bad way to fix that issue.  It will be a
non-issue as long as do-for-each-ref will never give anything outside
"refs/", but once that happens (say, a contaminated .git/packed-refs
file), this will show whatever that is outside "refs/", i.e. the issue the
proposed commit log message claims to address, which is "... which caused
do_for_each_ref to ignore", is not fixed here at all.

Shouldn't you be passing prefix and trim the same way as we have always
done, but just fixing the strncmp() at the beginning of do_one_ref()?
