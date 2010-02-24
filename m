From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: fix 'git pull --all' when current branch is 
 tracking remote that is not last in the list of remotes
Date: Tue, 23 Feb 2010 16:22:31 -0800
Message-ID: <7vzl2zxz20.fsf@alter.siamese.dyndns.org>
References: <1266965731-4208-1-git-send-email-michael.lukashov@gmail.com>
 <7vtyt75zdo.fsf@alter.siamese.dyndns.org>
 <63cde7731002231544k4140d0d8u65e8c7250a8ff42c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Lukashov <michael.lukashov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 01:22:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk51b-0000Yo-RG
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 01:22:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890Ab0BXAWm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2010 19:22:42 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62278 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793Ab0BXAWl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2010 19:22:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 12BF79C8E6;
	Tue, 23 Feb 2010 19:22:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Qel37fFL1ZvH
	mgmCLAjsTp6NxBs=; b=wu9nTQepsakAz0QB3+2dB/byZCDsfMpLBZWliIdAq9QU
	GmHwF53UhHsRv2e6Jeyz+wTsG79JpxpcYngAOHl+wOxQmNkUGY3MKuOc3rbpVoNR
	iIIqKh9enuh91sIVq/Hzg1Z7RImxV3T+P1uFfg8CArDTnOBwJlhy5VdW+4QRzrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NiR2TX
	eqmAjI78DXs0SmEz8EN01BmV02lbSWMal5FrbTxMPqhzeB61ldyrVftCY1UVBcEL
	U6f6YOrj6CJGXlAyGWK0VVBNRs4xyNPZtgwwZefj/7KBSNCP8AvzhSHzZFsgYbJm
	4ZbSJPvMLveVbCNGTavoEQ/4By83sT5FC0188=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E42339C8E2;
	Tue, 23 Feb 2010 19:22:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D5739C8DF; Tue, 23 Feb
 2010 19:22:33 -0500 (EST)
In-Reply-To: <63cde7731002231544k4140d0d8u65e8c7250a8ff42c@mail.gmail.com>
 (Michael Lukashov's message of "Wed\, 24 Feb 2010 02\:44\:28 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B52CD58A-20DA-11DF-A2DB-E038EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140881>

Michael Lukashov <michael.lukashov@gmail.com> writes:

> On Wed, Feb 24, 2010 at 2:02 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Michael Lukashov <michael.lukashov@gmail.com> writes:
>>
>>> diff --git a/git-pull.sh b/git-pull.sh
>>> index 38331a8..fcde096 100755
>>> --- a/git-pull.sh
>>> +++ b/git-pull.sh
>>> @@ -214,7 +214,11 @@ test true =3D "$rebase" && {
>>> =C2=A0 =C2=A0 =C2=A0 done
>>> =C2=A0}
>>> =C2=A0orig_head=3D$(git rev-parse -q --verify HEAD)
>>> -git fetch $verbosity --update-head-ok "$@" || exit 1
>>> +if test -e "$GIT_DIR"/FETCH_HEAD
>>> +then
>>> + =C2=A0 =C2=A0 rm "$GIT_DIR"/FETCH_HEAD 2>/dev/null
>>> +fi
>>
>> When is it sane to ignore an error from this "rm", especially after =
you
>> made sure that it exists?
>
> The file "$GIT_DIR"/FETCH_HEAD is rewritten
> in subsequent call to 'git fetch', thus it is safe to ignore all erro=
rs.

You are not answering my question.

You found out that the thing exists, and you want to overwrite it later=
=2E
You _need_ that file to either not exist, or at least be empty, because
you will be _appending_ to it, unlike the earlier code.

Now, you expected you would be able to remove it, and that is why you
called "rm".  Suppose that removal has failed for some reason.  The fil=
e
stays.  It is not emptied, either.

Why is it sane to ignore that error and let fetch --append to run, as i=
f
it is starting from either non-existing file or an empty one?  You alre=
ady
diagnosed that the file is in some _funny_ state.  It is not sensible t=
o
continue further at that point, knowing that there is something wrong.

If the new code you introduced were

	rm -f "$GIT_DIR/FETCH_HEAD" || exit

then I would understand it.  But your patch doesn't make sense to me;
neither your "thus it is safe".
