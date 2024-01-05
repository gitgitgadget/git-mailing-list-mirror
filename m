Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0882E833
	for <git@vger.kernel.org>; Fri,  5 Jan 2024 16:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Tw2IWPGF"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 533BE26467;
	Fri,  5 Jan 2024 11:13:10 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Tg53dcBGd5wRDweZZ4P2pJ75WnMpurG+7j/TGJ
	tiQ0Q=; b=Tw2IWPGF4NRWKRgI/UUGxtaZq6puDyrogFKXyl6nSPvESs00XjWOSr
	k8YC9RKEnICQBtmojuD9c87V4Qt57V5AOHUnGBzJNMF11vAe5cTY0Wih5XhqFJbU
	pHpCKitkMRYqzmta/3XGGzi6xdgf/rgUpkeM3NJ8FcGU9KkOsYpMc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4AA2F26466;
	Fri,  5 Jan 2024 11:13:10 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D3ACC26464;
	Fri,  5 Jan 2024 11:13:06 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Tamino Bauknecht <dev@tb6.eu>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] fetch: add cli option --default-only
In-Reply-To: <20240104222259.15659-2-dev@tb6.eu> (Tamino Bauknecht's message
	of "Thu, 4 Jan 2024 23:22:10 +0100")
References: <cc74dc58-4fbe-470d-a212-4c2d2249918c@tb6.eu>
	<20240104222259.15659-1-dev@tb6.eu>
	<20240104222259.15659-2-dev@tb6.eu>
Date: Fri, 05 Jan 2024 08:13:05 -0800
Message-ID: <xmqqa5pjpxm6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4FBEB8D0-ABE5-11EE-9EC7-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Tamino Bauknecht <dev@tb6.eu> writes:

> This option can be used to restore the default behavior of "git fetch"
> if the "fetch.all" config option is enabled.
> The flag cannot be used in combination with "--all" or explicit
> remote(s).

There is "--all" option that can be used to alter the behaviour of
the command.  This is OPT_BOOL(), and if you have

    [alias] f = fetch --all

you can say "git f --no-all" to countermand it from the command
line, as it is equivalent to "git fetch --all --no-all" and the last
one wins.

If you add "fetch.all" that makes the command behave as if it was
given "--all" from the command line even when the user didn't,
passing "--no-all" would be a lot more natural way to countermand
it, no?

"git fetch" (no parameters) are omitting two kinds of stuff, i.e.,
where we fetch from (repository) and what we are fetching from there
(refspec).  You created a need to override the configured fetch
source (aka fetch.all), and in order to countermand it, one way is
to tell the command to "fetch from the default repository", but for
that, an option that does not say "repository" anywhere is closing
door for future evolution of the command.  What if the next person
(which could be you) invented a way to say what refspec to be used
without specifying it from the command line, and needs to say "no,
no, no, do not use the configured value, but just use the default"?
In other words, "--default" will be met by a reaction "default of
which one???".

Compared to that, I would think "--[no-]all" would be a lot simpler
to understand.

The best part is that you do not have to add a new option.  Just
make sure the one specified from the command line, either --all
or --no-all, will cause the command to ignore the configured
fetch.all and you do not need to add anything new to the UI.


