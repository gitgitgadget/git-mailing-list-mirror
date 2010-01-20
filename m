From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] rev-parse --glob
Date: Wed, 20 Jan 2010 02:17:15 -0800
Message-ID: <7vska13wt0.fsf@alter.siamese.dyndns.org>
References: <1263980906-11058-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Jan 20 11:17:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXXcw-0002TN-He
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 11:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973Ab0ATKR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 05:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930Ab0ATKR0
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 05:17:26 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40209 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789Ab0ATKRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 05:17:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 39EBD923D4;
	Wed, 20 Jan 2010 05:17:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NqOpDr0Us8sS22hwwbcTDXvuIIk=; b=ioo4mn
	eaY2yFY8fjT07s9erkJgoTuYvzfUk9vLvT0JZn7ja0cCPCytdL9Mz0bOEg5/x3pg
	Wp3vp/5yEq9XdyVhifZDPksyUDxH4Aw0EudsAOpZPgSwnSOaLWD1jIOyCDBwZcqJ
	9SQLl8iaLE1gq40v7jzZL9MYfETthCbGTAgAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E+uQh4IDlxEgJ/cP2HuP1Q9Emfa4L/pe
	SIIxOV9tjabstztDfBWobuWnIPdJjTqf+GxvXP+hbPxh+riRypJoZtQSUxoIvtX4
	XKLG2mUHNS5uk40I8TI2VnJCTOgbtdsTGLqMlMT2EXgGIGZ38IfOPx6ptGCwyGJQ
	HePpLohyptA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 15B64923D3;
	Wed, 20 Jan 2010 05:17:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5948B923D2; Wed, 20 Jan
 2010 05:17:17 -0500 (EST)
In-Reply-To: <1263980906-11058-1-git-send-email-ilari.liusvaara@elisanet.fi>
 (Ilari Liusvaara's message of "Wed\, 20 Jan 2010 11\:48\:25 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FE216DA8-05AC-11DF-9B1B-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137536>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> Add --glob=<glob-pattern> option to rev-parse and everything that
> accepts its options. This option matches all refs that match given
> shell glob pattern (complete with some DWIM logic).
>
> Example:
>
> 'git log --branches --not --glob=remotes/origin'
>
> To show what you have that origin doesn't.
>
> Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
> ---

Looks fairly competently done.  Does this mean you've abandoned the --namespace
series?  I don't mind reverting them from 'next'.

> +static int filter_refs(const char* ref, const unsigned char *sha, int flags,
> +	void* data)
> +{
> +	struct ref_filter *filter = (struct ref_filter*)data;
> +	if (fnmatch(filter->pattern, ref, 0))
> +		return 0;

In many places (not just refs) we use "If leading path component matches,
or fnmatch() says Ok" (e.g. builtin-for-each-ref.c, builtin_grep.c), and
in some other places we only use fnmatch().  I think it is better to pick
one convention, and adjust the other one to match, and my gut feeling is
that "leading path or fnmatch()", while theologically might be messier,
would be more useful in practice.  And that was why I did my "like this"
patch http://article.gmane.org/gmane.comp.version-control.git/137492 that way.

My longer term desire is to consolidate these fnmatch() users to call a
single helper function, and then perhaps replace fnmatch() in that helper
function with something more powerful.  Although I do not personally care
too much, people often wanted to have "path/**/leaf-that-is-deep" matcher.

I don't want you to go there just yet with this series, but at least
following the same style everywhere would pave the way to consolidating
them.

> @@ -674,6 +691,35 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
>  	return do_for_each_ref("refs/replace/", fn, 13, 0, cb_data);
>  }
>  
> +int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data)
> +{
> +	struct strbuf real_pattern = STRBUF_INIT;
> +	struct ref_filter filter;
> +	const char *has_glob_specials;
> +	int ret;
> +
> +	if (prefixcmp(pattern, "refs/"))
> +		strbuf_addstr(&real_pattern, "refs/");
> +	strbuf_addstr(&real_pattern, pattern);
> +
> +	has_glob_specials = strpbrk(pattern, "?*[");

Would the need for this code hopefully disappear if we take the "leading
path or fnmatch()" check?  If we still need this, we probably would want
to add a has_glob_special() helper function not as a hardcoded srpbrk(),
but in terms of is_glob_special() in git-compat-util.h.

Thanks.
