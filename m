From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] entry: fix filter lookup
Date: Thu, 14 Mar 2013 14:50:45 -0700
Message-ID: <7vwqt9wszu.fsf@alter.siamese.dyndns.org>
References: <7vehfhyjgv.fsf@alter.siamese.dyndns.org>
 <cover.1363291173.git.john@keeping.me.uk>
 <bede6d48dd44f7ed4a11da5821bb112b700475d5.1363291173.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Matt McClure <matthewlmcclure@gmail.com>,
	Tim Henigan <tim.henigan@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Mar 14 22:51:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGG3R-0005bJ-SY
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 22:51:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140Ab3CNVuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 17:50:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48509 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752292Ab3CNVuu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 17:50:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71F11CD8F;
	Thu, 14 Mar 2013 17:50:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ohTiGqWLvcnyajP7IZPSwKM+Jwg=; b=wEleNv
	5/g6BKaRq7ig/T5kcUpPPZVgWndeT6shhTTh2DUU40LAhLn5qGOjd2QIATy85CDT
	9Ydz+Rl0xOQE5ZuiCQ2nl/BzUoRGgB90tgzaxDJUIPse9zazY1njdFXe6V4q8qQw
	8M3KBe0vzokCgomEE1yXXfHnsrS37w8RXUmAY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=swDQqbK8g/8iF2kchIRUnkORSigkV7Xn
	dhkLl1etzxQ8GYhkKsIcV18VSCXDtCVrjlfvQzIsveWb6Bc6Bo9alY4m75zCsXwv
	HypWyuJRhmV8wBxkSH/W/oLxgW87F3FwObsYHj0+G4+6+kvyAuf8keiko4Muctp2
	CW05LLO0+TU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64C94CD8E;
	Thu, 14 Mar 2013 17:50:47 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA956CD8C; Thu, 14 Mar 2013
 17:50:46 -0400 (EDT)
In-Reply-To: <bede6d48dd44f7ed4a11da5821bb112b700475d5.1363291173.git.john@keeping.me.uk>
 (John Keeping's message of "Thu, 14 Mar 2013 20:00:51 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3A4E213A-8CF1-11E2-8783-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218172>

John Keeping <john@keeping.me.uk> writes:

> diff --git a/t/t2003-checkout-cache-mkdir.sh b/t/t2003-checkout-cache-mkdir.sh
> index 63fd0a8..4c97468 100755
> --- a/t/t2003-checkout-cache-mkdir.sh
> +++ b/t/t2003-checkout-cache-mkdir.sh
> @@ -90,4 +90,30 @@ test_expect_success SYMLINKS 'use --prefix=tmp- where tmp-path1 is a symlink' '
>  	test -f tmp-path1/file1
>  '
>  
> +test_expect_success 'apply filter from working tree .gitattributes with --prefix' '
> +	rm -fr path0 path1 path2 tmp* &&
> +	mkdir path1 &&
> +	mkdir tmp &&
> +	git config filter.replace-all.smudge "sed -e s/./=/g" &&
> +	git config filter.replace-all.clean cat &&
> +	git config filter.replace-all.required true &&
> +	echo "file1 filter=replace-all" >path1/.gitattributes &&
> +	git checkout-index --prefix=tmp/ -f -a &&
> +	echo frotz >expected &&
> +	test_cmp expected tmp/path0 &&
> +	echo ====== >expected &&
> +	test_cmp expected tmp/path1/file1
> +'
> +
> +test_expect_success 'apply CRLF filter from working tree .gitattributes with --prefix' '
> +	rm -fr path0 path1 path2 tmp* &&
> +	mkdir path1 &&
> +	mkdir tmp &&
> +	echo "file1 eol=crlf" >path1/.gitattributes &&
> +	git checkout-index --prefix=tmp/ -f -a &&
> +	echo rezrovQ >expected &&
> +	tr \\015 Q <tmp/path1/file1 >actual &&
> +	test_cmp expected actual
> +'

Nicely done.  Thanks.
