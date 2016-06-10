From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/27] upload-pack: move "unshallow" sending code out of deepen()
Date: Fri, 10 Jun 2016 13:09:12 -0700
Message-ID: <xmqq1t44g61j.fsf@gitster.mtv.corp.google.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
	<20160610122714.3341-7-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:09:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSk4-0001Eo-9t
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbcFJUJQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 16:09:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64186 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751868AbcFJUJQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2016 16:09:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E6FC924115;
	Fri, 10 Jun 2016 16:09:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cukBcBFInwAm
	4RknidfMc9vzJEU=; b=tBxzBA4jkM/zbhDxhGFWtPHSEWbQzx7Q76TSsPOMo6X/
	6x02wn2+Lg/s00xARhnnR4iFRwEqwUmuibTXTpK5jn/XEibxyZrmhR7kfurXUM2t
	b5tRUHXeSX7eC6WqH/aRttm9kByv+gL2sHIVvNB+3ZPQXqO5tGH+wuFOxTNmKXc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=D20xw5
	6LvROTcyYubYTTWlKjh93/Cj14eh6U8FG93oqyhMpTd29LdhlKIkYTQEhXE5wnrJ
	0KmYHrYSm6mk8Nq8wxYrxr5tzn3baEf2Fzu7f5Eo5ZWx57Z1I8jaeEtSTBfC/7Xj
	s3fSsuiH8SHm9ea/gBxWR0uI4/UXvhR5Kw1Yc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DF93824114;
	Fri, 10 Jun 2016 16:09:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 64C6E24113;
	Fri, 10 Jun 2016 16:09:14 -0400 (EDT)
In-Reply-To: <20160610122714.3341-7-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
	Duy"'s message of "Fri, 10 Jun 2016 19:26:53 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 34134EFC-2F47-11E6-BABF-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297022>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +static void deepen(int depth, const struct object_array *shallows)
> +{
> +	struct commit_list *result =3D NULL;
> +	int i;
> +	if (depth =3D=3D INFINITE_DEPTH && !is_repository_shallow())
> +		for (i =3D 0; i < shallows->nr; i++) {
> +			struct object *object =3D shallows->objects[i].item;
> +			object->flags |=3D NOT_SHALLOW;
> +		}
> +	else
> +		result =3D get_shallow_commits(&want_obj, depth,
> +					     SHALLOW, NOT_SHALLOW);
> +	send_shallow(result);
> +	free_commit_list(result);
> +	send_unshallow(shallows);
>  	packet_flush(1);
>  }

Starting from the original up to this point, the code structure of
this function have bothered me quite a bit because I would expect

	if (depth =3D=3D INFINITE_DEPTH && !is_repository_shallow()) {
		for (i =3D 0; i < shallows->nr; i++) {
			struct object *object =3D shallows->objects[i].item;
			object->flags |=3D NOT_SHALLOW;
		}
	} else {
		struct commit_list *result;
		result =3D get_shallow_commits(&want_obj, depth,
					     SHALLOW, NOT_SHALLOW);
		send_shallow(result);
		free_commit_list(result);
	}
	send_unshallow(shallows);
	packet_flush(1);

would be easier to understand.  The function seems to be reshaped
further in the series, so let's keep reading...
