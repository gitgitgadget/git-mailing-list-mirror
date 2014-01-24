From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/9] cherry-pick, revert: add the --gpg-sign option
Date: Fri, 24 Jan 2014 13:00:06 -0800
Message-ID: <xmqqiot9qend.fsf@gitster.dls.corp.google.com>
References: <1390524666-51274-1-git-send-email-sandals@crustytoothpaste.net>
	<1390524666-51274-2-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Vigier <boklm@mars-attacks.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Fri Jan 24 22:00:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6nrQ-0003zw-II
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 22:00:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371AbaAXVAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 16:00:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40057 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752104AbaAXVAO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 16:00:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 224EB642D3;
	Fri, 24 Jan 2014 16:00:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v+eu6KfYRWFU+49MW2DL4OZIiw8=; b=YCuGqG
	3SFcgF1B92xRrJnr6ppg5Eg06sHp+DWA+gQhNjTj+7O+for7oUObw0WIMbTwPOfa
	MW0vq3nMoAmMLYH03uX4XHNu53n40VfHdNhfYs55bFcs2A8MEhYuKfUCh3WyALhy
	GhL1C61j68qwda34gfk7rMH8doj4Hp7LKb7Rs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ALrzjWMA3XjqHEenTHtekVpUnLicAgdt
	/+qwYzmA65rk89+OBWet0vEAt3TMVMr/P1RxQTvPTVoLS7/rRZOUji4qOSC5hoGb
	AJxp+V0NqzjN3LA6untM3iutS5LpV1+kVzXzbpMq4cup8buoPNT6yjfWrOeImlAW
	v3eimiZ+r6U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C798C642CF;
	Fri, 24 Jan 2014 16:00:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F5FD642BF;
	Fri, 24 Jan 2014 16:00:09 -0500 (EST)
In-Reply-To: <1390524666-51274-2-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Fri, 24 Jan 2014 00:50:58 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 82589EC8-853A-11E3-B66A-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241039>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> +-S[<keyid>]::
> +--gpg-sign[=<keyid>]::
> +	GPG-sign commits.
> +

Does this accept --no-gpg-sign?  If not, shouldn't it?

> diff --git a/sequencer.c b/sequencer.c
> index 90cac7b..bde5f04 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -392,11 +392,18 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
>  {
>  	struct argv_array array;
>  	int rc;
> +	char *gpg_sign;
>  
>  	argv_array_init(&array);
>  	argv_array_push(&array, "commit");
>  	argv_array_push(&array, "-n");
>  
> +	if (opts->gpg_sign) {
> +		gpg_sign = xmalloc(3 + strlen(opts->gpg_sign));
> +		sprintf(gpg_sign, "-S%s", opts->gpg_sign);
> +		argv_array_push(&array, gpg_sign);
> +		free(gpg_sign);
> +	}

Here you would need to invent a new way to propagate --no-gpg-sign
to subsequent invocations, I think.
