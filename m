From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/27] upload-pack: move "shallow" sending code out of deepen()
Date: Fri, 10 Jun 2016 13:05:36 -0700
Message-ID: <xmqqa8isg67j.fsf@gitster.mtv.corp.google.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
	<20160610122714.3341-5-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:05:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSgd-0007Ak-2B
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbcFJUFn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 16:05:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53762 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751868AbcFJUFm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2016 16:05:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A841240BC;
	Fri, 10 Jun 2016 16:05:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MvdSjDoRoJ5e
	V+c8w9AhHJKmWwA=; b=s+LiArI0uVELV+w24872jK6pGID5IJKqvNKRB6h78XdT
	Yue4DPOfZ4/uaWpVawX6HFLIu0ny6LaXrpcKORuSBchgGnV/POq4TEy4svSx4k9M
	eTTiobUKJt8i9GRDhcyHfIOUiJWKVRcKbzqKWuHT8SnUW+3lYmarl30NpGjWHeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ltDJ4m
	2sz89/XQxASSC7I5VH4fqnMYLnmUXj1tY/Yxm59XnubQtYuoFAAOVX8kztoAZz/u
	hfMUP3ceJYmajf1kmxD4L4J5Al+pE5t1STpByHFSpzoVRhvRqBp2AMoQHQuz/ohh
	ynM8Y0f2nsz6y6S8GvNFagg/x/yhKwzJMvPfQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 91ED9240BB;
	Fri, 10 Jun 2016 16:05:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1B32B240BA;
	Fri, 10 Jun 2016 16:05:38 -0400 (EDT)
In-Reply-To: <20160610122714.3341-5-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
	Duy"'s message of "Fri, 10 Jun 2016 19:26:51 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B32661D0-2F46-11E6-A5DE-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297020>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> @@ -551,16 +565,7 @@ static void deepen(int depth, const struct objec=
t_array *shallows)
>  		backup =3D result =3D
>  			get_shallow_commits(&want_obj, depth,
>  					    SHALLOW, NOT_SHALLOW);
> -	while (result) {
> -		struct object *object =3D &result->item->object;
> -		if (!(object->flags & (CLIENT_SHALLOW|NOT_SHALLOW))) {
> -			packet_write(1, "shallow %s",
> -				     oid_to_hex(&object->oid));
> -			register_shallow(object->oid.hash);
> -			shallow_nr++;
> -		}
> -		result =3D result->next;
> -	}
> +	send_shallow(result);
>  	free_commit_list(backup);

At this point in the series, "backup" becomes an unnecessary and
redundant variable, as you can free_commit_list(result) here, right?

>  	for (i =3D 0; i < shallows->nr; i++) {
>  		struct object *object =3D shallows->objects[i].item;
