From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 08/15] ref-filter: introduce color_atom_parser()
Date: Tue, 05 Jan 2016 13:06:42 -0800
Message-ID: <xmqqr3hvivml.fsf@gitster.mtv.corp.google.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
	<1451980994-26865-9-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 22:06:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGYoe-0003oE-UO
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 22:06:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698AbcAEVGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 16:06:48 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60824 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753468AbcAEVGo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 16:06:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E09C5382BC;
	Tue,  5 Jan 2016 16:06:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7yGUciBkaBBMTnLYKjiR4jjuiNA=; b=ELOvbU
	DyKJvarDtrtXdhOV6kyEoZ0yXcmKHG5XkMYNLCH8D55Ec24ge3Hjxsd2LhIxgqyQ
	eNhWeiaBsz3tGNH5SUP5ye7VkGV1hRg0xj730iMBD0P01p2ND3xmNmUnsJWoSzF2
	iYljkhL1TLwu1Ehz05rZJRiYFRQIsVyhKxndg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pmow32zl9EJZa4YXdFdxGVn7erVImzNn
	lvwYaV7uyMRhD/XIkEQiay/2eBm/65ez0tx/sByGlRn8vlQMvdYteULMhQFvcqL5
	v0Xe94m+qCcJvW3CGUTfORSCqXTLVpjJtQtsatKrnF1XJS0iWDRvNalO4yR66cXV
	GlnyYzsMWz4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D8814382BB;
	Tue,  5 Jan 2016 16:06:43 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5CE11382BA;
	Tue,  5 Jan 2016 16:06:43 -0500 (EST)
In-Reply-To: <1451980994-26865-9-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Tue, 5 Jan 2016 13:33:07 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 38F75044-B3F0-11E5-8953-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283400>

Karthik Nayak <karthik.188@gmail.com> writes:

> @@ -90,7 +105,7 @@ static struct {
>  	{ "symref" },
>  	{ "flag" },
>  	{ "HEAD" },
> -	{ "color" },
> +	{ "color", FIELD_STR, color_atom_parser },
>  	{ "align" },
>  	{ "end" },
>  };

This is minor, as I do not think anybody sane would say
"for-each-ref --sort=color" and expect anything sensible, but

I think we shouldn't mark these bogus attributes [*1*] as FIELD_STR
(and it is not FIELD_ULONG, either).  Perhaps add a new FIELD_BOGUS
(or some better name to make it clear that this is not a "value"
that belongs to the ref and can be used to sort, e.g. "FAKE") value
and mark them as such?

That would allow us to error out when they are specified as a
sorting criteria.


[Footnote]

*1* Bogus from the point of view of "what are the various attributes
specific to these items that the command is iterating over,
i.e. refs (or the objects at the tips of these refs)", as color,
align, etc. are not attributes per refs.
