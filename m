From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 05/17] ref-filter: move get_head_description() from branch.c
Date: Tue, 17 May 2016 12:59:30 -0700
Message-ID: <xmqqtwhwv4kd.fsf@gitster.mtv.corp.google.com>
References: <1463309133-14503-1-git-send-email-Karthik.188@gmail.com>
	<1463309133-14503-6-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 17 21:59:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2l9X-0002Hp-1N
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 21:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbcEQT7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 15:59:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51827 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750790AbcEQT7e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 15:59:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A28F81A577;
	Tue, 17 May 2016 15:59:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TBWPJE/J1aDoYNdXgE4QcXSDW1Q=; b=MSo5/B
	w6IPgknZjbvbdVsbgq28lyfkRpzvaYSmwy2q1hDqkDPKU1ExHa8b2BSm5pqP9MEn
	WTEAqrpcDh/rbHA3NPD3CQYTq83IdcQWrIKUC3S7nhZg4cG6nbuA3qxyOESUBOos
	WIYEYbWKDJDO67qpaSTbz3+DK1SgrA7lfggek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wXu0Yd9CArD8m/RsUOtM6FqYXG1OzUNo
	XHLG7mPzdSAV3pFpMzUi0SigsNnJkDndJSZKyml2em5QKKFRSlUaaPP2V4Q+Lvcv
	QB/kZsO2mU8yoUEo4XfMPYuIRAU0UBxK4Hso+pUVs2/DSE2Vqr/0bVoKcZu6lDIL
	eR+NNY8ldYs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 98E571A576;
	Tue, 17 May 2016 15:59:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 11CCA1A575;
	Tue, 17 May 2016 15:59:32 -0400 (EDT)
In-Reply-To: <1463309133-14503-6-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Sun, 15 May 2016 16:15:21 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DFA84EA2-1C69-11E6-AC59-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294908>

Karthik Nayak <karthik.188@gmail.com> writes:

> diff --git a/builtin/branch.c b/builtin/branch.c
> index 2ecde53..141168d 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -361,39 +361,6 @@ static void add_verbose_info(struct strbuf *out, struct ref_array_item *item,
>  	strbuf_release(&subject);
>  }
>  
> -static char *get_head_description(void)
> -{
> -	struct strbuf desc = STRBUF_INIT;
> -	struct wt_status_state state;
> -	memset(&state, 0, sizeof(state));
> -	wt_status_get_state(&state, 1);
> -	if (state.rebase_in_progress ||
> -	    state.rebase_interactive_in_progress)
> -		strbuf_addf(&desc, _("(no branch, rebasing %s)"),
> -			    state.branch);
> -	else if (state.bisect_in_progress)
> -		strbuf_addf(&desc, _("(no branch, bisect started on %s)"),
> -			    state.branch);
> -	else if (state.detached_from) {
> -		if (state.detached_at)
> -			/* TRANSLATORS: make sure this matches
> -			   "HEAD detached at " in wt-status.c */
> -			strbuf_addf(&desc, _("(HEAD detached at %s)"),
> -				state.detached_from);
> -		else
> -			/* TRANSLATORS: make sure this matches
> -			   "HEAD detached from " in wt-status.c */
> -			strbuf_addf(&desc, _("(HEAD detached from %s)"),
> -				state.detached_from);
> -	}

Note that this expects that va/i18n-misc-updates topic, which
corrects the translator instruction around here, is already applied.

> diff --git a/ref-filter.c b/ref-filter.c
> index 7d3af1c..fcb3353 100644
> ...
> +char *get_head_description(void)
> +{
> +	struct strbuf desc = STRBUF_INIT;
> +	struct wt_status_state state;
> +	memset(&state, 0, sizeof(state));
> +	wt_status_get_state(&state, 1);
> +	if (state.rebase_in_progress ||
> +	    state.rebase_interactive_in_progress)
> +		strbuf_addf(&desc, _("(no branch, rebasing %s)"),
> +			    state.branch);
> +	else if (state.bisect_in_progress)
> +		strbuf_addf(&desc, _("(no branch, bisect started on %s)"),
> +			    state.branch);
> +	else if (state.detached_from) {
> +		/* TRANSLATORS: make sure these match _("HEAD detached at ")
> +		   and _("HEAD detached from ") in wt-status.c */
> +		if (state.detached_at)
> +			strbuf_addf(&desc, _("(HEAD detached at %s)"),
> +				state.detached_from);
> +		else
> +			strbuf_addf(&desc, _("(HEAD detached from %s)"),
> +				state.detached_from);
> +	}

... but the change is apparently lost.

It is a good lesson not to blindly rebase things on 'next', which
would have unrelated changes.  If you needed es/test-gpg-tags topic
for the test script change, check out 'master', merge that single
topic, and then rebase the series on top of the result.
