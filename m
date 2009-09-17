From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-log --format: Add %B tag with %B(x) option
Date: Thu, 17 Sep 2009 16:27:45 -0700
Message-ID: <7vk4zxgnim.fsf@alter.siamese.dyndns.org>
References: <1253227671-20493-1-git-send-email-heipei@hackvalue.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Gilger <heipei@hackvalue.de>
X-From: git-owner@vger.kernel.org Fri Sep 18 01:28:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoQOO-0003tG-AJ
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 01:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbZIQX1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 19:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbZIQX1v
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 19:27:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42457 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbZIQX1u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 19:27:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 678FE54E54;
	Thu, 17 Sep 2009 19:27:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T8Z5QeaDj1tlD+MI+gV4t3PHvJc=; b=N0Sk9I
	vgM/HuS3t8SjbhvkdiMVprn27JxXqMo3eprTscZHSG81yRn9f+f+siJ3WwKMMNSD
	VlTsAZTkzidMCkTTA5QydMPjT7MZB53XlOXjCGMSsNoXqeFa8Hw3qQeYA1zYaD7x
	vz53koFER6lB0ZJiDaHtU8Bm/nCJXvq4n6zsc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UrNCBELKkECb01lcAckNgNJRHQnXyOiG
	UcPbUGNR57rl87QJJEQ2ieRtgFUhiWsQYWS/rLCTtpQIfc46wHG68SHkhT3lZJ5B
	Ei0H1izZCNrK1el8QGIngP0KnoGjW2nYXzl0scc94iYh8ym7DerjfX8oC2Xa2zTM
	0N/7FLlMM4Q=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4A31D54E53;
	Thu, 17 Sep 2009 19:27:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0CD0854E52; Thu, 17 Sep 2009
 19:27:46 -0400 (EDT)
In-Reply-To: <1253227671-20493-1-git-send-email-heipei@hackvalue.de>
 (Johannes Gilger's message of "Fri\, 18 Sep 2009 00\:47\:51 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B719B55A-A3E1-11DE-8E90-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128779>

Johannes Gilger <heipei@hackvalue.de> writes:

> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index 2a845b1..c04f118 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -123,6 +123,8 @@ The placeholders are:
>  - '%s': subject
>  - '%f': sanitized subject line, suitable for a filename
>  - '%b': body
> +- '%B': body without trailing newline
> +- '%B(x)': body indented with x spaces

First the design issues.

Because this will set a precedent for possible future formatting features
that take optional parameters, we need to pick the syntax carefully not
only for this feature but for the later ones that we haven't invented yet.

Let's say that pair of parentheses is a good choice and if later features
want to take more than one, it would be reasonable for them to use a
comma-separated list, e.g. %Q(1,2,3).

I wonder if it is reasonable to invoke print_wrapped_text(), not just
limit this feature to indenting.

Now, let's look at the implementation.

> diff --git a/pretty.c b/pretty.c
> index f5983f8..6d530e1 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -735,6 +735,19 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
>  	case 'b':	/* body */
>  		strbuf_addstr(sb, msg + c->body_off);
>  		return 1;
> +	case 'B':
> +		if (placeholder[1] == '(') {
> +			const char *body = msg + c->body_off;
> +			const char *end = strchr(placeholder + 2, ')');
> +			if(!end)
> +				return 0;

Style: "if (!end)"

I'd sleep better if the syntax checking is done as a separate phase way
before this in the codepath.

> +			pp_remainder(CMIT_FMT_MEDIUM, &body, sb, atoi(placeholder + 2));

What happens when atoi() fails, or %B(12Q) was given?

We tend to use strto[u]l when parsing integers and check for errors.
