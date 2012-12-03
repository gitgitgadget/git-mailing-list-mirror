From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 1/4] submodule: add get_submodule_config helper
 funtion
Date: Mon, 03 Dec 2012 11:30:12 -0800
Message-ID: <7vehj7q6gr.fsf@alter.siamese.dyndns.org>
References: <20121130032719.GE29257@odin.tremily.us>
 <cover.1354417618.git.wking@tremily.us>
 <436a73a8fdc8f0695aa597d53483d4c4bae16ebb.1354417618.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Mon Dec 03 20:30:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tfbiw-0005sq-0p
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 20:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049Ab2LCTaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2012 14:30:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50498 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008Ab2LCTaO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2012 14:30:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5495EA017;
	Mon,  3 Dec 2012 14:30:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=o9oTHii8d0dIqCT46IO2KUoM6cU=; b=M0KkqYik3YcCuh8I19y1
	hPJG2Z048Vhx0pJ+PvbUUMZkY06aKeEhKYNhrv7I4PWMVn2bDrGrHu0WGPIm8MN3
	CQjrbiwiRHWK+Qh1cffqiJkCdIucsL+CkvOGyvja7ChDau12kFE1ZPmuTfFxHyp8
	SVfhhH+uMYWoRDmn6wZWWnU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=PpaKJs9UuBlcDjaUI60eHh+wSD9AIK9ZKbwJeVOzp0rjs7
	AbxJNlf+3E6ynM33a7p+wrNN09LHm61dqh26VTtaTzWJGZRPYBtH9wsW9kcXcK0q
	tFUxezAaPDFhnDe8gLMt96wJhkTuvcs2wXzjypha3mamkK5jWGcDrV0kjLbE0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 403F7A016;
	Mon,  3 Dec 2012 14:30:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B7CFA012; Mon,  3 Dec 2012
 14:30:13 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DC10D420-3D7F-11E2-B63C-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211055>

"W. Trevor King" <wking@tremily.us> writes:

> From: "W. Trevor King" <wking@tremily.us>
>
> Several submodule configuration variables
> (e.g. fetchRecurseSubmodules) are read from .gitmodules with local
> overrides from the usual git config files.  This shell function mimics
> that logic to help initialize configuration variables in
> git-submodule.sh.
>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
>  git-submodule.sh | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index ab6b110..97ce5e4 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -152,6 +152,33 @@ die_if_unmatched ()
>  }
>  
>  #
> +# Print a submodule configuration setting
> +#
> +# $1 = submodule name
> +# $2 = option name
> +# $3 = default value
> +#
> +# Checks in the usual git-config places first (for overrides),
> +# otherwise it falls back on .gitmodules.  This allows you to
> +# distribute project-wide defaults in .gitmodules, while still
> +# customizing individual repositories if necessary.  If the option is
> +# not in .gitmodules either, print a default value.
> +#
> +get_submodule_config()
> +{

style (see CodingGuidelines):

	get_submodule_config ()	{

> +	name="$1"
> +	option="$2"
> +	default="$3"
> +	value=$(git config submodule."$name"."$option")

This will get unwieldy quickly once we have submodule.$name.$var
that takes a boolean option, as there are different ways to spell
boolean and "git config --bool" is the way to ask for canonicalized
"true" or "false".

If we never query any boolean via this helper function, it is
obviously not an issue, though.

> +	if test -z "$value"
> +	then
> +		value=$(git config -f .gitmodules submodule."$name"."$option")
> +	fi
> +	printf '%s' "${value:-$default}"
> +}
> +
> +
> +#
>  # Map submodule path to submodule name
>  #
>  # $1 = path
