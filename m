Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E8D2568
	for <git@vger.kernel.org>; Sun, 12 Nov 2023 05:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eXQHSCbf"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7F8D8
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 21:59:09 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 440581D342D;
	Sun, 12 Nov 2023 00:59:07 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=E2uk57ouSR3F/ZgiWjPnt9vPos86yD9ZhUpzU2
	j7Hgs=; b=eXQHSCbfK35DqrDz2ztCqAOWCIgc9Gc5xaxwrmuXszgjfWxZI+5VUr
	XPyCkQPLPDqv+rfu9P3zbYQPpXZBEnjuD5deVrXm/6PY8eDNcyBk9iydqfBv3IYd
	3hctb7W3rkTzf1LpHUibfxsFvQJgovlMDjMa77Ene4dBMQ8369QXo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 383C31D342C;
	Sun, 12 Nov 2023 00:59:07 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 35F871D342B;
	Sun, 12 Nov 2023 00:59:05 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Arthur Chan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Arthur Chan <arthur.chan@adalogics.com>
Subject: Re: [PATCH] fuzz: add new oss-fuzz fuzzer for date.c / date.h
In-Reply-To: <pull.1612.git.1699724379458.gitgitgadget@gmail.com> (Arthur Chan
	via GitGitGadget's message of "Sat, 11 Nov 2023 17:39:39 +0000")
References: <pull.1612.git.1699724379458.gitgitgadget@gmail.com>
Date: Sun, 12 Nov 2023 14:59:03 +0900
Message-ID: <xmqqfs1bo6l4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 96B5FB30-8120-11EE-8D48-25B3960A682E-77302942!pb-smtp2.pobox.com

"Arthur Chan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Makefile b/Makefile
> index 03adcb5a480..c9fe99a8c88 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -752,6 +752,7 @@ ETAGS_TARGET = TAGS
>  FUZZ_OBJS += oss-fuzz/fuzz-commit-graph.o
>  FUZZ_OBJS += oss-fuzz/fuzz-pack-headers.o
>  FUZZ_OBJS += oss-fuzz/fuzz-pack-idx.o
> +FUZZ_OBJS += oss-fuzz/fuzz-date.o

The same comment applies to .gitignore but I think the existing
entries are sorted and fuzz-date should be added between
fuzz-commit-graph and fuzz-pack-headers.

> diff --git a/oss-fuzz/fuzz-date.c b/oss-fuzz/fuzz-date.c
> new file mode 100644
> index 00000000000..29bcaf595e4
> --- /dev/null
> +++ b/oss-fuzz/fuzz-date.c
> @@ -0,0 +1,75 @@
> +#include "git-compat-util.h"
> +#include "date.h"
> +
> +int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
> +
> +int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
> +{
> +	int type;
> +	int time;
> +	int num;
> +	char *str;
> +	timestamp_t ts;
> +	enum date_mode_type dmtype;
> +	struct date_mode *dm;
> +
> +	if (size <= 8)
> +	{
> +		return 0;
> +	}

How much do we care about sticking to our coding style for source
files in this directory?  If we do (and I do not see a strong reason
not to), let's lose the {unneeded braces} around a single statement
block.

> +	type = (*((int *)data)) % 8;
> +	data += 4;
> +	size -= 4;

I'd prefer to avoid these hardcoded and unexplained constants.  I
think "8" relates to the number of case arms below?  I am not sure
if "4" is justifiable without "we assume everybody's int is four
bytes long", but if that is what is going on, perhaps use uint32_t
or something?

Also, is data[] guaranteed to be aligned well to allow us to do the
above?  As we only need to spread to DATE_UNIX-1 types (because we
exclude DATE_STRFTIME), it is sufficient to look at the lower nibble
of a single byte.  The upper nibble could be used to fuzz the .local
bit if you wanted to, e.g. so I wonder

	local_bit = !!(*data & 0x10);
	dmtype = (enum date_mode_type)(*data % DATE_UNIX);
	if (dmtype == DATE_STRFTIME)
		return 0;
	data++;
	size--;

> +	time = abs(*((int *)data));
> +	data += 4;
> +	size -= 4;

Ditto.  Rename "time" because the second parameter to show_date() is
*not* "time" but "tz".  The valid range of "tz" comfortably fits in
16-bit signed int, but note that there are valid negative values in
the range.

Are we assuming that the "tz" is attacker controlled?  Why are you
limiting its value to non-negative, yet you are not rejecting absurd
timezone offsets?  Good values lie in a range much narrower than
between -2400 and 2400.  Subjecting "tz" to fuzzer is perfectly
fine, but then limiting its value to non-negative contradicts with
it, so I am not sure what your intention is.

As I used the first byte to fuzz dmtype and .local, let's use the
next three bytes to allow feeding overly wild timezone values to the
machinery and see what breaks, perhaps like so:

	tz = *data++; /* int tz; */
	tz = (tz << 8) | *data++;
	tz = (tz << 8) | *data++;
	size -= 3;

Now the upfront length check needs to reject any input shorter than
4 bytes, so do so with a comment accordingly, perhaps like

	if (size < 4)
		/*
                 * we use the first byte to fuzz dmtype and local,
                 * then the next three bytes to fuzz tz	offset,
                 * and the remainder is fed as end-user input to
		 * approxidate().
		 */
		return 0;

before everything I wrote so far.

> +	str = (char *)malloc(size+1);

	(char *)malloc(size + 1);

> +	if (!str)
> +	{
> +		return 0;
> +	}

Ditto on {unnecessary braces}.

> +	memcpy(str, data, size);
> +	str[size] = '\0';
> +
> +	ts = approxidate_careful(str, &num);
> +	free(str);
> +
> +	switch(type)
> +	{
> +		case 0: default:
> +			dmtype = DATE_NORMAL;
> +			break;

Style.  In our codebase, "switch" and "case" align at the same
column, and case arms are written one per line, i.e.,

	switch (type) {
	case 0:
	default:
		...

The way dmtype is handled in a switch() below tells me that you do
not consider it is a potential attack vector (e.g., an attacker
cannot force us to use dmtype==DATE_STRFTIME without the format and
cause us to die).  Am I reading your intention correctly?

If so, I'd just do the "use the lower nibble of the first byte" as I
shown earlier, and this large switch statement will go away.

> +		case 1:
> +			dmtype = DATE_HUMAN;
> +			break;
> +		case 2:
> +			dmtype = DATE_SHORT;
> +			break;
> +		case 3:
> +			dmtype = DATE_ISO8601;
> +			break;
> +		case 4:
> +			dmtype = DATE_ISO8601_STRICT;
> +			break;
> +		case 5:
> +			dmtype = DATE_RFC2822;
> +			break;
> +		case 6:
> +			dmtype = DATE_RAW;
> +			break;
> +		case 7:
> +			dmtype = DATE_UNIX;
> +			break;
> +	}
> +
> +	dm = date_mode_from_type(dmtype);
> +	dm->local = 1;

Don't we want to allow the incoming data to fuzz the local bit, too?

> +	show_date(ts, time, dm);
> +
> +	date_mode_release(dm);
> +
> +	return 0;
> +}
>
> base-commit: dadef801b365989099a9929e995589e455c51fed
