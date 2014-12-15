From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 4/4] attr: avoid heavy work when we know the specified attr is not defined
Date: Mon, 15 Dec 2014 09:30:35 -0800
Message-ID: <xmqqfvcges78.fsf@gitster.dls.corp.google.com>
References: <1418133205-18213-1-git-send-email-pclouds@gmail.com>
	<1418133205-18213-5-git-send-email-pclouds@gmail.com>
	<xmqqsigojr0u.fsf@gitster.dls.corp.google.com>
	<20141215005018.GA31006@lanh>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 18:30:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0ZTx-0006xT-7k
	for gcvg-git-2@plane.gmane.org; Mon, 15 Dec 2014 18:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbaLORat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2014 12:30:49 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50083 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750987AbaLORaq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2014 12:30:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DEAB227790;
	Mon, 15 Dec 2014 12:30:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J9prVy9W3Mz2ODv1+bq0MWlLKFs=; b=Jtlzs5
	ZeYTcNw43tDbLpilXUGbkLBJJVi7RfazUq6Xhcg875M9KLAiTsLRDsYd4HKkq01W
	XBQTsTIye0/wOkdtZEHDxRjF17oEwtyiYoKEHQPmZPhpXM8AsAtRiZ5S/W4UWMiR
	Gs35TJVBef3gGT1g+byl73MnqMgMnFwo3lZlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p0Gy805nCNnzon93tDMH6xLvyU7PBe2Z
	Ck+3IL8d95wdqRFPZf7qCTR+2UhdFC5vY8Mmv8vUkmPGtP4KitKEAoHlb9LlNOPJ
	ilGWqWjxSC5WdotMSnTYIl12at+50wnGBYs2mjG262Z17++E8tqPmGvvOqoWRmnz
	4RESv9PV9Mg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D53862778F;
	Mon, 15 Dec 2014 12:30:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 664E62778E;
	Mon, 15 Dec 2014 12:30:37 -0500 (EST)
In-Reply-To: <20141215005018.GA31006@lanh> (Duy Nguyen's message of "Mon, 15
	Dec 2014 07:50:18 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1533C19C-8480-11E4-A943-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261410>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Dec 09, 2014 at 04:18:57PM -0800, Junio C Hamano wrote:
> ...
>> I smell that a much better split is possible.
>> ...
>
> Something like this? Definitely looks better.

Yeah, I was lazy and did not try it myself to see what the end
result would look like when I commented, but doing it this way
avoids needless repetitions.

The comment block before the collect_*_attrs function need to be
adjusted to match the updated behaviour, though.

Thanks.

> -- 8< --
> diff --git a/attr.c b/attr.c
> index b80e52b..0f828e3 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -33,9 +33,11 @@ struct git_attr {
>  	unsigned h;
>  	int attr_nr;
>  	int maybe_macro;
> +	int maybe_real;
>  	char name[FLEX_ARRAY];
>  };
>  static int attr_nr;
> +static int cannot_trust_maybe_real;
>  
>  static struct git_attr_check *check_all_attr;
>  static struct git_attr *(git_attr_hash[HASHSIZE]);
> @@ -97,6 +99,7 @@ static struct git_attr *git_attr_internal(const char *name, int len)
>  	a->next = git_attr_hash[pos];
>  	a->attr_nr = attr_nr++;
>  	a->maybe_macro = 0;
> +	a->maybe_real = 0;
>  	git_attr_hash[pos] = a;
>  
>  	REALLOC_ARRAY(check_all_attr, attr_nr);
> @@ -269,6 +272,10 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
>  	/* Second pass to fill the attr_states */
>  	for (cp = states, i = 0; *cp; i++) {
>  		cp = parse_attr(src, lineno, cp, &(res->state[i]));
> +		if (!is_macro)
> +			res->state[i].attr->maybe_real = 1;
> +		if (res->state[i].attr->maybe_macro)
> +			cannot_trust_maybe_real = 1;
>  	}
>  
>  	return res;
> @@ -713,7 +720,9 @@ static int macroexpand_one(int nr, int rem)
>   * Collect all attributes for path into the array pointed to by
>   * check_all_attr.
>   */
> -static void collect_all_attrs(const char *path)
> +static void collect_some_attrs(const char *path, int num,
> +			       struct git_attr_check *check)
> +
>  {
>  	struct attr_stack *stk;
>  	int i, pathlen, rem, dirlen;
> @@ -736,6 +745,19 @@ static void collect_all_attrs(const char *path)
>  	prepare_attr_stack(path, dirlen);
>  	for (i = 0; i < attr_nr; i++)
>  		check_all_attr[i].value = ATTR__UNKNOWN;
> +	if (num && !cannot_trust_maybe_real) {
> +		rem = 0;
> +		for (i = 0; i < num; i++) {
> +			if (!check[i].attr->maybe_real) {
> +				struct git_attr_check *c;
> +				c = check_all_attr + check[i].attr->attr_nr;
> +				c->value = ATTR__UNSET;
> +				rem++;
> +			}
> +		}
> +		if (rem == num)
> +			return;
> +	}
>  
>  	rem = attr_nr;
>  	for (stk = attr_stack; 0 < rem && stk; stk = stk->prev)
> @@ -746,7 +768,7 @@ int git_check_attr(const char *path, int num, struct git_attr_check *check)
>  {
>  	int i;
>  
> -	collect_all_attrs(path);
> +	collect_some_attrs(path, num, check);
>  
>  	for (i = 0; i < num; i++) {
>  		const char *value = check_all_attr[check[i].attr->attr_nr].value;
> @@ -762,7 +784,7 @@ int git_all_attrs(const char *path, int *num, struct git_attr_check **check)
>  {
>  	int i, count, j;
>  
> -	collect_all_attrs(path);
> +	collect_some_attrs(path, 0, NULL);
>  
>  	/* Count the number of attributes that are set. */
>  	count = 0;
> -- 8< --
