Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XYW6/DNo"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E14AE4
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 07:09:08 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 03F131BC4F2;
	Tue, 12 Dec 2023 10:09:07 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7+lKjSi95kZpYVFx+qyha3OL/0l/dpsdOz/4kV
	3qfFU=; b=XYW6/DNoc0DaCv7U8y33hFlzWrLHQNvjHr/YvPxWS/3HkwoLg5TH1D
	OfVFY/XNRevrnQ1ARmgT7ectrKdVvNbOJVKpIS/MRa6pVcI2luzd5BiL8fFyQLpM
	r3RdOCfW6O/CxFZeRIYspikM4k8hg1PqRtKkUAM9HwygXhdiCz+zA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DEF401BC4F1;
	Tue, 12 Dec 2023 10:09:06 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 683DD1BC4ED;
	Tue, 12 Dec 2023 10:09:05 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Britton Kerin <britton.kerin@gmail.com>
Subject: Re: [PATCH] revision: parse integer arguments to --max-count,
 --skip, etc., more carefully
In-Reply-To: <20231212013045.GE376323@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 11 Dec 2023 20:30:45 -0500")
References: <CAC4O8c-nuOTS=a0sVp1603KaM2bZjs+yNZzdAaa5CGTNGFE7hQ@mail.gmail.com>
	<xmqqy1e41lf5.fsf@gitster.g> <xmqq5y181fx0.fsf_-_@gitster.g>
	<20231212013045.GE376323@coredump.intra.peff.net>
Date: Tue, 12 Dec 2023 07:09:02 -0800
Message-ID: <xmqqjzpjsbjl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 64365DC4-9900-11EE-A7C0-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> This all looks pretty reasonable to me.
>
> I couldn't help but think, though, that surely we have some helpers for
> this already? But the closest seems to be git_parse_int(), which also
> allows unit factors. I'm not sure if allowing "-n 1k" would be a feature
> or a bug. ;)

The change in question is meant to be a pure fix to replace a careless
use of atoi().  I do not mind to see a separate patch to add such a
feature later on top.

> I guess "strtol_i()" maybe is that helper already, though I did not even
> know it existed. Looks like it goes back to 2007, and is seldom used.

I didn't know about it, either ;-) I used it only because there is
one use of it, among places that used atoi() I wanted to tighten.

> I wonder if there are more spots that could benefit.

"git grep -e 'atoi('" would give somebody motivated a decent set of
#microproject ideas, but many hits are not suited for strtol_i(),
which is designed to parse an integer at the end of a string.  Some
places use atoi() immediately followed by strspn() to skip over
digits, which means they are parsing an integer and want to continue
reading after the integer, which is incompatible with what
strtol_i() wants to do.  They need either a separate helper or an
updated strtol_i() that optionally allows you to parse the prefix
and report where the integer ended, e.g., something like:

#define strtol_i(s,b,r) strtol_i2((s), (b), (r), NULL)
static inline int strtol_i2(char const *s, int base, int *result, char **endp)
{
	long ul;
        char *dummy = NULL;

        if (!endp)
		endp = &dummy;
	errno = 0;
	ul = strtol(s, &endp, base);
	if (errno ||
	    /*
	     * if we are told to parse to the end of the string by
	     * passing NULL to endp, it is an error to have any
	     * remaining character after the digits.
	     */
            (dummy && *dummy) ||
	    endp == s || (int) ul != ul)
		return -1;
	*result = ul;
	return 0;
}

perhaps.
