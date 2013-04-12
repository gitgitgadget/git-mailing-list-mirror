From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: fail early if we know we can't merge from upstream
Date: Fri, 12 Apr 2013 09:35:10 -0700
Message-ID: <7v38uvg11d.fsf@alter.siamese.dyndns.org>
References: <1365686801-17206-1-git-send-email-cmn@elego.de>
 <7v1uahj7do.fsf@alter.siamese.dyndns.org>
 <1365761838.2468.21.camel@flaca.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Apr 12 18:35:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQgwa-00031c-Kj
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 18:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081Ab3DLQfO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Apr 2013 12:35:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59423 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752441Ab3DLQfM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Apr 2013 12:35:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64A681508F;
	Fri, 12 Apr 2013 16:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=t87hyGP2k6Y5
	0/MYOBDS6BMrcwg=; b=TU7nwA6jNlFSAsS3bGtn/aCxSWr6FWjHty9+5hblq7FK
	Kx5ZE8gIROEA6FtejKwbPs/mlSt/fKp4LtB7gWUL6+gQRSCWQuq4erO5YOss+wud
	tUQ/rMpi469XLZkU+sveuDHNiXnBtS7VAPOVXAEa2S04R0cZo4jY6mDFWsAlXA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Efcnpo
	wKCR03Xd/cbhTuWTCEAW0BpqGaIMm+NDD3OQ4I+DcalhI0gpDO4KMFW4+Khxc5Iy
	OnCF05yL4AX/bZGapNPmQIAbmAf4n0YW76FjDTefDd16RC6iCHkd9wemaJKKp3U4
	kONk/J+h0Enr3VxgzKtCN6BTlRBD/i33LYaUs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C2A11508E;
	Fri, 12 Apr 2013 16:35:12 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD2411508C; Fri, 12 Apr
 2013 16:35:11 +0000 (UTC)
In-Reply-To: <1365761838.2468.21.camel@flaca.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Fri, 12 Apr 2013 12:17:18
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F22662A0-A38E-11E2-840F-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220999>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> On Thu, 2013-04-11 at 10:37 -0700, Junio C Hamano wrote:
>
>> > +	fetch=3D$(git config --get-all "remote.$use_remote.fetch")
>> > +	if [ -z "$fetch" ]; then
>> > +		return
>> > +	fi
>>=20
>> Hmm, it is probably correct to punt on this case, but it defeats
>> large part of the effect of your effort, doesn't it? We fetch what
>> is covered by remote.$name.fetch _and_ what need to complete the
>> merge operation (otherwise branch.$name.merge that is not covered by
>> remote.$there.fetch will not work).  So
>>=20
>>     [remote "origin"]
>>             url =3D $over_there
>>     [branch "master"]
>>             remote =3D origin
>>             merge =3D refs/heads/master
>>=20
>> would still fetch refs/heads/master from there and merge it.
>
> If you run 'git pull' in this situation, then everything's fine and t=
he
> right thing gets merged.

My mistake.  You are trying to reject an obviously bad case early,
and because this is an obviously good case, you just let it be
handled in the original codeflow (which should not find any issues
in this set-up).
