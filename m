From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7610-mergetool: add test cases for tempfile behavior
Date: Wed, 09 Mar 2016 12:43:31 -0800
Message-ID: <xmqqh9gfgz64.fsf@gitster.mtv.corp.google.com>
References: <1457501814-10599-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Charles Bailey <cbailey32@bloomberg.net>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 21:43:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adkxI-0005Mr-At
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 21:43:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895AbcCIUnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 15:43:37 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61086 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751536AbcCIUnf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 15:43:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2B6114CB96;
	Wed,  9 Mar 2016 15:43:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=97w76MqN9EJWRBSXKOQCbVtHr5A=; b=WZBUjO
	MKvxMibv+FW0IYQswFEqUjbJVMUt+vv/MX8DnVQoJMWl5RJ7qkUh83630XLsYO1i
	CWqEMKc6KOO8vj42nus0ALtEaU59NydcTzg3JIXCsEkxBKyHAzuwmiZAU2K9y4v9
	Fyrl8n/RyI63swLs7l3eIXsArls9HdlyGWgqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N1NjEU7Hr4GeqVRD4zfA7Xmio2Vn3sEl
	vQj6wtOgyil7k4zr2LKwSEHtznS8o+gTETzPdjs1Z9skGj1g0gA7Mdo6TsaEsZND
	a0boJ6bccYmlhh6B/msO5HFx5d3J+F4YWQLmBi/aR2zAQ4T6nEqjt1mPG7G45ZcA
	i/k7rnYEiwM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 21E934CB95;
	Wed,  9 Mar 2016 15:43:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 90C274CB94;
	Wed,  9 Mar 2016 15:43:33 -0500 (EST)
In-Reply-To: <1457501814-10599-1-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Tue, 8 Mar 2016 21:36:54 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9707113C-E637-11E5-8847-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288575>

David Aguilar <davvid@gmail.com> writes:

> Ensure that mergetool.keepTemporaries is honored when resolving
> delete/delete conflicts.
>
> Ensure that stderr stays empty, and that worktree directories
> created by mergetool to are removed.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  t/t7610-mergetool.sh | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)

Thanks.

> diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
> index f1668be..cf2eceb 100755
> --- a/t/t7610-mergetool.sh
> +++ b/t/t7610-mergetool.sh
> @@ -273,6 +273,40 @@ test_expect_success 'mergetool delete/delete conflict' '
>  	git reset --hard HEAD
>  '
>  
> +test_expect_success 'mergetool honors tempfile config for deleted files' '
> +	test_config mergetool.keepTemporaries false &&
> +	! git merge move-to-b &&

We'd like to catch a newly built Git segfaulting, so let's change
this to:

	test_must_fail git merge move-to-b &&

Two other "! git merge" in this patch need be changed the same way.

> +	echo d | git mergetool a/a/file.txt &&
> +	! test -d a &&
> +	git reset --hard HEAD
> +'
> +
> +test_expect_success 'mergetool produces no errors when keepBackup is used' '
> +	test_config mergetool.keepBackup true &&
> +	! git merge move-to-b &&
> +	: >expect &&
> +	echo d | git mergetool a/a/file.txt 2>actual &&
> +	test_cmp expect actual &&
> +	! test -d a &&
> +	git reset --hard HEAD
> +'
> +
> +test_expect_success 'mergetool keeps tempfiles when aborting delete/delete' '
> +	test_config mergetool.keepTemporaries true &&
> +	! git merge move-to-b &&
> +	! (echo a; echo n) | git mergetool a/a/file.txt &&
> +	test -d a/a &&
> +	cat  >expect <<\-EOF &&
> +file_BASE_.txt
> +file_LOCAL_.txt
> +file_REMOTE_.txt
> +-EOF

Let's use EOF not -EOF as the end marker for here document, but use
a dash in front of the marker to allow us indent the contents of the
here document, like this:

	cat >expect <<-\EOF &&
	file_BASE_.txt
	file_LOCAL_.txt
	file_REMOTE_.txt
	EOF

While at it, let's lose the extra SP after "cat".

> +	ls -1 a/a | sed -e "s/[0-9]*//g" >actual &&
> +	test_cmp expect actual &&
> +	git clean -fdx &&
> +	git reset --hard HEAD
> +'
>  test_expect_success 'deleted vs modified submodule' '
>  	git checkout -b test6 branch1 &&
>  	git submodule update -N &&


I'll queue this patch with the above-mentioned fixups squashed in,
but I suspect that another new test added by the previous patches
have the same "! git merge" issue we'd want to correct before we
start to move the topic to 'next' and to 'master', so perhaps you'd
want to reroll these three patches as two patches (i.e. squashing
this one to 1/2, correcting the test in 2/2) after 2.8 final ships?

Thanks.
