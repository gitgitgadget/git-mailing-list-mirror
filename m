From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] diffcore-pickaxe: respect --no-textconv
Date: Thu, 04 Apr 2013 10:45:25 -0700
Message-ID: <7vvc82i40a.fsf@alter.siamese.dyndns.org>
References: <vpqd2uay9rq.fsf@grenoble-inp.fr>
 <20130404160359.GA25232@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Ruderich <simon@ruderich.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 04 19:46:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNoEd-00024l-MW
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 19:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764135Ab3DDRpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 13:45:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38660 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764128Ab3DDRp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 13:45:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFC9F13293;
	Thu,  4 Apr 2013 17:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QLTdGeLpser1Bv7Cz6VFS/H8lOA=; b=puqBwK
	1WVvldv9IQqylF8BPJuH3S9+W4OHl52rijJ88WNPLLwrll4U1TGpOlesnD/tHA2V
	wf8OGAoPoHxjI1a9ZHWqXlZWA++Id+afdSGivRRTb3WbJG5XyiPf3yyZl9pKD/P8
	miTFl0jK2yEOjSSEZYt1OGTI6OyyAgss7YzaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ezZVpO2583Vor1/NKw8hkQW5iNunN56a
	5otDML4Gt+uaP0K84YcstYny+OO2YyHIQLwb+n/KI30xf360RSLjhQ6ITM3BsV+s
	cVeNnkHK8Se6A3GDRDCKN+/pENFkk3FihVII5pqJzB2EQp3MHCxFZNT8gwFMA5Vz
	9iS42HHRpaM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C510813292;
	Thu,  4 Apr 2013 17:45:27 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1CB401328F; Thu,  4 Apr
 2013 17:45:27 +0000 (UTC)
In-Reply-To: <20130404160359.GA25232@ruderich.org> (Simon Ruderich's message
 of "Thu, 4 Apr 2013 18:03:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6F6308F4-9D4F-11E2-9280-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220040>

Simon Ruderich <simon@ruderich.org> writes:

> git log -S doesn't respect --no-textconv:
>
>     $ echo '*.txt diff=wrong' > .gitattributes
>     $ git -c diff.wrong.textconv='xxx' log --no-textconv -Sfoo
>     error: cannot run xxx: No such file or directory
>     fatal: unable to read files to diff
>
> Reported-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> Signed-off-by: Simon Ruderich <simon@ruderich.org>
> ---

Sounds sensible.

With this change fill_one() no longer needs to update textconv, it
can just take a pointer to one, not a pointer to a pointer to one,
which is [2/2].

Peff, anything I missed?

> On Thu, Apr 04, 2013 at 10:34:17AM +0200, Matthieu Moy wrote:
>> Hi,
>>
>> It seems the command "git log --no-textconv -Sfoo" still runs the
>> textconv filter (noticed because I have a broken textconv filter that
>> lets "git log -S" error out).
>>
>> [snip]
>
> Hello Matthieu,
>
> This patch should fix it. All tests pass.
>
> Regards
> Simon
>
>  diffcore-pickaxe.c     | 15 ++++++++++++---
>  t/t4209-log-pickaxe.sh | 14 ++++++++++++++
>  2 files changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
> index b097fa7..f814a52 100644
> --- a/diffcore-pickaxe.c
> +++ b/diffcore-pickaxe.c
> @@ -78,7 +78,6 @@ static void fill_one(struct diff_filespec *one,
>  		     mmfile_t *mf, struct userdiff_driver **textconv)
>  {
>  	if (DIFF_FILE_VALID(one)) {
> -		*textconv = get_textconv(one);
>  		mf->size = fill_textconv(*textconv, one, &mf->ptr);
>  	} else {
>  		memset(mf, 0, sizeof(*mf));
> @@ -97,6 +96,11 @@ static int diff_grep(struct diff_filepair *p, struct diff_options *o,
>  	if (diff_unmodified_pair(p))
>  		return 0;
>  
> +	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
> +		textconv_one = get_textconv(p->one);
> +		textconv_two = get_textconv(p->two);
> +	}
> +
>  	fill_one(p->one, &mf1, &textconv_one);
>  	fill_one(p->two, &mf2, &textconv_two);
>  
> @@ -201,14 +205,19 @@ static unsigned int contains(mmfile_t *mf, struct diff_options *o,
>  static int has_changes(struct diff_filepair *p, struct diff_options *o,
>  		       regex_t *regexp, kwset_t kws)
>  {
> -	struct userdiff_driver *textconv_one = get_textconv(p->one);
> -	struct userdiff_driver *textconv_two = get_textconv(p->two);
> +	struct userdiff_driver *textconv_one = NULL;
> +	struct userdiff_driver *textconv_two = NULL;
>  	mmfile_t mf1, mf2;
>  	int ret;
>  
>  	if (!o->pickaxe[0])
>  		return 0;
>  
> +	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
> +		textconv_one = get_textconv(p->one);
> +		textconv_two = get_textconv(p->two);
> +	}
> +
>  	/*
>  	 * If we have an unmodified pair, we know that the count will be the
>  	 * same and don't even have to load the blobs. Unless textconv is in
> diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
> index eed7273..953cec8 100755
> --- a/t/t4209-log-pickaxe.sh
> +++ b/t/t4209-log-pickaxe.sh
> @@ -116,4 +116,18 @@ test_expect_success 'log -S -i (nomatch)' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'log -S --textconv (missing textconv tool)' '
> +	echo "* diff=test" >.gitattributes &&
> +	test_must_fail git -c diff.test.textconv=missing log -Sfoo &&
> +	rm .gitattributes
> +'
> +
> +test_expect_success 'log -S --no-textconv (missing textconv tool)' '
> +	echo "* diff=test" >.gitattributes &&
> +	git -c diff.test.textconv=missing log -Sfoo --no-textconv >actual &&
> +	>expect &&
> +	test_cmp expect actual &&
> +	rm .gitattributes
> +'
> +
>  test_done
> -- 
> 1.8.2
