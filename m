From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] pretty: add %D format specifier
Date: Tue, 16 Sep 2014 11:37:29 -0700
Message-ID: <xmqqegvb2yza.fsf@gitster.dls.corp.google.com>
References: <541875ef.6153c20a.4ef5.ffff8cbb@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Harry Jeffery <harry@exec64.co.uk>
X-From: git-owner@vger.kernel.org Tue Sep 16 20:37:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTxdB-0007KR-5w
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 20:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754503AbaIPShd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 14:37:33 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60017 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753000AbaIPShc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 14:37:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 23B1D38CF4;
	Tue, 16 Sep 2014 14:37:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LM0pn28kfQ9NqVT+PYFT0sOXxEo=; b=Mk5/Z1
	TeSiOiWi68DJwhPjwCSF7YyLh43CUVHQ0DCYcGiH9MZKk/BdmowOM6/hS5Znbxqj
	1BrDZElW/mxkZ8hkRGRMHyLGJjIykLpXbqwmxk7d6adjkyNatiwxcQYp4NDTQyK2
	9dw3r77/2H6pcpOqw19PeuMLbI6gDTOZrkgrY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VuoyMFZqT9tnzjrmC2ux3ZTkvlJqy4AH
	GgADjmvkFccaHR665Mcc2kZvVdIG6uIgHxSCrdv1dZM+yevJoyRaae8jHEcxdYgt
	eWpa56W9mnMgTtTn84TO8MPEf2LXZ13RSq2D6xixLqwZD0tNgSKP719QBMDFTHgv
	uvQQV0k80f8=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1956738CF2;
	Tue, 16 Sep 2014 14:37:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 88A0D38CEF;
	Tue, 16 Sep 2014 14:37:31 -0400 (EDT)
In-Reply-To: <541875ef.6153c20a.4ef5.ffff8cbb@mx.google.com> (Harry Jeffery's
	message of "Tue, 16 Sep 2014 17:37:38 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 84A2ACC4-3DD0-11E4-A1E7-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257139>

Harry Jeffery <harry@exec64.co.uk> writes:

> Add a new format specifier, '%D' that is identical in behaviour to '%d',
> except that it does not include the ' (' prefix or ')' suffix provided
> by '%d'.
>
> Signed-off-by: Harry Jeffery <harry@exec64.co.uk>

Thanks.

> @@ -196,20 +198,20 @@ void format_decorations(struct strbuf *sb,
>  	decoration = lookup_decoration(&name_decoration, &commit->object);
>  	if (!decoration)
>  		return;
> -	prefix = " (";
> +	strbuf_addstr(sb, color_commit);
> +	strbuf_addstr(sb, prefix);
>  	while (decoration) {
> -		strbuf_addstr(sb, color_commit);
> -		strbuf_addstr(sb, prefix);
>  		strbuf_addstr(sb, decorate_get_color(use_color, decoration->type));
>  		if (decoration->type == DECORATION_REF_TAG)
>  			strbuf_addstr(sb, "tag: ");
>  		strbuf_addstr(sb, decoration->name);
>  		strbuf_addstr(sb, color_reset);
> -		prefix = ", ";
> +		strbuf_addstr(sb, color_commit);
> +		if (decoration->next)
> +			strbuf_addstr(sb, separator);
>  		decoration = decoration->next;
>  	}

I was kind of found of the nice trick to use a punctuation, which
first points at the prefix " (" and then later points at the
separator ", ", to allow the code that prefixes the punctuation
before showing a new item.  It is now lost.

We can restore it by doing something like this, though:

	if (!decoration)
        	return;
	while (decoration) {
		strbuf_addstr(sb, prefix);
                strbuf_addstr(sb, decoration->name);
                prefix = separator;
                decoration = decoration->next;
	}

> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index de0cc4a..38148c1 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -457,4 +457,15 @@ EOF
>  	test_cmp expected actual1
>  '
>  
> +test_expect_success 'clean log decoration' '
> +	git log --no-walk --tags --pretty="%H %D" --decorate=full >actual &&
> +	cat <<EOF >expected &&
> +$head1 tag: refs/tags/tag2
> +$head2 tag: refs/tags/message-one
> +$old_head1 tag: refs/tags/message-two
> +EOF

You could indent the here-doc if you wanted to, like this:

	cat >expected <<-EOF &&
        $head1 tag: ...
	...
	EOF

and the end result may look easier on the eyes.

> +	sort actual >actual1 &&

Hmph.  I actually think the part that prepares the history makes
sure that the output order of the commits is predictable by using
test_commit and test_tick.  I see existing tests at the end (which
is a sign that they were added more recently than the rest of the
test script, and can indicate a careless addition) already has
"sort", but we shouldn't have to sort.

> +	test_cmp expected actual1
> +'

Thanks.
