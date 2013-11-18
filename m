From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 6/6] for-each-ref: avoid color leakage
Date: Mon, 18 Nov 2013 13:55:16 -0800
Message-ID: <xmqqwqk59xyz.fsf@gitster.dls.corp.google.com>
References: <1384796353-18701-1-git-send-email-artagnon@gmail.com>
	<1384796353-18701-7-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 18 22:55:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViWn2-000841-S6
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 22:55:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798Ab3KRVzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 16:55:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39114 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751771Ab3KRVzT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 16:55:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F8465140A;
	Mon, 18 Nov 2013 16:55:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TTHeONIK6RGmzrLJIYBEque6kIs=; b=Qh2oXU
	yOgDqmdezxct5EuDD8n6KegRgXx5INY657MhPKtTTfHV5y907ma4Lo5gHCcSX3U7
	vTDrC9Dkui32lXltcaXFlzvQUEfMBOqmx2TghCrlrvcC7xkU76P/Z0atR3IMnoDW
	rUnApAIaFGQqH6rxLXPFxpndnR5iCDP/gM5UI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tb/MmnrtrWp4vl1g9vwTs6mBwmsZRndM
	4YHunGC+xtcSdfufL8tpx1WPxK3VbAMQLeiw8KhmoMHyouSvKRcrNQcWJWACZ4Eo
	LnVNkg80+V0t9URXdFvseUqx3WyVBryyMAaDdXfxQdQaa97GmYr3bfIdfwYvQbRd
	nWxh9erceAU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EE2451408;
	Mon, 18 Nov 2013 16:55:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7997D51407;
	Mon, 18 Nov 2013 16:55:18 -0500 (EST)
In-Reply-To: <1384796353-18701-7-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Mon, 18 Nov 2013 23:09:13 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1D214A3C-509C-11E3-9C7C-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238017>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> To make sure that an invocation like the following doesn't leak color,
>
>   $ git for-each-ref --format='%(subject)%(color:green)'
>
> auto-reset at the end of the format string when the last color token
> seen in the format string isn't a color-reset.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  builtin/for-each-ref.c  | 29 +++++++++++++++++++++++++----
>  t/t6300-for-each-ref.sh |  2 +-
>  2 files changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 2ff4e54..04e35ba 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -23,6 +23,7 @@ typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
>  struct atom_value {
>  	const char *s;
>  	unsigned long ul; /* used for sorting when not FIELD_STR */
> +	int color : 2; /* 1 indicates color, 2 indicates color-reset */
>  };

Hmph.  It looks wasteful to have this information in atom_value.

Isn't a new single bit in "struct refinfo" all you need to keep
track of, to see the last %(color:something) you ever saw is for a
color that is not reset?
