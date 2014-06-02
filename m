From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH alt-v2] Improve function dir.c:trim_trailing_spaces()
Date: Mon, 02 Jun 2014 13:23:41 -0700
Message-ID: <xmqqha433vsi.fsf@gitster.dls.corp.google.com>
References: <1401727551-8871-1-git-send-email-pasha.bolokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com, peff@peff.net
To: Pasha Bolokhov <pasha.bolokhov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 22:23:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrYlr-00031M-IO
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 22:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbaFBUXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 16:23:47 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58572 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751628AbaFBUXq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 16:23:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 48F1B1DF13;
	Mon,  2 Jun 2014 16:23:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CTCjf5UExmums2La2Vnwz31TMwM=; b=s6ab/U
	4HAEhjcg/r8seMjXDKLTmFx4fXm44+wfrOJ8wIkZZ4a2aDaB6ecp7rTYzwREMjRv
	lz/PCY09rUEYimIFUrB0Eoh40kyvxRHomgXUCGsc1ko9elqWjloThoJjDKVx2o5e
	JlafNwFaA4WHclISPbAF49xCkc5LpAJfCftMY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fC+8n5JbPjjfEgjIj3u/n01d1mLTY3Ur
	rkcyDD0Kdr10LDZR8f4cfitLZEpMrXiGwdSNngsgwOxod9+Q4neC43MRI5QWPJsd
	noye2WgSWTT3vrs0uqELxnk62ZHfMY8C8/fmOChu1LiQCNnqkawAROvl6EAwgKWm
	kizMN4WyVUw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3EB341DF12;
	Mon,  2 Jun 2014 16:23:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 98AE51DF0D;
	Mon,  2 Jun 2014 16:23:42 -0400 (EDT)
In-Reply-To: <1401727551-8871-1-git-send-email-pasha.bolokhov@gmail.com>
	(Pasha Bolokhov's message of "Mon, 2 Jun 2014 09:45:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CA4D1FB0-EA93-11E3-BCEA-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250591>

Pasha Bolokhov <pasha.bolokhov@gmail.com> writes:

> Discard the unnecessary 'nr_spaces' variable, remove 'strlen()' and
> improve the 'if' structure. Switch to pointers instead of integers
>
> Slightly more rare occurrences of 'text  \    ' with a backslash
> in between spaces are handled correctly. Namely, the code in
> 8ba87adad6 does not reset 'last_space' when a backslash is
> encountered and the above line stays intact as a result.
> Add a test at the end of t/t0008-ignores.sh to exhibit this behavior
>
> Signed-off-by: Pasha Bolokhov <pasha.bolokhov@gmail.com>
> ---
> After correcting for the trailing backslash 'text\', a switch()
> structure gives better readability than nested 'ifs', the way I see it.
> Add a test to show that the trailing backslash 'text\' is handled
> correctly
>
>  dir.c              | 35 ++++++++++++++++++++---------------
>  t/t0008-ignores.sh | 23 +++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 15 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index eb6f581..06483d4 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -508,21 +508,26 @@ void clear_exclude_list(struct exclude_list *el)
>  
>  static void trim_trailing_spaces(char *buf)
>  {
> -	int i, last_space = -1, nr_spaces, len = strlen(buf);
> -	for (i = 0; i < len; i++)
> -		if (buf[i] == '\\')
> -			i++;
> -		else if (buf[i] == ' ') {
> -			if (last_space == -1) {
> -				last_space = i;
> -				nr_spaces = 1;
> -			} else
> -				nr_spaces++;
> -		} else
> -			last_space = -1;
> -
> -	if (last_space != -1 && last_space + nr_spaces == len)
> -		buf[last_space] = '\0';
> +	char *p, *last_space = NULL;
> +
> +	for (p = buf; *p; p++)
> +		switch (*p) {
> +		case ' ':
> +			if (!last_space)
> +				last_space = p;
> +			break;
> +
> +		case '\\':
> +			p++;
> +			if (!*p)
> +				return;
> +

Write

			/* fallthru */

here.

> +		default:
> +			last_space = NULL;
> +		}
> +
> +	if (last_space)
> +		*last_space = '\0';
>  }

I think the loop structure is a lot simpler to follow (with or
without switch/case) with this change.  Good.

>  int add_excludes_from_file_to_list(const char *fname,
> diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
> index 63beb99..4cea858 100755
> --- a/t/t0008-ignores.sh
> +++ b/t/t0008-ignores.sh
> @@ -806,4 +806,27 @@ test_expect_success !MINGW 'quoting allows trailing whitespace' '
>  	test_cmp err.expect err
>  '
>  
> +test_expect_success NOT_MINGW,NOT_CYGWIN 'correct handling of backslashes' '
> +	rm -rf whitespace &&
> +	mkdir whitespace &&
> +	>"whitespace/trailing 1  "	&&
> +	>"whitespace/trailing 2 \\\\"	&&
> +	>"whitespace/trailing 3 \\\\"	&&
> +	>"whitespace/trailing 4   \\ "	&&
> +	>"whitespace/trailing 5 \\ \\ "	&&
> +	>"whitespace/trailing 6 \\a\\"	&&

Don't be cute and try to align with tabs.

> +	>whitespace/untracked &&
> +	echo "whitespace/trailing 1 \\    "			>ignore  &&
> +	echo "whitespace/trailing 2 \\\\\\\\\\\\\\\\"		>>ignore &&
> +	echo "whitespace/trailing 3 \\\\\\\\\\\\\\\\ "		>>ignore &&
> +	echo "whitespace/trailing 4   \\\\\\\\\\\\    "		>>ignore &&
> +	echo "whitespace/trailing 5 \\\\\\\\ \\\\\\\\\\\\   "	>>ignore &&
> +	echo "whitespace/trailing 6 \\\\\\\\a\\\\\\\\"		>>ignore &&
> +	echo whitespace/untracked >expect &&
> +	: >err.expect &&

Other file truncation is done with ">whitespace/filename" without an
explicit ":" aka no-op command; I know this was copied from a
previous test but perhaps we want to be consistent?

> +	git ls-files -o -X ignore whitespace >actual 2>err &&
> +	test_cmp expect actual &&
> +	test_cmp err.expect err
> +'
> +
>  test_done
