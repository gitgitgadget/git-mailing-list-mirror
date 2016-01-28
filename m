From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 1/2] submodule: port resolve_relative_url from shell to C
Date: Thu, 28 Jan 2016 14:03:11 -0800
Message-ID: <xmqqzivpl5uo.fsf@gitster.mtv.corp.google.com>
References: <xmqqtwm1e0ps.fsf@gitster.mtv.corp.google.com>
	<1453948237-9860-1-git-send-email-sbeller@google.com>
	<1453948237-9860-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, sunshine@sunshineco.com,
	j6t@kdbg.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 23:03:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOuex-000286-NR
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 23:03:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755806AbcA1WDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 17:03:15 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58788 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751769AbcA1WDO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 17:03:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 23A703F5DD;
	Thu, 28 Jan 2016 17:03:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O4vmVWC7rKexvIt6oAGGJrC8y98=; b=AjyeN8
	VZ+Zc/rP0NvmEfPsyBqnkXhI72PzIXVtmscatcFM5tUYTx+lqhhWDDwxEHakd+/d
	1KjMiXgRu/E8eMg5t0O1jXLJaivBh6c8FtbFKdyfLwbH14Da7j6CG+VFXAi57X0G
	8+m7XYBffkB38aV6xhNDDQwJgnr2lSEyW4lAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FD+9LzvGTKitDPAEhj5TduL/Oie8SZOe
	/obXe0N87Q+r+E0fwh53Rd7IhgJ4k8Y4FCcWSWtWQLTRPXHR7jRkexY2t7kB6ABT
	wn6JWCx5UFrOh9hEUVb2BUn7m/gf3ydcPTnz6RQTn67fx+exBl+L4BiUl1k9KsGU
	AVlbweLQdJM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1B5C23F5DB;
	Thu, 28 Jan 2016 17:03:13 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 82AC23F5DA;
	Thu, 28 Jan 2016 17:03:12 -0500 (EST)
In-Reply-To: <1453948237-9860-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 27 Jan 2016 18:30:36 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EC8FB3EA-C60A-11E5-B009-B4986AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285037>

Stefan Beller <sbeller@google.com> writes:

> +static char *relative_url(const char *remote_url,
> +				const char *url,
> +				const char *up_path)
> +{
> +	int is_relative = 0;
> +	int colonsep = 0;
> +	char *out;
> +	char *remoteurl = xstrdup(remote_url);
> +	struct strbuf sb = STRBUF_INIT;
> +	size_t len = strlen(remoteurl);
> +
> +	if (is_dir_sep(remoteurl[len]))
> +		remoteurl[len] = '\0';
> +
> +	if (!url_is_local_not_ssh(remoteurl) || is_absolute_path(remoteurl))
> +		is_relative = 0;
> +	else {
> +		is_relative = 1;
> +		/*
> +		 * Prepend a './' to ensure all relative
> +		 * remoteurls start with './' or '../'
> +		 */
> +		if (!starts_with_dot_slash(remoteurl) &&
> +		    !starts_with_dot_dot_slash(remoteurl)) {
> +			strbuf_reset(&sb);
> +			strbuf_addf(&sb, "./%s", remoteurl);
> +			free(remoteurl);
> +			remoteurl = strbuf_detach(&sb, NULL);
> +		}
> +	}
> +	/*
> +	 * When the url starts with '../', remove that and the
> +	 * last directory in remoteurl.
> +	 */
> +	while (url) {
> +		if (starts_with_dot_dot_slash(url)) {
> +			url += 3;
> +			colonsep |= chop_last_dir(&remoteurl, is_relative);
> +		} else if (starts_with_dot_slash(url))
> +			url += 2;
> +		else
> +			break;
> +	}
> +	strbuf_reset(&sb);
> +	strbuf_addf(&sb, "%s%s%s", remoteurl, colonsep ? ":" : "/", url);
> +
> +	if (starts_with_dot_slash(sb.buf))
> +		out = xstrdup(sb.buf + 2);
> +	else
> +		out = xstrdup(sb.buf);
> +	strbuf_reset(&sb);
> +
> +	free(remoteurl);

This is a rather strange place to put this free(), as you are done
with it a bit earlier, but it's OK.  I briefly wondered if the code
becomes easier to follow with fewer free(remoteurl) if this local
variable is made into a strbuf, but I didn't seriously think it
through.

Otherwise looking good.

Thanks.
