From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] word-diff: ignore '\ No newline at eof' marker
Date: Thu, 12 Jan 2012 11:23:59 -0800
Message-ID: <7vty40208g.fsf@alter.siamese.dyndns.org>
References: <4F0EA23D.3010603@yandex-team.ru>
 <902665ee053876c2684f5b935ee4f81e77122802.1326366909.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ivan Shirokoff <shirokoff@yandex-team.ru>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jan 12 20:24:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlQFt-00051u-6C
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 20:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754880Ab2ALTYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 14:24:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63629 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752926Ab2ALTYB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 14:24:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1AF2754B;
	Thu, 12 Jan 2012 14:24:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ubyOYO8jGmgN8UZJjefGmaF1odg=; b=tficua
	bpae7mjt7YIxdiPVhDDTJhWSxANDCCrovyQ4FZJbdEWAKFwh3u+/4uZ7Xa4vEojp
	ct5+dAUdGoN+8sGzlULlXemVQHLLD+CwcGpW24qz5ofsVJ+/JI7cXHfVTKjRLxQQ
	pNkOlc4WhSVgjW7rjtLxe5rnBiQ8+tA6NneRg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o9JB8ZvH1sFRbp8Js3gu8rYSq3CPaiJY
	MPGFUH7a+OnWzO1GvGttD3whAZ9VkOkOwL3RvKC+ap3wNt65CCHFMKddVaf5FdFh
	ny5NEF9GYSF3PgQ7WwEungfKsa20YC9U1aVY5Mv1VGkDmaw37lQlZhNscisLgWuF
	ZjCRkG7Iexw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6ABC754A;
	Thu, 12 Jan 2012 14:24:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5929E7549; Thu, 12 Jan 2012
 14:24:00 -0500 (EST)
In-Reply-To: <902665ee053876c2684f5b935ee4f81e77122802.1326366909.git.trast@student.ethz.ch> (Thomas Rast's message of "Thu, 12 Jan 2012 12:15:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FAE5456C-3D52-11E1-AF43-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188473>

Thomas Rast <trast@student.ethz.ch> writes:

> A proper fix would defer such markers until the end of the hunk.
> However, word-diff is inherently whitespace-ignoring, so as a cheap
> fix simply ignore the marker (and hide it from the output).

Sounds like a very sensible simplification of the issue.

> We use a prefix match for '\ ' to parallel the logic in
> apply.c:parse_fragment().  We currently do not localize this string
> (just accept other variants of it in git-apply), but this should be
> future-proof.
>
> Noticed-by: Ivan Shirokoff <shirokoff@yandex-team.ru>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>
>  diff.c                |    8 ++++++++
>  t/t4034-diff-words.sh |   14 ++++++++++++++
>  2 files changed, 22 insertions(+), 0 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index a65223a..996cc60 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1113,6 +1113,14 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
>  			diff_words_append(line, len,
>  					  &ecbdata->diff_words->plus);
>  			return;
> +		} else if (!prefixcmp(line, "\\ ")) {
> +			/*
> +			 * Silently eat the "no newline at eof" marker
> +			 * (we are diffing without regard to
> +			 * whitespace anyway), and defer processing:
> +			 * more '+' lines could be after it.
> +			 */
> +			return;
>  		}
>  		diff_words_flush(ecbdata);

It took me a while to realize "defer processing" in the comment was meant
to justify the placement of the new block _before_ this flush. Perhaps
rephrasing it to "return without calling diff_words_flush()" would make it
more readable?

Otherwise the patch looks good.

Thanks.

>  		if (ecbdata->diff_words->type == DIFF_WORDS_PORCELAIN) {
> diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
> index 6f1e5a2..5c20121 100755
> --- a/t/t4034-diff-words.sh
> +++ b/t/t4034-diff-words.sh
> @@ -334,4 +334,18 @@ test_expect_success 'word-diff with diff.sbe' '
>  	word_diff --word-diff=plain
>  '
>  
> +test_expect_success 'word-diff with no newline at EOF' '
> +	cat >expect <<-\EOF &&
> +	diff --git a/pre b/post
> +	index 7bf316e..3dd0303 100644
> +	--- a/pre
> +	+++ b/post
> +	@@ -1 +1 @@
> +	a a [-a-]{+ab+} a a
> +	EOF
> +	printf "%s" "a a a a a" >pre &&
> +	printf "%s" "a a ab a a" >post &&
> +	word_diff --word-diff=plain
> +'
> +
>  test_done
