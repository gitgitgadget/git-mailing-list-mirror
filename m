From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Ignore dirty submodule states during stash
Date: Tue, 17 May 2016 09:15:24 -0700
Message-ID: <xmqqmvnoy82r.fsf@gitster.mtv.corp.google.com>
References: <20160517131635.GA5299@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Vasily Titskiy <qehgt0@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 17 18:15:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2heg-0001IO-4n
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 18:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755424AbcEQQP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 12:15:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53731 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751829AbcEQQP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 12:15:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A068E193E3;
	Tue, 17 May 2016 12:15:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vx+eDUxPgeDL8jPcJjmOZxbLEy0=; b=Wh6QLo
	UQvAPCLroVjSgRWte6gxYwaTINu0JRNZ27oV9vbdXlr0aR24E2P+MFZ8ROwQHd8J
	8rCUMQualmflQ6K1KzrYESdh1+P1VFUvBB3UE90LxF9XXHu81fLqSlZ9npFUzSt8
	4X4u/NKNZAxn0QcEZOAM4/iIGejNpcuMVAbcI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TgLRQL6DeqBzPJprFQdq2gAjwZiXyinv
	QAdzZY+9JPvJ3oSriFgXaETHrpm32ZLIYcl8PaB7KxncoAyWMVD/FEV4JhB3D3a6
	E6Vd9wbPIfGT6bROt+BKxyfwbANBdBByWBKOLIsw0OMWYXvx9CSvMm/3NG7S3lL+
	a1HQEWm6BbE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 986D8193E2;
	Tue, 17 May 2016 12:15:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 18E6E193DF;
	Tue, 17 May 2016 12:15:27 -0400 (EDT)
In-Reply-To: <20160517131635.GA5299@gmail.com> (Vasily Titskiy's message of
	"Tue, 17 May 2016 13:16:35 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 913C0584-1C4A-11E6-AA2C-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294869>

Vasily Titskiy <qehgt0@gmail.com> writes:

> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 2142c1f..1be62f3 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -731,4 +731,38 @@ test_expect_success 'stash list --cc shows combined diff' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'stash ignores changes in submodules' '
> +	git submodule init &&

Hmmmm... what is this "submodule init" needed for at this point in
the test sequence?

> +	git init sub1 &&
> +	(
> +		cd sub1 &&
> +		echo "x" >file1 &&
> +		git add file1 &&
> +		git commit -a -m "initial sub1"
> +	) &&
> +	git submodule add ./. sub1 &&
> +	echo "main" >file1 &&
> +	git add file1 &&
> +	git commit -a -m "initial main" &&
> +	# make changes in submodule
> +	(
> +		cd sub1 &&
> +		echo "y" >>file1 &&
> +		git commit -a -m "change y"
> +	) &&
> +	git commit sub1 -m "update reference" &&
> +	# switch submodule to another revision
> +	(
> +		cd sub1 &&
> +		echo "z" >>file1 &&
> +		git commit -a -m "change z"
> +	) &&
> +	# everything is prepared, check if changes in submodules are ignored
> +	echo "local change" >>file1 &&
> +	git stash save &&
> +	git checkout HEAD~1 &&
> +	git submodule update &&
> +	git stash pop
> +'
> +
>  test_done
