From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unpack-trees: do not delete i-t-a entries in worktree even when forced
Date: Wed, 24 Feb 2016 14:57:37 -0800
Message-ID: <xmqqa8mpsom6.fsf@gitster.mtv.corp.google.com>
References: <1456314317-30301-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 23:58:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiNa-0002ML-DT
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 23:57:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758435AbcBXW5m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2016 17:57:42 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50399 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753568AbcBXW5k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Feb 2016 17:57:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4AC234745B;
	Wed, 24 Feb 2016 17:57:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=NDzDamG2JFG6
	bQxRH0V2FsY14tY=; b=OGLE5MVlPzSh+gS3hj/JIIER+Tt5J/BA96oqPPIN4gl2
	MiRRqDyjfL+Mm6/JKBiCtVhdFmfTrlbe7YvtkcPAywDH4NdlXh0ysSMJSpEkl2/h
	RjbDwMXj/0BuVdemhNR7BCA9TC2BeVhtdj7MAAo5N8saj0nj1P4F/82+jOpMYmM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dgQem9
	O9oe0Bfhdf7ORpR7vLe+RLccCYM+6vNjlKac2Drboce8DFH+cyC8tfO6Y3Z9Bp9l
	v72DMY7ETPWBVicrYRyEq+q9K+RqFZc8CR9o97/mWxa6xAKClmJmMoQWc4iM+fD5
	ekJEgyXTfJvvDf/I7QOsLIiVYdHK4L+SrTNlY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 422764745A;
	Wed, 24 Feb 2016 17:57:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 79A7747453;
	Wed, 24 Feb 2016 17:57:38 -0500 (EST)
In-Reply-To: <1456314317-30301-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 24
 Feb 2016 18:45:17 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 00617BD4-DB4A-11E5-8CFA-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287242>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Intent-to-add entries are basically "I may want to commit these files
> later, but for now they are untracked". As such, when the user does "=
git
> reset --hard <tree>", which removes i-t-a entries from the index, i-t=
-a
> entries in worktree should be kept as untracked.

Hmm, I can see that the control flow of "reset --hard" for an i-t-a
path does pass through this function, but it is not very obvious
to see how this will not negatively affect other uses of the
unpack-trees machinery (e.g. "checkout" and "merge", especially when
such a path needs to turn into a directory by getting removed).

>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Lost two files today, luckily I had a backup.
>
>  t/t2203-add-intent.sh | 15 +++++++++++++++
>  unpack-trees.c        |  2 +-
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
> index 2a4a749..63086bf 100755
> --- a/t/t2203-add-intent.sh
> +++ b/t/t2203-add-intent.sh
> @@ -82,5 +82,20 @@ test_expect_success 'cache-tree invalidates i-t-a =
paths' '
>  	test_cmp expect actual
>  '
> =20
> +test_expect_success 'reset --hard leaves on-disk ita entries alone' =
'
> +	git init keep-ita &&
> +	(
> +	cd keep-ita &&
> +	echo abc >abc &&
> +	echo def >def &&
> +	git add abc &&
> +	git commit -m abc &&
> +	git add -N def &&
> +	git reset --hard HEAD &&
> +	echo def >expected &&
> +	test_cmp expected def
> +	)
> +'
> +
>  test_done
> =20
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 9f55cc2..1a2271b 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -104,7 +104,7 @@ static int do_add_entry(struct unpack_trees_optio=
ns *o, struct cache_entry *ce,
>  {
>  	clear |=3D CE_HASHED;
> =20
> -	if (set & CE_REMOVE)
> +	if ((set & CE_REMOVE) && !ce_intent_to_add(ce))
>  		set |=3D CE_WT_REMOVE;
> =20
>  	ce->ce_flags =3D (ce->ce_flags & ~clear) | set;
