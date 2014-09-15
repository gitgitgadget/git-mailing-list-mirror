From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] mailinfo: do not treat ">From" lines as in-body headers
Date: Mon, 15 Sep 2014 11:56:16 -0700
Message-ID: <xmqqha087lwv.fsf@gitster.dls.corp.google.com>
References: <20140913154556.GA12361@kroah.com>
	<20140913203645.GB24854@peff.net>
	<20140913204745.GA12291@msilap.einon.net>
	<20140913205751.GA17875@mwanda> <20140913210908.GG6549@mwanda>
	<20140913212504.GA25190@peff.net>
	<20140913225713.GB189120@vauxhall.crustytoothpaste.net>
	<20140914004725.GA28010@peff.net>
	<CAPc5daWxZdi+JTTsznefPk2U+Q8uWWYuBUa-rJA4knDZzwU38w@mail.gmail.com>
	<20140914010120.GA28498@peff.net> <20140914013038.GA5974@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Mark Einon <mark.einon@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 15 20:56:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTbRo-0004UD-VN
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 20:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145AbaIOS4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 14:56:20 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52993 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753618AbaIOS4T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 14:56:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DC27839C8B;
	Mon, 15 Sep 2014 14:56:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T1yzXArozxHPz3pAcctW2zRqgYE=; b=Zpjdyu
	IhAA2NDrQY91QUsMFpvVG4obtq+HsXkYowUTj5uS2+T7AVFzzPVcrCYggQNdRQyh
	TsT/P7strDiBdfVMH4zgQ1qXKiX4NATIPef15qi+J4iTdnKcLy3jFNtIKyCycSvh
	/TxRjiKrHY5zow62XwyW0uzWt87ylu6lRaU0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S8cgaRikSjhI1XwMkOIKW/LJG9V1eenP
	YDMnIDnoVtibcu8nBKGyd28GkBacBHNVpO0cYxq9Pfn/I4oncnEDJ0JpkPQT6eSg
	va3KJMuJdYYITMFXSvhPLrE38YKY+oyeUaIPUUzjN9gLTA9PX4HzMFKPxCdv7Arh
	a4YLBp3Myp4=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D166039C8A;
	Mon, 15 Sep 2014 14:56:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2A7C539C87;
	Mon, 15 Sep 2014 14:56:18 -0400 (EDT)
