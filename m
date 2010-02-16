From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] bugfix: git diff --quiet -w never returns with exit
 status 1
Date: Mon, 15 Feb 2010 21:42:44 -0800
Message-ID: <7v3a11ivmz.fsf@alter.siamese.dyndns.org>
References: <1266293446-8092-1-git-send-email-larry@elder-gods.org>
 <1266293446-8092-2-git-send-email-larry@elder-gods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Tue Feb 16 06:43:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhGDD-0001iO-F9
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 06:43:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547Ab0BPFnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 00:43:00 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45203 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab0BPFm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 00:42:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B60029AB0C;
	Tue, 16 Feb 2010 00:42:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6ffISTj4opKHge1iaGcSNIYOBMU=; b=QLcJau
	jvISJ2neVSz1ponw98Mo8F0oCU5cmHnv/JjRDCJLDh/F9oLx5ZnPShBXJWNwMwfi
	TPZIc+xuZkGF3EjXA+73vn+FD6l2oBfkqVTYoLkohzJCDpBoi8CJ2jNFEPqwiCZ0
	5SoDj7rj6TiMTgPc1DmZZTDfb6IvgF4PSVNKc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mZd44rm174Mtjuy+bPXmtBrpwxSN5g4S
	HN8ogutLn6LPYZ8NDKFUiZGta8bJYgAcUrzoDLGtzzk3zMwEHNPldii7iXHn+vaW
	4DHdvcboGaDMWLG6rvRBTXupYy8S6PhDgLV8jjkxF/iPRb+zpGm8jKzu2Bc8EzmG
	VgbSJfu+akI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E2099AB0B;
	Tue, 16 Feb 2010 00:42:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F8449AB0A; Tue, 16 Feb
 2010 00:42:51 -0500 (EST)
In-Reply-To: <1266293446-8092-2-git-send-email-larry@elder-gods.org> (Larry
 D'Anna's message of "Mon\, 15 Feb 2010 23\:10\:46 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2113FED6-1ABE-11DF-A6B1-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140068>

Larry D'Anna <larry@elder-gods.org> writes:

> Rationale: diff_flush_patch expects to write its output to options->file.
> Adding a "silence" flag to diff_flush_patch and everything it calls would be
> more invasive.

I would agree that the logic to redirect the output to nowhere may be the
easiest way out, but because the reason anybody sane would want to give -q
is to say "I don't care what the actual changes are, but I want to know if
there is any real quick" (otherwise the call would be "diff -w >/dev/null"),
shouldn't we at least be exiting the loop early when we see any difference?

> Signed-off-by: Larry D'Anna <larry@elder-gods.org>
> ---
>  diff.c |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 68def6c..ff00816 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3522,6 +3522,26 @@ void diff_flush(struct diff_options *options)
>  		separator++;
>  	}
>  
> +	if (output_format & DIFF_FORMAT_NO_OUTPUT &&
> +	    DIFF_OPT_TST(options, EXIT_WITH_STATUS) &&
> +	    DIFF_OPT_TST(options, DIFF_FROM_CONTENTS)) {
> +		/* run diff_flush_patch for the exit status */
> +		/* setting options->file to /dev/null should be safe, becaue we
> +		   aren't supposed to produce any output anyways */

Style?

> +		static FILE *devnull = NULL;

Would this cause one file descriptor to leak?  Do we care?

> +		if(!devnull) {

Style?	if (!devnull)

> +			devnull = fopen("/dev/null", "w");
> +			if (!devnull)
> +				die_errno("Could not open /dev/null");
> +		}
> +		options->file = devnull;

Would this cause the original "options->file" leak?  Do we care?

> +		for (i = 0; i < q->nr; i++) {
> +			struct diff_filepair *p = q->queue[i];
> +			if (check_pair_status(p))
> +				diff_flush_patch(p, options);
> +		}
> +	}
> +
>  	if (output_format & DIFF_FORMAT_PATCH) {
>  		if (separator) {
>  			putc(options->line_termination, options->file);
> -- 
> 1.7.0.rc2.40.g7d8aa
