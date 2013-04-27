From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/9] completion: add file completion tests
Date: Sat, 27 Apr 2013 14:24:31 -0700
Message-ID: <7vehdvu0og.fsf@alter.siamese.dyndns.org>
References: <1367093407-8898-1-git-send-email-felipe.contreras@gmail.com>
	<1367093407-8898-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Manlio Perillo <manlio.perillo@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 23:24:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWCbm-0004BB-Tk
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 23:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753898Ab3D0VYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 17:24:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57561 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753369Ab3D0VYe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 17:24:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBD261A61E;
	Sat, 27 Apr 2013 21:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x8G4XfnAS2JKfH8q5sEGsK3rnIA=; b=MHxLax
	56TL7NawVgRbR0QbqUhRpi+9iZUOdjmLk1JebsjIYW3OOOBzUA93sV9B3K0k4alZ
	EqlgLvIPJlXTbKnrzTaRpTUcCD8YJYyviUCOaC3Eg+k6BJPd7Lmd2FbdwUWDvuIl
	B1fvbFvQIZenHXNZePX9G7RLMdLWgm7hWzAZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qYJ0yNZ9U4pGocdVowYf++O2weDX44xY
	KBA2P6zV+NQYRAfzG7uXUTA8zFQXpAati2FjQBOWL8NI66zXWb/jKZLJEd77kcW4
	kj5ldS/lQU9nUWTnHDIA+Yi2C0x78dssB97zPXIl/6nRsGD4Fv49/LZagsi7w5LO
	T+H/m20YUcQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D36AA1A61D;
	Sat, 27 Apr 2013 21:24:33 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 380DD1A61B;
	Sat, 27 Apr 2013 21:24:33 +0000 (UTC)
In-Reply-To: <1367093407-8898-2-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sat, 27 Apr 2013 15:09:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DA949B36-AF80-11E2-96EB-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222700>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> The commit fea16b4 (git-completion.bash: add support for path
> completion) introduced quite a few changes, without the usual tests.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  t/t9902-completion.sh | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 6d9d141..385e1e4 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -347,4 +347,72 @@ test_expect_success 'send-email' '
>  	test_completion "git send-email ma" "master "
>  '
>  
> +test_expect_success 'complete files' '
> +	git init tmp && cd tmp &&
> +	test_when_finished "cd .. && rm -rf tmp" &&

Hmm, this construct is not very nice.

Later part of the code can be modified carelessly and chdir around
even more, and "cd .." may end up at an unexpected place.  Can't
this be done in a way to make later reviews of patches that come
after this change lands doable without looking at the whole 70
lines?  For example, if the test ran the whole "these are done in a
subdirectry" part, starting from the "cd tmp", inside a subshell,
and "rm -rf tmp" is done in the original shell that ran "git init
tmp" to create it, it would make it much harder to make mistakes for
anybody who add new code to the body of the test to affect the
clean-up part.

> +
> +	echo "expected" > .gitignore &&
> +	echo "out" >> .gitignore &&

Style: we tend to omit SP between redireciton operator and targets.

> +	git add .gitignore &&
> +	test_completion "git commit " ".gitignore" &&
> +
> +	git commit -m ignore &&
> +
> +	touch new &&
> +	test_completion "git add " "new" &&
> +
> +	git add new &&
> +	git commit -a -m new &&
> +	test_completion "git add " "" &&
> +
> +	git mv new modified &&
> +	echo modify > modified &&
> +	test_completion "git add " "modified" &&
> +
> +	touch untracked &&
> +
> +	: TODO .gitignore should not be here &&
> +	test_completion "git rm " <<-\EOF &&
> +	.gitignore
> +	modified
> +	EOF
> +
> +	test_completion "git clean " "untracked" &&
> +
> +	: TODO .gitignore should not be here &&
> +	test_completion "git mv " <<-\EOF &&
> +	.gitignore
> +	modified
> +	EOF
> +
> +	mkdir dir &&
> +	touch dir/file-in-dir &&
> +	git add dir/file-in-dir &&
> +	git commit -m dir &&
> +
> +	mkdir untracked-dir &&
> +
> +	: TODO .gitignore should not be here &&
> +	test_completion "git mv modified " <<-\EOF &&
> +	.gitignore
> +	dir
> +	modified
> +	untracked
> +	untracked-dir
> +	EOF
> +
> +	test_completion "git commit " "modified" &&
> +
> +	: TODO .gitignore should not be here &&
> +	test_completion "git ls-files " <<-\EOF
> +	.gitignore
> +	dir
> +	modified
> +	EOF
> +
> +	touch momified &&
> +	test_completion "git add mom" "momified"
> +'
> +
>  test_done
