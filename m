From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 17/33] repack_without_ref(): silence errors for dangling
 packed refs
Date: Mon, 15 Apr 2013 10:39:53 -0700
Message-ID: <7vhaj7vgk6.fsf@alter.siamese.dyndns.org>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
 <1365944088-10588-18-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 15 19:40:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URnNp-0006MS-2i
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 19:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934152Ab3DORj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 13:39:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49689 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932679Ab3DORj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 13:39:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B123A15CCC;
	Mon, 15 Apr 2013 17:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=4Fkh6v+V7ccgrMzbUsQfq6HyYrQ=; b=YckVGQ8563jwhHh5ETTG
	xebTkH+fl2zDPmnRyMcyPlyD6d/UOgmu94lSfA67X0UK+Sm+SUfqnJLT3PIluqGe
	0gM1NzViBsfGa2yq+WCCvJmMy3Ece2Gvb6Lp7yRQAUXvl+MOHs/hlBUuPoIjIIzR
	pn8KNCI/1ClaKsKY3OgD8Xk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=HOiXJb10lrzXHgEPznhE71q4Dn9y1QbMUUAQDqFxlFX2m6
	r1jWx/xNEKetp1AOm/hg073iPTjiDK2JdVFx3FLo1atDkt7yaqk/4In3RCc0yBOq
	hQn36tdfBLsTnwExW9dKfGOe0/gr/OSEaH1NIVwkMlASj0B3bd8bdWGFF2jz4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A42D515CCB;
	Mon, 15 Apr 2013 17:39:55 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A2FD15CC7; Mon, 15 Apr
 2013 17:39:54 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7BFF20D2-A5F3-11E2-8E05-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221265>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Stop emitting an error message for dangling packed references found
> when deleting another packed reference.  See the previous commit for a
> longer explanation of the issue.
>
> Change repack_without_ref_fn() to silently ignore dangling packed
> references.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Somehow this feels as if it is sweeping the problem under the rug.

If you ignore a ref for which a loose ref exists when you update a
packed refs file, whether the stale "packed" one points at an object
that is still there or an object that has been garbage collected,
you would not even have to check if the "ref" resolves to object or
anything like that, no?

Am I missing something?

This one feels iffy in the otherwise pleasant-to-read series.

> ---
>  refs.c               | 17 ++++++++++-------
>  t/t3210-pack-refs.sh |  2 +-
>  2 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 51f68d3..eadbc2a 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -531,15 +531,17 @@ static void sort_ref_dir(struct ref_dir *dir)
>  
>  /*
>   * Return true iff the reference described by entry can be resolved to
> - * an object in the database.  Emit a warning if the referred-to
> - * object does not exist.
> + * an object in the database.  If report_errors is true, emit a
> + * warning if the referred-to object does not exist.
>   */
> -static int ref_resolves_to_object(struct ref_entry *entry)
> +static int ref_resolves_to_object(struct ref_entry *entry, int report_errors)
>  {
>  	if (entry->flag & REF_ISBROKEN)
>  		return 0;
>  	if (!has_sha1_file(entry->u.value.sha1)) {
> -		error("%s does not point to a valid object!", entry->name);
> +		if (report_errors)
> +			error("%s does not point to a valid object!",
> +			      entry->name);
>  		return 0;
>  	}
>  	return 1;
> @@ -578,7 +580,7 @@ static int do_one_ref(struct ref_entry *entry, void *cb_data)
>  		return 0;
>  
>  	if (!((data->flags & DO_FOR_EACH_INCLUDE_BROKEN) ||
> -	      ref_resolves_to_object(entry)))
> +	      ref_resolves_to_object(entry, 1)))
>  		return 0;
>  
>  	current_ref = entry;
> @@ -1897,8 +1899,9 @@ static int repack_without_ref_fn(struct ref_entry *entry, void *cb_data)
>  
>  	if (!strcmp(data->refname, entry->name))
>  		return 0;
> -	if (!ref_resolves_to_object(entry))
> -		return 0; /* Skip broken refs */
> +	/* Silently skip broken refs: */
> +	if (!ref_resolves_to_object(entry, 0))
> +		return 0;
>  	len = snprintf(line, sizeof(line), "%s %s\n",
>  		       sha1_to_hex(entry->u.value.sha1), entry->name);
>  	/* this should not happen but just being defensive */
> diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
> index c032d88..559f602 100755
> --- a/t/t3210-pack-refs.sh
> +++ b/t/t3210-pack-refs.sh
> @@ -142,7 +142,7 @@ test_expect_success 'delete ref with dangling packed version' '
>  	test_cmp /dev/null result
>  '
>  
> -test_expect_failure 'delete ref while another dangling packed ref' '
> +test_expect_success 'delete ref while another dangling packed ref' '
>  	git branch lamb &&
>  	git commit --allow-empty -m "future garbage" &&
>  	git pack-refs --all &&
