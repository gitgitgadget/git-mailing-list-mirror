Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C005920189
	for <e@80x24.org>; Wed, 22 Jun 2016 21:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbcFVVj2 (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 17:39:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60211 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750718AbcFVVj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 17:39:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9849727532;
	Wed, 22 Jun 2016 17:39:26 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RBU/ukH8vePjfSDxWPo+8g9xoY4=; b=RCQWRk
	zIOz4WbYy1S1yirI+4uiBDby3d8bOGs2vkaqNUN1Mlb5k9PIOndf9M0zoX/YFiAW
	hgP4FXhswv96ZkSAOEGtcnyoOub0je21zjxMouv0PxpFmYX6iVO63+Lr5wCvj68Q
	Xk8FKWEIDaKv/2D9giRMg8T78OXJ2L7jjuvvM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aa6s0BKTTeauCtTw9mUwyUdE9qZqVKXn
	ZqdF4TS14gm+XJswFpTZg+DUZmyl0V6KvpZ4+DE0umVxh9U4WSbFfMwGyOe5B4lL
	8A2g1Bm5cx6Pm8FKQFkXmWPMQ3kFEACpPgrJBpNKnejMpJ6DknsxkRhx8owQicX4
	wufgfZJ2jQ8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9132A27531;
	Wed, 22 Jun 2016 17:39:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1AFE02752F;
	Wed, 22 Jun 2016 17:39:26 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Joey Hess <joeyh@joeyh.name>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v4 8/8] use smudgeToFile filter in recursive merge
References: <1466629758-8035-1-git-send-email-joeyh@joeyh.name>
	<1466629758-8035-9-git-send-email-joeyh@joeyh.name>
Date:	Wed, 22 Jun 2016 14:39:24 -0700
In-Reply-To: <1466629758-8035-9-git-send-email-joeyh@joeyh.name> (Joey Hess's
	message of "Wed, 22 Jun 2016 17:09:18 -0400")
Message-ID: <xmqq7fdglx83.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CAA7813E-38C1-11E6-BF78-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Joey Hess <joeyh@joeyh.name> writes:

> @@ -781,6 +773,7 @@ static void update_file_flags(struct merge_options *o,
>  		}
>  		if (S_ISREG(mode) || (!has_symlinks && S_ISLNK(mode))) {
>  			int fd;
> +			int isreg = S_ISREG(mode);

You probably want to move this isreg business up one scope
(i.e. inside "if (update_wd) {").  Then the if () condition
for this block can use it already.

>  			if (mode & 0100)
>  				mode = 0777;
>  			else
> @@ -788,8 +781,37 @@ static void update_file_flags(struct merge_options *o,
>  			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
>  			if (fd < 0)
>  				die_errno(_("failed to open '%s'"), path);
> -			write_in_full(fd, buf, size);
> -			close(fd);
> +
> +			int smudge_to_file = can_smudge_to_file(path);

This does not compile with decl-after-statement.  I suspect other
patches in this series have the same issue but I did not check.  Do
you say "make DEVELOPER=1"?

> +			if (smudge_to_file) {
> +				close(fd);
> +				fd = convert_to_working_tree_filter_to_file(path, path, buf, size);
> +				if (fd < 0) {
> +					/* smudgeToFile filter failed;
> +					 * continue with regular file
> +					 * creation. */

/*
 * Style: We format our multi-line
 * comments like this.
 */

> +					smudge_to_file = 0;

Ahh, I was wondering why this is not "if (smudge_to_file) ... else ...".

> +					fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
> +					if (fd < 0)
> +						die_errno(_("failed to open '%s'"), path);
> +				}
> +				else {
> +					close(fd);
> +				}
> +			}
> +
> +			if (! smudge_to_file) {

Style: if (!smudge_to_file) {

> +test_expect_success 'smudgeToFile filter is used in merge' '
> +	test_config filter.rot13.smudgeToFile ./rot13-to-file.sh &&
> +
> +	git commit -m "added fstest.t" fstest.t &&
> +	git checkout -b old &&
> +	git reset --hard HEAD^ &&
> +	git merge master &&
> +
> +	test -e rot13-to-file.ran &&
> +	rm -f rot13-to-file.ran &&
> +
> +	cmp test fstest.t &&

"test_cmp test fstest.t"?  The difference matters when running the
test with -v option.

> +	git checkout master

What happens if any of the previous steps failed?  Does the next
test get confused because you would fail to go back to the master
branch?

> +'
> +
>  test_expect_success 'smudgeToFile filter is used by git am' '
>  	test_config filter.rot13.smudgeToFile ./rot13-to-file.sh &&
>  
> -	git commit fstest.t -m "added fstest.t" &&
>  	git format-patch HEAD^ --stdout > fstest.patch &&

Style: 

	git format-patch HEAD^ --stdout >fstest.patch &&

>  	git reset --hard HEAD^ &&
>  	git am < fstest.patch &&

Style: 

	git am <fstest.patch &&

but in this case you do not even need to redirect, i.e.

	git am fstest.patch &&

is enough.

Thanks.
