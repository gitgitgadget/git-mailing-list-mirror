From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] t0000-*.sh: Fix the GIT_SKIP_TESTS sub-tests
Date: Tue, 20 May 2014 14:33:33 -0700
Message-ID: <xmqqppj8rv82.fsf@gitster.dls.corp.google.com>
References: <537BC8A2.9060009@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Ilya Bobyr <ilya.bobyr@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue May 20 23:33:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmrfO-0000xo-JO
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 23:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbaETVdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 17:33:40 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61234 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751429AbaETVdi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 17:33:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 49EC919F65;
	Tue, 20 May 2014 17:33:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D+qG/xf0dXmtRWiWJS+S5RFJfMo=; b=wdyYUb
	pV1Kb0q9adZ1EbKHGfhZPnQV1+/ly/r51NS5jBBmprjlEAQhjyEORCsU5mf8QzUr
	2Fu/G6IF/MJ8ZVT6RbkLii4D59Sd8MHgW9kBOu96UCCWlgbNAcU9Idwh9Mwr/oqr
	ircsJzr7+XrdghsTRVPBhd0XwZQ9ZJEtSLNoA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qsgoVxfG1tJzg4HFE0uPgBpdX2O3y2jz
	TlpG3BfhNQQpfOH9Cv4WRwInu06nlvTVWka8QwCDSRmPgZIVXxRYDtLlLjxYKYvR
	MZKmqqSS2Ka+j3bxkcPx6Z9OvzXxWYDhafOFiYt73ZzSpTDhxj4qDwPRXUmBcxoc
	2A7Uft/cIfk=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3E33D19F64;
	Tue, 20 May 2014 17:33:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1C55D19F60;
	Tue, 20 May 2014 17:33:35 -0400 (EDT)
In-Reply-To: <537BC8A2.9060009@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Tue, 20 May 2014 22:26:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 65D96430-E066-11E3-BA26-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249748>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> This patch is an RFC, because I take a different approach to the
> above solution, only because the diff is much smaller and easier
> to read! Is it a better solution?
>
> ATB,
> Ramsay Jones
>
>  t/t0000-basic.sh | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index 8345c8a..373ad8f 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -296,8 +296,9 @@ test_expect_success 'test --verbose-only' '
>  '
>  
>  test_expect_success 'GIT_SKIP_TESTS' "
> -	GIT_SKIP_TESTS='git.2' \
> -		run_sub_test_lib_test git-skip-tests-basic \
> +	GIT_SKIP_TESTS='git.2' && export GIT_SKIP_TESTS &&
> +	test_when_finished sane_unset GIT_SKIP_TESTS &&
> +	run_sub_test_lib_test git-skip-tests-basic \
>  		'GIT_SKIP_TESTS' <<-\\EOF &&

The original is clearly wrong if run_sub_test_lib_test is a shell
function.  I thought we hunted those down and killed them already,
but apparently we didn't.

I think exporting the variable and then clearing it in
test-when-finished is fine, and doing the export and run in a
subshell so that you do not have to clear is also fine.

>  	for i in 1 2 3
>  	do
> @@ -315,8 +316,9 @@ test_expect_success 'GIT_SKIP_TESTS' "
>  "
>  
>  test_expect_success 'GIT_SKIP_TESTS several tests' "
> -	GIT_SKIP_TESTS='git.2 git.5' \
> -		run_sub_test_lib_test git-skip-tests-several \
> +	GIT_SKIP_TESTS='git.2 git.5' && export GIT_SKIP_TESTS &&
> +	test_when_finished sane_unset GIT_SKIP_TESTS &&
> +	run_sub_test_lib_test git-skip-tests-several \
>  		'GIT_SKIP_TESTS several tests' <<-\\EOF &&
>  	for i in 1 2 3 4 5 6
>  	do
> @@ -337,8 +339,9 @@ test_expect_success 'GIT_SKIP_TESTS several tests' "
>  "
>  
>  test_expect_success 'GIT_SKIP_TESTS sh pattern' "
> -	GIT_SKIP_TESTS='git.[2-5]' \
> -		run_sub_test_lib_test git-skip-tests-sh-pattern \
> +	GIT_SKIP_TESTS='git.[2-5]' && export GIT_SKIP_TESTS &&
> +	test_when_finished sane_unset GIT_SKIP_TESTS &&
> +	run_sub_test_lib_test git-skip-tests-sh-pattern \
>  		'GIT_SKIP_TESTS sh pattern' <<-\\EOF &&
>  	for i in 1 2 3 4 5 6
>  	do
