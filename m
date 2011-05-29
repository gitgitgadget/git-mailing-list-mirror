From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v0 3/3] Bigfile: teach "git add" to send a large file
 straight to a pack
Date: Sun, 29 May 2011 13:29:41 -0700
Message-ID: <7v62otp7wq.fsf@alter.siamese.dyndns.org>
References: <1304844455-23570-1-git-send-email-gitster@pobox.com>
 <1304844455-23570-4-git-send-email-gitster@pobox.com>
 <BANLkTikB3VhB4nTZhjE+3znfVTuBYsnehg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 29 22:29:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQmcU-0006qR-I5
	for gcvg-git-2@lo.gmane.org; Sun, 29 May 2011 22:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395Ab1E2U3u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 May 2011 16:29:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57721 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408Ab1E2U3t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2011 16:29:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 409695D89;
	Sun, 29 May 2011 16:31:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0gkjMJOcZRmB
	vuWRd37GdbHnOZM=; b=BY4GwFloqWOxmEd0vvonUp51wL4yMyfOP+Xya1lcXZKW
	FsjRCdX0UYfEDUzBYqHiXkGdKvF0pz0nrTwpUFdMcqP7DdmV7S8cxjk9uECaFlr4
	/TsDGTRZdMhJt7X0tavFLqpllkPJLPaeLbTf+rzSux7Yu99oVVTWGn8pkOX7nPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=H1sET5
	Y1Hfg1oeMpeaFvTXYh+5cGhs9lIXQAtD1FkQ0Euunsu9Iv6DuDqZFpBtgOCUiAJ3
	Xp6wqhqFENRsOw1Gl9SRQcy320U6Xs9vfKyhp46Cdz80bbWbMvN1tZ66LkagSeyX
	x3VHfF+1jqWxnGphr8h7Kr5p3edumN89QByME=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1D7015D88;
	Sun, 29 May 2011 16:31:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3CD025D87; Sun, 29 May 2011
 16:31:50 -0400 (EDT)
In-Reply-To: <BANLkTikB3VhB4nTZhjE+3znfVTuBYsnehg@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 29 May
 2011 20:20:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B0CDD580-8A32-11E0-A61B-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174704>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sun, May 8, 2011 at 10:47, Junio C Hamano <gitster@pobox.com> wrot=
e:
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char buf[10240];
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t sz =3D siz=
e < sizeof(buf) ? size : sizeof(buf);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t actual;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actual =3D read_i=
n_full(fd, buf, sz);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (actual < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 die_errno("index-stream: reading input");

It already has been fixed with 23c7df6 (sha1_file: use the correct type
(ssize_t, not size_t) for read-style function, 2011-05-26).

Scanning the list and updating your copy of 'pu' from k.org would often
save your time for topics that are relatively new.

Thanks.
