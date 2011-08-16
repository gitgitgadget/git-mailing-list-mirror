From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: check return value of lookup_commit()
Date: Tue, 16 Aug 2011 11:02:23 -0700
Message-ID: <7vy5ytgrps.fsf@alter.siamese.dyndns.org>
References: <1313422716-26432-1-git-send-email-pclouds@gmail.com>
 <7vei0mlg8d.fsf@alter.siamese.dyndns.org>
 <CACsJy8AusStKNWuw3j740r4Nc0FhzR+jJZJNaesxn68pr7dTqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 16 20:02:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtNyC-0006V4-9V
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 20:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685Ab1HPSC1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Aug 2011 14:02:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61466 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752296Ab1HPSC0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2011 14:02:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E180E4AAD;
	Tue, 16 Aug 2011 14:02:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=oaoYFcI/C/gR
	i7ivsU8+nJTQw1Q=; b=SjbGoZaG3BbNBE//Ktqjb/KY4oR2VfIjDMwCNuW1l0wD
	XaFl4VzF+6GKCLdCKVYWx72PDSpJy9ObIutcttsmSk4oFUFaC2m/16wZbAaV/dyL
	ZtDN4oFPVXuNtO/Gu3DBRDH9YZmWqpTO1poU9O0Mj7iWzeeRSm0iZiGi7gX/gCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NZ+DRN
	QAbaqVEa+jIpJDVbP8B/mUyBUhTiu1ARtD40NaACaL6Wedn4jFr5H9V1C9DJ25Ee
	2P4s490qV+Vl16XV3RY2YzD7ZGsnfpvg3dHHVR/F4j/Ig2/GZJ3sc6sgEUD2rcFX
	bA8i67+ilUSnJgbrKwCEg/vrKimspLgtoWxuo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D96684AAC;
	Tue, 16 Aug 2011 14:02:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B8284AAB; Tue, 16 Aug 2011
 14:02:25 -0400 (EDT)
In-Reply-To: <CACsJy8AusStKNWuw3j740r4Nc0FhzR+jJZJNaesxn68pr7dTqA@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 16 Aug 2011 20:22:27 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E5BE274E-C831-11E0-8A6C-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179464>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> 2011/8/16 Junio C Hamano <gitster@pobox.com>:
>> The change itself looks good to me but a point and a half to think a=
bout:
>>
>> =C2=A0- In this if/elseif/.../else cascade, everybody except for the
>> =C2=A0 "initial_commit" case needs to make sure that head_sha1 point=
s at a
>> =C2=A0 valid commit and get an commit object. Hoisting the scope of =
the
>> =C2=A0 variable "commit" one level in your patch is good, but it wou=
ld make it
>> =C2=A0 easier to read and the future code modification much less err=
or prone
>> =C2=A0 if (1) you called lookup_commit() and checked for errors befo=
re
>> =C2=A0 entering this if/elseif/... cascade, and (2) you renamed this=
 variable
>> =C2=A0 to "head_commit".
>
> But then I would need to avoid die()ing in "initial_commit" case.

That's exactly what I said.

	if (!initial)
	        /* we need to know the head_commit */
                head_commit =3D lookup_and_check(HEAD);

	/* depending on what kind of commit, we need different stuff */
        if (initial)
        	... going to create a parentless commit
	else if (amending)
		... use the head_commit to learn parent, reuse the message
                ... from there
	else if ...

These two are independent if/else cascades in the sense that the first =
is
about learning the details of head_commit, and the latter is about
learning how the commit is done, and in a subset of the latter head_com=
mit
is used.

>> =C2=A0- Whether we like it or not, many people have a broken reimple=
mentations
>> =C2=A0 of git that can put a non-commit in HEAD, and they won't be f=
ixed
>> =C2=A0 overnight. Instead of erroring out, would it be nicer of us i=
f we just
>> =C2=A0 warned, unwrapped the tag and used the tagged commit instead?
>
> How about replacing those lookup_commit() with this? It would tolerat=
e
> tag-in-branch case, but also warn users that something's gone wrong.

Yes, that is exactly what I meant.

Thakns.
