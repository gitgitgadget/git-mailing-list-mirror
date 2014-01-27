From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 8/9] rebase: add the --gpg-sign option
Date: Mon, 27 Jan 2014 15:36:44 -0800
Message-ID: <xmqqha8pm1yr.fsf@gitster.dls.corp.google.com>
References: <1390524666-51274-1-git-send-email-sandals@crustytoothpaste.net>
	<1390524666-51274-9-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Vigier <boklm@mars-attacks.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Jan 28 00:36:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7vjZ-0004bD-HP
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jan 2014 00:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754360AbaA0Xgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jan 2014 18:36:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64463 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754018AbaA0Xgr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 18:36:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4578B67153;
	Mon, 27 Jan 2014 18:36:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mH3Rnr0pc1sJyQ2F9KheyXZLNEk=; b=tjFpGI
	ahLbOFjOTh/wdgdooAevJew8Cp5phBhd++Z89iq1hhiIExJ9sZJ8N9FF7lFDLCmh
	uYTBTSe2TCEhFiQDFUV5ax87GrmdGQXXv07DIkzOjUVW2guyYHi1bUdyuA9yqD9I
	KY+dkG9ZUh7pVw4bCo2PNb6Do+ET8timEHfB8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UtXhmedSp3mjNa5vu4GItDXJsUGXY+cC
	OQ8tRJNR2r406hFmctXhMGwYYLkEnxYHU1ruNlwuwnH+ZK+OQmg2NkFIkzSlxdG/
	kM8I8jvoKwryFR5lrmPpsRYmDRPK7LRc8YA1MgwxVJQelCfn8QQXJb6DSUyWdGdf
	Y4QfWAqLrzk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26ABF67151;
	Mon, 27 Jan 2014 18:36:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6FD5E6714E;
	Mon, 27 Jan 2014 18:36:46 -0500 (EST)
In-Reply-To: <1390524666-51274-9-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Fri, 24 Jan 2014 00:51:05 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E2C08FDC-87AB-11E3-A677-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241168>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 43c19e0..73d32dd 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -181,7 +181,7 @@ exit_with_patch () {
>  	git rev-parse --verify HEAD > "$amend"
>  	warn "You can amend the commit now, with"
>  	warn
> -	warn "	git commit --amend"
> +	warn "	git commit --amend $gpg_sign_opt"

I think this is meant to be cut-&-pasted, so you may have to quote
the RHS of --gpg-sign=<key> (or the key part of -S<key>).

The same comment as the one for 'git pull' patch applies around
'eval's in the remainder of the patch.

> @@ -248,7 +248,8 @@ pick_one () {
>  
>  	test -d "$rewritten" &&
>  		pick_one_preserving_merges "$@" && return
> -	output eval git cherry-pick "$strategy_args" $empty_args $ff "$@"
> +	output eval git cherry-pick ${gpg_sign_opt:+"$gpg_sign_opt"} \
> +			"$strategy_args" $empty_args $ff "$@"
>  }
> [rest snipped]

Thanks.
