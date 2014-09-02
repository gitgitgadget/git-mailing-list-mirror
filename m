From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] reachable.c: add HEAD to reachability starting commits
Date: Tue, 02 Sep 2014 10:47:40 -0700
Message-ID: <xmqq4mwp3oeb.fsf@gitster.dls.corp.google.com>
References: <20140831152806.GC17449@peff.net>
	<1409519804-15960-1-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Tue Sep 02 19:47:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOsBR-0001wF-Iw
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 19:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754274AbaIBRrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 13:47:53 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52180 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754033AbaIBRrw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 13:47:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DB91536B80;
	Tue,  2 Sep 2014 13:47:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dasxeQusnkwsdjg6JyRMdx8fqGU=; b=U8Vu07
	5YbwxFIjK4fH6yVlS4dvveYpT7cwmz0V16ttlqQZ60uR9tFxxNSZpdICMw2cY7dj
	TyNwIExZcTPsoHU4tSiS8lZCoPrCyARKEm8bFknxS+bI2sFit26Ee/gmIccQ8jIu
	Gu7sSh8TvkxJj4XfK4/1LQTS/v27EG6xWut0U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IlYF3IzwQAkrAbX/QMi5Ute31ri5xaLc
	87Yw7v2XZ+9eNyJeyugBczJGHOjbKkUU+HLMQGzPm9M4FTg9DxyVHbfIEbNS1qQV
	oCWBsiOq3eM0EehgdZSAMyod/5/u9eERe1pDL6xlxhBaYhNieJM7zfMCXzx2xcyO
	rwtT3p2+IK4=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CDAEB36B7F;
	Tue,  2 Sep 2014 13:47:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3522236B68;
	Tue,  2 Sep 2014 13:47:42 -0400 (EDT)
In-Reply-To: <1409519804-15960-1-git-send-email-max@max630.net> (Max
	Kirillov's message of "Mon, 1 Sep 2014 00:16:44 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3D1062FA-32C9-11E4-A1D1-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256329>

Max Kirillov <max@max630.net> writes:

> HEAD is not explicitly used as a starting commit for
> calculating reachability, so if it's detached and reflogs
> are disabled it may be pruned.
>
> Add tests which demonstrate it. Test 'prune: prune former HEAD after checking
> out branch' also reverts changes to repository.
>
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
> Inserted test into existing script.
>  reachable.c      |  3 +++
>  t/t5304-prune.sh | 21 +++++++++++++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/reachable.c b/reachable.c
> index 654a8c5..6f6835b 100644
> --- a/reachable.c
> +++ b/reachable.c
> @@ -229,6 +229,9 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
>  	/* Add all external refs */
>  	for_each_ref(add_one_ref, revs);
>  
> +	/* detached HEAD is not included in the list above */
> +	head_ref(add_one_ref, revs);
> +

Unlike the change to rev-parse, which I haven't decided if I like
it, this is definitely the right thing to do.

Thanks for catching.

>  	/* Add all reflog info */
>  	if (mark_reflog)
>  		for_each_reflog(add_one_reflog, revs);
> diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
> index 377d3d3..77cf064 100755
> --- a/t/t5304-prune.sh
> +++ b/t/t5304-prune.sh
> @@ -104,6 +104,27 @@ test_expect_success 'prune: prune unreachable heads' '
>  
>  '
>  
> +test_expect_success 'prune: do not prune detached HEAD with no reflog' '
> +
> +	git config core.logAllRefUpdates false &&
> +	test ! -e .git/logs &&

This test is somewhat iffy; if you had it just before "git prune", I
would understand that it matches what the title of the test claims,
though.

> +	git checkout --detach --quiet &&
> +	git commit --allow-empty -m "detached commit" &&
> +	git prune -n >prune_actual &&
> +	: >prune_expected &&
> +	test_cmp prune_actual prune_expected
> +
> +'
> +
> +test_expect_success 'prune: prune former HEAD after checking out branch' '
> +
> +	head_sha1=`git rev-parse HEAD` &&

Favor $(...) over `...`.

> +	git checkout --quiet master &&
> +	git prune -v >prune_actual &&
> +	grep -q "$head_sha1" prune_actual

Please don't use "grep -q"; unless running the test with "-v", we
wouldn't have to see the output anyway.

> +
> +'
> +
>  test_expect_success 'prune: do not prune heads listed as an argument' '
>  
>  	: > file2 &&
