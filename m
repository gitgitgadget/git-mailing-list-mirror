From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/6] branch.c: replace `git_config()` with `git_config_get_string()`
Date: Mon, 21 Jul 2014 10:59:21 -0700
Message-ID: <xmqqiomqk2yu.fsf@gitster.dls.corp.google.com>
References: <1405941145-12120-1-git-send-email-tanayabh@gmail.com>
	<1405941145-12120-3-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 19:59:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9Hs6-000814-7B
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 19:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933153AbaGUR7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 13:59:30 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50153 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933022AbaGUR73 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 13:59:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 208272B084;
	Mon, 21 Jul 2014 13:59:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9Vc50yJPea+w10uil4OaRZnH9O4=; b=FkJAlu
	dVJ6407pPZQ5o7N4LhAhLzD1hGppK5V4wH1D9fGyXuMM6OswPw+s5Mu2aYdjmYGZ
	CgoUz9gFvFo25+UIyGe/mGrXoR6kmc18Sv1QF+tA8C84/dFrBzqKrjCd6MnkgcE2
	HVB+Jnv6q6MHq9cVI2ZuNv/eM9T+L2NYYUiHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tRYt8DJuTxZFpbRiHZazYhCKeI+JjiqT
	MJrzjpXTB5y1CemP8psXhnQJ3jCfoy3mg9oTSqj5V0+whrJoUc39wbOIOHaGx/JP
	+0M7VcWRzxrRJaQ6K/+dOin6SxaZ3qcSzzzWqr1rhhiCfrdD1xFuYX3ZD2bLY7Bx
	DxGpv26UKD0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 168082B083;
	Mon, 21 Jul 2014 13:59:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1A56A2B07B;
	Mon, 21 Jul 2014 13:59:23 -0400 (EDT)
In-Reply-To: <1405941145-12120-3-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 21 Jul 2014 04:12:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BF110BF0-1100-11E4-8BE9-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253982>

Tanay Abhra <tanayabh@gmail.com> writes:

> Use `git_config_get_string()` instead of `git_config()` to take advantage of
> the config-set API which provides a cleaner control flow.
>
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
>  branch.c | 24 ++++--------------------
>  1 file changed, 4 insertions(+), 20 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 46e8aa8..827307f 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -140,33 +140,17 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
>  	return 0;
>  }
>  
> -struct branch_desc_cb {
> -	const char *config_name;
> -	const char *value;
> -};
> -
> -static int read_branch_desc_cb(const char *var, const char *value, void *cb)
> -{
> -	struct branch_desc_cb *desc = cb;
> -	if (strcmp(desc->config_name, var))
> -		return 0;
> -	free((char *)desc->value);
> -	return git_config_string(&desc->value, var, value);
> -}
> -
>  int read_branch_desc(struct strbuf *buf, const char *branch_name)
>  {
> -	struct branch_desc_cb cb;
> +	const char *v = NULL;
>  	struct strbuf name = STRBUF_INIT;
>  	strbuf_addf(&name, "branch.%s.description", branch_name);
> -	cb.config_name = name.buf;
> -	cb.value = NULL;
> -	if (git_config(read_branch_desc_cb, &cb) < 0) {
> +	if (git_config_get_string(name.buf, &v)) {
>  		strbuf_release(&name);
>  		return -1;
>  	}
> -	if (cb.value)
> -		strbuf_addstr(buf, cb.value);
> +	strbuf_addstr(buf, v);
> +	free((char*)v);

In this cast, I smell an API mistake to insist an extra constness to
the output parameter of git_config_get_string() in [3/4] of the
previous series.  Unlike the underlying git_config_get_value(),
which lets the caller peek into the internal cached copy, the caller
of git_config_get_string() is given its own copy, and I do not
offhand see a good reason to forbid the caller from modifying it.

>  	strbuf_release(&name);
>  	return 0;
>  }
