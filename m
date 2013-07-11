From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] t4203: test mailmap functionality directly rather than indirectly
Date: Thu, 11 Jul 2013 12:07:33 -0700
Message-ID: <7vhag0rk3u.fsf@alter.siamese.dyndns.org>
References: <1373554528-15775-1-git-send-email-sunshine@sunshineco.com>
	<1373554528-15775-4-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 21:07:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxMDS-0007XG-Pi
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 21:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756572Ab3GKTHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 15:07:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33952 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756435Ab3GKTHm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 15:07:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDED92F629;
	Thu, 11 Jul 2013 19:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OIfFVaoiXdanql5Ejl3YQ7Lvnj8=; b=Cr29hD
	XG+rvXgJi5glyXsJovIfIhQQvhGYqcdWSQn/lCM4njdzdJk1NugN/DWdQKTP0VW1
	DcLc2ERKVz2eG0d81oyinFaZ+70X5Na9wE14om3A8IRB5UXy6BIGwixtIS54NsgZ
	ACwkcvxSvop8UAEnXp6QSIiYDYUwU551VZOQo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jUIIqQlQP90cLnXuGX0LTG26qhOiu09P
	MkOxdiShizLLgMCHtf/WV3AEkQtY2+h3JhGH9sOcm6O33qlar6Nd/6Y4F5M4niHL
	o6+01H8nl4FqL0HROuxbUDmqWe+9wf6Go5fiyQuo6SYvMac36mjzRuygkjJyb7fA
	q7YKQSLg9E0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8F622F615;
	Thu, 11 Jul 2013 19:07:37 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EE7FB2F5F8;
	Thu, 11 Jul 2013 19:07:34 +0000 (UTC)
In-Reply-To: <1373554528-15775-4-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Thu, 11 Jul 2013 10:55:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 251AD6AE-EA5D-11E2-89B2-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230126>

Eric Sunshine <sunshine@sunshineco.com> writes:

> With the introduction of check-mailmap, it is now possible to check
> .mailmap functionality directly rather than indirectly as a side-effect
> of other commands (such as git-shortlog), therefore, do so.

Does this patch mean that we will now ignore future breakages in
shortlog and blame if their mailmap integration becomes buggy?

I am not convinced it is a good idea if that is what is going on.

