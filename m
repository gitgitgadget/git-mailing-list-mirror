From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] diff: Introduce --diff-algorithm command line
 option
Date: Mon, 14 Jan 2013 13:06:39 -0800
Message-ID: <7vvcaz8of4.fsf@alter.siamese.dyndns.org>
References: <cover.1358193364.git.mprivozn@redhat.com>
 <1b9015bb45f2ece54dae7baee3cbcdc54b9c7ee9.1358193364.git.mprivozn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, trast@student.ethz.ch
To: Michal Privoznik <mprivozn@redhat.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 22:07:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TurFG-0001fM-OD
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 22:07:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757962Ab3ANVGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 16:06:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61377 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757048Ab3ANVGl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 16:06:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48F80B3D6;
	Mon, 14 Jan 2013 16:06:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=LVsHoygq449iFv8lkd8U9gS7zYk=; b=hzqmUS3SFG3DcYWjXXg3
	x/X1iP51KGyIGbaQSvfB6+vmN+9NZH0UZB1rigEAG+S34b1PpuKSmFu630qfAIYC
	/F762GtA5/0qJGSt0laicCZyDESINTpB+meI19dzXTDKnXp37co/1h1vgSfe2Sog
	hHIc8IKjUSsT6rRXMMA93Lg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=VSeRctdD+6uwoWaFBbXFLzIkySJ/tEizZNchu1qDvzojsM
	HLIn40QXf9ZdME+x2gGyFL+CKfKHPAtBWErvGSkA0YYWBUBmH+0sfBbenp0xAfkX
	bmzLX0zIjJi+J8Tsr93a3JdJkONq2wmLVsaAoPv2Uy9Yom5hX4FM3ZABf5jOY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D532B3D5;
	Mon, 14 Jan 2013 16:06:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8EB28B3D4; Mon, 14 Jan 2013
 16:06:40 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4AAF9F86-5E8E-11E2-9A90-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213531>

Michal Privoznik <mprivozn@redhat.com> writes:

> +--diff-algorithm={patience|minimal|histogram|myers}::
> +	Choose a diff algorithm. The variants are as follows:
> ++
> +--
> +`myers`;;
> +	The basic greedy diff algorithm.
> +`minimal`;;
> +	Spend extra time to make sure the smallest possible diff is
> +	produced.
> +`patience`;;
> +	Use "patience diff" algorithm when generating patches.
> +`histogram`;;
> +	This algorithm extends the patience algorithm to "support
> +	low-occurrence common elements".
> +--
> ++
> +For instance, if you configured diff.algorithm variable to a
> +non-default value and want to use the default one, then you
> +have to use `--diff-algorithm=myers` option.
> +
> +You should prefer this option over the `--minimal`, `--patience` and
> +`--histogram` which are kept just for backwards compatibility.

Much better; I'd drop the last paragraph, though.

I also think we really should consider "default" synonym for
whichever happens to be the built-in default (currently myers).

> diff --git a/diff.c b/diff.c
> index e9a7e4d..3e021d5 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -144,7 +144,7 @@ static int git_config_rename(const char *var, const char *value)
>  	return git_config_bool(var,value) ? DIFF_DETECT_RENAME : 0;
>  }
>  
> -static long parse_algorithm_value(const char *value)
> +long parse_algorithm_value(const char *value)
>  {
>  	if (!value || !strcasecmp(value, "myers"))
>  		return 0;
> @@ -3633,6 +3633,16 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
>  		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
>  	else if (!strcmp(arg, "--histogram"))
>  		options->xdl_opts = DIFF_WITH_ALG(options, HISTOGRAM_DIFF);
> +	else if (!prefixcmp(arg, "--diff-algorithm=")) {
> +		long value = parse_algorithm_value(arg+17);
> +		if (value < 0)
> +			return error("option diff-algorithm accepts \"myers\", "
> +				     "\"minimal\", \"patience\" and \"histogram\"");
> +		/* clear out previous settings */
> +		DIFF_XDL_CLR(options, NEED_MINIMAL);
> +		options->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
> +		options->xdl_opts |= value;

This makes me wonder if other places that use DIFF_WITH_ALG() also
need to worry about clearing NEED_MINIMAL?
