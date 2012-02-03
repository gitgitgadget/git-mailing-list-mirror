From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/4] completion: simplify __gitcomp*
Date: Fri, 03 Feb 2012 12:23:12 -0800
Message-ID: <7vty37oedr.fsf@alter.siamese.dyndns.org>
References: <1328214625-3576-1-git-send-email-felipe.contreras@gmail.com>
 <1328214625-3576-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 21:23:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtPfE-0001FB-5r
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 21:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756289Ab2BCUXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 15:23:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41807 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754851Ab2BCUXO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 15:23:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DB906D8D;
	Fri,  3 Feb 2012 15:23:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Re5VseEuKgl6rX1V2bjKBs/9FnE=; b=YRNPbcvvzV+mLrrrU0gW
	xxQ+DtgiNYUikkFMAgELSBsqmIel2IO+3r0IQ0pkob50SlXayw3dUUa0SJCF1Q3q
	GiYOg/YHpxV1QUNxT2MXo4nx8yxSHdjwwEnJAxFdxAsjSeOjnuwaS+D1kf1x7Nef
	wLvRGHVVoER0Yb3tlB80GEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Id8fJmrjrapJ2DQGys0zA9aCR4Y2BZMbeq8Iyxv2mo1RKs
	1SzGsdVvOnJDCSRW6e1qvJWR5WgA8Njx/LSPGcYx2KC9wca3ZwNFYuzN3/iKK9rt
	4YsFqCh1Kz/ZtMY8p1PMdIAPhyGEzNjkMjb3S+FYodDnurIExXIWbAW1HXuhs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74A696D8C;
	Fri,  3 Feb 2012 15:23:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 01C706D88; Fri,  3 Feb 2012
 15:23:13 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E61EBC2C-4EA4-11E1-B298-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189798>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> @@ -495,11 +495,7 @@ fi
>  # 4: A suffix to be appended to each possible completion word (optional).
>  __gitcomp ()
>  {
> -	local cur_="$cur"
> -
> -	if [ $# -gt 2 ]; then
> -		cur_="$3"
> -	fi
> +	local cur_="${3:-$cur}"
>  	case "$cur_" in
>  	--*=)
>  		COMPREPLY=()

I think this rewrite is wrong, even though it may not make a difference to
the current callers (I didn't check).  Drop the colon from ${3:-...}.

> @@ -524,18 +520,8 @@ __gitcomp ()
>  #    appended.
>  __gitcomp_nl ()
>  {
> -	local s=$'\n' IFS=' '$'\t'$'\n'
> -	local cur_="$cur" suffix=" "
> -
> -	if [ $# -gt 2 ]; then
> -		cur_="$3"
> -		if [ $# -gt 3 ]; then
> -			suffix="$4"
> -		fi
> -	fi
> -
> -	IFS=$s
> -	COMPREPLY=($(compgen -P "${2-}" -S "$suffix" -W "$1" -- "$cur_"))
> +	local IFS=$'\n'
> +	COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3:-$cur}"))

So is this.

Fixing the above two gives me what I've already sent in $gmane/189683,
so...
