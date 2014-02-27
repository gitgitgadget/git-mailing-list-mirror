From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] commit.c: use the generic "sha1_pos" function for lookup
Date: Thu, 27 Feb 2014 11:06:58 -0800
Message-ID: <xmqqppm8z86l.fsf@gitster.dls.corp.google.com>
References: <530E3732.3060708@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
X-From: git-owner@vger.kernel.org Thu Feb 27 20:07:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ6Id-0005rc-Bj
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 20:07:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267AbaB0THE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 14:07:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64277 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752545AbaB0THB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 14:07:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C79A6FA37;
	Thu, 27 Feb 2014 14:07:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=19UYOIdwaRNdg3j0efxYCaz14X4=; b=F7dM8L
	phHlV26Gyl+xb2SB10UED/TVVv2+Tv3DznSyhiF1y2UIXJe1qTpn+w3G8BWaHRu7
	YR6HHcmzVuJU8U0FdeeG6fykNQ4aOU5j1EZUl2ePowUMCD3ZaYboVGSAfoKWHeDM
	fJ76hnZTl9AsPI1zwRJKGnzeXvLMNXoVkKFnk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JKeIShipSdtUFZe4H7NMxkV8eSbdZfI/
	Q/aldk+DEeaXMKVk3pkZ5je0plM6ZOfZfJUmy4fxJVIh+umx05xTGGsrMOy5u+sk
	txl9R+UCviRnnGrVHD7y3xahsYHw1z1E5rqXhrNxZomw6ToC3fnhb0WQfii/5Q+V
	Am2acNdzE7M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0101A6FA36;
	Thu, 27 Feb 2014 14:07:01 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F9456FA34;
	Thu, 27 Feb 2014 14:06:59 -0500 (EST)
In-Reply-To: <530E3732.3060708@yandex.ru> (Dmitry S. Dolzhenko's message of
	"Wed, 26 Feb 2014 22:49:22 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 55B6D6C4-9FE2-11E3-9365-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242838>

"Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru> writes:

> Refactor binary search in "commit_graft_pos" function: use
> generic "sha1_pos" function.
>
> Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
> ---

Looks trivially correct; thanks.

Looking at this patch makes me wonder why we have sha1_pos() and
sha1_entry_pos() helper functions, though.  It feels as if the
former could be written in terms of the latter, but there may be
some performance and correctness downsides if we did so:

 - rewriting sha1_entry_pos() in terms of sha1_pos() would add the
   cost of callback to obtain the keys;

 - sha1_entry_pos() picks the middle location conservatively to
   avoid overshooting penalty, which sha1_pos() does not do;

 - sha1_entry_pos() has been updated recently to tolerate
   duplicates.



>  commit.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index 6bf4fe0..6ceee6a 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -10,6 +10,7 @@
>  #include "mergesort.h"
>  #include "commit-slab.h"
>  #include "prio-queue.h"
> +#include "sha1-lookup.h"
>  
>  static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
>  
> @@ -114,23 +115,16 @@ static unsigned long parse_commit_date(const char *buf, const char *tail)
>  static struct commit_graft **commit_graft;
>  static int commit_graft_alloc, commit_graft_nr;
>  
> +static const unsigned char *commit_graft_sha1_access(size_t index, void *table)
> +{
> +	struct commit_graft **commit_graft_table = table;
> +	return commit_graft_table[index]->sha1;
> +}
> +
>  static int commit_graft_pos(const unsigned char *sha1)
>  {
> -	int lo, hi;
> -	lo = 0;
> -	hi = commit_graft_nr;
> -	while (lo < hi) {
> -		int mi = (lo + hi) / 2;
> -		struct commit_graft *graft = commit_graft[mi];
> -		int cmp = hashcmp(sha1, graft->sha1);
> -		if (!cmp)
> -			return mi;
> -		if (cmp < 0)
> -			hi = mi;
> -		else
> -			lo = mi + 1;
> -	}
> -	return -lo - 1;
> +	return sha1_pos(sha1, commit_graft, commit_graft_nr,
> +			commit_graft_sha1_access);
>  }
>  
>  int register_commit_graft(struct commit_graft *graft, int ignore_dups)
