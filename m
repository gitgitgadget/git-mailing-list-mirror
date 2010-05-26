From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6 rebase-version] diff.c: Output the text graph padding
 before each diff line.
Date: Tue, 25 May 2010 22:07:33 -0700
Message-ID: <7v7hmrqmi2.fsf@alter.siamese.dyndns.org>
References: <1274778154-29976-1-git-send-email-struggleyb.nku@gmail.com>
 <1274778154-29976-2-git-send-email-struggleyb.nku@gmail.com>
 <1274778154-29976-3-git-send-email-struggleyb.nku@gmail.com>
 <1274778154-29976-4-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, peff@peff.net
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 26 07:07:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH8qP-0005XB-UP
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 07:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933007Ab0EZFHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 01:07:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48049 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932536Ab0EZFHo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 01:07:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E2235B67C5;
	Wed, 26 May 2010 01:07:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=mPsSdKlvdpsqujkjeocKaqE20nk=; b=xBGSx/Va5byE6T1SXrsGOSI
	eIUAEjstJrOXWJB5UYZPuzAyZWGjqFvjzVhkB3/JdeSxpGjNjBmFrlmldiaQSf2V
	2I+pUmxBVYUU0k2aeVA6jq7y/O18lkjDQjOcL0Byo29o4V7pgJgm0bon7PcN8Mx/
	++LGVk4axyagQ9cHqQLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=HHI7BtVrlhQ9YJbEeELbhkWnwCd/NmiqGaeZbAY5NDh0IQ3Om
	S6k9vr8sw5iOVmjqir0D2Gpn37Ldg38lX7+shP0Z0tRqoyQMwRSwafGWi5MTOiM+
	0HVOKZrYKfKEimxCAh7oXv3oGc+hmUl1NV2No6F4bqw0vRcmUV2oTFnfJs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E231B67C1;
	Wed, 26 May 2010 01:07:39 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5234B67BD; Wed, 26 May
 2010 01:07:34 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9B606E0E-6884-11DF-99ED-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147741>

Bo Yang <struggleyb.nku@gmail.com> writes:

> Change -p/--dirstat/--binary/--numstat/--stat/--shortstat/
> --check/--summary to align with graph paddings.
> Thanks Jeff King <peff@peff.net> for reporting the '--summary' bug and his
> initial patch.
>
> Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
> ---
>  diff.c |  201 +++++++++++++++++++++++++++++++++++++++++++++++-----------------
>  1 files changed, 148 insertions(+), 53 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index e2f910a..b99a56c 100644
> --- a/diff.c
> +++ b/diff.c
> ...
> @@ -1289,10 +1329,20 @@ struct dirstat_dir {
>  	int alloc, nr, percent, cumulative;
>  };
>  
> -static long gather_dirstat(FILE *file, struct dirstat_dir *dir, unsigned long changed, const char *base, int baselen)
> +static long gather_dirstat(struct diff_options *opt, struct dirstat_dir *dir,
> +		unsigned long changed, const char *base, int baselen)
>  {
>  	unsigned long this_dir = 0;
>  	unsigned int sources = 0;
> +	assert(opt);
> +	FILE *file = opt->file;
> +	const char *line_prefix = "";
> +	struct strbuf *msg = NULL;

Yikes.  Do we really need that assert?  Also "FILE *file" is used
only once and it would be easier to read without an extra variable.
Besides, this introduces decl-after-statement error.

Other than that the series looked clean.  Oh, please drop the final "."
from all of your "Subject:"s.

Thanks.
