From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] bundle: Fix exclusion of annotated tags
Date: Mon, 04 Aug 2014 13:10:37 -0700
Message-ID: <xmqqvbq8qama.fsf@gitster.dls.corp.google.com>
References: <1406968747-16100-1-git-send-email-git@cryptocrack.de>
	<1406968747-16100-2-git-send-email-git@cryptocrack.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Lukas Fleischer <git@cryptocrack.de>
X-From: git-owner@vger.kernel.org Mon Aug 04 22:10:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEOap-0002jF-U2
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 22:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbaHDUKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 16:10:48 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63930 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827AbaHDUKr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 16:10:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B3B5D2FB2B;
	Mon,  4 Aug 2014 16:10:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B8JIi00UtW8RPxlCWopVWFAld8c=; b=uRaWE6
	4v/9etAbEIMxKpuNpW2cah5NhtXeM+BXa3oW0b/6Fxo+jA01kkacQ9cOBJgFdiSd
	xGhB2F3vUKgG3j1L1qFRFuu99R12KX7bK0Cy+qy5/Uwp5wMm7BenwLs0iLLQFQI0
	IqTvQ47fA6Ep+sO9FLnh53y70VWRYxwA7d9yA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xIlFtXwudW4uDuq/Gk1zaZBOebcuVdJH
	dAl6iND32UzNBnQVj3z2ZnNUkvSg9WyCRsbNHWzcv53LtB8zLTNXdIhWGmipgYc0
	rEzKPZ5ladAtbFTVBoW+spEm0Vb+sSKRTVoYHs2pKAMyqb/zWsiA5kNPYTr53g5M
	WcaloqyIgBM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AB2242FB2A;
	Mon,  4 Aug 2014 16:10:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1D7F82FB1B;
	Mon,  4 Aug 2014 16:10:40 -0400 (EDT)
In-Reply-To: <1406968747-16100-2-git-send-email-git@cryptocrack.de> (Lukas
	Fleischer's message of "Sat, 2 Aug 2014 10:39:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 67EA1BA0-1C13-11E4-8BAE-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254774>

Lukas Fleischer <git@cryptocrack.de> writes:

> In commit c9a42c4 (bundle: allow rev-list options to exclude annotated
> tags, 2009-01-02), support for excluding annotated tags outside the
> specified date range was added. However, the wrong order of parameters
> was chosen when calling memchr(). Fix this by swapping the character to
> search for with the maximum length parameter.
>
> Signed-off-by: Lukas Fleischer <git@cryptocrack.de>
> ---
>  bundle.c          | 4 ++--
>  t/t5704-bundle.sh | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/bundle.c b/bundle.c
> index 71a21a6..b708906 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -221,8 +221,8 @@ static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
>  	line = memmem(buf, size, "\ntagger ", 8);
>  	if (!line++)
>  		return 1;
> -	lineend = memchr(line, buf + size - line, '\n');
> -	line = memchr(line, lineend ? lineend - line : buf + size - line, '>');
> +	lineend = memchr(line, '\n', buf + size - line);
> +	line = memchr(line, '>', lineend ? lineend - line : buf + size - line);

Good spotting; thanks.

>  	if (!line++)
>  		return 1;
>  	date = strtoul(line, NULL, 10);
> diff --git a/t/t5704-bundle.sh b/t/t5704-bundle.sh
> index 2f063ea..8a4d299 100755
> --- a/t/t5704-bundle.sh
> +++ b/t/t5704-bundle.sh
> @@ -14,7 +14,7 @@ test_expect_success 'setup' '
>  	git tag -d third
>  '
>  
> -test_expect_failure 'annotated tags can be excluded by rev-list options' '
> +test_expect_success 'annotated tags can be excluded by rev-list options' '
>  	git bundle create bundle --all --since=7.Apr.2005.15:14:00.-0700 &&
>  	git ls-remote bundle > output &&
>  	grep tag output &&
