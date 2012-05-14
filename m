From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pack-objects: use streaming interface for reading
 large loose blobs
Date: Mon, 14 May 2012 12:43:19 -0700
Message-ID: <7v62byh7l4.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.02.1205121220070.21030@xanadu.home>
 <1336883862-9013-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 14 21:43:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SU1B2-0004YE-41
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 21:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757653Ab2ENTnX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 May 2012 15:43:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42977 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757130Ab2ENTnW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 May 2012 15:43:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F41249DFE;
	Mon, 14 May 2012 15:43:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1aj2pnTwGJgg
	UW2SzgVMHMNLICI=; b=IK94PpJV1x8FivZ8KWYSEj29BLLWQz566j+pcJX8xg0c
	SQjVF/tfxxU6x1S9pHXZE18O3qI5JujmbEbwS5zX7jBNTQVYLklxZ/989k087kdv
	OEn9KjCyhu0hZFvnsXWcYtZDAyzPBOaJ63+AA6Hc48YJjO7IwS4rIY9fE0MGRnI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=HLeD+E
	FAl2vhxmgghJJqXwZ8ETnyqkgpV3sqljEQ39HaLIhivOGcXnWOzP1JeoPUzdoNuJ
	sUUMxmrz9Az1QNaRwK91fkXkHeD6N20qRPOEzqo6RgTnG9SzWDU+ShLWmlphDHvH
	UGx3hA1fH5Y2DZ+Ty0y4TrizsUOlDlL745i14=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAD959DFD;
	Mon, 14 May 2012 15:43:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E39F9DFC; Mon, 14 May 2012
 15:43:21 -0400 (EDT)
In-Reply-To: <1336883862-9013-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 13 May
 2012 11:37:42 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0FCE0E5E-9DFD-11E1-9ABA-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197804>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> git usually streams large blobs directly to packs. But there are case=
s
> diff --git a/t/t1050-large.sh b/t/t1050-large.sh
> index 55ed955..7fbd2e1 100755
> --- a/t/t1050-large.sh
> +++ b/t/t1050-large.sh
> @@ -134,6 +134,22 @@ test_expect_success 'repack' '
>  	git repack -ad
>  '
> =20
> +test_expect_success 'pack-objects with large loose object' '
> +	echo Z | dd of=3Dlarge4 bs=3D1k seek=3D2000 &&
> +	OBJ=3D9f36d94e145816ec642592c09cc8e601d83af157 &&
> +	P=3D.git/objects/9f/36d94e145816ec642592c09cc8e601d83af157 &&

I do not think you need these hardcoded constants; you will run
hash-object later, no?

Also, relying on $P to exist after hash-object -w returns is somewhat
flaky, no?

> +	(
> +	unset GIT_ALLOC_LIMIT &&

sane_unset?

> +	cat large4 | git hash-object -w --stdin &&
> +	git cat-file blob $OBJ >actual &&
> +	cmp large4 actual
> +	) &&
> +	echo $OBJ | git pack-objects .git/objects/pack/pack &&

If you do not write directly into this directory, and then
create another _empty_ repository and deposit the packfile and its
associated .idx file there, then you do not have to care how the earlie=
r
hash-object wrote its object.  You are interested only in pack-objects
producing a usable pack, and testing it like so will be the most direct
way to test it, no?

> +	rm $P &&
> +	git cat-file blob $OBJ >actual &&
> +	cmp large4 actual
> +'

In any case, the patch when applied on top of cd07cc5 (Update draft
release notes to 1.7.11 (11th batch), 2012-05-11) does not pass this pa=
rt
of the test on my box.

>  test_expect_success 'tar achiving' '
>  	git archive --format=3Dtar HEAD >/dev/null
>  '
