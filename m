From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] tag: do not show ambiguous tag names as "tags/foo"
Date: Mon, 25 Jan 2016 16:04:16 -0800
Message-ID: <xmqq60yhdx4v.fsf@gitster.mtv.corp.google.com>
References: <20160124230531.GB29115@sigill.intra.peff.net>
	<20160124230840.GB16455@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Pete Harlan <pgit@tento.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 01:04:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNr7U-0004Zs-7P
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 01:04:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755926AbcAZAEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 19:04:24 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50544 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755600AbcAZAET (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 19:04:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AA45840F77;
	Mon, 25 Jan 2016 19:04:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BzxMZbuJy/9tL4LNXKhZVBc/8+M=; b=K2bDIz
	ohhS7Ac5NtqkpTu5YuHHNHrlQlSa+MRZHszmDn9iSQMqGd99dnFhFcRcWhHUxwYG
	Ca2MsnhKNp+VUwCYEebeSdVYFyrfkfUiSdj4lAbWZ4pgoBfHqWYJ+f5miNOTWGtW
	t6hmTrCgE8j3wBFUIlrNhnd3zgceEZkz/brn4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZRD6P7c45X9TwliqtdtegoIFywjOJISy
	OJ9I00Uckt+OVljQjddL2/wspKuKDZ1fo4ZTBjE1Q+0/lRr+jgEKvG0MEzc/0oZt
	w9sgFDnLb0S1Rae9nyZw4oO+z3csoh39rvc//ynWRbmMpAf0aHWvGtDOAImv8RJ9
	MMnXMnQiqj4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A212040F76;
	Mon, 25 Jan 2016 19:04:18 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0E26040F75;
	Mon, 25 Jan 2016 19:04:17 -0500 (EST)
In-Reply-To: <20160124230840.GB16455@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 24 Jan 2016 18:08:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 57E925A6-C3C0-11E5-BE3A-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284770>

Jeff King <peff@peff.net> writes:

> Since b7cc53e9 (tag.c: use 'ref-filter' APIs, 2015-07-11),
> git-tag has started showing tags with ambiguous names (i.e.,
> when both "heads/foo" and "tags/foo" exists) as "tags/foo"
> instead of just "foo". This is both:
>
>   - pointless; the output of "git tag" includes only
>     refs/tags, so we know that "foo" means the one in
>     "refs/tags".
>
> and
>
>   - ambiguous; in the original output, we know that the line
>     "foo" means that "refs/tags/foo" exists. In the new
>     output, it is unclear whether we mean "refs/tags/foo" or
>     "refs/tags/tags/foo".
>
> The reason this happens is that commit b7cc53e9 switched
> git-tag to use ref-filter's "%(refname:short)" output
> formatting, which was adapted from for-each-ref.
> ...

Karthik, getting a fix in for "git tag" regression is more important
than the topics parked in 'pu', so I'll queue this patch in the
early part of 'pu'.

I personally feel that "refname:strip=<n>" would be a good mechanism
for end users to specify a custom format, and it is unclear to me
what should happen when there are not enough elements to be
stripped, so I do not think we want to cast the "we will show the
whole thing" decision in stone prematurely only because we want to
push out the regression fix soon.  So I may ask Jeff to rework this
one (or I may end up trying to do so myself) not to squat on the
nice strip=<n> notation.  refname:strip-standard-prefix that removes
the known prefix ("refs/heads", "refs/remotes" and "refs/tags") if
present and does not touch the refname otherwise would leave us more
time to decide what strip=<n> should do in the error case.

Unfortunately, this means kn/ref-filter-atom-parsing topic from you
that were parked on 'pu' must be ejected for now, as any change in
this area overlaps with it, and the atom parsing code would need to
be updated to learn about the new attribute of the 'refname' atom
(be it 'remove-prefix=<glob>', 'strip=<n>', or something else) that
we would decide to use for the regression fix anyway.

Thanks.

>  Documentation/git-for-each-ref.txt |  6 +++++-
>  Documentation/git-tag.txt          |  2 +-
>  builtin/tag.c                      |  4 ++--
>  ref-filter.c                       | 13 ++++++++++++-
>  t/t3203-branch-output.sh           |  8 ++++++++
>  t/t6300-for-each-ref.sh            |  4 ++++
>  t/t7004-tag.sh                     |  8 ++++++++
>  7 files changed, 40 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 06208c4..f15c817 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -92,7 +92,11 @@ refname::
>  	The name of the ref (the part after $GIT_DIR/).
>  	For a non-ambiguous short name of the ref append `:short`.
>  	The option core.warnAmbiguousRefs is used to select the strict
> -	abbreviation mode.
> +	abbreviation mode. If `strip=<N>` is appended, strips `<N>`
> +	slash-separated path components from the front of the refname
> +	(e.g., `%(refname:strip=2)` turns `refs/tags/foo` into `foo`.
> +	If the ref has fewer components than `<N>`, the whole,
> +	unstripped `%(refname)` is printed.
>  
>  objecttype::
>  	The type of the object (`blob`, `tree`, `commit`, `tag`).
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 7220e5e..abab481 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -163,7 +163,7 @@ This option is only applicable when listing tags without annotation lines.
>  	A string that interpolates `%(fieldname)` from the object
>  	pointed at by a ref being shown.  The format is the same as
>  	that of linkgit:git-for-each-ref[1].  When unspecified,
> -	defaults to `%(refname:short)`.
> +	defaults to `%(refname:strip=2)`.
>  
>  --[no-]merged [<commit>]::
>  	Only list tags whose tips are reachable, or not reachable
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 8db8c87..1705c94 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -44,11 +44,11 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, con
>  	if (!format) {
>  		if (filter->lines) {
>  			to_free = xstrfmt("%s %%(contents:lines=%d)",
> -					  "%(align:15)%(refname:short)%(end)",
> +					  "%(align:15)%(refname:strip=2)%(end)",
>  					  filter->lines);
>  			format = to_free;
>  		} else
> -			format = "%(refname:short)";
> +			format = "%(refname:strip=2)";
>  	}
>  
>  	verify_ref_format(format);
> diff --git a/ref-filter.c b/ref-filter.c
> index 7bef7f8..9f54adc 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -909,12 +909,23 @@ static void populate_value(struct ref_array_item *ref)
>  		formatp = strchr(name, ':');
>  		if (formatp) {
>  			int num_ours, num_theirs;
> +			const char *arg;
>  
>  			formatp++;
>  			if (!strcmp(formatp, "short"))
>  				refname = shorten_unambiguous_ref(refname,
>  						      warn_ambiguous_refs);
> -			else if (!strcmp(formatp, "track") &&
> +			else if (skip_prefix(formatp, "strip=", &arg)) {
> +				int strip = atoi(arg);
> +				const char *start = refname;
> +				while (strip && *start) {
> +					if (*start == '/')
> +						strip--;
> +					start++;
> +				}
> +				if (!strip)
> +					refname = start;
> +			} else if (!strcmp(formatp, "track") &&
>  				 (starts_with(name, "upstream") ||
>  				  starts_with(name, "push"))) {
>  
> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> index d3913f9..4261403 100755
> --- a/t/t3203-branch-output.sh
> +++ b/t/t3203-branch-output.sh
> @@ -176,4 +176,12 @@ test_expect_success 'git branch --points-at option' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'ambiguous branch/tag not marked' '
> +	git tag ambiguous &&
> +	git branch ambiguous &&
> +	echo "  ambiguous" >expect &&
> +	git branch --list ambiguous >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 859b237..1f3abeb 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -50,6 +50,10 @@ test_atom() {
>  
>  test_atom head refname refs/heads/master
>  test_atom head refname:short master
> +test_atom head refname:strip=0 refs/heads/master
> +test_atom head refname:strip=1 heads/master
> +test_atom head refname:strip=2 master
> +test_atom head refname:strip=3 refs/heads/master
>  test_atom head upstream refs/remotes/origin/master
>  test_atom head upstream:short origin/master
>  test_atom head push refs/remotes/myfork/master
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 2797f22..cf3469b 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1558,4 +1558,12 @@ test_expect_success '--no-merged show unmerged tags' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'ambiguous branch/tags not marked' '
> +	git tag ambiguous &&
> +	git branch ambiguous &&
> +	echo ambiguous >expect &&
> +	git tag -l ambiguous >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
