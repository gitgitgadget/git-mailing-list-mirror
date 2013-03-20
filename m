From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH jk/checkout-attribute-lookup] t2003: work around path
 mangling issue on Windows
Date: Wed, 20 Mar 2013 10:10:10 -0700
Message-ID: <7vli9if159.fsf@alter.siamese.dyndns.org>
References: <514977BD.6060604@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 20 18:10:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIMXE-0008N5-GF
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 18:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757314Ab3CTRKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 13:10:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39417 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932082Ab3CTRKN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 13:10:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A079AB4F;
	Wed, 20 Mar 2013 13:10:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5rJ+tFz2oK0sfY2MTCkLcXFfXnI=; b=r8hZ5S
	Sx+kXKQ/L8qTOKo9HTXXsBoV0cPGQOaZnUw/HLSMrDsk+1wjSZEpNbtdqopzt6tB
	ZypXbrjUhXseNZwOd9pAaGQXhYJJCC9OA7whLnJow3Da5MmlqriNyd0zkg2PNwzc
	x9cdhjoLcSa5C7kbANcWgl2gmn4wKGzbjplTs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R3cx0U1QAcb6I0p5JKiHyaAj2KDhYkDa
	4T4MRO70643PIowlrAK8Io62FcmGJhuQU+rbTCc3stMqO89ATnz8andIFgkWmBFc
	VeH0RgmNcxA0hZbumkKyVeTKfDgdUR3hz50yyLQkBJtvwaNz3dHOP/T0ThEBeeYP
	L269c2yWRog=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E3FAAB4D;
	Wed, 20 Mar 2013 13:10:13 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D645AB4A; Wed, 20 Mar 2013
 13:10:12 -0400 (EDT)
In-Reply-To: <514977BD.6060604@viscovery.net> (Johannes Sixt's message of
 "Wed, 20 Mar 2013 09:47:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 06B57C30-9181-11E2-865C-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218621>

Johannes Sixt <j.sixt@viscovery.net> writes:

> From: Johannes Sixt <j6t@kdbg.org>
>
> MSYS bash considers the part "/g" in the sed expression "s/./=/g" as an
> absolute path after an assignment, and mangles it to a C:/something
> string. Do not attract bash's attention by avoiding the equals sign.

If this breakage is about path mangling, I suspect it may be cleaner
to work it around by not using / as the pattern separator, e.g.

	sed -e s!.!=!g

Or perhaps use SHELL_PATH to point at a more reasonable
implementation of shell that does not have such an idiocy?

> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  t/t2003-checkout-cache-mkdir.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t2003-checkout-cache-mkdir.sh b/t/t2003-checkout-cache-mkdir.sh
> index 4c97468..ff163cf 100755
> --- a/t/t2003-checkout-cache-mkdir.sh
> +++ b/t/t2003-checkout-cache-mkdir.sh
> @@ -94,14 +94,14 @@ test_expect_success 'apply filter from working tree .gitattributes with --prefix
>  	rm -fr path0 path1 path2 tmp* &&
>  	mkdir path1 &&
>  	mkdir tmp &&
> -	git config filter.replace-all.smudge "sed -e s/./=/g" &&
> +	git config filter.replace-all.smudge "sed -e s/./,/g" &&
>  	git config filter.replace-all.clean cat &&
>  	git config filter.replace-all.required true &&
>  	echo "file1 filter=replace-all" >path1/.gitattributes &&
>  	git checkout-index --prefix=tmp/ -f -a &&
>  	echo frotz >expected &&
>  	test_cmp expected tmp/path0 &&
> -	echo ====== >expected &&
> +	echo ,,,,,, >expected &&
>  	test_cmp expected tmp/path1/file1
>  '
