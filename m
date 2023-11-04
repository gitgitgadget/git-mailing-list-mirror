Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472667FF
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 01:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tsKh0XC6"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AFED54
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 18:19:21 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3675C1B99F5;
	Fri,  3 Nov 2023 21:19:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=is6irX7XUwnmnHVSYFK7MDdFmWVhEkF9qgIWFX
	VQYLk=; b=tsKh0XC6fyOBl97Ppwm5vl24PzPr4/JYOWQGHveQrkB9G/VP0//Lux
	rgC9tBo4/co73d4G9AZ+zL6dpAGdsQWnliN1+l8LnAd2TVgSGscGmhCKXt+kFl9a
	6HODMlYosJ2TF6llepMI/5V1HQa+J7RIHkqLsFUPA+5KvshJ1ETeg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 14F291B99F3;
	Fri,  3 Nov 2023 21:19:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5DD501B99F2;
	Fri,  3 Nov 2023 21:19:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org,  newren@gmail.com
Subject: Re: [PATCH 1/2] rebase: support non-interactive autosquash
In-Reply-To: <20231103212958.18472-1-andy.koppe@gmail.com> (Andy Koppe's
	message of "Fri, 3 Nov 2023 21:29:57 +0000")
References: <20231103212958.18472-1-andy.koppe@gmail.com>
Date: Sat, 04 Nov 2023 10:19:17 +0900
Message-ID: <xmqqil6iiacq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2D11B2A8-7AB0-11EE-9572-25B3960A682E-77302942!pb-smtp2.pobox.com

Andy Koppe <andy.koppe@gmail.com> writes:

>  rebase.autoSquash::
> -	If set to true enable `--autosquash` option by default.
> +	When set to 'interactive' or 'true', enable the `--autosquash` option
> +	for interactive rebase. When set to 'always', enable it for
> +	non-interactive rebase as well. Defaults to 'false'.

I think a better and more extensible way to coax the new feature
into the configuration system is to arrange it more like so:

    false	  - synonym for "".
    true	  - synonym for "interactive".
    anything else - comman separated list of rebase methods, e.g.,
		    "interactive,noninteractive"

		    possible rebase method names might include other
		    stuff like "apply" or "merge", but I haven't
		    thought it through, so take this part with a
		    grain of salt.

That way, the Boolean versions can be considered historical spelling
of a more general system where you can exactly tell when autosquash
takes place.  When we add to a new variant on top of 'interactive'
and 'non-interactive' variants the current rebase has, we do not
know if it makes sense to allow it to also handle autosquash without
knowing how that new variant's behavior appears to the end user, so
'always' that blindly enables autosquash for any unforseen future
variants of 'rebase' is probably not what you want.
