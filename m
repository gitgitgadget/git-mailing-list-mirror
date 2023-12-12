Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="akZWjyIq"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD1DD0
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 17:43:34 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C84BE2AEE5;
	Mon, 11 Dec 2023 20:43:32 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/j+HS7wMAtisWXh9RUzSaOiCB0QGohf1tzrEcj
	NMj4k=; b=akZWjyIqaPwM6801HzM3ORS8SKg5Anx7L2q/pPLgQhefu+HCSYYsNV
	VW2DB3cSwYpQjqMaXPutdxFAyTys35qkgvsxhkVPv2K9ZBGDX8iOYlqxqWq/smP3
	AmXRbmCxZiHLsyHKFF0LpoNUZvV5iugiSv/c2EfxrLC5l6x0WioL0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C07292AEE4;
	Mon, 11 Dec 2023 20:43:32 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 603672AEE3;
	Mon, 11 Dec 2023 20:43:29 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Daniel Ducharme <dducharme@catalisgov.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug in SVN.pm
In-Reply-To: <DS7PR13MB46861D9FF40E2A340FD2C8D2CF8FA@DS7PR13MB4686.namprd13.prod.outlook.com>
	(Daniel Ducharme's message of "Mon, 11 Dec 2023 22:51:48 +0000")
References: <DS7PR13MB46861D9FF40E2A340FD2C8D2CF8FA@DS7PR13MB4686.namprd13.prod.outlook.com>
Date: Mon, 11 Dec 2023 17:43:27 -0800
Message-ID: <xmqqo7ewtcu8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D9A23234-988F-11EE-8619-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Daniel Ducharme <dducharme@catalisgov.com> writes:

> sub parse_svn_date requires both the month, day, hour, and minute
> to be 2 digits long and fails on 2007-3-12T17:46:4.000000Z as an
> example due to the regex. Suggestion is to make the regex instead
> /^(\d{4})\-(\d\d?)\-(\d\d?)T (\d\d?)\:(\d\d?)\:(\d\d?)\.\d*Z$/x)
>
> I have found this data to be present in a SVN repository converted
> off of VSS while trying to take some old VSS repos to git through
> SVN, not sure if standard SVN would have allowed these date
> patterns, but they should be valid. The above regex also contains
> a fix for single digit minute and second as I also ran into that
> as well.

I do not think it is fair to call this a bug in SVN.pm, provided if
SVN wants to use ISO 8601 datetime format for its timestamps.  ISO
8601, IIUC, is fairly clear that month and day must be two-digit
strings, 0-filled to the left as needed, and I would not be
surprised if standard SVN rejected such bogus dates, and I do not
agree with your "they *SHOULD* be valid" statement.

Having said all that, it is good to be liberal in what we accept,
and I am sympathetic to "it would be nicer if they were accepted"
sentiment.  As long as there is no ambiguity, I would say that it
would be nicer if timestamps like "2007-3-12T17:1:2.0Z" were
accepted, and I would not be fundamentally opposed to a patch that
loosens the regex to do so.

Patches welcome ;-).
