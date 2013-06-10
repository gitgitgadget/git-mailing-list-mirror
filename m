From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] checkout: respect GIT_REFLOG_ACTION
Date: Mon, 10 Jun 2013 11:31:16 -0700
Message-ID: <7vd2rtizrf.fsf@alter.siamese.dyndns.org>
References: <1370881332-9231-1-git-send-email-artagnon@gmail.com>
	<1370881332-9231-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 20:31:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um6sJ-0001fg-HZ
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 20:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915Ab3FJSbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 14:31:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33259 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557Ab3FJSbU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 14:31:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2680727F8D;
	Mon, 10 Jun 2013 18:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1ocTQ/69Qb6xHx4jH2w+K8Xzx0c=; b=ySB8AU
	ZLcwidObWQdsRZSwGT/4yBTy3C2Ee2PN/op5dahCGO8alFfdb97GrDJZ9BHUu0Fi
	lUueAgMco3DEbHGcQZdush1wBskd/R8hHKGhYeXR7iwJOI772M7NyqVQ0bCwxU9t
	reaZBnnIcEdvXhAvbh4BgVD3ZLUTEA747qtFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aXB91yzjIPNNR3j888W5Ya4MNttBEdNn
	IQZb6aaFMRKwuKsYDKDeJGWKSI/8Y3e3bQDUBowdz6SKBt9JhZZsoewHg12UQBTx
	CFKVhwQWBN2QDyiJCxHxplqu20/DMS951D3Umz5Ynt/576fBQM9lh8OcpvKrf2Rs
	kxVIrw+64uE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B0E127F8C;
	Mon, 10 Jun 2013 18:31:20 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6371C27F87;
	Mon, 10 Jun 2013 18:31:18 +0000 (UTC)
In-Reply-To: <1370881332-9231-3-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Mon, 10 Jun 2013 21:52:11 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0F5B02A-D1FB-11E2-8BC1-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227344>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> GIT_REFLOG_ACTION is an environment variable specifying the reflog
> message to write after an action is completed.  Other commands including
> merge, reset, and commit respect it.
>
> This incidentally fixes a bug in t/checkout-last.  You can now expect
>
>   $ git checkout -
>
> to work fine after an interactive rebase.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  builtin/checkout.c       | 11 ++++++++---
>  t/t2012-checkout-last.sh |  2 +-
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index f5b50e5..1e2af85 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -587,7 +587,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
>  				   struct branch_info *new)
>  {
>  	struct strbuf msg = STRBUF_INIT;
> -	const char *old_desc;
> +	const char *old_desc, *reflog_msg;
>  	if (opts->new_branch) {
>  		if (opts->new_orphan_branch) {
>  			if (opts->new_branch_log && !log_all_ref_updates) {
> @@ -620,8 +620,13 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
>  	old_desc = old->name;
>  	if (!old_desc && old->commit)
>  		old_desc = sha1_to_hex(old->commit->object.sha1);
> -	strbuf_addf(&msg, "checkout: moving from %s to %s",
> -		    old_desc ? old_desc : "(invalid)", new->name);
> +
> +	reflog_msg = getenv("GIT_REFLOG_ACTION");
> +	if (!reflog_msg)
> +		strbuf_addf(&msg, "checkout: moving from %s to %s",
> +			old_desc ? old_desc : "(invalid)", new->name);
> +	else
> +		strbuf_insert(&msg, 0, reflog_msg, strlen(reflog_msg));

Looks very sensible; we may need to audit programs that set and
export REFLOG_ACTION to make sure they do not do so incorrectly,
which wouldn't have mattered if they called "checkout" but now it
would with this fix, though.



>  	if (!strcmp(new->name, "HEAD") && !new->path && !opts->force_detach) {
>  		/* Nothing to do. */
> diff --git a/t/t2012-checkout-last.sh b/t/t2012-checkout-last.sh
> index 5729487..ab80da7 100755
> --- a/t/t2012-checkout-last.sh
> +++ b/t/t2012-checkout-last.sh
> @@ -116,7 +116,7 @@ test_expect_success 'master...' '
>  	test "z$(git rev-parse --verify HEAD)" = "z$(git rev-parse --verify master^)"
>  '
>  
> -test_expect_failure '"checkout -" works after an interactive rebase' '
> +test_expect_success '"checkout -" works after an interactive rebase' '
>  	git checkout master &&
>  	git checkout other &&
>  	git rebase -i master &&
