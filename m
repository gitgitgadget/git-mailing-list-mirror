From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] t7610-mergetool: prefer test_config over git config
Date: Wed, 15 Oct 2014 14:08:11 -0700
Message-ID: <xmqqwq81ujlw.fsf@gitster.dls.corp.google.com>
References: <1413362121-17361-1-git-send-email-davvid@gmail.com>
	<1413362121-17361-2-git-send-email-davvid@gmail.com>
	<1413362121-17361-3-git-send-email-davvid@gmail.com>
	<1413362121-17361-4-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Charles Bailey <charles@hashpling.org>,
	Thomas Rast <trast@student.ethz.ch>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 23:08:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeVnu-0003G0-4j
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 23:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbaJOVIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 17:08:14 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56777 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750776AbaJOVIN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 17:08:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DF2A71507C;
	Wed, 15 Oct 2014 17:08:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s83IAaOMwaDWjolMq8ypEb2jA4s=; b=ukrhLH
	QTrIh+QjC2r4kgqvAQ96i6hNOcopxLmTH1b0s+zUzTk26Tr6d5id1UhoncY1xKYI
	o3yonflVjtXzdvTKwAOEZ+/rd0mogMsrtrZMvJwvUZviqEQrp7cWjsxBuNzCwAwW
	GnBgYRu9VtI9W6yK6yQJl22fG/lU7phl36Oig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xXwY8DHRPTczxuR5cKbnh0uXO1nAkfQJ
	Q8V2bP/zT25ZQIu6mZgA1Khj4zupQnQ4HfUJBwl2n8TMbfdveWquQ1SUn+zUzzr5
	qxFslTIspw3BS6pbbyxoTwRc2puDP1/XFZY5/Cj9CcK6qyH6KFpqN2QXu+yajhFO
	HVj1Rd52B/k=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D51C41507B;
	Wed, 15 Oct 2014 17:08:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3F1B01507A;
	Wed, 15 Oct 2014 17:08:12 -0400 (EDT)
In-Reply-To: <1413362121-17361-4-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Wed, 15 Oct 2014 01:35:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5F4AD35C-54AF-11E4-80A5-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---

The reason why this change favours "test_config" over "git config"
is not described here, but if we think about that, some of the
changes in this may become questionable.

> diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
> index 1a15e06..7eeb207 100755
> --- a/t/t7610-mergetool.sh
> +++ b/t/t7610-mergetool.sh
> @@ -14,7 +14,7 @@ Testing basic merge tool invocation'
>  # running mergetool
>  
>  test_expect_success 'setup' '
> -	git config rerere.enabled true &&
> +	test_config rerere.enabled true &&
>  	echo master >file1 &&
>  	echo master spaced >"spaced name" &&
>  	echo master file11 >file11 &&

This one does not have corresponding "git config" to remove the
configuration when the setup is done, so this changes the
behaviour.  The remainder of the tests will run without
rerere.enabled set.

If this change does not make a difference, perhaps we do not even
need to set rerere.enabled here in the first place?

But do later tests perform merges that can potentially be affected
by the setting of rerere.enabled?  If so, this change can break
them.  If this change does not break existing tests, I would say
this is a good change that anticipates that we may add more tests in
the future that work in subdir and that makes sure to leave subdir
in a predictable state for them.

> @@ -112,7 +112,7 @@ test_expect_success 'custom mergetool' '
>  '
>  
>  test_expect_success 'mergetool crlf' '
> -	git config core.autocrlf true &&
> +	test_config core.autocrlf true &&
>  	git checkout -b test2 branch1 &&
>  	test_must_fail git merge master >/dev/null 2>&1 &&
>  	( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
> @@ -129,7 +129,7 @@ test_expect_success 'mergetool crlf' '
>  	git submodule update -N &&
>  	test "$(cat submod/bar)" = "master submodule" &&
>  	git commit -m "branch1 resolved with mergetool - autocrlf" &&
> -	git config core.autocrlf false &&
> +	test_config core.autocrlf false &&
>  	git reset --hard
>  '

This one wants to set core.autocrlf to true while it runs, and then
wants to reset to the original.  When the test fails in the middle,
however, we may abort this test and move on to the next one, while
leaving core.autcrlf still set to "true", which may break later
tests, hence use of test_config to ensure that the setting is
reverted at the end of the test is the right thing to do.

So the hunk #112 is correct, but the hunk #129 is questionable and
even misleading.

> @@ -176,7 +176,7 @@ test_expect_success 'mergetool skips autoresolved' '
>  test_expect_success 'mergetool merges all from subdir' '
>  	(
>  		cd subdir &&
> -		git config rerere.enabled false &&
> +		test_config rerere.enabled false &&
>  		test_must_fail git merge master &&
>  		( yes "r" | git mergetool ../submod ) &&
>  		( yes "d" "d" | git mergetool --no-prompt ) &&

Same comment as the one for hunk #14 applies here.  In principle,
this change will make this test more isolated and is a good thing.

> @@ -190,7 +190,7 @@ test_expect_success 'mergetool merges all from subdir' '
>  '
>  
>  test_expect_success 'mergetool skips resolved paths when rerere is active' '
> -	git config rerere.enabled true &&
> +	test_config rerere.enabled true &&
>  	rm -rf .git/rr-cache &&
>  	git checkout -b test5 branch1 &&
>  	git submodule update -N &&

Ditto.

> @@ -204,7 +204,7 @@ test_expect_success 'mergetool skips resolved paths when rerere is active' '
>  '
>  
>  test_expect_success 'conflicted stash sets up rerere'  '
> -	git config rerere.enabled true &&
> +	test_config rerere.enabled true &&
>  	git checkout stash1 &&
>  	echo "Conflicting stash content" >file11 &&
>  	git stash &&

Ditto.

> @@ -232,7 +232,7 @@ test_expect_success 'conflicted stash sets up rerere'  '
>  
>  test_expect_success 'mergetool takes partial path' '
>  	git reset --hard &&
> -	git config rerere.enabled false &&
> +	test_config rerere.enabled false &&
>  	git checkout -b test12 branch1 &&
>  	git submodule update -N &&
>  	test_must_fail git merge master &&

Ditto.

> @@ -505,14 +505,12 @@ test_expect_success 'file with no base' '
>  
>  test_expect_success 'custom commands override built-ins' '
>  	git checkout -b test14 branch1 &&
> -	git config mergetool.defaults.cmd "cat \"\$REMOTE\" >\"\$MERGED\"" &&
> -	git config mergetool.defaults.trustExitCode true &&
> +	test_config mergetool.defaults.cmd "cat \"\$REMOTE\" >\"\$MERGED\"" &&
> +	test_config mergetool.defaults.trustExitCode true &&
>  	test_must_fail git merge master &&
>  	git mergetool --no-prompt --tool defaults -- both &&
>  	echo master both added >expected &&
>  	test_cmp both expected &&
> -	git config --unset mergetool.defaults.cmd &&
> -	git config --unset mergetool.defaults.trustExitCode &&
>  	git reset --hard master >/dev/null 2>&1
>  '

This one is good; with test_config, you do not have to do the
unsetting yourself.
