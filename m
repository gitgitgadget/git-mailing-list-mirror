From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 30/51] sort_ref_dir(): do not sort if already sorted
Date: Mon, 12 Dec 2011 15:26:57 -0800
Message-ID: <7vehw9xq4l.fsf@alter.siamese.dyndns.org>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
 <1323668338-1764-31-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Dec 13 01:38:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaGO2-00016R-Lo
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 01:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754603Ab1LMAiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 19:38:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62365 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753592Ab1LMAiU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 19:38:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2775E799D;
	Mon, 12 Dec 2011 19:38:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=Xodu4/wBPNLhKTHFes/8ALJMfYE=; b=UrB340bLvLVmvF9IXI8f
	/QgAwkQivmMhZpTDX6xyga7YUkBWxwQwqfFYh6tZ9YnpwI3Sn1PN4gamWjWIjIgw
	WOq1QnAC1+B6nd/aHKgXFiqyDhTalAd8vUSgxtV/ajYoWrGDViXUFkUSOsAv9jnv
	ic5ApW3Lb0BLSkJuAOTzzck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=JXY8eFXzKYDsslTX0Nl98s79z6M7G2+ukId5CgOTc4Wf7Q
	94LFopHTyhne6D/PAEAmci/Jn5VB87vz2x8B4jkPviyvae6b8EEE/fk0PY8re9Gz
	/YJ7WLv2/NR/CtCtgKJKI6yB6HQ+LHUZKQkpv/9vijF8Gz8XsqoZ15GmMrgew=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D25A799C;
	Mon, 12 Dec 2011 19:38:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 90B1F799B; Mon, 12 Dec 2011
 19:38:19 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C117BFF6-2522-11E1-9BEE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186985>

mhagger@alum.mit.edu writes:

> From: Michael Haggerty <mhagger@alum.mit.edu>
>
> Keep track of how many entries in a ref_dir are already sorted.  In
> sort_ref_dir(), only call qsort() if the dir contains unsorted
> entries.
>
> We could store a binary "sorted" value instead of an integer, but
> storing the number of sorted entries leaves the way open for a couple
> of possible future optimizations:
>
> * In sort_ref_dir(), sort *only* the unsorted entries, then merge them
>   with the sorted entries.  This should be faster if most of the
>   entries are already sorted.
>
> * Teach search_ref_dir() to do a binary search of any sorted entries,
>   and if unsuccessful do a linear search of any unsorted entries.
>   This would avoid the need to sort the list every time that
>   search_ref_dir() is called, and (given some intelligence about how
>   often to sort) could significantly improve the speed in certain
>   hypothetical usage patterns.

The elegance (which I think is the right word for this case as it is both
simple and clever) of the above strategy is not fully appreciated unless
you explain that your plan for "lazily add new entries and keep the
directory unsorted" case is to append them at the end (hence preserving
the property that entries[0..sorted] is always sorted).

If you reword the comment "How many of the entries..." to something like
"entries at 0 up to this index in the array are sorted", you could express
that idea without changing the log message that much, I guess.

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c |   29 ++++++++++++++++++++++++-----
>  1 files changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index ccd2806..ce141ea 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -108,6 +108,10 @@ struct ref_value {
>  
>  struct ref_dir {
>  	int nr, alloc;
> +
> +	/* How many of the entries in this directory are sorted? */
> +	int sorted;
> +
>  	struct ref_entry **entries;
>  };
