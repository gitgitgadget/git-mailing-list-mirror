From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/3] git: submodule honor -c credential.* from command line
Date: Mon, 29 Feb 2016 10:20:54 -0800
Message-ID: <xmqqmvqjcr95.fsf@gitster.mtv.corp.google.com>
References: <1456532000-22971-1-git-send-email-jacob.e.keller@intel.com>
	<1456532000-22971-4-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 19:21:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaSRK-00016t-94
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 19:21:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344AbcB2SU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 13:20:58 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60032 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753329AbcB2SU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 13:20:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 227FC48F88;
	Mon, 29 Feb 2016 13:20:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+FTHYLNRi+t/YyFGtklPYxBxve0=; b=UMgkMq
	L9mGBdfCx32rv8/1vDTZZzFI1hOS2CvGGjF3u8HZEhUsnZpYiVtZCPNf6XVyRnKW
	oyY8/wMyL87i4hNbNer192pBa0lb9/JBDG6TEEXJxCAUJi18r4h9/eao+OtTfc9M
	TaiDt83n+Juk2S3iTHaAj+XS7kXDwRkOIPw7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vr/qMJwz/qCXFrORKBkTjBgLMv/zz88v
	2Vxamm3hnTRpQ0bIcNoLTGaq/MNsbAfTaFOAZh01tN4UGucWpQDtUMamq9zNvhNz
	wiREA5blESyViyDpDk0aGJHhYTL1VSOvy2Cl6XnZ+WtEWlzyL1Ck4te9Eg0AycD3
	Z5Y2xZSJn1w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1A23648F87;
	Mon, 29 Feb 2016 13:20:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 793E148F86;
	Mon, 29 Feb 2016 13:20:55 -0500 (EST)
In-Reply-To: <1456532000-22971-4-git-send-email-jacob.e.keller@intel.com>
	(Jacob Keller's message of "Fri, 26 Feb 2016 16:13:20 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2C5379F2-DF11-11E5-893D-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287855>

Jacob Keller <jacob.e.keller@intel.com> writes:

> +static int sanitize_submodule_config(const char *var, const char *value, void *data)
> +{
> +	struct strbuf quoted = STRBUF_INIT;
> +	struct strbuf *out = data;
> +
> +	if (submodule_config_ok(var)) {
> +		if (out->len)
> +			strbuf_addch(out, ' ');
> +
> +		sq_quotef(out, "%s=%s", var, value);

Can a configuration variable that comes from the original command
line be a boolean true that is spelled without "=true", i.e. can
value be NULL here?

> +	}
> +
> +	strbuf_release(&quoted);
> +
> +	return 0;
> +}
> +
> +static void prepare_submodule_repo_env(struct argv_array *out)
> +{
> +	const char * const *var;
> +
> +	for (var = local_repo_env; *var; var++) {
> +		if (!strcmp(*var, CONFIG_DATA_ENVIRONMENT)) {
> +			struct strbuf sanitized_config = STRBUF_INIT;
> +			git_config_from_parameters(sanitize_submodule_config,
> +						   &sanitized_config);
> +			argv_array_pushf(out, "%s=%s", *var, sanitized_config.buf);
> +			strbuf_release(&sanitized_config);
