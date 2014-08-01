From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] lockfile.c: remove PATH_MAX limitation (except in resolve_symlink)
Date: Fri, 01 Aug 2014 10:55:59 -0700
Message-ID: <xmqqtx5wuma8.fsf@gitster.dls.corp.google.com>
References: <1405858399-23082-1-git-send-email-pclouds@gmail.com>
	<1406814214-21725-1-git-send-email-pclouds@gmail.com>
	<1406814214-21725-2-git-send-email-pclouds@gmail.com>
	<xmqqfvhgw3q9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, ramsay@ramsay1.demon.co.uk,
	yuelinho777@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 19:56:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDH44-0002II-E1
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 19:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754822AbaHAR4U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Aug 2014 13:56:20 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63720 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752571AbaHAR4T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2014 13:56:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2AB382D1A1;
	Fri,  1 Aug 2014 13:56:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WYKSt0Cs+OE5
	LZU+4/KIiVL80uY=; b=SCoEnFInCUh+Csk5gSh6zsZDp7c1kvs/ZSB6hCn1Isl/
	cppl0MeU7cWFtop67fi/CWul6nwsz54jpsVZ8I6oTumarpkRe7nIgXmurxz2Bhok
	TT8vsa3tc+LclJBwEibcGR47paUejP46yz83zb+MBxt/Cbl2bcqr0Gu4GjBgRdU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Ri0XlO
	KK3SlB6nUMzKBiAhJOcUUTH3HWe8s0ygwgPpy9Z9yOR9PS8jpswhG6ZbAJaQx54V
	+jflx4EqjgYZ4TT59XGHyN5+oRdzfcUd0beawhUkoYfu56zvhvHCJRnO5fpF6/kz
	X1/F3gEPuRhNjl5tPWHB5fvlbh4yZq0yt6dPY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2095C2D1A0;
	Fri,  1 Aug 2014 13:56:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EAD842D187;
	Fri,  1 Aug 2014 13:56:00 -0400 (EDT)
In-Reply-To: <xmqqfvhgw3q9.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 01 Aug 2014 09:53:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 193BFF20-19A5-11E4-BB89-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254645>

Junio C Hamano <gitster@pobox.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>
> Somewhat underexplained, given that it seems to add some new
> semantics.
>
>> +static void clear_filename(struct lock_file *lk)
>> +{
>> +	free(lk->filename);
>> +	lk->filename =3D NULL;
>> +}
>
> It is good to abstract out lk->filename[0] =3D '\0', which used to be
> the way we say that we are done with the lock.  But I am somewhat
> surprised to see that there aren't so many locations that used to
> check !!lk->filename[0] to see if we are done with the lock to requir=
e
> a corresponding wrapper.
>
>>  static void remove_lock_file(void)
>>  {
>>  	pid_t me =3D getpid();
>> =20
>>  	while (lock_file_list) {
>>  		if (lock_file_list->owner =3D=3D me &&
>> -		    lock_file_list->filename[0]) {
>> +		    lock_file_list->filename) {
>
> ... and this seems to be the only location?

While looking at possible fallout of merging this topic to any
branch, I am starting to suspect that it is probably a bad idea for
clear-filename to free lk->filename.  I am wondering if it would be
safer to do:

 - in lock_file(), free lk->filename if it already exists before
   what you do in that function with your series;

 - update "is this lock already held?" check !!lk->filename[0] to
   check for (lk->filename && !!lk->filename[0]);

 - in clear_filename(), clear lk->filename[0] =3D '\0', but do not
   free lk->filename itself.

Then existing callers that never suspected that lk->filename can be
NULL and thought that it does not need freeing can keep doing the
same thing as before without leaking nor breaking.

If we want to adopt the new world order at once, alternatively, you
can keep the code in this series but then lk->filename needs to be
renamed to something that the current code base has not heard of to
force breakage at the link time for us to notice.

I grepped for 'lk->filename' and checked if the ones in read-cache.c
and refs.c are OK (they seem to be), but that is not a very robust
check.

I dunno.
