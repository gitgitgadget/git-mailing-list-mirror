From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] sha1_name: fix error message for @{u}
Date: Wed, 22 May 2013 10:35:03 -0700
Message-ID: <7vhahukjeg.fsf@alter.siamese.dyndns.org>
References: <1369219195-20096-1-git-send-email-artagnon@gmail.com>
	<1369219195-20096-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 19:35:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfCwU-0000oJ-FE
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 19:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756674Ab3EVRfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 13:35:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49248 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756563Ab3EVRfG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 13:35:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A01B21531;
	Wed, 22 May 2013 17:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zykfoADTkfBoH/8SQyVak+qP3es=; b=bR+Oga
	lm2e7Jo/pnZJLb5mUcQOTBgZ4Z8p1+htR3XU2yevu/G1MWjvghGQg3/3mXxaK/l/
	p9tdRZi/YhPYBStVwaB8YQ7htWwNJHOj795La4UKouvNoTbLqI7EJEL1foTtnNP9
	JTwbRl4NTetPGS1E2qHv4sxBhAB1PDwjgiI/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FNLFWsUDU46nMgE82dMiC6frty1iUgPP
	N/4A5+NLfL+utyuEojU++B/+k2x1pV2t+nmfvMMKjui6D0MXbrxouzlUhQCw3m/P
	8jWlDhHgiAYDZSfqrQu7T9EB2AQlDcFuZXvbZfFkleAqzjNi0gDOic0GMptqGM+M
	0/OYfA8hf50=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8120F21530;
	Wed, 22 May 2013 17:35:05 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C817A2152D;
	Wed, 22 May 2013 17:35:04 +0000 (UTC)
In-Reply-To: <1369219195-20096-2-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Wed, 22 May 2013 16:09:54 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F04B995A-C305-11E2-9EE3-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225178>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> 2. Callers calling in with programmatic data, and expecting the function
>    to return and not die().  In this case, why would anyone ever
>    construct a string containing "@{u}" programmatically in the first
>    place?

If you have to ask why, and cannot answer the question yourself,
then you would not know if such a caller exists.  After a code
audit, I know there is no such caller that appends @{u} but if you
were writing a quick-and-dirty caller, I would not be surprised if
you find it more convenient to form a textual extended SHA-1
expression and have get_sha1() do its work, instead of asking the
same question programmatically.

In this case, I think you already checked there is no such problem,
and it is a more straight-forward justification to say that you did
a code-audit and made sure that all the callers that used to hit one
of these errors() want to die().

Also such a caller, if existed, would either

    (1) want to die itself, in which case these error() messages are
        superfluous; or

    (2) want to continue (possibly dying with its own message), in
        which case these error() messages are unwanted.

Because you are changing only the existing call sites of error()
into die(), and not changing silent -1 returns to die(), this change
is safe for both kinds of such callers, I think.

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  sha1_name.c                   | 13 +++++++------
>  t/t1507-rev-parse-upstream.sh | 15 +++++----------
>  2 files changed, 12 insertions(+), 16 deletions(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 3820f28..416a673 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -1033,14 +1033,15 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
>  	 * points to something different than a branch.
>  	 */
>  	if (!upstream)
> -		return error(_("HEAD does not point to a branch"));
> +		die(_("HEAD does not point to a branch"));

OK.

>  	if (!upstream->merge || !upstream->merge[0]->dst) {
>  		if (!ref_exists(upstream->refname))
> +			die(_("No such branch: '%s'"), cp);

OK.

> +		if (!upstream->merge) {
> +			die(_("No upstream configured for branch '%s'"),
> +				upstream->name);
> +		}

OK, but I would not add extra {} if I were doing this change.

> +		die(
>  			_("Upstream branch '%s' not stored as a remote-tracking branch"),
>  			upstream->merge[0]->src);

OK, but I would fix the indentation while at it if I were doing this change.

> diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
> index b27a720..2a19e79 100755
> --- a/t/t1507-rev-parse-upstream.sh
> +++ b/t/t1507-rev-parse-upstream.sh
> @@ -129,8 +129,7 @@ test_expect_success 'branch@{u} works when tracking a local branch' '
>  
>  test_expect_success 'branch@{u} error message when no upstream' '
>  	cat >expect <<-EOF &&
> -	error: No upstream configured for branch ${sq}non-tracking${sq}
> -	fatal: Needed a single revision
> +	fatal: No upstream configured for branch ${sq}non-tracking${sq}

Much nicer.
