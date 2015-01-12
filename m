From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] t1020-subdirectory.sh: check hook pwd, $GIT_PREFIX
Date: Mon, 12 Jan 2015 14:38:23 -0800
Message-ID: <xmqq4mrv7hgg.fsf@gitster.dls.corp.google.com>
References: <54B0E1EE.2020301@kdbg.org>
	<1420931503-22857-1-git-send-email-rhansen@bbn.com>
	<1420931503-22857-3-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: j6t@kdbg.org, git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 23:38:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAndD-0000zH-Lr
	for gcvg-git-2@plane.gmane.org; Mon, 12 Jan 2015 23:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbbALWij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 17:38:39 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65202 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751214AbbALWii (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 17:38:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B6F292FF49;
	Mon, 12 Jan 2015 17:38:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6fLHRjYeoQxY9KS4nnLM7yHoYmQ=; b=SKt/7l
	i2xs2Vkhpiz0ilVVEhuNJdx2UUT3sBtxHKP/YQduDNwJgbIbNCii3QwewNqfwJbU
	EB+W+ya40K1BeayhF8b3ugCdGbj0IZEehdWCgiKQur0Rz52H0a8pITQhOl+BUJGI
	+TqTn3OREKI/YPe/CJ7WnQtBDHFHhZbd+uxg4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xG0w9cQfga65XTOXWZyYDyHVJ11voTXg
	aHp/mSY7PgL7h5st+oEvpTS0XdUWaqgxGv5NDbLuznmSeP9ERb6XGIUbNqhMQR1L
	P6yJIUXX+ujUIjvZB7yFGzyq6fmHSq2HJyXs51VKW5IKVOggj0+Pg9F2pq5mouvk
	HFRd5nDz2aE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AC6F92FF47;
	Mon, 12 Jan 2015 17:38:37 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3619D2FF45;
	Mon, 12 Jan 2015 17:38:37 -0500 (EST)
In-Reply-To: <1420931503-22857-3-git-send-email-rhansen@bbn.com> (Richard
	Hansen's message of "Sat, 10 Jan 2015 18:11:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BF9653CA-9AAB-11E4-AF36-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262298>

Richard Hansen <rhansen@bbn.com> writes:

> Make sure hooks are executed at the top-level directory and that
> GIT_PREFIX is set (as documented).

The same comment as the one for 1/2 applies here.  If we substitute
'hook' everywhere with 'post-checkout hook' in this patch, it makes
perfect sense to me, but otherwise this is far from "check _hook_"
in general.

> Signed-off-by: Richard Hansen <rhansen@bbn.com>
> ---
>  t/t1020-subdirectory.sh | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
> index 2edb4f2..0ccbb7e 100755
> --- a/t/t1020-subdirectory.sh
> +++ b/t/t1020-subdirectory.sh
> @@ -128,6 +128,17 @@ test_expect_success !MINGW '!alias expansion' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'hook pwd' '
> +	rm -f actual &&
> +	mkdir -p .git/hooks &&
> +	write_script .git/hooks/post-checkout <<-\EOF &&
> +		pwd >actual
> +	EOF
> +	test_when_finished "rm -f .git/hooks/post-checkout actual" &&
> +	(cd dir && git checkout -- two) &&
> +	test_path_is_file actual

Cute, but it is misleading to use "pwd" there, because the contents
of the file does not matter for this test, even though the test is
about the current directory.  It forces the reader to look for the
place where you are comparing the contents of that file with
expected path to the current directory, and no such code exists.

"date >actual", "echo >actual", or even just a redirection without
command, i.e. ">actual", woudl have been easier to see what is going
on (I would have used the last form if I were doing this patch).

> +'
> +
>  test_expect_success 'GIT_PREFIX for !alias' '
>  	printf "dir/" >expect &&
>  	(
> @@ -154,6 +165,18 @@ test_expect_success 'GIT_PREFIX for built-ins' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'GIT_PREFIX for hooks' '
> +	printf "dir/" >expect &&
> +	rm -f actual &&
> +	mkdir -p .git/hooks &&
> +	write_script .git/hooks/post-checkout <<-\EOF &&
> +		printf %s "$GIT_PREFIX" >actual
> +	EOF
> +	test_when_finished "rm -f .git/hooks/post-checkout expect actual" &&
> +	(cd dir && git checkout -- two) &&
> +	test_cmp expect actual
> +'

It is not wrong per-se, but the same cute trick could have been
used, i.e.

	write_script ... post-checkout <<-\EOF &&
        >"$GIT_PREFIX/actual"
        EOF
        ...
        test_path_is_file dir/actual




> +
>  test_expect_success 'no file/rev ambiguity check inside .git' '
>  	git commit -a -m 1 &&
>  	(
