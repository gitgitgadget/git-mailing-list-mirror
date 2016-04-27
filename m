From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 24/29] ref_transaction_update(): check refname_is_safe() at a minimum
Date: Wed, 27 Apr 2016 13:14:33 -0700
Message-ID: <xmqqtwim95cm.fsf@gitster.mtv.corp.google.com>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
	<a67a1b745d0a14111c774f13a5776d3756cbf2f2.1461768690.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twopensource.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Apr 27 22:14:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avVr7-0006Jp-CN
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 22:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbcD0UOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 16:14:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57950 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752558AbcD0UOh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 16:14:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A65D017E1A;
	Wed, 27 Apr 2016 16:14:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/JDh0VRzVChTS4leDKEUu9THucQ=; b=JySob5
	qwHv5R3aAdOvYvEJzkHHiQa9KQUyMLUFR0TAYwSOZB0x21NB15QdNmmKt/rhqJH/
	XFuUj9UE7cMPiS1A1loCpwztuMjf5Mwcf54tSSpKYcGyQ6YyNGS8tKrScceiljDg
	SQyr7yhNs6PRvVG0pfclr0Fi65/Zpf9Pi0zYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dhlc7x8fVP/4U4ZHBCsaFEH5oi0acGhH
	++wsT7JC0oXchGmyF4HGuiAByAdO3jPkQkUK8ifwcO7Oe4i5h4p4E37XUMPJNxmz
	USuMr0TTo/mzTBT6wsE1QWrHrQS8Mf3KHVCHcnS9nm5DLPxDTVvDqQyEYZuOZcSd
	uUwafbqnoFs=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C89717E19;
	Wed, 27 Apr 2016 16:14:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 03BF017E18;
	Wed, 27 Apr 2016 16:14:35 -0400 (EDT)
In-Reply-To: <a67a1b745d0a14111c774f13a5776d3756cbf2f2.1461768690.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Wed, 27 Apr 2016 18:57:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A9084376-0CB4-11E6-BFD4-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292812>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> If the user has asked that a new value be set for a reference, we use
> check_refname_format() to verify that the reference name satisfies all
> of the rules. But in other cases, at least check that refname_is_safe().

It isn't clear to me what "in other cases" exactly refers to.  A
request to delete a ref would obviously one of those that do not
"ask that a new value be set", but are there other cases?

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> There are remaining problems in this area of the code. For example,
> check_refname_format() is *less* strict than refname_is_safe(). It
> allows almost arbitrary top-level reference names like "foo" and
> "refs". (The latter is especially fun because if you manage to create
> a reference called "refs", Git stops recognizing the directory as a
> Git repository.) On the other hand, some callers call
> check_refname_format() with incomplete reference names (e.g., branch
> names like "master"), so the functions can't be made stricter until
> those callers are changed.
>
> I'll address these problems separately if I find the time.

Thanks.

>  refs.c                  | 5 +++--
>  t/t1400-update-ref.sh   | 2 +-
>  t/t1430-bad-ref-name.sh | 2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 858b6d7..41eb9e2 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -802,8 +802,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
>  	if ((flags & REF_ISPRUNING) && !(flags & REF_NODEREF))
>  		die("BUG: REF_ISPRUNING set without REF_NODEREF");
>  
> -	if (new_sha1 && !is_null_sha1(new_sha1) &&
> -	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
> +	if ((new_sha1 && !is_null_sha1(new_sha1)) ?
> +	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
> +	    !refname_is_safe(refname)) {
>  		strbuf_addf(err, "refusing to update ref with bad name '%s'",
>  			    refname);
>  		return -1;
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 40b0cce..08bd8fd 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -23,7 +23,7 @@ test_expect_success setup '
>  m=refs/heads/master
>  n_dir=refs/heads/gu
>  n=$n_dir/fixes
> -outside=foo
> +outside=refs/foo
>  
>  test_expect_success \
>  	"create $m" \
> diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
> index 25ddab4..8937e25 100755
> --- a/t/t1430-bad-ref-name.sh
> +++ b/t/t1430-bad-ref-name.sh
> @@ -285,7 +285,7 @@ test_expect_success 'update-ref -d cannot delete non-ref in .git dir' '
>  	echo precious >expect &&
>  	test_must_fail git update-ref -d my-private-file >output 2>error &&
>  	test_must_be_empty output &&
> -	test_i18ngrep -e "cannot lock .*: unable to resolve reference" error &&
> +	test_i18ngrep -e "refusing to update ref with bad name" error &&
>  	test_cmp expect .git/my-private-file
>  '
