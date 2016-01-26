From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] merge-file: let conflict markers match end-of-line style of the context
Date: Tue, 26 Jan 2016 10:23:35 -0800
Message-ID: <xmqqoac8ci8o.fsf@gitster.mtv.corp.google.com>
References: <cover.1453709205.git.johannes.schindelin@gmx.de>
	<cover.1453819314.git.johannes.schindelin@gmx.de>
	<13379804ad901b53d78d741156677664924fc50d.1453819314.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
	Jeff King <peff@peff.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 26 19:23:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO8HH-0005OV-JF
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 19:23:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967300AbcAZSXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 13:23:40 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54927 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965744AbcAZSXi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 13:23:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3A0CC3EFAE;
	Tue, 26 Jan 2016 13:23:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FHFpWILpblhIz3PPbPTKqyQFXg0=; b=MqhTBS
	vkemP5QAVAKk59kuUznlILZkO7FNsTj2Z7LQFr2cXqGoizmcvzoG+ranNxKS8GiL
	coFLmlW/6ya6e8QZkhEyvkczJDNh33wvfs6H6Qd5Ff/4Qg63w0PXv2nMFXMV3s38
	m4PNgrQD4CoeqXA2F9XNHcWr+cfeyKsWQSHr4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eRWmn8ERxqsUAYqqv+FT7gmdx4NdOece
	6UarfA3VV8EXb6+EXEu2fBvb/bEELbkvHba+8gldmgqf2uH3TPRhf4b3YBEnCVD2
	PyCHpKZKiE10a5BI9JKXJp2KXObXw8I6dW5ov9ahW7R0PpN9zlLdtx6+KWbsAkj0
	gcQcHioCb4c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 230F03EFAD;
	Tue, 26 Jan 2016 13:23:37 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7F83D3EFAC;
	Tue, 26 Jan 2016 13:23:36 -0500 (EST)
In-Reply-To: <13379804ad901b53d78d741156677664924fc50d.1453819314.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Tue, 26 Jan 2016 15:42:12 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EA441C50-C459-11E5-866D-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284846>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +static int is_cr_needed(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m)
> +{
> +	int needs_cr;
> +
> +	/* Match post-images' preceding, or first, lines' end-of-line style */
> +	needs_cr = is_eol_crlf(&xe1->xdf2, m->i1 ? m->i1 - 1 : 0);
> +	if (needs_cr)
> +		needs_cr = is_eol_crlf(&xe2->xdf2, m->i2 ? m->i2 - 1 : 0);
> +	/* Look at pre-image's first line, unless we already settled on LF */
> +	if (needs_cr)
> +		needs_cr = is_eol_crlf(&xe1->xdf1, 0);
> +	/* If still undecided, use LF-only */
> +	return needs_cr < 0 ? 0 : needs_cr;
> +}

Retrying with other images when needs_cr is either -1 (unknown) or 1
(known to be true) was tricky; I had to read it twice and think
about it for 30 seconds before convincing myself that the code does
what the log message specifies it should.

That is probably because I was thinking in terms of "do we know that
we need to add a CR?"; if I read "needs_cr" in my head as "we might
want to add a CR", everything becomes much more clear, but perhaps
it is just me.

The return value of this function is definitely "do we need and want
to add a CR", and it is appropriately named.

Thanks.
