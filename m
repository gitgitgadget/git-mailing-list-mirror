From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] Fix memory leak in apply_patch in apply.c.
Date: Sat, 03 Mar 2012 13:51:51 -0800
Message-ID: <7v7gz173pk.fsf@alter.siamese.dyndns.org>
References: <cover.1330740964.git.jaredhance@gmail.com>
 <cover.1330785363.git.jaredhance@gmail.com>
 <e631bb2059c800f9d49eed51cfa5ba4d04106a2e.1330785363.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 22:52:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3wsN-0002e5-Vc
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 22:52:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641Ab2CCVvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 16:51:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59977 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753360Ab2CCVvy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 16:51:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FB1B7CE3;
	Sat,  3 Mar 2012 16:51:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bA2sC1y0Edvzsnv5NcaRhoTYZps=; b=fPiWmk
	xiINPf0m+nu8e6DNNxNd93uI90L/NustseNP3dzQfWOmoFr9cum9pcDfKXvt9Utu
	ct+WPs+eT03wKCLTHBM7bPtaToNpUmEQeX9YATEB9om146dQIOOjLWeACGq/ekCV
	v/FOD06x5GwRF+GbISy2m/Mitljp+MWQRXWKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x2z5Y5zO1P9qN5NX+uqQMPM6NQEIG/TS
	5LIufrFccLIPn0wZpB7zl1J1edF56ux+6zi8Z/o35ZoNCOYsh1SV+N5TK+jibyMt
	T7Scs3uV2lf1rRWIdeiHjb3kC5p4BLMPa8//ECp4sFkWksBGjrbIk4e4W5LzqbnL
	yhbWBlkwLiA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 879E27CE2;
	Sat,  3 Mar 2012 16:51:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF48C7CE0; Sat,  3 Mar 2012
 16:51:52 -0500 (EST)
In-Reply-To: <e631bb2059c800f9d49eed51cfa5ba4d04106a2e.1330785363.git.jaredhance@gmail.com> (Jared Hance's message of "Sat, 3 Mar 2012 09:40:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 166A011A-657B-11E1-B235-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192137>

Jared Hance <jaredhance@gmail.com> writes:

> In addition, the list of fragments should be free'd. To fix this, the
> utility function free_patch has been implemented. It loops over the
> entire patch list, and in each patch, loops over the fragment list,
> freeing the fragments, followed by the patch in the list. It frees both
> patch and patch->next.

Right encapsulation and abstraction. Good.

>
> The main caveat is that the text in a fragment, ie,
> patch->fragments->patch, may or may not need to be free'd. The text is
> dynamically allocated and needs to be freed iff the patch is a binary
> patch, as allocation occurs in inflate_it.

Can't we do better than "is this for a binary patch"?  I find this part
not very forward-thinking implementation that relies on an implementation
detail that happens to hold true for today's code.

At least

        if ((buf.buf <= fragment->patch &&
            (fragment->patch < buf.buf + buf.len))
		; /* this is inside the original buffer */
	else
		free(fragment->patch);

or something?

Strictly speaking, even the above is not forward-thinking enough, as the
code deep in the callchain is free to replace ->patch with an unfreeable
string.  I think the right way to handle this is to add a single bitfield
"should_free" to the struct fragment and default it to 'false', and make
the place that replace the patch field with different string responsible
for flipping the bit to 'true'.  Your "free_patch()" can then rely on that
bit to make the decision.

> Signed-off-by: Jared Hance <jaredhance@gmail.com>
> ---
>  builtin/apply.c |   30 +++++++++++++++++++++++++++---
>  1 files changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 389898f..a73d339 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -196,6 +196,30 @@ struct patch {
>  	struct patch *next;
>  };
>  
> +static void free_patch(struct patch *patch) {
> +    while(patch != NULL) {

Style:

	static void free_patch(struct patch *patch)
	{
		while (patch) {
			...

Thanks.
