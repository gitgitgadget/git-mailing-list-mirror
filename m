From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] config: Introduce diff.algorithm variable
Date: Mon, 14 Jan 2013 13:05:27 -0800
Message-ID: <7v38y3a31k.fsf@alter.siamese.dyndns.org>
References: <cover.1358193364.git.mprivozn@redhat.com>
 <f76708fc2a1dc33f3f9c67688ef5709302b56cbb.1358193364.git.mprivozn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, trast@student.ethz.ch
To: Michal Privoznik <mprivozn@redhat.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 22:05:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TurE7-0000le-Hz
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 22:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757636Ab3ANVFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 16:05:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60224 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756505Ab3ANVFa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 16:05:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C4A8B22C;
	Mon, 14 Jan 2013 16:05:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=lPDQbkytHFcHiNuJAhzQAcNrD3I=; b=GXhb9q3TVXJ+KKpHq83m
	jgMG+E9YXS10tlnghIVF6xcZEFu8/StGMw6epL0z3rRUd3fOZhv04xOlKM7Lu+R9
	v6KYyrgxXM2z4xGPHcWhtfe7CaZQ9zm2PAuwCFvz0iCe5EsQiXflfhG/cb8nwB5x
	il85HiHMIZFId8b8YLGVK5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=eLu45AMW1ngjzzdvoVdVzgQ7KlNZl3o7jk3KCwTq8+m2h6
	+RhKkUh89BvgJ9F88A/2WogCLutIwG2CyAJL2FmzwBaf5XPC1Xuv3DsXpPtNDX2C
	7t/ipx9Kyl5ph0sSEXNFpzUbHu+Kym9V1W+dmjPxU4GwnrYkdpZC+/oenOR4I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90E94B22B;
	Mon, 14 Jan 2013 16:05:29 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E21DFB229; Mon, 14 Jan 2013
 16:05:28 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1FF9836A-5E8E-11E2-85DD-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213530>

Michal Privoznik <mprivozn@redhat.com> writes:

> +static long parse_algorithm_value(const char *value)
> +{
> +	if (!value || !strcasecmp(value, "myers"))
> +		return 0;

[diff]
	algorithm

should probably error out.  Also it is rather unusual to parse the
keyword values case insensitively.

> +	else if (!strcasecmp(value, "minimal"))
> +		return XDF_NEED_MINIMAL;
> +	else if (!strcasecmp(value, "patience"))
> +		return XDF_PATIENCE_DIFF;
> +	else if (!strcasecmp(value, "histogram"))
> +		return XDF_HISTOGRAM_DIFF;
> +	else
> +		return -1;
> +}
> +
>  /*
>   * These are to give UI layer defaults.
>   * The core-level commands such as git-diff-files should
> @@ -196,6 +211,13 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
>  		return 0;
>  	}
>  
> +	if (!strcmp(var, "diff.algorithm")) {
> +		diff_algorithm = parse_algorithm_value(value);
> +		if (diff_algorithm < 0)
> +			return -1;
> +		return 0;
> +	}
> +
>  	if (git_color_config(var, value, cb) < 0)
>  		return -1;
>  
> @@ -3213,6 +3235,7 @@ void diff_setup(struct diff_options *options)
>  	options->add_remove = diff_addremove;
>  	options->use_color = diff_use_color_default;
>  	options->detect_rename = diff_detect_rename_default;
> +	options->xdl_opts |= diff_algorithm;
>  
>  	if (diff_no_prefix) {
>  		options->a_prefix = options->b_prefix = "";
