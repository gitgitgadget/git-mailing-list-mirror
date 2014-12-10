From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/18] Provide a function to parse fsck message IDs
Date: Wed, 10 Dec 2014 09:56:19 -0800
Message-ID: <xmqqsignie2k.fsf@gitster.dls.corp.google.com>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
	<e217caa9c30b72004eca9b15be3aa1c6674dc278.1418055173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 10 18:56:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XylUz-0002II-0G
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 18:56:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932719AbaLJR4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 12:56:25 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50909 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932452AbaLJR4X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 12:56:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DFFDF2261F;
	Wed, 10 Dec 2014 12:56:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qPL1XFrDo0nPpGqh/2vWC46+AaQ=; b=Egsb0G
	dpJwb7tc+3Su17cGvzZ6mxcFg+F2AkKba0rM+DhSm96GA1T6gC7DpBp5L8d6FwnM
	4PDLkjSExsyi0Ll7Q2HGqQOsSUkpCHdLbFsJQXx/R1CRpgNQjdDZSX4X9tWFhYFP
	wwYhE6T7wGRR109KC06r5scPotSVIsuTNEqdI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OybCt2DwwN6d2YIf7pnLMmx0EzPK3fSq
	JCMM4fcjUpHBJAnczsjJgwEy2RpqqOZniCTBWu+0Sv/aPfJqnPv8WUgZGgmEuROX
	RhDNVIFXJEscOHy48QTuMoBzXaq6e+BJEwoo1jx7S8QlU5hD2FuYSXWBxBMf8RRv
	scEX0uKg+6Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D513F2261E;
	Wed, 10 Dec 2014 12:56:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5153A2261D;
	Wed, 10 Dec 2014 12:56:20 -0500 (EST)
In-Reply-To: <e217caa9c30b72004eca9b15be3aa1c6674dc278.1418055173.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 8 Dec 2014 17:14:24 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D8CB6036-8095-11E4-B854-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261227>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This function will be used in the next commits to allow the user to
> ask fsck to handle specific problems differently, e.g. demoting certain
> errors to warnings. It has to handle partial strings because we would
> like to be able to parse, say, '--strict=missing-email=warn' command
> lines.
>
> To make the parsing robust, we generate strings from the enum keys, and we
> will match both lower-case, dash-separated values as well as camelCased
> ones (e.g. both "missing-email" and "missingEmail" will match the
> "MISSING_EMAIL" key).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  fsck.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/fsck.c b/fsck.c
> index 3cea034..05b146c 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -63,6 +63,38 @@ enum fsck_msg_id {
>  	FSCK_MSG_MAX
>  };
>  
> +#define STR(x) #x
> +#define MSG_ID_STR(x) STR(x),
> +static const char *msg_id_str[FSCK_MSG_MAX + 1] = {
> +	FOREACH_MSG_ID(MSG_ID_STR)
> +	NULL
> +};

I wondered what the ugly macro was in the previous step, but as a
way to keep these two lists in sync it makes sense.
