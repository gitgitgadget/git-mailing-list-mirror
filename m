From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/27] upload-pack: make check_non_tip() clean things up error
Date: Fri, 10 Jun 2016 13:25:45 -0700
Message-ID: <xmqqwplweqpi.fsf@gitster.mtv.corp.google.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
	<20160610122714.3341-10-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:26:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBT06-0004wj-KD
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:25:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589AbcFJUZu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 16:25:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53281 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752320AbcFJUZt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2016 16:25:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D4402252A;
	Fri, 10 Jun 2016 16:25:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=69kSwo8pt3Wy
	N9Ur4EMATuKHHsg=; b=MJMElGcA/Jv4mN7OTCEuF2mfV7RKFvaktBtWN4MvfRDX
	gU+NuK85ffB6lOMJ7i9HBUUZylgVtF1QL3F5sIqCQlhe7sRpI0lq8PBBDsW0keT/
	XVgRey7uIj2w60xe01CgJbrLbAtT1GftLFeTNNkUFsEfyvB45Cdg5Mz7hjX/CLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Paj2Qh
	5TmzsMP/VpYaYM0z0BD5q6mPuhEIp530wMzWucFQI3LHUUHQd2/7etdFtEutJpTX
	ydArCgqC1P8mToDNv5UXlU1GHxUDcVk5SQGto0T9KrKoiz3H7ni36huRswhmQqB7
	ukzTZvjKvpgQjyaCQ4Umwuwz0+1lbT2QoSSbM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 65E2822529;
	Fri, 10 Jun 2016 16:25:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9F01822520;
	Fri, 10 Jun 2016 16:25:47 -0400 (EDT)
In-Reply-To: <20160610122714.3341-10-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Fri, 10 Jun 2016 19:26:56 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 841773A4-2F49-11E6-89AE-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297067>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Subject: Re: [PATCH 09/27] upload-pack: make check_non_tip() clean th=
ings up error

"clean things up on error"?

> On error check_non_tip() will die and not closing file descriptors is=
 no
> big deal. The next patch will split the majority of this function out
> for reuse in other cases, where die() may not be the only outcome. Sa=
me
> story for popping SIGPIPE out of the signal chain. So let's make sure=
 we
> clean things up properly first.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

Makes me wonder if you can push into sigchain before the first
appearance of "goto error" so that in the error handling codepath
you can do sigchain_pop(), without adding sigchain_pop() before all
the "goto error"?

>  upload-pack.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/upload-pack.c b/upload-pack.c
> index 60f2e5e..1e8b025 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -494,8 +494,10 @@ static void check_non_tip(void)
>  		if (!is_our_ref(o))
>  			continue;
>  		memcpy(namebuf + 1, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
> -		if (write_in_full(cmd.in, namebuf, 42) < 0)
> +		if (write_in_full(cmd.in, namebuf, 42) < 0) {
> +			sigchain_pop(SIGPIPE);
>  			goto error;
> +		}
>  	}
>  	namebuf[40] =3D '\n';
>  	for (i =3D 0; i < want_obj.nr; i++) {
> @@ -503,10 +505,13 @@ static void check_non_tip(void)
>  		if (is_our_ref(o))
>  			continue;
>  		memcpy(namebuf, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
> -		if (write_in_full(cmd.in, namebuf, 41) < 0)
> +		if (write_in_full(cmd.in, namebuf, 41) < 0) {
> +			sigchain_pop(SIGPIPE);
>  			goto error;
> +		}
>  	}
>  	close(cmd.in);
> +	cmd.in =3D -1;
> =20
>  	sigchain_pop(SIGPIPE);
> =20
> @@ -518,6 +523,7 @@ static void check_non_tip(void)
>  	if (i)
>  		goto error;
>  	close(cmd.out);
> +	cmd.out =3D -1;
> =20
>  	/*
>  	 * rev-list may have died by encountering a bad commit
> @@ -531,6 +537,11 @@ static void check_non_tip(void)
>  	return;
> =20
>  error:
> +	if (cmd.in >=3D 0)
> +		close(cmd.in);
> +	if (cmd.out >=3D 0)
> +		close(cmd.out);
> +
>  	/* Pick one of them (we know there at least is one) */
>  	for (i =3D 0; i < want_obj.nr; i++) {
>  		o =3D want_obj.objects[i].item;
