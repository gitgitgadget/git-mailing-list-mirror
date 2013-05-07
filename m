From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] refs.c: Refactor rules for expanding shorthand names into full refnames
Date: Mon, 06 May 2013 18:36:25 -0700
Message-ID: <7v1u9jpo4m.fsf@alter.siamese.dyndns.org>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
	<1367711749-8812-5-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue May 07 03:36:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZWpV-0005rR-RU
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 03:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759479Ab3EGBg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 21:36:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49056 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758214Ab3EGBg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 21:36:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6840812753;
	Tue,  7 May 2013 01:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e6rRzpyDK6YJXbW3cJMNiMOp+i4=; b=mW5sDP
	midQNo5kuuUPim9QWhQB0QRk/ZuR+SqBTZ0q5sisZyXXNdbfeOCf/Y4w1/wlQGQJ
	YDGmWRW3aAj6YAuFP99fplIKIRcSzKTYT+sMb5sTNkkd798TsqAd5miNTZlcYsMz
	MfW0EMN+zdx8xme0eeSkNO+9j9tDQcU9DFlxs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AsqhO/WPrQHlHXs66lqdUqpUhv7ftMkb
	ArBFpALYZhmSDeJ8427CQyqwkSV0UEPlbmdnRgwJ8eYKkeXEKNi6DbJyl/K4I3Th
	1eTYXL2FxQ3eMV+dAujZ8cE7xhPr6LDtoh+gBcWl5qTlDXHNqcCNxAqMAus1wi0l
	7uPUUOypabQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DC6812752;
	Tue,  7 May 2013 01:36:28 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A856112751;
	Tue,  7 May 2013 01:36:27 +0000 (UTC)
In-Reply-To: <1367711749-8812-5-git-send-email-johan@herland.net> (Johan
	Herland's message of "Sun, 5 May 2013 01:55:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8937ACFA-B6B6-11E2-9470-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223518>

Johan Herland <johan@herland.net> writes:

> diff --git a/refs.c b/refs.c
> index 7231f54..8b02140 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1724,7 +1724,24 @@ const char *prettify_refname(const char *name)
>  		0);
>  }
>  
> -const char *ref_rev_parse_rules[] = {
> +static void ref_expand_txtly(const struct ref_expand_rule *rule,
> +			     char *dst, size_t dst_len,
> +			     const char *shortname, size_t shortname_len)
> +{
> +	mksnpath(dst, dst_len, rule->pattern, shortname_len, shortname);
> +}
> +
> +const struct ref_expand_rule ref_expand_rules[] = {
> +	{ ref_expand_txtly, "%.*s" },
> +	{ ref_expand_txtly, "refs/%.*s" },
> +	{ ref_expand_txtly, "refs/tags/%.*s" },
> +	{ ref_expand_txtly, "refs/heads/%.*s" },
> +	{ ref_expand_txtly, "refs/remotes/%.*s" },
> +	{ ref_expand_txtly, "refs/remotes/%.*s/HEAD" },
> +	{ NULL, NULL }
> +};
> +
> +static const char *ref_rev_parse_rules[] = {
>  	"%.*s",
>  	"refs/%.*s",
>  	"refs/tags/%.*s",
> @@ -1734,15 +1751,17 @@ const char *ref_rev_parse_rules[] = {
>  	NULL
>  };
>  
> -int refname_match(const char *abbrev_name, const char *full_name, const char **rules)
> +int refname_match(const char *abbrev_name, const char *full_name,
> +		  const struct ref_expand_rule *rules)
>  {
> -	const char **p;
> +	const struct ref_expand_rule *p;
>  	const int abbrev_name_len = strlen(abbrev_name);
> +	char n[PATH_MAX];

Hmmm, is it too much to ask to do this without a fixed length
buffer?  I think we have long learned the value of using strbuf to
avoid having to worry about buffer overruns.

I am OK with the idea to make ref_expand_rules[] customizable, and
the overall strategy taken by this step to refactor the current code
looks reasonably sensible.
