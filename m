From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/3] teach --histogram to diff
Date: Tue, 12 Jul 2011 12:56:08 -0700
Message-ID: <7vy6036zon.fsf@alter.siamese.dyndns.org>
References: <1310451027-15148-1-git-send-email-rctay89@gmail.com>
 <1310451027-15148-2-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 21:56:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qgj45-0001hE-HE
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 21:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755142Ab1GLT4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 15:56:12 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51397 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754887Ab1GLT4M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 15:56:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F369457BC;
	Tue, 12 Jul 2011 15:56:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bz7783s6MqcWk+0oU6vSfEmgsOM=; b=O0oUEj
	pzn4FplsBcWc0W1IpO+ytRXZrgxY8TZwmc+wU7fV0ikEsimnP/wnB0moZHFtBILz
	ebypUMrW1sBxp5OA3gILIdkEfT7mYHvnGNCr5ddnOXdXcPlnRyyWAi7a+mqzgkU+
	LGHBeI4Es7Ypq1SaG8XaowuAcvvyJlm6pCR/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KUQHBbCL4v1E2rrD42ngIfZD9gIpMzAa
	bNx8ZLxEvFfH3HiqzzaUly+XdUkZhTdH1XaJn1Y2DCOdKso4gO6d12Ar+ncb+LlF
	6VKfM4uhVmwpVnUrV9jFZEnT2kWZPtxR1g6EjQ0FWrgTal2LPt8ssCWhDmuoXuh0
	ZSR2ePsdjPM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ECCB157BB;
	Tue, 12 Jul 2011 15:56:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1093C57B9; Tue, 12 Jul 2011
 15:56:09 -0400 (EDT)
In-Reply-To: <1310451027-15148-2-git-send-email-rctay89@gmail.com> (Tay Ray
 Chuan's message of "Tue, 12 Jul 2011 14:10:25 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FD13FC70-ACC0-11E0-AF6D-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176975>

This is just half-a-review (bottom half of the file).

> +static int histogram_diff(xpparam_t const *xpp, xdfenv_t *env,
> +	int line1, int count1, int line2, int count2)
> +{

What does this function return?

> +	struct histindex index;
> +	struct region lcs;
> +	int sz;
> +	int result = -1;
> +
> +	if (count1 <= 0 && count2 <= 0)
> +		return 0;
> +
> +	if (LINE_END(1) >= MAX_PTR)
> +		return -1;
> +
> +	if (!count1) {
> +		while(count2--)
> +			env->xdf2.rchg[line2++ - 1] = 1;
> +		return 0;
> +	} else if (!count2) {
> +		while(count1--)
> +			env->xdf1.rchg[line1++ - 1] = 1;
> +		return 0;
> +	}
> +
> +	memset(&index, 0, sizeof(index));
> +
> +	index.env = env;
> +	index.xpp = xpp;
> +
> +	index.records = NULL;
> +	index.line_map = NULL;
> +	/* in case of early xdl_cha_free() */
> +	index.rcha.head = NULL;
> +
> +	index.table_bits = xdl_hashbits(count1);
> +	sz = index.records_size = 1 << index.table_bits;
> +	sz *= sizeof(struct record *);
> +	if (!(index.records = (struct record **) xdl_malloc(sz)))
> +		goto cleanup;
> +	memset(index.records, 0, sz);
> +
> +	sz = index.line_map_size = count1;
> +	sz *= sizeof(struct record *);
> +	if (!(index.line_map = (struct record **) xdl_malloc(sz)))
> +		goto cleanup;
> +	memset(index.line_map, 0, sz);
> +
> +	sz = index.line_map_size;
> +	sz *= sizeof(unsigned int);
> +	if (!(index.next_ptrs = (unsigned int *) xdl_malloc(sz)))
> +		goto cleanup;
> +	memset(index.next_ptrs, 0, sz);
> +
> +	/* lines / 4 + 1 comes from xprepare.c:xdl_prepare_ctx() */
> +	if (xdl_cha_init(&index.rcha, sizeof(struct record), count1 / 4 + 1) < 0)
> +		goto cleanup;
> +
> +	index.ptr_shift = line1;
> +	index.max_chain_length = 64;
> +
> +	memset(&lcs, 0, sizeof(lcs));
> +	if (find_lcs(&index, &lcs, line1, count1, line2, count2))
> +		result = fall_back_to_classic_diff(&index, line1, count1, line2, count2);
> +	else {
> +		result = 0;
> +		if (lcs.begin1 == 0 && lcs.begin2 == 0) {
> +			int ptr;
> +			for (ptr = 0; ptr < count1; ptr++)
> +				env->xdf1.rchg[line1 + ptr - 1] = 1;
> +			for (ptr = 0; ptr < count2; ptr++)
> +				env->xdf2.rchg[line2 + ptr - 1] = 1;
> +		} else {
> +			result = histogram_diff(xpp, env,
> +				line1, lcs.begin1 - line1,
> +				line2, lcs.begin2 - line2);
> +			result = histogram_diff(xpp, env,
> +				lcs.end1 + 1, LINE_END(1) - lcs.end1,
> +				lcs.end2 + 1, LINE_END(2) - lcs.end2);

The result from the first half before lcs is discarded?

> +			result *= -1;

Again, what does this function (called recursively) return, and what does
flipping the sign of it do?

> +		}
> +	}
> +
> +cleanup:
> +	xdl_free(index.records);
> +	xdl_free(index.line_map);
> +	xdl_free(index.next_ptrs);
> +	xdl_cha_free(&index.rcha);
> +
> +	return result;
> +}
> +
> +int xdl_do_histogram_diff(mmfile_t *file1, mmfile_t *file2,
> +	xpparam_t const *xpp, xdfenv_t *env)
> +{
> +	int line1, line2, count1, count2;
> +
> +	if (xdl_prepare_env(file1, file2, xpp, env) < 0)
> +		return -1;
> +
> +	line1 = line2 = 1;
> +	count1 = env->xdf1.nrec;
> +	count2 = env->xdf2.nrec;
> +
> +	reduce_common_start_end(xpp, env, &line1, &count1, &line2, &count2);

What this does is logically not specific to histogram algorithm but can be
applied to other backends, no? And I vaguely recall that Linus did try
something like this once, found some issues with it when context is set to
non zero, and stopped doing it (sorry, I do not have any more details).

I am not suggesting you to remove this call or hoist the call to one level
up to xdl_do_diff(), but I do have to wonder how much of the performance
improvement you reported is due to this common head/tail reduction.

> +	return histogram_diff(xpp, env, line1, count1, line2, count2);
> +}