>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  t/t4203-mailmap.sh | 133 ++++++++++++++++++-----------------------------------
>  1 file changed, 45 insertions(+), 88 deletions(-)
>
> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
> index 8645492..48a000b 100755
> --- a/t/t4203-mailmap.sh
> +++ b/t/t4203-mailmap.sh
> @@ -74,128 +74,96 @@ test_expect_success 'check-mailmap bogus contact' '
>  '
>  
>  cat >expect <<\EOF
> -A U Thor (1):
> -      initial
> -
> -nick1 (1):
> -      second
> -
> +A U Thor <author@example.com>
> +nick1 <bugs@company.xx>
>  EOF
>  
>  test_expect_success 'No mailmap' '
> -	git shortlog HEAD >actual &&
> +	git check-mailmap --stdin <contacts >actual &&
>  	test_cmp expect actual
>  '
>  
>  cat >expect <<\EOF
> -Repo Guy (1):
> -      initial
> -
> -nick1 (1):
> -      second
> -
> +Repo Guy <author@example.com>
> +nick1 <bugs@company.xx>
>  EOF
>  
>  test_expect_success 'default .mailmap' '
>  	echo "Repo Guy <author@example.com>" > .mailmap &&
> -	git shortlog HEAD >actual &&
> +	git check-mailmap --stdin <contacts >actual &&
>  	test_cmp expect actual
>  '
>  
>  # Using a mailmap file in a subdirectory of the repo here, but
>  # could just as well have been a file outside of the repository
>  cat >expect <<\EOF
> -Internal Guy (1):
> -      second
> -
> -Repo Guy (1):
> -      initial
> -
> +Repo Guy <author@example.com>
> +Internal Guy <bugs@company.xx>
>  EOF
>  test_expect_success 'mailmap.file set' '
>  	mkdir -p internal_mailmap &&
>  	echo "Internal Guy <bugs@company.xx>" > internal_mailmap/.mailmap &&
>  	git config mailmap.file internal_mailmap/.mailmap &&
> -	git shortlog HEAD >actual &&
> +	git check-mailmap --stdin <contacts >actual &&
>  	test_cmp expect actual
>  '
>  
>  cat >expect <<\EOF
> -External Guy (1):
> -      initial
> -
> -Internal Guy (1):
> -      second
> -
> +External Guy <author@example.com>
> +Internal Guy <bugs@company.xx>
>  EOF
>  test_expect_success 'mailmap.file override' '
>  	echo "External Guy <author@example.com>" >> internal_mailmap/.mailmap &&
>  	git config mailmap.file internal_mailmap/.mailmap &&
> -	git shortlog HEAD >actual &&
> +	git check-mailmap --stdin <contacts >actual &&
>  	test_cmp expect actual
>  '
>  
>  cat >expect <<\EOF
> -Repo Guy (1):
> -      initial
> -
> -nick1 (1):
> -      second
> -
> +Repo Guy <author@example.com>
> +nick1 <bugs@company.xx>
>  EOF
>  
>  test_expect_success 'mailmap.file non-existent' '
>  	rm internal_mailmap/.mailmap &&
>  	rmdir internal_mailmap &&
> -	git shortlog HEAD >actual &&
> +	git check-mailmap --stdin <contacts >actual &&
>  	test_cmp expect actual
>  '
>  
>  cat >expect <<\EOF
> -Internal Guy (1):
> -      second
> -
> -Repo Guy (1):
> -      initial
> -
> +Repo Guy <author@example.com>
> +Internal Guy <bugs@company.xy>
>  EOF
>  
>  test_expect_success 'name entry after email entry' '
>  	mkdir -p internal_mailmap &&
>  	echo "<bugs@company.xy> <bugs@company.xx>" >internal_mailmap/.mailmap &&
>  	echo "Internal Guy <bugs@company.xx>" >>internal_mailmap/.mailmap &&
> -	git shortlog HEAD >actual &&
> +	git check-mailmap --stdin <contacts >actual &&
>  	test_cmp expect actual
>  '
>  
>  cat >expect <<\EOF
> -Internal Guy (1):
> -      second
> -
> -Repo Guy (1):
> -      initial
> -
> +Repo Guy <author@example.com>
> +Internal Guy <bugs@company.xy>
>  EOF
>  
>  test_expect_success 'name entry after email entry, case-insensitive' '
>  	mkdir -p internal_mailmap &&
>  	echo "<bugs@company.xy> <bugs@company.xx>" >internal_mailmap/.mailmap &&
>  	echo "Internal Guy <BUGS@Company.xx>" >>internal_mailmap/.mailmap &&
> -	git shortlog HEAD >actual &&
> +	git check-mailmap --stdin <contacts >actual &&
>  	test_cmp expect actual
>  '
>  
>  cat >expect <<\EOF
> -A U Thor (1):
> -      initial
> -
> -nick1 (1):
> -      second
> -
> +A U Thor <author@example.com>
> +nick1 <bugs@company.xx>
>  EOF
>  test_expect_success 'No mailmap files, but configured' '
>  	rm -f .mailmap internal_mailmap/.mailmap &&
> -	git shortlog HEAD >actual &&
> +	git check-mailmap --stdin <contacts >actual &&
>  	test_cmp expect actual
>  '
>  
> @@ -217,54 +185,43 @@ test_expect_success 'setup mailmap blob tests' '
>  
>  test_expect_success 'mailmap.blob set' '
>  	cat >expect <<-\EOF &&
> -	Blob Guy (1):
> -	      second
> -
> -	Repo Guy (1):
> -	      initial
> -
> +	Repo Guy <author@example.com>
> +	Blob Guy <bugs@company.xx>
>  	EOF
> -	git -c mailmap.blob=map:just-bugs shortlog HEAD >actual &&
> +	git -c mailmap.blob=map:just-bugs check-mailmap --stdin \
> +		<contacts >actual &&
>  	test_cmp expect actual
>  '
>  
>  test_expect_success 'mailmap.blob overrides .mailmap' '
>  	cat >expect <<-\EOF &&
> -	Blob Guy (2):
> -	      initial
> -	      second
> -
> +	Blob Guy <author@example.com>
> +	Blob Guy <bugs@company.xx>
>  	EOF
> -	git -c mailmap.blob=map:both shortlog HEAD >actual &&
> +	git -c mailmap.blob=map:both check-mailmap --stdin \
> +		<contacts  >actual &&
>  	test_cmp expect actual
>  '
>  
>  test_expect_success 'mailmap.file overrides mailmap.blob' '
>  	cat >expect <<-\EOF &&
> -	Blob Guy (1):
> -	      second
> -
> -	Internal Guy (1):
> -	      initial
> -
> +	Internal Guy <author@example.com>
> +	Blob Guy <bugs@company.xx>
>  	EOF
>  	git \
>  	  -c mailmap.blob=map:both \
>  	  -c mailmap.file=internal.map \
> -	  shortlog HEAD >actual &&
> +	  check-mailmap --stdin <contacts >actual &&
>  	test_cmp expect actual
>  '
>  
>  test_expect_success 'mailmap.blob can be missing' '
>  	cat >expect <<-\EOF &&
> -	Repo Guy (1):
> -	      initial
> -
> -	nick1 (1):
> -	      second
> -
> +	Repo Guy <author@example.com>
> +	nick1 <bugs@company.xx>
>  	EOF
> -	git -c mailmap.blob=map:nonexistent shortlog HEAD >actual &&
> +	git -c mailmap.blob=map:nonexistent check-mailmap --stdin \
> +		<contacts >actual &&
>  	test_cmp expect actual
>  '
>  
> @@ -273,12 +230,12 @@ test_expect_success 'mailmap.blob defaults to off in non-bare repo' '
>  	(
>  		cd non-bare &&
>  		test_commit one .mailmap "Fake Name <author@example.com>" &&
> -		echo "     1	Fake Name" >expect &&
> -		git shortlog -ns HEAD >actual &&
> +		echo "Fake Name <author@example.com>" >expect &&
> +		git check-mailmap "A U Thor <author@example.com>" >actual &&
>  		test_cmp expect actual &&
>  		rm .mailmap &&
> -		echo "     1	A U Thor" >expect &&
> -		git shortlog -ns HEAD >actual &&
> +		echo "A U Thor <author@example.com>" >expect &&
> +		git check-mailmap "A U Thor <author@example.com>" >actual &&
>  		test_cmp expect actual
>  	)
>  '
> @@ -287,8 +244,8 @@ test_expect_success 'mailmap.blob defaults to HEAD:.mailmap in bare repo' '
>  	git clone --bare non-bare bare &&
>  	(
>  		cd bare &&
> -		echo "     1	Fake Name" >expect &&
> -		git shortlog -ns HEAD >actual &&
> +		echo "Fake Name <author@example.com>" >expect &&
> +		git check-mailmap "A U Thor <author@example.com>" >actual &&
>  		test_cmp expect actual
>  	)
>  '
