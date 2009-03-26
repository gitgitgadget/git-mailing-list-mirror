From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/10] rev-list: call new "filter_skip" function
Date: Wed, 25 Mar 2009 23:49:11 -0700
Message-ID: <7v8wmssrrs.fsf@gitster.siamese.dyndns.org>
References: <20090326055549.e1f244d9.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Mar 26 07:50:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmjQT-0000aq-Ep
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 07:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbZCZGtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 02:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbZCZGtX
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 02:49:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645AbZCZGtW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 02:49:22 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0769EA5F65;
	Thu, 26 Mar 2009 02:49:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 361C3A5F64; Thu,
 26 Mar 2009 02:49:12 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3AEBDC04-19D2-11DE-82AF-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114740>

Christian Couder <chriscool@tuxfamily.org> writes:

> This patch implements a new "filter_skip" function in C in
> "bisect.c" that will later replace the existing implementation in
> shell in "git-bisect.sh".
>
> An array is used to store the skipped commits. But the array is
> not yet fed anything.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  bisect.c           |   65 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  bisect.h           |    6 ++++-
>  builtin-rev-list.c |   30 ++++++++++++++++++++----
>  3 files changed, 95 insertions(+), 6 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index 27def7d..39189f2 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -4,6 +4,11 @@
>  #include "revision.h"
>  #include "bisect.h"
>  
> +
> +static unsigned char (*skipped_sha1)[20];
> +static int skipped_sha1_nr;
> +static int skipped_sha1_alloc;
> +
>  /* bits #0-15 in revision.h */
>  
>  #define COUNTED		(1u<<16)
> @@ -386,3 +391,63 @@ struct commit_list *find_bisection(struct commit_list *list,
>  	return best;
>  }
>  
> +static int skipcmp(const void *a, const void *b)
> +{
> +	return hashcmp(a, b);
> +}

I've learned to suspect without reading a qsort() callback that does not
derefence its arguments.  Is this doing the right thing?

> +
> +static void prepare_skipped(void)
> +{
> +	qsort(skipped_sha1, skipped_sha1_nr, sizeof(*skipped_sha1), skipcmp);
> +}
> +
> +static int lookup_skipped(unsigned char *sha1)
> +{
> +	int lo, hi;
> +	lo = 0;
> +	hi = skipped_sha1_nr;
> +	while (lo < hi) {
> +		int mi = (lo + hi) / 2;
> +		int cmp = hashcmp(sha1, skipped_sha1[mi]);
> +		if (!cmp)
> +			return mi;
> +		if (cmp < 0)
> +			hi = mi;
> +		else
> +			lo = mi + 1;
> +	}
> +	return -lo - 1;
> +}
