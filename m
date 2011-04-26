From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] New --dirstat=lines mode, doing dirstat analysis
 based on diffstat
Date: Tue, 26 Apr 2011 09:59:44 -0700
Message-ID: <7vliyxeynz.fsf@alter.siamese.dyndns.org>
References: <BANLkTim9U4cOnV+5=Mp-2g_M6+JOiM5e7A@mail.gmail.com>
 <1303776102-9085-1-git-send-email-johan@herland.net>
 <1303776102-9085-7-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Apr 26 19:00:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QElcM-0003yD-AZ
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 19:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756866Ab1DZQ77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 12:59:59 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56377 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756218Ab1DZQ76 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 12:59:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 85A614EE3;
	Tue, 26 Apr 2011 13:01:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6T0E4OKel9DzJ9GTaWWknQKFG94=; b=ja/+0+
	PfojwEyGRnQt728BKUOSnuGJM+cXUPJnYATp8WcHGVF00EKmwPq+Qr1hd53EMJzR
	7Mrz81ryUvCDg2o7l+busDneMEb13+3ZE85hXV2eWY9pBg/PTFmxA0rMHxtsh/Qr
	Duiq7qbLklQxMFLenml/gumhKIy4qaXjKDBeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VOd++EvUHUGpzoz/pFe/7Co3MNYPeELt
	1fiSP2DJvSE+yCnxVEvhQD6m31qpZHRs7a9XsnPN+gFG8M6d5PPRFUq/W90jqOnW
	Xr2mptTQ3uUUvipwYXwtd5TkJJcjWwva3vWL1TulrrsLj3Gi4A3S+jOmoe8UJz06
	UMu+oGx0WbE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5445A4EE2;
	Tue, 26 Apr 2011 13:01:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0E4694EE1; Tue, 26 Apr 2011
 13:01:47 -0400 (EDT)
In-Reply-To: <1303776102-9085-7-git-send-email-johan@herland.net> (Johan
 Herland's message of "Tue, 26 Apr 2011 02:01:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E1EDE2FC-7026-11E0-9868-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172109>

Johan Herland <johan@herland.net> writes:

> This patch adds an alternative implementation of show_dirstat(), called
> show_dirstat_by_line(), which uses the more expensive diffstat analysis
> (as opposed to show_dirstat()'s own (relatively inexpensive) analysis)
> to derive the numbers from which the --dirstat output is computed.
>
> The alternative implementation is controlled by the new "lines" argument
> to the --dirstat option (or the diff.dirstat config variable).
>
> In linux-2.6.git, running the three different --dirstat modes:
>
>   time git diff v2.6.20..v2.6.30 --dirstat=changes > /dev/null
> vs.
>   time git diff v2.6.20..v2.6.30 --dirstat=lines > /dev/null
> vs.
>   time git diff v2.6.20..v2.6.30 --dirstat=files > /dev/null
>
> yields the following average runtimes on my machine:
>
> - "changes" (default): ~6.0 s
> - "lines":             ~9.6 s
> - "files":             ~0.1 s
>
> So, as expected, there's a considerable performance hit (~60%) by going
> through the full diffstat analysis as compared to the default "changes"
> analysis (obviously, "files" is much faster than both). As such, the
> "lines" mode is probably only useful if you really need the --dirstat
> numbers to be consistent with the numbers returned from the other
> --*stat options.
>
> The patch also includes documentation and tests for the new dirstat mode.

It needs to document and also mention in the proposed commit log message
how binary files are accounted for.

> @@ -1677,6 +1684,48 @@ found_damage:
>  	gather_dirstat(options, &dir, changed, "", 0);
>  }
>  
> +static void show_dirstat_by_line(struct diffstat_t *data, struct diff_options *options)
> +{
> +	int i;
> +	unsigned long changed;
> +	struct dirstat_dir dir;
> +
> +	if (data->nr == 0)
> +		return;
> +
> +	dir.files = NULL;
> +	dir.alloc = 0;
> +	dir.nr = 0;
> +	dir.percent = options->dirstat_percent;
> +	dir.cumulative = DIFF_OPT_TST(options, DIRSTAT_CUMULATIVE);
> +
> +	changed = 0;
> +	for (i = 0; i < data->nr; i++) {
> +		struct diffstat_file *file = data->files[i];
> +		unsigned long damage = file->added + file->deleted;
> +		if (damage && file->is_binary)
> +			/*
> +			 * binary files counts bytes, not lines. Must find some
> +			 * way to normalize binary bytes vs. textual lines.
> +			 * The following heuristic is cheap, but beyond ugly...
> +			 */
> +			damage = damage < 52 ? 1 : damage / 52;

If 52 is just as good as any number around 50-70 range, I would prefer to
see 64, just because I am superstitious and dividing by a power of two
feels nicer.

> +cat <<EOF >expect_diff_dirstat_CC
> +  16.7% changed/
> +  16.7% dst/copy/changed/
> +  16.7% dst/copy/rearranged/
> +  16.7% dst/move/changed/
> +  16.7% dst/move/rearranged/
> +  16.7% rearranged/
> +EOF

I really wish you can come up with a way to express expected results in
much less strict way in the test vector (not limited to the test vectors
for this patch but for the entire series).  The underlying count-damages
(for the purpose of rename detection) implementation may improve over time
and the textual diff generation may too.  Here what we want to preserve is
that these six entries show more-or-less the same amount of contribution,
not precisely 16.666666% each.
