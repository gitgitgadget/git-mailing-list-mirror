From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] merge-file: let conflict markers match end-of-line style of the context
Date: Tue, 26 Jan 2016 13:14:41 -0800
Message-ID: <xmqqsi1kavr2.fsf@gitster.mtv.corp.google.com>
References: <cover.1453709205.git.johannes.schindelin@gmx.de>
	<cover.1453819314.git.johannes.schindelin@gmx.de>
	<13379804ad901b53d78d741156677664924fc50d.1453819314.git.johannes.schindelin@gmx.de>
	<xmqqoac8ci8o.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
	Jeff King <peff@peff.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 26 22:14:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOAwr-0004IU-RT
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 22:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753675AbcAZVOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 16:14:45 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57223 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753670AbcAZVOn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 16:14:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0CBD8408A3;
	Tue, 26 Jan 2016 16:14:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QZcyR942qSqPrlgwpt8eDYl67kc=; b=xBoy3Q
	97ZFOjRax6WejZLEgTnzVub05qWUUHzAo2aGuYKyU73Cvz5k23zeCIPEZmpe4WEw
	1RU2rh5H9uKxOpthyNmns4KfdPhGXrW+AbCPrblAwdwysrWiDSH5FI1Www/6oy++
	bdouAhuzLfxYDPWP5AVfy9LGO0NB2kI/OO+jw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GItSJlUk4ftQILMOkWWy3OZJCGdRiBqt
	yRJGbMtDNFkl6N1XLdhc4RjfwEoioBFTaE0GCx/G/tDfogS7zRzmemZ1RcgrGIqp
	Z4xhDJbJ+NA5qONlxmf6IFZ2L5lYSSwFdjJj3ADYrGgozPwN54MkgbqZcJYTmVua
	fnuCUmLmSUI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 03126408A2;
	Tue, 26 Jan 2016 16:14:43 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 63C884089F;
	Tue, 26 Jan 2016 16:14:42 -0500 (EST)
In-Reply-To: <xmqqoac8ci8o.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 26 Jan 2016 10:23:35 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D1355748-C471-11E5-BD35-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284856>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>> +static int is_cr_needed(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m)
>> +{
>> +	int needs_cr;
>> +
>> +	/* Match post-images' preceding, or first, lines' end-of-line style */
>> +	needs_cr = is_eol_crlf(&xe1->xdf2, m->i1 ? m->i1 - 1 : 0);
>> +	if (needs_cr)
>> +		needs_cr = is_eol_crlf(&xe2->xdf2, m->i2 ? m->i2 - 1 : 0);
>> +	/* Look at pre-image's first line, unless we already settled on LF */
>> +	if (needs_cr)
>> +		needs_cr = is_eol_crlf(&xe1->xdf1, 0);
>> +	/* If still undecided, use LF-only */
>> +	return needs_cr < 0 ? 0 : needs_cr;
>> +}
>
> Retrying with other images when needs_cr is either -1 (unknown) or 1
> (known to be true) was tricky; I had to read it twice and think
> about it for 30 seconds before convincing myself that the code does
> what the log message specifies it should.
>
> That is probably because I was thinking in terms of "do we know that
> we need to add a CR?"; if I read "needs_cr" in my head as "we might
> want to add a CR", everything becomes much more clear, but perhaps
> it is just me.
>
> The return value of this function is definitely "do we need and want
> to add a CR", and it is appropriately named.
>
> Thanks.

Just in case it was unclear, none of the comment above means I want
any part of the patch redone--I am happy with this patch as-is.