In-Reply-To: <20140914013038.GA5974@peff.net> (Jeff King's message of "Sat, 13
	Sep 2014 21:30:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F9BCB990-3D09-11E4-B8F3-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257066>

Jeff King <peff@peff.net> writes:

> It looks like we have a reasonably sane is_from_line() function. So at
> least _we_ will not generally break on reading our own output, except in
> some extreme circumstances (you'd have to come up with something
> contrived like "From me, at 10:30 30 minutes before 11!").
>
> We can pretty easily reuse this to make the from-line check in mailinfo
> more robust. Here's a replacement for the patch I sent earlier that
> keeps the "magically ignore extra >From headers" behavior but fixes the
> case that started this discussion.

Why cache.h when this is still only between mail{info,split}.c both
of which do not really deal with any "Git" data?

For mailsplit, we are trying to detect mbox boundary various MUAs
would use in their output, and is_from_line() may be appropriate,
but I am not sure if the same logic is appropriate for mailinfo.
What are we trying to protect us against?  Those who paste a single
e-mail output from format-patch in full?  Do people paste a single
e-mail received to their mailbox from somebody else and do we need
to protect against that, skipping the ">From " thing, while risking
to skip "From me at 10:30 30 minutes..."?

If we only want to skip ">?From" in pasted format-patch output, we
would want a rule in mailinfo that is tighter than is_from_line() in
mailsplit.

By the way, I see ">From " in is_rfc2822_header(), too.  Do we have
to worry about this comparison as well?

> -- >8 --
> Subject: mailinfo: make ">From" in-body header check more robust
>
> Since commit 81c5cf7 (mailinfo: skip bogus UNIX From line
> inside body, 2006-05-21), we have treated lines like ">From"
> in the body as headers. This makes "git am" work for people
> who erroneously paste the whole mbox entry:
>
>   From 12345abcd...
>   From: them
>   Subject: [PATCH] whatever
>
> into their email body (assuming that an mbox writer then
> quotes "From" as ">From", as otherwise we would actually
> mailsplit on the in-body line).
>
> However, this has false positives if somebody actually has a
> commit body that starts with "From "; in this case we
> erroneously remove the line entirely from the commit
> message. We can make this check more robust by making sure
> the line actually looks like a real mbox "From" line.
>
> To do this we pull the "is_from_line" definition out of
> mailsplit, and make it available for general use.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Makefile                   |  1 +
>  builtin/mailinfo.c         |  2 +-
>  builtin/mailsplit.c        | 31 -------------------------------
>  cache.h                    |  6 ++++++
>  mbox.c                     | 32 ++++++++++++++++++++++++++++++++
>  t/t5100-mailinfo.sh        | 18 ++++++++++++++++++
>  t/t5100/embed-from.expect  |  5 +++++
>  t/t5100/embed-from.in      | 13 +++++++++++++
>  t/t5100/quoted-from.expect |  3 +++
>  t/t5100/quoted-from.in     | 10 ++++++++++
>  10 files changed, 89 insertions(+), 32 deletions(-)
>  create mode 100644 mbox.c
>  create mode 100644 t/t5100/embed-from.expect
>  create mode 100644 t/t5100/embed-from.in
>  create mode 100644 t/t5100/quoted-from.expect
>  create mode 100644 t/t5100/quoted-from.in
>
> diff --git a/Makefile b/Makefile
> index e0f15a3..e018450 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -704,6 +704,7 @@ LIB_OBJS += lockfile.o
>  LIB_OBJS += log-tree.o
>  LIB_OBJS += mailmap.o
>  LIB_OBJS += match-trees.o
> +LIB_OBJS += mbox.o
>  LIB_OBJS += merge.o
>  LIB_OBJS += merge-blobs.o
>  LIB_OBJS += merge-recursive.o
> diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
> index cf11c8d..a434d39 100644
> --- a/builtin/mailinfo.c
> +++ b/builtin/mailinfo.c
> @@ -329,7 +329,7 @@ static int check_header(const struct strbuf *line,
>  
>  	/* for inbody stuff */
>  	if (starts_with(line->buf, ">From") && isspace(line->buf[5])) {
> -		ret = 1; /* Should this return 0? */
> +		ret = is_from_line(line->buf + 1, line->len - 1);
>  		goto check_header_out;
>  	}
>  	if (starts_with(line->buf, "[PATCH]") && isspace(line->buf[7])) {
> diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
> index 763cda0..11ba281 100644
> --- a/builtin/mailsplit.c
> +++ b/builtin/mailsplit.c
> @@ -12,37 +12,6 @@
>  static const char git_mailsplit_usage[] =
>  "git mailsplit [-d<prec>] [-f<n>] [-b] [--keep-cr] -o<directory> [(<mbox>|<Maildir>)...]";
>  
> -static int is_from_line(const char *line, int len)
> -{
> -	const char *colon;
> -
> -	if (len < 20 || memcmp("From ", line, 5))
> -		return 0;
> -
> -	colon = line + len - 2;
> -	line += 5;
> -	for (;;) {
> -		if (colon < line)
> -			return 0;
> -		if (*--colon == ':')
> -			break;
> -	}
> -
> -	if (!isdigit(colon[-4]) ||
> -	    !isdigit(colon[-2]) ||
> -	    !isdigit(colon[-1]) ||
> -	    !isdigit(colon[ 1]) ||
> -	    !isdigit(colon[ 2]))
> -		return 0;
> -
> -	/* year */
> -	if (strtol(colon+3, NULL, 10) <= 90)
> -		return 0;
> -
> -	/* Ok, close enough */
> -	return 1;
> -}
> -
>  static struct strbuf buf = STRBUF_INIT;
>  static int keep_cr;
>  
> diff --git a/cache.h b/cache.h
> index dfa1a56..9e71ca5 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1568,4 +1568,10 @@ void stat_validity_update(struct stat_validity *sv, int fd);
>  
>  int versioncmp(const char *s1, const char *s2);
>  
> +/*
> + * Returns true if the line appears to be an mbox "From" line starting a new
> + * message.
> + */
> +int is_from_line(const char *line, int len);
> +
>  #endif /* CACHE_H */
> diff --git a/mbox.c b/mbox.c
> new file mode 100644
> index 0000000..75f3150
> --- /dev/null
> +++ b/mbox.c
> @@ -0,0 +1,32 @@
> +#include "cache.h"
> +
> +int is_from_line(const char *line, int len)
> +{
> +	const char *colon;
> +
> +	if (len < 20 || memcmp("From ", line, 5))
> +		return 0;
> +
> +	colon = line + len - 2;
> +	line += 5;
> +	for (;;) {
> +		if (colon < line)
> +			return 0;
> +		if (*--colon == ':')
> +			break;
> +	}
> +
> +	if (!isdigit(colon[-4]) ||
> +	    !isdigit(colon[-2]) ||
> +	    !isdigit(colon[-1]) ||
> +	    !isdigit(colon[ 1]) ||
> +	    !isdigit(colon[ 2]))
> +		return 0;
> +
> +	/* year */
> +	if (strtol(colon+3, NULL, 10) <= 90)
> +		return 0;
> +
> +	/* Ok, close enough */
> +	return 1;
> +}
> diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
> index 3e64a7a..9e1ad1c 100755
> --- a/t/t5100-mailinfo.sh
> +++ b/t/t5100-mailinfo.sh
> @@ -89,4 +89,22 @@ test_expect_success 'mailinfo on from header without name works' '
>  
>  '
>  
> +test_expect_success 'mailinfo finds headers after embedded From line' '
> +	mkdir embed-from &&
> +	git mailsplit -oembed-from "$TEST_DIRECTORY"/t5100/embed-from.in &&
> +	test_cmp "$TEST_DIRECTORY"/t5100/embed-from.in embed-from/0001 &&
> +	git mailinfo embed-from/msg embed-from/patch \
> +	  <embed-from/0001 >embed-from/out &&
> +	test_cmp "$TEST_DIRECTORY"/t5100/embed-from.expect embed-from/out
> +'
> +
> +test_expect_success 'mailinfo on message with quoted >From' '
> +	mkdir quoted-from &&
> +	git mailsplit -oquoted-from "$TEST_DIRECTORY"/t5100/quoted-from.in &&
> +	test_cmp "$TEST_DIRECTORY"/t5100/quoted-from.in quoted-from/0001 &&
> +	git mailinfo quoted-from/msg quoted-from/patch \
> +	  <quoted-from/0001 >quoted-from/out &&
> +	test_cmp "$TEST_DIRECTORY"/t5100/quoted-from.expect quoted-from/msg
> +'
> +
>  test_done
> diff --git a/t/t5100/embed-from.expect b/t/t5100/embed-from.expect
> new file mode 100644
> index 0000000..06a3a38
> --- /dev/null
> +++ b/t/t5100/embed-from.expect
> @@ -0,0 +1,5 @@
> +Author: Commit Author
> +Email: commit@example.com
> +Subject: patch subject
> +Date: Sat, 13 Sep 2014 21:13:23 -0400 
> +
> diff --git a/t/t5100/embed-from.in b/t/t5100/embed-from.in
> new file mode 100644
> index 0000000..5f3f84e
> --- /dev/null
> +++ b/t/t5100/embed-from.in
> @@ -0,0 +1,13 @@
> +From 1234567890123456789012345678901234567890 Mon Sep 17 00:00:00 2001
> +From: Email Author <email@example.com>
> +Date: Sun, 25 May 2008 00:38:18 -0700
> +Subject: [PATCH] email subject
> +
> +>From 1234567890123456789012345678901234567890 Mon Sep 17 00:00:00 2001
> +From: Commit Author <commit@example.com>
> +Date: Sat, 13 Sep 2014 21:13:23 -0400
> +Subject: patch subject
> +
> +patch body
> +---
> +patch
> diff --git a/t/t5100/quoted-from.expect b/t/t5100/quoted-from.expect
> new file mode 100644
> index 0000000..8c9d48c
> --- /dev/null
> +++ b/t/t5100/quoted-from.expect
> @@ -0,0 +1,3 @@
> +>From the depths of history, we are stuck with the
> +flaky mbox format.
> +
> diff --git a/t/t5100/quoted-from.in b/t/t5100/quoted-from.in
> new file mode 100644
> index 0000000..847e1c4
> --- /dev/null
> +++ b/t/t5100/quoted-from.in
> @@ -0,0 +1,10 @@
> +From 1234567890123456789012345678901234567890 Mon Sep 17 00:00:00 2001
> +From: Author Name <somebody@example.com>
> +Date: Sun, 25 May 2008 00:38:18 -0700
> +Subject: [PATCH] testing quoted >From
> +
> +>From the depths of history, we are stuck with the
> +flaky mbox format.
> +
> +---
> +patch
