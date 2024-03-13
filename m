Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19AA53364
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 20:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710360694; cv=none; b=LpnOu+7ofo3zo7xvZLYzvHW6aVER3ocBMPeqA4gMRlmjwdU+i00tK6dFswpXZxHCI+DYSOSsF+3MvTQh8aPFi7mUeJpwTjFA4P7xChl5TIg+JONBOYF1OAUGFRRinIIPJZRAQQ3AC10sQ2WvHxgH3wxHpVujaOkzVrwJKHdt640=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710360694; c=relaxed/simple;
	bh=G8WVeoQ+2nzGP1/EEYNWlGpVYlgSyvaH76hs1NlUWTU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XM7cM18gw+8t6gDgVHhLIyD1qUN9HU8B+gfH7wFrdTdFhyUGec052HAURXStB+GAAfqvYIo0fGeG+SGwefnvtAHMiCDro5r9DHsB/MDk1J82Q9zGUICJoNHPVp2UbsJ4bLciU4FEbdpRVRiyTKTSAvFVwPr0WEGHJKwQaLs11s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WzTxIIhH; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WzTxIIhH"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F0B41DE3EA;
	Wed, 13 Mar 2024 16:11:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=G8WVeoQ+2nzGP1/EEYNWlGpVYlgSyvaH76hs1N
	lUWTU=; b=WzTxIIhHpYx9EWwOrF0wS2ee9FoVDrdR3RqtA4RIx7PULx/GihgZaJ
	SfV+dSj9Vn6pab2rh6beiXHWM+RIBwMbVTj6//yR1vmjXtBK9IiOB5kFb6DGp+67
	qjufmvwFLkiX0XBFKjrpI4VA7F3SN4MFNmrGPYYBcvOqrUCcRf4u4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 869161DE3E9;
	Wed, 13 Mar 2024 16:11:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E847D1DE3E8;
	Wed, 13 Mar 2024 16:11:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: git@vger.kernel.org,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC PATCH] mailsplit: add option to extract PATCH M/N numbers
In-Reply-To: <20240313010040.1828970-1-jacob.e.keller@intel.com> (Jacob
	Keller's message of "Tue, 12 Mar 2024 17:58:48 -0700")
References: <20240313010040.1828970-1-jacob.e.keller@intel.com>
Date: Wed, 13 Mar 2024 13:11:29 -0700
Message-ID: <xmqqzfv1ao3y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E1BC2932-E175-11EE-961B-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jacob Keller <jacob.e.keller@intel.com> writes:

> Its frustrating to download an mbox file and then have to manually re-sort
> or re-apply patches because it failed to extract things nicely. I don't know
> if this approach is the best solution, or whether there's something else we
> could do instead. In theory we probably want something more robust for the
> M/N extraction over using strchr, memrchr, and whatnot....
>
>  builtin/mailsplit.c | 126 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 116 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
> index 3af9ddb8ae5c..5255f4056e91 100644
> --- a/builtin/mailsplit.c
> +++ b/builtin/mailsplit.c
> @@ -10,7 +10,7 @@
>  #include "strbuf.h"
>  
>  static const char git_mailsplit_usage[] =
> -"git mailsplit [-d<prec>] [-f<n>] [-b] [--keep-cr] -o<directory> [(<mbox>|<Maildir>)...]";
> +"git mailsplit [-d<prec>] [-f<n>] [-b] [--keep-cr] [--extract-patch-from-subject] -o<directory> [(<mbox>|<Maildir>)...]";

"extract patch from subject" is quite a mouthful and more
importantly, I suspect that it is different from what the option
does (unless the sender is cramming the log message and the patch on
a single title line).

This seems to try parsing the numbers out of the prefixes like
"[PATCH v2 04/18]" but I wonder if it has to understand four and
eighteen in such a header.  Doesn't the sending side make sure that
the patches will be in the right order if you sort the message in
your MUA by the subject textually?  After all, such a numbering
convention is to aid humans to read them in order in a mailbox.

I also wonder if it is enough to run the commit title (before
stripping out the "[PATCH v4 04/18]" part) through
format_sanitized_subject() to derive the patch file name.  At the
receiving end, they have to be prepared to take a non-number with
your patch anyway, and when things go wrong, peeking the directory
may become easier.  I dunno.

> +	if (found) {
> +		*nr = atoi(m_buf.buf);
> +		*total = atoi(n_buf.buf);
> +	} else {
> +		*nr = 0;
> +		*total = 0;
> +	}

Having said all that, I also wonder if we want to simplify this to
the other extreme.  When we accept such a 18-patch series that is
stored in a mailbox file in a wrong order, we do not even care about
"/18" part of "[PATCH v2 04/18]".  So instead of worrying about
total at all, how about "--use-patchnum-from-subject" that only uses
the "04" part of "[PATCH v2 04/18]" as the output filename?  We
would probably still want to count how many messges we processed and
as long as we need to parse out "04" out of "04/18", we'd probably
parse "18" as well, so we can maintain a bitmap to ensure we saw all
the messages without duplicates, or something.

The reason why I care is because such a scheme would be easier for
existing consumers that are prepared to take ...

> -		char *name = xstrfmt("%s/%0*d", dir, nr_prec, ++skip);

... only numbers in their filenames, and not ...

> ...
> +			name = xstrfmt("%s/%0*d_%0*d_%0*d", dir, nr_prec, total, nr_prec, nr, nr_prec, ++skip);

... a string like "04_18".

Overall, I like the idea of massaging a mailbox that got patches in
shuffled order to make it usable.  In addition to the "sort the
shuffled mess" benefit, it would allow us to drop the cover letter
and pick only the patch messages.  I just am not happy with the
output "04_18", and the parsing code, as you said, is yucky indeed.

And of course totally outside the Git tools scope, I wonder if this
is something "formail" should be able to do more naturally.
