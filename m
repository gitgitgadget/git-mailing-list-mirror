From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5 v4] diff: parse detached options like -S foo
Date: Mon, 02 Aug 2010 09:46:27 -0700
Message-ID: <7v62ztnesc.fsf@alter.siamese.dyndns.org>
References: <vpq7hkdml22.fsf@bauges.imag.fr>
 <1280478669-22973-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Aug 02 18:46:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ofy9x-0005wq-O9
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 18:46:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255Ab0HBQqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 12:46:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34718 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab0HBQqf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 12:46:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 386C3CA312;
	Mon,  2 Aug 2010 12:46:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xf1Rb4xFijEuPM+8DMldxALLr5M=; b=B0/64S
	9eRwPVOzBVMSB4UWiOP9f8+qgRMmKm7ncxm3jAjHlyu+0d21jdzrEWKggG56hQXj
	p0m9ezmmJHjGkap+yYcd4tR3FqQZpsQsn+7b1SZ9GHCVw/YqSFykq/0zqJrTbI8g
	NVrRRqThznG7ZRngtX5ZLcOxXz797T2fjmh2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hdWPiF0nIzbuBVLZzEWsZNzvOQjC+wbH
	wLbLqON4A2yqojLpWMH4NSy9dv1CF2Adfv0uBIr8ovqqa7Nb7cQcXwAW8r8nuho/
	pbiw1TrHwD0YrzViSg+L9FpmM2NHT9aUWqMhPOWOoycVKpivO0HborYR4IFnkFvj
	MylfpII4KrE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 14E38CA30E;
	Mon,  2 Aug 2010 12:46:32 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33D1FCA30C; Mon,  2 Aug
 2010 12:46:29 -0400 (EDT)
In-Reply-To: <1280478669-22973-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Fri\, 30 Jul 2010 10\:31\:05 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8125C28A-9E55-11DF-80AD-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152423>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Change the option parsing logic in revision.c to accept detached forms
> like `-S foo' in addition to `-Sfoo'. The rest of git already accepted
> this form, but revision.c still used its own option parsing.
>
> This patch does not handle --stat-name-width and --stat-width, which are
> special-cases where diff_long_opt do not apply. They are handled in a
> separate patch to ease review.
>
> Original patch by Matthieu Moy, plus refactoring by Jonathan Nieder.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  diff.c                       |   87 ++++++++++++++++++++++++++++++++++--------
>  diff.h                       |    7 +++
>  t/t4013-diff-various.sh      |    5 ++
>  t/t4013/diff.log_-S_F_master |    7 +++
>  t/t4202-log.sh               |   12 ++---
>  5 files changed, 95 insertions(+), 23 deletions(-)
>  create mode 100644 t/t4013/diff.log_-S_F_master
>
> diff --git a/diff.c b/diff.c
> index 17873f3..d89ea20 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2990,9 +2990,50 @@ static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *va
>  
>  static int diff_scoreopt_parse(const char *opt);
>  
> +static inline int short_opt(char opt, const char **argv,
> +			    const char **optarg)
> +{
> +	const char *arg = argv[0];
> +	if (arg[0] != '-' || arg[1] != opt)
> +		return 0;
> +	if (arg[2] != '\0') {
> +		*optarg = arg + strlen("-c");

Just a style thing, but I think "arg + 2" is much easier to read in this
particular case, as it won't risk tempting readers to go "Huh?  What does
that 'c' mean"?  I know the code wants to skip over an option that is a
single dash followed by a single byte and 'c' is just a placeholder for
that single unknown byte, but when the reader reaches that realization,
the reader already knows that the code wants to skip exactly two bytes,
no?  strlen("--") in diff_long_opt() is much easier to justify, though.  I
like the reduction of "arg + N"s that follow prefixcmp(arg, "--whatever")s
in diff_opt_parse() this patch gives us in general.  I just think the
above "-c" is overdoing it.

Do we have an option that can take a zero-length string as its value and
do something meaningful?  I don't think of any offhand ("log -S'' -p" is
not it---it may be meaningful but it is not useful), but this code would
start giving "-p" instead of "" to the option in such a case.

A longer option always required '=' before the value, so it won't share
the above issue (if it is an issue, that is).

Other than that minor style issue and a nagging -X<empty> worry, the
resulting code looks a lot nicer than the original.

Thanks.
