From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] convert: add a helper to determine the correct EOL for a given path
Date: Fri, 22 Jan 2016 10:47:58 -0800
Message-ID: <xmqqegd9v4bl.fsf@gitster.mtv.corp.google.com>
References: <cover.1453482052.git.johannes.schindelin@gmx.de>
	<c4e6707b53d82cdeeb16c83bddf9c4870a53d9df.1453482052.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Jan 22 19:48:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMgki-0000PO-2Q
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 19:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754701AbcAVSsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 13:48:04 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63374 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754389AbcAVSsC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 13:48:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 923AB3D627;
	Fri, 22 Jan 2016 13:48:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=20ZF9BwKbxCaCMJfqHKp0lxyM+8=; b=wO7Ptc
	WwgIGg0i5xX9kk7EniTzULgekwFgrMSCqBWCLnBJVNtWavvFX4gZHREdAPg0uSK+
	7KGrufXDTBVXVlTCg4t9luky4ca7ury76l6KSSFGKqsGbUYQXgE8PwjrbwMLTUGk
	J5SEwsNpit+BieZgxvtVSDJn+UKTwOSeROGFg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jnxy9XEvrUS/Iq6+TdCuRKZ+rUmu6ckT
	wipOgDhaif5QaYM1xvU7DOGA+PEVBnNKNWs25sJUZOT4+Z79RTgCzEobaCQ+5u/O
	SFUp7KNc8HrBGnI7b55Om+w0haZgOOzOw9fuEucxRyOp/btjEZ0beoellel3XGJn
	w8z7fcjtZkI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 661723D626;
	Fri, 22 Jan 2016 13:48:00 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CBB793D625;
	Fri, 22 Jan 2016 13:47:59 -0500 (EST)
In-Reply-To: <c4e6707b53d82cdeeb16c83bddf9c4870a53d9df.1453482052.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Fri, 22 Jan 2016 18:01:16 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A8C55C36-C138-11E5-9F26-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284579>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

This change somehow ringed a bell and reminded me of your recent
ls-files stuff.  Are there things that these topics can use from
each other?

These topics are similar in that they add many lines of code as
"helpers" that inspect data and guess what the existing code would
do to the data, without refactoring much existing code whose
behaviour these helpers are guessing/defining to use them, which is
somewhat disturbing, as the behaviour the actual code exhibits and
the guesses the helpers make can easily drift apart.



>  convert.c | 29 +++++++++++++++++++++++++++++
>  convert.h |  2 ++
>  2 files changed, 31 insertions(+)
>
> diff --git a/convert.c b/convert.c
> index 814e814..b458734 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -758,6 +758,35 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
>  	}
>  }
>  
> +enum eol eol_for_path(const char *path, const char *src, size_t len)
> +{
> +	struct conv_attrs ca;
> +	struct text_stat stats;
> +
> +	if (!path) {
> +		memset(&ca, 0, sizeof(ca));
> +		ca.crlf_action = CRLF_AUTO;
> +		ca.eol_attr = EOL_UNSET;
> +	} else {
> +		convert_attrs(&ca, path);
> +		if (ca.eol_attr == EOL_UNSET)
> +			ca.eol_attr = output_eol(ca.crlf_action);
> +		if (ca.eol_attr != EOL_UNSET)
> +			return ca.eol_attr;
> +	}
> +	if (!len || (ca.crlf_action != CRLF_AUTO &&
> +				ca.crlf_action != CRLF_GUESS))
> +		return core_eol;
> +	ca.crlf_action = input_crlf_action(ca.crlf_action, ca.eol_attr);
> +	gather_stats(src, len, &stats);
> +	if (ca.crlf_action == CRLF_GUESS && stats.cr > stats.crlf)
> +		return core_eol;
> +	else if (stats.crlf)
> +		return EOL_CRLF;
> +	else
> +		return EOL_LF;
> +}
> +
>  int would_convert_to_git_filter_fd(const char *path)
>  {
>  	struct conv_attrs ca;
> diff --git a/convert.h b/convert.h
> index d9d853c..1892867 100644
> --- a/convert.h
> +++ b/convert.h
> @@ -33,6 +33,8 @@ enum eol {
>  
>  extern enum eol core_eol;
>  
> +extern enum eol eol_for_path(const char *path, const char *src, size_t len);
> +
>  /* returns 1 if *dst was used */
>  extern int convert_to_git(const char *path, const char *src, size_t len,
>  			  struct strbuf *dst, enum safe_crlf checksafe);
